-- Generar un informe diario de ventas en la tabla log
DELIMITER //
CREATE EVENT IF NOT EXISTS informe_diario_ventas
ON SCHEDULE EVERY 1 DAY
STARTS '2024-10-22 23:59:00'  
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
STARTS '2024-10-22 23:59:00'
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


