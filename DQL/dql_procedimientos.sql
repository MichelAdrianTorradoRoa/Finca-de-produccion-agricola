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
DELIMITER //
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
CREATE PROCEDURE RegistrarProduccionAgricola(IN idagricola INT, IN idpecuario INT, IN cantidad INT)
BEGIN   
    INSERT INTO produccion (idAgricola, idPecuario, Cantidad, Fecha)
    VALUES (idagricola, idpecuario, cantidad, CURDATE());
END //
DELIMITER ;



-- Registrar una nueva orden de compra y actualizar inventario
DELIMITER //
CREATE PROCEDURE RegistrarOrdenCompra(
    IN idProveedor INT, 
    IN idProducto INT, 
    IN cantidad INT, 
    IN precio DECIMAL(10,2)
)
BEGIN
    -- Insertar la orden de compra
    INSERT INTO ordenes_compra (idProveedor, idProducto, Cantidad, Precio_Unitario, Fecha)
    VALUES (idProveedor, idProducto, cantidad, precio, CURDATE());

    -- Actualizar el inventario del producto
    UPDATE inventario_productos
    SET Cantidad = Cantidad + cantidad
    WHERE idProducto = idProducto AND Estado = 'Disponible';
END //
DELIMITER ;


-- Actualizar el salario de un empleado
DELIMITER //
CREATE PROCEDURE ActualizarSalarioEmpleado(IN idEmpleado INT, IN nuevoSalario DECIMAL(10, 2))
BEGIN
    SET SQL_SAFE_UPDATES = 0;
    UPDATE empleados
    SET Salario = nuevoSalario
    WHERE idEmpleado = idEmpleado;
    SET SQL_SAFE_UPDATES = 1;
END //
DELIMITER ;

-- Asignar una nueva tarea a un cargo
DELIMITER //
CREATE PROCEDURE AsignarTareaCargo(IN IdCargo INT, IN IdTarea INT, IN Nombre VARCHAR(45),IN Fecha_Final DATE, IN Prioridad VARCHAR(45), IN Tipo VARCHAR(45))
BEGIN
    INSERT INTO tareas (IdCargo, IdTarea, Nombre, Fecha_Inicio, Fecha_Final, Prioridad, Tipo)
    VALUES (IdCargo, IdTarea, Nombre, CURDATE(), Fecha_Final, Prioridad, Tipo);
END //
DELIMITER ;

-- Reparar maquinaria y actualizar sus horas operativas
DELIMITER //
CREATE PROCEDURE RepararMaquinaria(IN idMaquinaria INT, IN Horas_Operativas INT, IN idTipo_Maquinaria INT)
BEGIN
    UPDATE maquinaria
    SET Horas_Operativas = Horas_Operativas
    WHERE idMaquinaria = idMaquinaria;

    -- Registrar la fecha de reparación en el historial de mantenimiento
    INSERT INTO mantenimiento_maquinaria (idMaquinaria, Fecha, idTipo_Maquinaria)
    VALUES (idMaquinaria, CURDATE(), idTipo_Maquinaria);
END //
DELIMITER ;

-- Registrar una nueva tarea agrícola
DELIMITER //
CREATE PROCEDURE RegistrarTareaAgricola(IN Nombre VARCHAR(45), IN Prioridad VARCHAR(10), IN Fecha_Inicio DATE, IN Fecha_Final DATE, IN IdCargo INT)
BEGIN
    INSERT INTO tareas (Nombre, Prioridad, Fecha_Inicio, Fecha_Final, Tipo, IdCargo)
    VALUES (Nombre, Prioridad, Fecha_Inicio, Fecha_Final, 'Agrícola', IdCargo);
END //
DELIMITER ;

-- Registrar una nueva tarea pecuaria
DELIMITER //
CREATE PROCEDURE RegistrarTareaPecuaria(IN Nombre VARCHAR(45), IN Prioridad VARCHAR(10), IN fecha_Inicio DATE, IN fecha_Final DATE, IN IdCargo INT)
BEGIN
    INSERT INTO tareas (Nombre, Prioridad, Fecha_Inicio, Fecha_Final, Tipo, IdCargo)
    VALUES (nombreTarea, prioridad, fechaInicio, fechaFin, 'Pecuario', IdCargo);
END //
DELIMITER ;

-- Registrar una venta
DELIMITER //
CREATE PROCEDURE RegistrarVentaConGanancia(IN idProducto INT, IN cantidad INT, IN precioVenta DECIMAL(10, 2))
BEGIN
    DECLARE precioCompra DECIMAL(10, 2);

    -- Obtener el precio de compra del producto
    SELECT Precio_Unitario INTO precioCompra
    FROM ordenes_compra
    WHERE idProducto = idProducto
    ORDER BY Fecha DESC
    LIMIT 1;

    -- Registrar la venta
    INSERT INTO ventas (idProducto, Cantidad, Total, Fecha)
    VALUES (idProducto, cantidad, cantidad * precioVenta, CURDATE());
END //
DELIMITER ;

-- Actualizar el inventario de maquinaria después de una compra
DELIMITER //
CREATE PROCEDURE ActualizarInventarioMaquinaria(
    IN idMaquinaria INT, 
    IN cantidad INT
)
BEGIN
    SET SQL_SAFE_UPDATES = 0;
    UPDATE inventario_maquinaria
    SET Cantidad = Cantidad + cantidad
    WHERE idMaquinaria = idMaquinaria;
    SET SQL_SAFE_UPDATES = 1;
END //
DELIMITER ;


-- Registrar una nueva herramienta
DELIMITER //
CREATE PROCEDURE RegistrarHerramienta(IN nombreHerramienta VARCHAR(45), IN cantidad INT, in ubicacion VARCHAR(45), IN estado VARCHAR(45), IN Fecha_Adquisicion DATE)
BEGIN
    INSERT INTO herramientas (Nombre, Cantidad, Ubicacion, Estado, Fecha_Adquisicion)
    VALUES (nombreHerramienta, cantidad, ubicacion, estado, fecha_adquisicion);
END //
DELIMITER ;

-- Obtener el total de ventas por empleado
DELIMITER //
CREATE PROCEDURE TotalVentasPorEmpleado(IN idEmpleado INT)
BEGIN
    SELECT e.Nombre, e.Apellido, SUM(v.Total) AS Total_Ventas
    FROM ventas v
    INNER JOIN empleados e ON v.idEmpleado = e.idEmpleado
    WHERE e.idEmpleado = idEmpleado
    GROUP BY e.Nombre, e.Apellido;
END //
DELIMITER ;
