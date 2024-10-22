-- Funcion para calcular el total de las ordenes de compra a proveedores
DELIMITER //
CREATE FUNCTION calcular_total_compras()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
DECLARE Total_Compras DECIMAL(10,2);
SELECT SUM(Total) INTO Total_Compras
FROM ordenes_compra;
RETURN Total_Compras;
END //
DELIMITER ;

-- Funcion para calcular el precio promedio de las ventas
DELIMITER //
CREATE FUNCTION calcular_promedio_ventas()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
DECLARE Promedio DECIMAL(10,2);
SELECT AVG(Total) INTO Promedio
FROM ventas;
RETURN Promedio;
END //
DELIMITER ;

-- Funcion para calcular el precio de los productos con el 10% de descuento
DELIMITER //
CREATE FUNCTION calcular_descuento_productos()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
DECLARE TotalConDescuento DECIMAL(10,2);
SELECT SUM(Precio - (Precio * 0.10)) INTO TotalConDescuento
FROM productos;
RETURN TotalConDescuento;
END //
DELIMITER ;

-- Funcion para calcular el costo total de una venta
DELIMITER //
CREATE FUNCTION calcular_total_venta(idVenta INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
DECLARE Total DECIMAL(10,2);
SELECT Total INTO Total
FROM ventas
WHERE idVenta = idVenta
LIMIT 1;
RETURN Total;
END //
DELIMITER ;

-- Funcion para obtener la cantidad de productos vendidos en un dia en especifico
DELIMITER //
CREATE FUNCTION cantidad_productos_vendidos(fecha DATE)
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE total_vendidos INT;
SELECT SUM(v.idVenta) INTO total_vendidos
FROM ventas v
WHERE v.Fecha = fecha;
RETURN IFNULL(total_vendidos, 0); 
END //
DELIMITER ;

-- Funcion para cacular de total de las ventas en un mes
DELIMITER //
CREATE FUNCTION total_ventas_mes(mes INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
DECLARE total_ventas DECIMAL(10,2);
SELECT SUM(Total) INTO total_ventas
FROM finca.ventas
WHERE MONTH(Fecha) = mes;
RETURN IFNULL(total_ventas, 0); 
END //
DELIMITER ;

-- Funcion para calcular la cantidad de produccion entre dos fechas
DELIMITER //
CREATE FUNCTION cantidad_produccion_entre_fechas(fecha_inicio DATE, fecha_fin DATE)
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE total_produccion INT;
SELECT SUM(Cantidad) INTO total_produccion
FROM produccion
WHERE Fecha BETWEEN fecha_inicio AND fecha_fin;
RETURN IFNULL(total_produccion, 0);
END //
DELIMITER ;

-- Funcion para calcular el total de clientes en una fecha de venta
DELIMITER //
CREATE FUNCTION total_clientes_ultimo_mes(fecha DATE)
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE total_clientes INT;
SELECT COUNT(idCliente) INTO total_clientes
FROM ventas
WHERE Fecha = fecha;
RETURN IFNULL(total_clientes, 0);
END //
DELIMITER ;

-- Funcion para obtener el promedio de ventas por empleado
DELIMITER //
CREATE FUNCTION promedio_ventas_por_empleado(idEmpleado INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
DECLARE promedio DECIMAL(10,2);
SELECT AVG(Total) INTO promedio
FROM ventas
WHERE idEmpleado = idEmpleado;
RETURN IFNULL(promedio, 0); 
END //
DELIMITER ;

-- Funcion para calcular el total de hectareas por tipo de terreno
DELIMITER //
CREATE FUNCTION total_hectareas_por_tipo(tipo_terreno VARCHAR(45))
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE total_hectareas INT;
SELECT SUM(Hectareas) INTO total_hectareas
FROM terreno_pecuario
WHERE Tipo = tipo_terreno;
RETURN IFNULL(total_hectareas, 0); 
END //
DELIMITER ;

-- Función para calcular el total de maquinaria en mantenimiento actualmente
DELIMITER //
CREATE FUNCTION total_maquinaria_en_mantenimiento()
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE total_maquinaria INT;
  SELECT COUNT(idMaquinaria) INTO total_maquinaria
  FROM mantenimiento_maquinaria
  WHERE Estado = 'En Mantenimiento';
  RETURN IFNULL(total_maquinaria, 0);
END //
DELIMITER ;

-- Función para obtener el total de herramientas en uso
DELIMITER //
CREATE FUNCTION total_herramientas_en_uso()
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE total_herramientas INT;
  SELECT COUNT(idHerramienta) INTO total_herramientas
  FROM tareas_herramientas
  WHERE Estado = 'En Uso';
  RETURN IFNULL(total_herramientas, 0);
END //
DELIMITER ;

-- Función para calcular el costo promedio de los productos
DELIMITER //
CREATE FUNCTION costo_promedio_productos()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  DECLARE promedio_costo DECIMAL(10,2);
  SELECT AVG(Precio) INTO promedio_costo
  FROM productos;
  RETURN IFNULL(promedio_costo, 0);
END //
DELIMITER ;

-- Función para calcular la producción total de un tipo específico de producto:

DELIMITER //
CREATE FUNCTION produccion_total_por_tipo(tipo_producto VARCHAR(45))
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE total_produccion INT;
  SELECT SUM(Cantidad) INTO total_produccion
  FROM produccion
  WHERE Tipo_Producto = tipo_producto;
  RETURN IFNULL(total_produccion, 0);
END //
DELIMITER ;

-- Función para obtener el total de empleados en un cargo específico

DELIMITER //
CREATE FUNCTION total_empleados_por_cargo(cargo_nombre VARCHAR(45))
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE total_empleados INT;
  SELECT COUNT(idEmpleado) INTO total_empleados
  FROM empleados
  WHERE Cargo = cargo_nombre;
  RETURN IFNULL(total_empleados, 0);
END //
DELIMITER ;

-- Función para calcular el total de gastos en maquinaria por proveedor
DELIMITER //
CREATE FUNCTION total_gastos_por_proveedor(idProveedor INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  DECLARE total_gastos DECIMAL(10,2);
  SELECT SUM(Costo) INTO total_gastos
  FROM ordenes_compra
  WHERE idProveedor = idProveedor;
  RETURN IFNULL(total_gastos, 0);
END //
DELIMITER ;

-- Función para obtener la cantidad total de productos en inventario por tipo
DELIMITER //
CREATE FUNCTION total_inventario_por_tipo(tipo_producto VARCHAR(45))
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE total_inventario INT;
  SELECT SUM(Cantidad) INTO total_inventario
  FROM inventario_producto
  WHERE Tipo_Producto = tipo_producto;
  RETURN IFNULL(total_inventario, 0);
END //
DELIMITER ;

-- Función para calcular el total de ventas realizadas por un cliente específico:

DELIMITER //
CREATE FUNCTION total_ventas_por_cliente(idCliente INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  DECLARE total_ventas DECIMAL(10,2);
  SELECT SUM(Total) INTO total_ventas
  FROM ventas
  WHERE idCliente = idCliente;
  RETURN IFNULL(total_ventas, 0);
END //
DELIMITER ;

-- Función para obtener el total de animales en una fecha específica:

DELIMITER //
CREATE FUNCTION total_animales_por_fecha(fecha DATE)
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE total_animales INT;
  SELECT SUM(Cantidad) INTO total_animales
  FROM pecuario
  WHERE Fecha_Ingreso = fecha;
  RETURN IFNULL(total_animales, 0);
END //
DELIMITER ;

-- Función para calcular el costo total de mantenimiento de una maquinaria específica:

DELIMITER //
CREATE FUNCTION costo_total_mantenimiento_maquinaria(idMaquinaria INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  DECLARE total_mantenimiento DECIMAL(10,2);
  SELECT SUM(Costo) INTO total_mantenimiento
  FROM mantenimiento_maquinaria
  WHERE idMaquinaria = idMaquinaria;
  RETURN IFNULL(total_mantenimiento, 0);
END //
DELIMITER ;

