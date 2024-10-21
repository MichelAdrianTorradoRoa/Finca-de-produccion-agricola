-- Registrar una venta y actualizar automaticamente el inventario
DELIMITER //
CREATE PROCEDURE RegistrarVenta(IN idProducto INT, IN cantidad INT, IN total DECIMAL(10, 2))
BEGIN
    INSERT INTO ventas (idProducto, Cantidad, Total, Fecha) 
    VALUES (idProducto, cantidad, total, CURDATE());
    UPDATE inventario_productos
    SET Cantidad = Cantidad - cantidad
    WHERE idProducto = idProducto AND Estado = 'Disponible';
END //
DELIMITER ;

-- Registrar un nuevo proveedor
DELIMITER //
CREATE PROCEDURE RegistrarProveedor(IN nombre VARCHAR(45), IN direccion VARCHAR(45), IN telefono VARCHAR(45))
BEGIN
    INSERT INTO proveedores (Nombre, Direccion, Telefono)
    VALUES (nombre, direccion, telefono);
END //
DELIMITER ;

-- Registrar un nuevo empleado
DELIMITER //
CREATE PROCEDURE RegistrarEmpleado(IN nombre VARCHAR(45), IN apellido VARCHAR(45), IN salario DECIMAL(10, 2), IN fechanacimiento DATE, IN horainicio TIME, IN horafinalizacion TIME, IN telefono VARCHAR(45))
BEGIN
    INSERT INTO empleados (Nombre, Apellido, Salario, Fecha_Contratacion, Fecha_Nacimiento, Hora_inicio, Hora_Finalizacion, Telefono, Estado)
    VALUES (nombre, apellido, salario, CURDATE(), fechanacimiento, horainicio, horafinalizacion, telefono, 'Activo');
END //
DELIMITER ;

-- Actualizar el estado de una maquinaria despues de un mantenimiento
DELIMITER //
CREATE PROCEDURE ActualizarEstadoMaquinaria(IN idmaquinaria INT, IN nuevoestado VARCHAR(50)
)
BEGIN
    UPDATE maquinaria
    SET Estado = nuevoEstado
    WHERE idMaquinaria = idmaquinaria;
    INSERT INTO mantenimiento_maquinaria (idMaquinaria, Fecha)
    VALUES (idMaquinaria, CURDATE());
END //
DELIMITER ;

-- Obtener las ventas entre dos fechas
DELIMITER //
CREATE PROCEDURE ObtenerVentas(IN fechadesde DATE, IN fechahasta DATE)
BEGIN
    SELECT Fecha, SUM(Total) AS Total_Ventas
    FROM ventas
    WHERE Fecha BETWEEN fechadesde AND fechahasta
    GROUP BY Fecha;
END // 
DELIMITER ;

-- Actualizar el inventario al comprar un producto
DELIMITER //
CREATE PROCEDURE ActualizarInventarioCompra(IN idproducto INT, IN cantidad INT)
BEGIN
    UPDATE inventario_productos
    SET Cantidad = Cantidad + cantidad
    WHERE idProducto = idproducto;
    INSERT INTO ordenes_compra (idProducto, Cantidad, Fecha)
    VALUES (idproducto, cantidad, CURDATE());
END //
DELIMITER ;

-- Registrar tareas a las herramientas
DELIMITER $$
CREATE PROCEDURE RegistrarTareaConHerramientas(IN tarea VARCHAR(45), IN idherramienta INT)
BEGIN
    INSERT INTO tareas (Nombre, Fecha)
    VALUES (tarea, CURDATE());
    SET @idTarea = LAST_INSERT_ID();
    INSERT INTO tareas_herramientas (idTarea, idHerramienta)
    VALUES (@idTarea, idherramienta);
END //
DELIMITER ;

-- Obtener el mantenimiento que requiere una maquinaria 
DELIMITER //
CREATE PROCEDURE ObtenerMantenimientoMaquinaria(IN idmaquinaria INT)
BEGIN
    SELECT Fecha, Estado
    FROM mantenimiento_maquinaria
    WHERE idMaquinaria = idmaquinaria;
END //
DELIMITER ;

-- Actualizar el estado de un producto en inventario
DELIMITER //
CREATE PROCEDURE ActualizarEstadoProducto(IN idproducto INT, IN estado VARCHAR(45))
BEGIN
    UPDATE inventario_productos
    SET Estado = estado
    WHERE idProducto = idproducto;
END //
DELIMITER ;

-- Registrar nueva produccion agricola y pecuaria
DELIMITER //
CREATE PROCEDURE RegistrarProduccionAgricola(IN idagricola INT, IN idpecuario, IN cantidad DECIMAL(10, 2))
BEGIN   
    INSERT INTO produccion (idAgricola, idPecuario, Cantidad, Fecha)
    VALUES (idagricola, idpecuario, cantidad, CURDATE());
END //
DELIMITER ;


