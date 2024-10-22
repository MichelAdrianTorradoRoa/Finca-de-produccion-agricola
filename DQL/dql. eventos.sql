-- Generar un informe diario de ventas en la tabla log
DELIMITER //
CREATE EVENT IF NOT EXISTS informe_diario_ventas
ON SCHEDULE EVERY 1 DAY
STARTS '2024-10-21 00:00:00'
DO
BEGIN
DECLARE total DECIMAL(10,2);
DECLARE idventa INT;
SELECT SUM(Total) INTO total
FROM ventas
WHERE Fecha = CURDATE() - INTERVAL 1 DAY;
SELECT idVenta INTO idventa
FROM ventas
WHERE Fecha = CURDATE() - INTERVAL 1 DAY;
INSERT INTO log_ventas (Fecha, Mensaje, idVenta)
VALUES (CURDATE() - INTERVAL 1 DAY, CONCAT('Se ha hecho un total de ',total,' ventas'), idventa);
END //
DELIMITER ;

-- Actualizar el inventario de productos diariamente
DELIMITER //
CREATE EVENT IF NOT EXISTS actualizar_inventario_diario
ON SCHEDULE EVERY 1 DAY
STARTS '2024-10-22 00:00:00'
DO
BEGIN
DECLARE cantidad INT;
SELECT Cantidad INTO cantidad
FROM ventas
WHERE idProducto IN (
    SELECT idProducto
    FROM Productos );
UPDATE inventario_productos
SET Cantidad = Cantidad - cantidad
WHERE idProducto = idProducto AND Estado = 'Disponible';
END //
DELIMITER ;

-- Generar una alerta en la tabla log cuando un producto en inventario este en cero
DELIMITER //
CREATE EVENT IF NOT EXISTS alerta_inventario_agotado
ON SCHEDULE EVERY 1 DAY
STARTS '2024-10-22 00:00:00'
DO
BEGIN
    -- Insertar un mensaje en log_productos para todos los productos agotados
    INSERT INTO log_productos (Mensaje, Fecha, idProducto)
    SELECT CONCAT('El producto con ID ', idProducto, ' se ha agotado.'), CURDATE(), idProducto
    FROM inventario_productos
    WHERE Cantidad = 0 AND Estado = 'Disponible';
END //
DELIMITER ;

-- Registrar ventas del mes anterior en la tabla historial_ventas
DELIMITER //
CREATE EVENT IF NOT EXISTS archivar_ventas_mensual
ON SCHEDULE EVERY 1 MONTH
STARTS '2024-10-22 00:00:00'
DO
BEGIN
INSERT INTO historial_ventas (Fecha, idVenta)
SELECT CURDATE(), idVenta
FROM ventas
WHERE MONTH(Fecha) = MONTH(CURDATE() - INTERVAL 1 MONTH)
AND YEAR(Fecha) = YEAR(CURDATE() - INTERVAL 1 MONTH);
END //
DELIMITER ;

-- Generar un reporte semanal de los productos más vendidos
DELIMITER //
CREATE EVENT IF NOT EXISTS productos_mas_vendidos
ON SCHEDULE EVERY 1 WEEK
STARTS '2024-10-22 00:00:00' 
DO
BEGIN
DECLARE producto_mas_vendido INT;
DECLARE cantidad_vendida INT;
SELECT idProducto, COUNT(*) AS cantidad
INTO producto_mas_vendido, cantidad_vendida
FROM productos_ventas pv
JOIN ventas v ON pv.idVenta = v.idVenta
WHERE v.Fecha BETWEEN CURDATE() - INTERVAL 7 DAY AND CURDATE()
GROUP BY idProducto
ORDER BY cantidad DESC
LIMIT 1;
INSERT INTO log_productos (Mensaje, Fecha, idProducto)
VALUES (CONCAT('El producto más vendido de la semana fue el producto con ID ', producto_mas_vendido, ' con ', cantidad_vendida, ' ventas.'), CURDATE(), producto_mas_vendido);
END //
DELIMITER ;

-- Generar un aviso de hacer pedido a un proveedor en la tabla log cuando se este acabando un producto
DELIMITER //
CREATE EVENT IF NOT EXISTS pedido_semanal
ON SCHEDULE EVERY 1 WEEK
STARTS '2024-10-29 00:00:00' -- Ajusta la fecha de inicio
DO
BEGIN
INSERT INTO log_proveedores (Mensaje, Fecha, idProveedor)
SELECT CONCAT('El producto ', p.Nombre, ' esta quedando agotado (', p.Cantidad_Disponible, ' unidades)'), CURDATE(), p.idProveedor
FROM productos p
WHERE p.Cantidad_Disponible < 10; 
END //
DELIMITER ;

-- Generar una semana de descuento para los productos del 8%
DELIMITER //
CREATE EVENT IF NOT EXISTS aplicar_descuento_semanal
ON SCHEDULE AT '2024-10-22 00:00:00' 
DO
BEGIN
UPDATE productos
SET Precio = Precio * 0.92; 
END //
DELIMITER ;

-- Quitar el descuento del 8% la siguiente semana
DELIMITER //
CREATE EVENT IF NOT EXISTS restaurar_precios
ON SCHEDULE AT '2024-10-30 00:00:00' 
DO
BEGIN
UPDATE productos
SET Precio = Precio / 0.92; 
END //
DELIMITER ;

-- Eliminar empleado que el estado este en 'Retirado'
DELIMITER //
CREATE EVENT IF NOT EXISTS eliminar_empleados_retirados
ON SCHEDULE EVERY 1 WEEK
STARTS '2024-10-22 00:00:00' 
DO
BEGIN
DELETE FROM empleados
WHERE Estado = 'Retirado';
END //
DELIMITER ;

-- Generar un reporte mensual de ingresos por las ventas
DELIMITER //
CREATE EVENT IF NOT EXISTS generar_reporte_ingresos_mensual
ON SCHEDULE LAST DAY OF MONTH
DO
BEGIN
DECLARE total_ingresos DECIMAL(10, 2);
DECLARE mensaje VARCHAR(45);
SELECT SUM(Total) INTO total_ingresos
FROM ventas
WHERE MONTH(Fecha) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH)
AND YEAR(Fecha) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH);
SET mensaje = CONCAT('Total de ventas en ', DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%M %Y'), ': ', total_ingresos);
INSERT INTO log_ventas (Mensaje, Fecha, idVenta)
VALUES (mensaje, CURRENT_DATE - INTERVAL 1 MONTH, NULL);
END //
DELIMITER ;
