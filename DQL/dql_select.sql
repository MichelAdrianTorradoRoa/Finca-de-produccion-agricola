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
    FROM mantenimiento_herramientas
);

-- Obtener la cantidad de productos en el inventario
USE finca;
SELECT COUNT(*) AS Productos
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


USE finca;
SELECT SUM(Total) AS Ventas
FROM ventas;

USE finca;
SELECT tp.Nombre AS Categoria, COUNT(pv.idProducto) AS Vendidos
FROM productos_ventas pv
JOIN productos p ON pv.idProducto = p.idProducto
JOIN tipo_productos tp ON p.idTipo = tp.idTipo
GROUP BY tp.Nombre;

USE finca;
SELECT SUM(Total) AS Ingresos
FROM ventas
WHERE Fecha BETWEEN '2024-01-01' AND '2024-01-07';

USE finca;
SELECT COUNT(*) AS Empleados
FROM empleados;

USE finca;
SELECT AVG(Salario) AS Promedio
FROM empleados;

USE finca;
SELECT p.Nombre, ip.Cantidad
FROM productos p
JOIN inventario_productos ip ON p.idProducto = ip.idProducto
WHERE ip.Estado = 'Disponible'
ORDER BY ip.Cantidad DESC
LIMIT 10; 

USE finca;
SELECT tm.Nombre AS Tipo_Maquinaria, COUNT(mm.idMantenimiento_Maquinaria) AS Mantenimientos
FROM mantenimiento_maquinaria mm
JOIN tipo_maquinaria tm ON mm.idTipo_Maquinaria = tm.idTipo_Maquinaria
GROUP BY tm.Nombre;


USE finca;
SELECT Tipo, COUNT(*) AS Tareas
FROM tareas
GROUP BY Tipo_Tarea;

USE finca;
SELECT tp.Nombre AS Tipo_Producto, SUM(p.Precio) AS Ingresos
FROM productos_ventas pv
JOIN productos p ON pv.idProducto = p.idProducto
JOIN tipo_productos tp ON p.idTipo = tp.idTipo
GROUP BY tp.Nombre;


USE finca;
SELECT p.Nombre AS Proveedor, COUNT(op.idProducto) AS Productos
FROM proveedores p
JOIN ordenes_compra op ON p.idProveedor = op.idProveedor
GROUP BY p.Nombre
ORDER BY Total_Productos DESC;

-- Obtener productos disponibles en el inventario
USE finca;
SELECT p.Nombre, i.Cantidad
FROM productos p
JOIN inventario_productos i ON p.idProducto = i.idProducto
WHERE i.Estado = 'Disponible';

-- Obtener el total de produccion agricola
USE finca;
SELECT idAgricola, SUM(Cantidad) AS Produccion
FROM produccion
GROUP BY idAgricola;

-- Obtener el total de compras por proveedor
USE finca;
SELECT p.Nombre, COUNT(oc.idOrdenes_Compra) AS Total
FROM proveedores p
JOIN ordenes_compra oc ON p.idProveedor = oc.idProveedor
GROUP BY p.Nombre;

-- Obtener herramientas con sus tareas a realizar
USE finca;
SELECT h.Nombre AS Herramienta, t.Nombre AS Tarea
FROM herramientas h
JOIN tareas_herramientas th ON h.idHerramienta = th.idHerramienta
JOIN finca.tareas t ON th.idTarea = t.idTarea;

-- Obtener las ventas totales por cada producto
USE finca;
SELECT p.Nombre, SUM(v.Total) AS Total
FROM productos p
JOIN productos_ventas pv ON p.idProducto = pv.idProducto
JOIN ventas v ON pv.idVenta = v.idVenta
GROUP BY p.Nombre;

-- Obtener la cantidad de maquinaria por cada tipo
USE finca;
SELECT idTipo_Maquinaria, COUNT(*) Maquinarias
FROM maquinaria
GROUP BY idTipo_Maquinaria;

-- Obtener los productos con sus tipos
USE finca;
SELECT p.Nombre AS Producto, tp.Nombre AS Tipo
FROM productos p
JOIN tipo_productos tp ON p.idTipo = tp.idTipo;

-- Obtener el mantenimiento requerido por la maquinaria
USE finca;
SELECT m.Fecha, ma.Nombre AS Maquinaria
FROM mantenimiento_maquinaria m
JOIN maquinaria ma ON m.idMaquinaria = ma.idMaquinaria;

-- Obtener los productos del inventario junto a su estado
USE finca;
SELECT p.Nombre, i.Estado
FROM productos p
JOIN inventario_productos i ON p.idProducto = i.idProducto;

-- Obtener los detalles de produccion de los cereales
USE finca;
SELECT p.Fecha, p.Cantidad
FROM produccion p
JOIN tipo_productos tp ON p.idPecuario = tp.idTipo
WHERE tp.Nombre = 'Cereales';

-- Obtener la cantidad de productos por cada estado
USE finca;
SELECT Estado, COUNT(*) AS Cantidad
FROM productos
GROUP BY Estado;

-- Obtener las herramientas disponibles
USE finca;
SELECT h.Nombre AS Herramienta
FROM herramientas h
WHERE idHerramienta NOT IN (
    SELECT idHerramienta
    FROM tareas_herramientas
);

-- Obtener la cantidad de proveedores que tienen orden de compra
USE finca;
SELECT COUNT(DISTINCT idProveedor) AS Proveedores
FROM ordenes_compra;

-- Obtener la ultima fecha de mantenimiento de cada maquinaria
USE finca;
SELECT nombre, MAX(Fecha) AS Ultimo_Mantenimiento
FROM mantenimiento_maquinaria
GROUP BY nombre;

-- Obtener la cantidad total de productos de cada proveedor
USE finca;
SELECT p.Nombre AS Proveedor, SUM(pv.Cantidad) AS Productos
FROM proveedores p
JOIN ordenes_compra oc ON p.idProveedor = oc.idProveedor
JOIN productos p ON oc.idProducto = p.idProducto
GROUP BY p.Nombre;

-- Obtener las ventas con sus productos
USE finca;
SELECT v.idVenta, p.Nombre AS Producto
FROM ventas v
JOIN productos_ventas pv ON v.idVenta = pv.idVenta
JOIN productos p ON pv.idProducto = p.idProducto;

-- Obtener la cantidad de tareas con sus herramientas usadas
USE finca;
SELECT COUNT(DISTINCT t.idTarea) AS Total_Tareas, COUNT(DISTINCT h.idHerramienta) AS Herramientas
FROM tareas_herramientas th
JOIN tareas t ON th.idTarea = t.idTarea
JOIN herramientas h ON th.idHerramienta = h.idHerramienta;

-- Obtener la cantidad de tipos de produccion hay
USE finca;
SELECT COUNT(DISTINCT idTipo) AS Total_Tipos
FROM productos;

-- Obtener las herramientas mas usadas en tareas
USE finca;
SELECT h.Nombre, COUNT(th.idTarea) AS Uso
FROM herramientas h
JOIN tareas_herramientas th ON h.idHerramienta = th.idHerramienta
GROUP BY h.Nombre
ORDER BY Uso DESC;

-- Obtener las ordenes de compra que son superiores a 2000.00
USE finca;
SELECT *
FROM finca.ordenes_compra
WHERE Total > 2000.00;

-- Obtener el total de herramientas por cada tipo
USE finca;
SELECT h.Tipo, COUNT(*) AS Total_Herramientas
FROM herramientas h
GROUP BY h.Tipo;

-- Obtener el total de compras por cada estado
USE finca;
SELECT Estado, COUNT(*) AS Total
FROM ordenes_compra
GROUP BY Estado;

-- Obtener el precio promedio de los productos
USE finca;
SELECT AVG(Precio) AS Precio_Promedio
FROM productos;

-- Obtener las ordenes de compra con sus proveedores
USE finca;
SELECT oc.idOrdenes_Compra, p.Nombre AS Proveedor
FROM ordenes_compra oc
JOIN proveedores p ON oc.idProveedor = p.idProveedor;

-- Obtener tareas que utilizan pala
USE finca;
SELECT t.Nombre AS Tarea
FROM tareas t
JOIN tareas_herramientas th ON t.idTarea = th.idTarea
WHERE th.idHerramienta = 2;

-- Obtener las ventas entre el mes de enero
USE finca;
SELECT *
FROM ventas
WHERE Fecha BETWEEN '2024-01-01' AND '2024-01-31';

-- Obtener la cantidad de mantenimiento por tipo de maquinaria
USE finca;
SELECT m.idTipo_Maquinaria, COUNT(*) AS Mantenimientos
FROM mantenimiento_maquinaria m
GROUP BY m.idTipo_Maquinaria;

-- Obtener las herramientas por el estado de su mantenimiento
USE finca;
SELECT Estado_Mantenimiento, COUNT(*) AS Herramientas
FROM herramientas
GROUP BY Estado_Mantenimiento;

-- Obtener los proveedores que no han tenido ordenes de compra
USE finca;
SELECT p.Nombre
FROM proveedores p
WHERE p.idProveedor NOT IN (
    SELECT oc.idProveedor
    FROM ordenes_compra oc
);

-- Obtener los productos que estan agotados
USE finca;
SELECT COUNT(*) AS Agotados
FROM inventario_productos
WHERE Cantidad = 0;

-- Obtener los productos mas vendidos
USE finca;
SELECT p.Nombre, COUNT(*) AS Total
FROM productos p
JOIN productos_ventas pv ON p.idProducto = pv.idProducto
GROUP BY p.Nombre
ORDER BY Total_Ventas DESC
LIMIT 10;

-- Obtener la cantidad de mantenimientos durante el ultimo mes
USE finca;
SELECT COUNT(*) AS Mantenimientos
FROM mantenimiento_maquinaria
WHERE Fecha >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

-- Obtener el total de ventas durante el mes de enero
USE finca;
SELECT COUNT(*) AS Total_Ventas, SUM(Total) AS Total
FROM ventas
WHERE Fecha BETWEEN '2024-01-01' AND '2024-01-31';

-- Obetener la cantidad de proveedores que tiene la finca
USE finca;
SELECT COUNT(*) AS Total_Proveedores
FROM proveedores;

-- Obtener todos los productos junto a su tipo
USE finca;
SELECT p.Nombre AS Producto, tp.Nombre AS Tipo
FROM productos p
JOIN tipo_productos tp ON p.idTipo = tp.idTipo;

-- Obtener el total de ventas por fecha
USE finca;
SELECT v.Fecha, SUM(v.Total) AS Total_Ventas
FROM ventas v
GROUP BY v.Fecha
ORDER BY v.Fecha;

-- Obtener herramientas que han sido mantenidas almenos una vez
USE finca;
SELECT h.Nombre, COUNT(mh.idManteniminto_Herramientas) AS Mantenimientos
FROM herramientas h
JOIN manteniminto_herramientas mh ON h.idHerramienta = mh.idHerramienta
GROUP BY h.Nombre
HAVING Total_Mantenimientos > 1;

-- Obtener productos con mas de 10 cantidades disponibles
USE finca;
SELECT p.Nombre, p.Cantidad_Disponible
FROM productos p
WHERE p.Cantidad_Disponible < 10;

-- Obtener las ordenes de compra con su proveedor

USE finca;SELECT oc.idOrdenes_Compra, p.Nombre AS Producto, pr.Nombre AS Proveedor, oc.Total
FROM ordenes_compra oc
JOIN productos p ON oc.idProducto = p.idProducto
JOIN proveedores pr ON oc.idProveedor = pr.idProveedor;

-- Obtener los terrenos con mas de 20 hectareas
USE finca;
SELECT idTerreno_Pecuario, Hectareas, Tipo, Estado
FROM terreno_pecuario
WHERE Hectareas > 20;

