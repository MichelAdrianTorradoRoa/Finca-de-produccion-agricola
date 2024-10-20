-- Obtener el proveedor que mas productos ha vendido
USE finca;
SELECT Nombre
FROM proveedores
WHERE idProveedor = (
    SELECT idProveedor
    FROM ordenes_compra
    GROUP BY idProveedor
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- Obtener las herramientas que necesitan mantenimiento
USE finca;
SELECT Nombre
FROM herramientas
WHERE idHerramienta IN (
    SELECT idHerramienta
    FROM manteniminto_herramientas
);

-- Obtener la cantidad de productos en el inventario
USE finca;
SELECT COUNT(*) AS Total_Productos
FROM productos
WHERE idProducto IN (
    SELECT idProducto
    FROM inventario_productos
    WHERE Estado = 'Disponible'
);

--  Obtener cantidad de mantenimiento por cada tipo de maquinaria
USE finca;
SELECT idTipo_Maquinaria, COUNT(*) AS Mantenimientos
FROM mantenimiento_maquinaria
WHERE idTipo_Maquinaria IN (
    SELECT idTipo_Maquinaria
    FROM tipo_maquinaria
)
GROUP BY idTipo_Maquinaria;

-- Obtener la ultima fecha de produccion agricola cosechada
USE finca;
SELECT Fecha AS Produccion
FROM produccion
WHERE idAgricola IN (
    SELECT idAgricola
    FROM agricola
    WHERE Estado = 'Cosechado'
);

-- Obtener los productos vendidos en las ventas
USE finca;
SELECT p.nombre AS Productos
FROM productos p
WHERE idProducto IN (
    SELECT idProducto
    FROM productos_ventas 
);

-- Obtener los productos que han sido comprados mas de una vez a proveedores 
USE finca;
SELECT p.Nombre
FROM productos p
WHERE p.idProducto IN (
    SELECT oc.idProducto
    FROM ordenes_compra oc
    GROUP BY oc.idProducto
    HAVING COUNT(oc.idOrdenes_Compra) > 1
);

-- Obtener herramientas que se han usado en alguna tarea
USE finca;
SELECT Nombre
FROM herramientas
WHERE idHerramienta IN (
    SELECT idHerramienta
    FROM tareas_herramientas
);

-- Obtener la cantidad de productos por tipo
USE finca;
SELECT Nombre, COUNT(*) AS Cantidad
FROM productos
WHERE idTipo IN (
    SELECT idTipo
    FROM tipo_productos
)
GROUP BY Nombre;

-- Obtener los productos donde el precio es mayor al promedio
USE finca;
SELECT p.Nombre, p.Precio
FROM productos p
WHERE p.Precio > (
    SELECT AVG(Precio)
    FROM productos
);
