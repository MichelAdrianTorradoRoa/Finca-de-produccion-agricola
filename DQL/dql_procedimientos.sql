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
CREATE PROCEDURE RegistrarProduccionAgricola(IN idagricola INT, IN idpecuario INT, IN cantidad INT)
BEGIN   
    INSERT INTO produccion (idAgricola, idPecuario, Cantidad, Fecha)
    VALUES (idagricola, idpecuario, cantidad, CURDATE());
END //
DELIMITER ;



-- Registrar una nueva orden de compra y actualizar inventario
DELIMITER //
CREATE PROCEDURE RegistrarOrdenCompra(IN idProveedor INT, IN idProducto INT, IN cantidad INT, IN precio DECIMAL(10, 2))
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
    UPDATE empleados
    SET Salario = nuevoSalario
    WHERE idEmpleado = idEmpleado;
END //
DELIMITER ;

-- Asignar una nueva tarea a un empleado
DELIMITER //
CREATE PROCEDURE AsignarTareaEmpleado(IN idEmpleado INT, IN idTarea INT)
BEGIN
    INSERT INTO tareas_empleados (idEmpleado, idTarea, Fecha_Asignacion)
    VALUES (idEmpleado, idTarea, CURDATE());
END //
DELIMITER ;

-- Reparar maquinaria y actualizar su estado
DELIMITER //
CREATE PROCEDURE RepararMaquinaria(IN idMaquinaria INT, IN estado VARCHAR(45))
BEGIN
    UPDATE maquinaria
    SET Estado = estado
    WHERE idMaquinaria = idMaquinaria;

    -- Registrar la fecha de reparación en el historial de mantenimiento
    INSERT INTO mantenimiento_maquinaria (idMaquinaria, Fecha)
    VALUES (idMaquinaria, CURDATE());
END //
DELIMITER ;

-- Registrar una nueva tarea agrícola
DELIMITER //
CREATE PROCEDURE RegistrarTareaAgricola(IN nombreTarea VARCHAR(45), IN prioridad VARCHAR(10), IN fechaInicio DATE, IN fechaFin DATE)
BEGIN
    INSERT INTO tareas (Nombre, Prioridad, Fecha_Inicio, Fecha_Fin, Tipo)
    VALUES (nombreTarea, prioridad, fechaInicio, fechaFin, 'Agrícola');
END //
DELIMITER ;

-- Registrar una nueva tarea pecuaria
DELIMITER //
CREATE PROCEDURE RegistrarTareaPecuaria(IN nombreTarea VARCHAR(45), IN prioridad VARCHAR(10), IN fechaInicio DATE, IN fechaFin DATE)
BEGIN
    INSERT INTO tareas (Nombre, Prioridad, Fecha_Inicio, Fecha_Fin, Tipo)
    VALUES (nombreTarea, prioridad, fechaInicio, fechaFin, 'Pecuario');
END //
DELIMITER ;

-- Registrar una venta y calcular la ganancia
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

    -- Calcular la ganancia
    INSERT INTO ganancia_ventas (idProducto, Cantidad, Ganancia, Fecha)
    VALUES (idProducto, cantidad, (precioVenta - precioCompra) * cantidad, CURDATE());
END //
DELIMITER ;

-- Actualizar el inventario de maquinaria después de una compra
DELIMITER //
CREATE PROCEDURE ActualizarInventarioMaquinaria(IN idMaquinaria INT, IN cantidad INT)
BEGIN
    UPDATE inventario_maquinarias
    SET Cantidad = Cantidad + cantidad
    WHERE idMaquinaria = idMaquinaria;
END //
DELIMITER ;

-- Registrar una nueva herramienta
DELIMITER //
CREATE PROCEDURE RegistrarHerramienta(IN nombreHerramienta VARCHAR(45), IN cantidad INT)
BEGIN
    INSERT INTO herramientas (Nombre, Cantidad, Fecha_Registro)
    VALUES (nombreHerramienta, cantidad, CURDATE());
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
