-- Actualizar la cantidad de productos despues de una venta
DELIMITER //

CREATE TRIGGER actualizar_cantidad_producto
AFTER INSERT ON ventas
FOR EACH ROW
BEGIN
UPDATE productos p
JOIN productos_ventas pv ON p.idProducto = pv.idProducto
SET p.Cantidad_Disponible = p.Cantidad_Disponible - pv.Cantidad
WHERE pv.idVenta = NEW.idVenta;
END //

DELIMITER ;


-- Reportar en la tabla log de productos cuando un producto se le modifique el precio
DELIMITER //
CREATE TRIGGER registro_actualizar_producto
AFTER UPDATE ON Productos
FOR EACH ROW
BEGIN
DECLARE idproducto INT;
SELECT idProducto INTO idproducto FROM Productos;
INSERT INTO log_productos (mensaje, fecha, idProducto)
VALUES(CONCAT('Precio actualizado: ', NEW.precio, ', precio anterior: ', OLD.precio,', precio nuevo: ', NEW.precio), NOW(), idproducto);
END //
DELIMITER ;

-- Validar la eliminacion de un cliente si es inactivo y no tiene ventas
DELIMITER //
CREATE TRIGGER verificar_cliente_antes_de_eliminar
BEFORE DELETE ON clientes
FOR EACH ROW
BEGIN
IF OLD.Estado = 'Inactivo' THEN
    IF EXISTS (SELECT 1 FROM ventas WHERE idCliente = OLD.idCliente) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Se recomienda no eliminar el cliente, puesto que tiene ventas registradas';
    END IF;
ELSE
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Se recomienda no eliminar el cliente, puesto que el estado no esta en estado inactivo';
END IF;
END //
DELIMITER ;

-- Verificar que los datos de un cliente esten completos antes de insertarlo
DELIMITER //
CREATE TRIGGER verificar_cliente_antes_de_insertar
BEFORE INSERT ON clientes
FOR EACH ROW
BEGIN
IF NEW.Nombre IS NULL OR NEW.Nombre = '' THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'el nombre del cliente no puede estar vacío';
END IF;
IF NEW.Estado IS NULL OR NEW.Estado = '' THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'el estado del cliente no puede estar vacío';
END IF;
IF NEW.Tipo IS NULL OR NEW.Tipo = '' THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'el tipo del cliente no puede estar vacío';
END IF; 
IF NEW.Fecha_Nacimiento IS NULL THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'la fecha de nacimiento del cliente no puede estar vacía';
END IF;
IF NEW.idDireccion IS NULL THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'debe especificar una dirección para el cliente';
END IF;
END //
DELIMITER ;

-- Generar una orden de compra si un producto esta bajo en inventario
DELIMITER //
CREATE TRIGGER generar_orden_compra_bajo_inventario
AFTER UPDATE ON inventario_productos
FOR EACH ROW
BEGIN
IF NEW.Cantidad < 10 AND NEW.Estado = 'Disponible' THEN
INSERT INTO ordenes_compra (Estado, Fecha, Total, idProducto, idMaquinaria, idProveedor, idHerramienta)
VALUES ('Pendiente', CURDATE(), 0, NEW.idProducto, 1, 1, 1);  
END IF;
END //
DELIMITER ;

-- Generar reporte cuando se actualice una venta
DELIMITER //
CREATE TRIGGER reporte_venta_actualizada
AFTER UPDATE ON ventas
FOR EACH ROW
BEGIN
INSERT INTO log_ventas (Mensaje, Fecha, idVenta)
VALUES (CONCAT('venta actualizada: total = ', NEW.Total, ', fecha = ', NEW.Fecha), CURDATE(), NEW.idVenta);
END //
DELIMITER ;

-- Registrar la ultima fecha cuando se actualice un producto
DELIMITER //
CREATE TRIGGER registrar_modificacion_producto
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN
INSERT INTO log_productos (Mensaje, Fecha, idProducto)
VALUES (CONCAT('producto modificado: ', NEW.Nombre), CURDATE(), NEW.idProducto);
END //
DELIMITER ;

-- Verificar inventario suficiente para una venta
DELIMITER //
CREATE TRIGGER verificar_inventario_antes_venta
BEFORE INSERT ON ventas
FOR EACH ROW
BEGIN
DECLARE cantidad_disponible INT;
SELECT Cantidad INTO cantidad_disponible
FROM inventario_productos
WHERE idProducto = NEW.idProducto
FOR UPDATE;
IF cantidad_disponible < 1 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'inventario insuficiente para realizar la venta';
END IF;
    
END //
DELIMITER ;

-- Evitar que se elimine un proveedor que tenga ordenes de compra
DELIMITER //
CREATE TRIGGER evitar_eliminacion_proveedor
BEFORE DELETE ON proveedores
FOR EACH ROW
BEGIN
DECLARE ordenes INT;
SELECT COUNT(*) INTO ordenes
FROM ordenes_compra
WHERE idProveedor = OLD.idProveedor;
IF ordenes > 0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'no se puede eliminar el proveedor porque tiene órdenes de compra';
END IF;
END //
DELIMITER ;

-- Registrar cada vez que se elimine una venta
DELIMITER //
CREATE TRIGGER registrar_eliminacion_venta
BEFORE DELETE ON ventas
FOR EACH ROW
BEGIN
INSERT INTO log_ventas (Mensaje, Fecha, idVenta)
VALUES (CONCAT('venta eliminada: ', OLD.idVenta), CURDATE(), OLD.idVenta);
END //
DELIMITER ;

-- Actualizar la cantidad de herramientas cuando sea alta
DELIMITER //
CREATE TRIGGER actualizar_cantidad_herramienta_tarea
AFTER UPDATE ON tareas
FOR EACH ROW
BEGIN
  IF NEW.Prioridad = 'Alta' THEN
    UPDATE inventario_herramientas ih
    JOIN tareas_herramientas th ON ih.idHerramienta = th.idHerramienta
    SET ih.Cantidad_Disponible = ih.Cantidad_Disponible + th.Cantidad_Usada
    WHERE th.idTarea = NEW.idTarea;
  END IF;
END //
DELIMITER ;

-- Registrar la eliminación de un empleado
DELIMITER //
CREATE TRIGGER eliminacion_empleado
BEFORE DELETE ON empleados
FOR EACH ROW
BEGIN
  INSERT INTO empleados (idEmpleado, Nombre, Fecha_Eliminacion)
  VALUES (OLD.idEmpleado, OLD.Nombre, NOW());
END //
DELIMITER ;


-- Actualizar estado de orden de compra al recibir el producto
DELIMITER //
CREATE TRIGGER actualizar_estado_orden_compra
AFTER UPDATE ON ordenes_compra
FOR EACH ROW
BEGIN
  IF NEW.Total >= '1500' THEN
    UPDATE ordenes_compra
    SET Estado = 'Completada'
    WHERE idordenes_compra= NEW.idordenes_compra;
  END IF;
END //
DELIMITER ;

--  Actualizar inventario
DELIMITER //
CREATE TRIGGER actualizar_inventario
AFTER INSERT ON productos
FOR EACH ROW
BEGIN
  UPDATE inventario_productos
  SET Cantidad = Cantidad + NEW.Cantidad_Disponible
  WHERE idProducto = NEW.idProducto;
END //
DELIMITER ;

-- Evitar modificar el salario de empleados retirados
DELIMITER //
CREATE TRIGGER evitar_modificacion_salario_retirado
BEFORE UPDATE ON empleados
FOR EACH ROW
BEGIN
  IF OLD.Estado = 'Retirado' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'No se puede modificar el salario de un empleado retirado';
  END IF;
END //
DELIMITER ;

-- Registrar la modificación de una orden de compra
DELIMITER ///
CREATE TRIGGER modificacion_orden_compra
AFTER UPDATE ON ordenes_compra
FOR EACH ROW
BEGIN
  INSERT INTO ordenes_compra (idOrdenCompra, Cambios, Fecha)
  VALUES (NEW.idOrdenCompra, CONCAT('Estado anterior: ', OLD.Estado, ', Estado nuevo: ', NEW.Estado), NOW());
END //
DELIMITER ;

-- Evitar eliminar maquinaria en mantenimiento
DELIMITER ///
CREATE TRIGGER evitar_eliminar_maquinaria_mantenimiento
BEFORE DELETE ON maquinarias
FOR EACH ROW
BEGIN
  IF OLD.Estado = 'Mantenimiento' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'No se puede eliminar una maquinaria en mantenimiento';
  END IF;
END //
DELIMITER ;

--  Actualizar estado de una tarea al completar una inspección
DELIMITER ///
CREATE TRIGGER actualizar_estado_tarea_inspeccion
AFTER UPDATE ON inspecciones_tareas
FOR EACH ROW
BEGIN
  IF NEW.Estado_Inspeccion = 'Aprobada' THEN
    UPDATE tareas
    SET Estado = 'Revisada'
    WHERE idTarea = NEW.idTarea;
  END IF;
END //
DELIMITER ;

-- Prevenir la inserción de ventas con clientes inactivos
DELIMITER //
CREATE TRIGGER prevenir_venta_cliente_inactivo
BEFORE INSERT ON ventas
FOR EACH ROW
BEGIN
  DECLARE estado_cliente VARCHAR(20);
  SELECT Estado INTO estado_cliente
  FROM clientes
  WHERE idCliente = NEW.idCliente;

  IF estado_cliente = 'Inactivo' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'No se pueden realizar ventas a clientes inactivos';
  END IF;
END //
DELIMITER ;

 -- Registrar eliminación de una orden de compra
 DELIMITER ///
CREATE TRIGGER registrar_eliminacion_orden_compra
BEFORE DELETE ON ordenes_compra
FOR EACH ROW
BEGIN
  INSERT INTO ordenes_compra (Mensaje, Fecha, idOrdenCompra)
  VALUES (CONCAT('Orden de compra eliminada: ', OLD.idOrdenCompra), CURDATE(), OLD.idOrdenCompra);
END //
DELIMITER ;
