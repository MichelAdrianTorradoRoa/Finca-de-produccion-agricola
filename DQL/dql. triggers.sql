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

