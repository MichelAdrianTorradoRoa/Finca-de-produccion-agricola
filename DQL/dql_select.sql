-- 1. Obtener el proveedor que mas productos ha vendido
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

-- 2. Obtener las herramientas que necesitan mantenimiento
USE finca;
SELECT Nombre
FROM herramientas
WHERE idHerramienta IN (
    SELECT idHerramienta
    FROM mantenimiento_herramientas
);

-- 3. Obtener la cantidad de productos en el inventario
USE finca;
SELECT COUNT(*) AS Total_Productos
FROM productos
WHERE idProducto IN (
    SELECT idProducto
    FROM inventario_productos
    WHERE Estado = 'Disponible'
);

-- 4. Obtener cantidad de mantenimiento por cada tipo de maquinaria
USE finca;
SELECT idTipo_Maquinaria, COUNT(*) AS Mantenimientos
FROM mantenimiento_maquinaria
WHERE idTipo_Maquinaria IN (
    SELECT idTipo_Maquinaria
    FROM tipo_maquinaria
)
GROUP BY idTipo_Maquinaria;

-- 5. Obtener la ultima fecha de produccion agricola cosechada
USE finca;
SELECT Fecha AS Produccion
FROM produccion
WHERE idAgricola IN (
    SELECT idAgricola
    FROM agricola
    WHERE Estado = 'Cosechado'
);

-- 6. Obtener los productos vendidos en las ventas
USE finca;
SELECT p.nombre AS Productos
FROM productos p
WHERE idProducto IN (
    SELECT idProducto
    FROM productos_ventas 
);

-- 7. Obtener los productos que han sido comprados mas de una vez a proveedores 
USE finca;
SELECT p.Nombre
FROM productos p
WHERE p.idProducto IN (
    SELECT oc.idProducto
    FROM ordenes_compra oc
    GROUP BY oc.idProducto
    HAVING COUNT(oc.idOrdenes_Compra) > 1
);

-- 8. Obtener herramientas que se han usado en alguna tarea
USE finca;
SELECT Nombre
FROM herramientas
WHERE idHerramienta IN (
    SELECT idHerramienta
    FROM tareas_herramientas
);

-- 9. Obtener la cantidad de productos por tipo
USE finca;
SELECT Nombre, COUNT(*) AS Cantidad
FROM productos
WHERE idTipo IN (
    SELECT idTipo
    FROM tipo_productos
)
GROUP BY Nombre;

-- 10. Obtener los productos donde el precio es mayor al promedio
USE finca;
SELECT p.Nombre, p.Precio
FROM productos p
WHERE p.Precio > (
    SELECT AVG(Precio)
    FROM productos
);

-- 11. Obtener el total de ventas

USE finca;
SELECT SUM(Total) AS Total_Ventas
FROM ventas;

-- 12. Obtener el total de ventas por categoría de producto

USE finca;
SELECT tp.Nombre AS Categoria, COUNT(pv.idProducto) AS Total_Vendidos
FROM productos_ventas pv
JOIN productos p ON pv.idProducto = p.idProducto
JOIN tipo_productos tp ON p.idTipo = tp.idTipo
GROUP BY tp.Nombre;

-- 13. Obtener el ingreso total en una semana específica

USE finca;
SELECT SUM(Total) AS Ingreso_Total
FROM ventas
WHERE Fecha BETWEEN '2024-01-01' AND '2024-01-07';

-- 14. Obtener el número total de empleados

USE finca;
SELECT COUNT(*) AS Total_Empleados
FROM empleados;

-- 15. Obtener el promedio de salarios de los empleados.

USE finca;
SELECT AVG(Salario) AS Promedio_Salario
FROM empleados;

-- 16. Obtener los productos con el mayor inventario disponible

USE finca;
SELECT p.Nombre, ip.Cantidad
FROM productos p
JOIN inventario_productos ip ON p.idProducto = ip.idProducto
WHERE ip.Estado = 'Disponible'
ORDER BY ip.Cantidad DESC
LIMIT 10; 

-- 17. Obtener la suma total de costos de mantenimiento por tipo de maquinaria

USE finca;
SELECT tm.Nombre AS Tipo_Maquinaria, COUNT(mm.idMantenimiento_Maquinaria) AS Total_Mantenimientos
FROM mantenimiento_maquinaria mm
JOIN tipo_maquinaria tm ON mm.idTipo_Maquinaria = tm.idTipo_Maquinaria
GROUP BY tm.Nombre;

-- 18. Obtener la cantidad de tareas programadas para cada tipo de tarea

USE finca;
SELECT Tipo, COUNT(*) AS Total_Tareas
FROM tareas
GROUP BY Tipo;

-- 19. Obtener información sobre el mantenimiento de maquinaria

USE finca;
SELECT tp.Nombre AS Tipo_Producto, SUM(p.Precio) AS Ingreso_Generado
FROM productos_ventas pv
JOIN productos p ON pv.idProducto = p.idProducto
JOIN tipo_productos tp ON p.idTipo = tp.idTipo
GROUP BY tp.Nombre;

-- 20. Obtener los proveedores con la mayor cantidad de productos suministrados.

USE finca;
SELECT p.Nombre AS Proveedor, COUNT(op.idProducto) AS Total_Productos
FROM proveedores p
JOIN ordenes_compra op ON p.idProveedor = op.idProveedor
GROUP BY p.Nombre
ORDER BY Total_Productos DESC;

-- 21. Obtener productos disponibles en el inventario
USE finca;
SELECT p.Nombre, i.Cantidad
FROM productos p
JOIN inventario_productos i ON p.idProducto = i.idProducto
WHERE i.Estado = 'Disponible';

-- 22. Obtener el total de produccion agricola
USE finca;
SELECT idAgricola, SUM(Cantidad) AS Total_Produccion
FROM produccion
GROUP BY idAgricola;

-- 23. Obtener el total de compras por proveedor
USE finca;
SELECT p.Nombre, COUNT(oc.idOrdenes_Compra) AS Total_Ordenes
FROM proveedores p
JOIN ordenes_compra oc ON p.idProveedor = oc.idProveedor
GROUP BY p.Nombre;

-- 24. Obtener herramientas con sus tareas a realizar
USE finca;
SELECT h.Nombre AS Herramienta, t.Nombre AS Tarea
FROM herramientas h
JOIN tareas_herramientas th ON h.idHerramienta = th.idHerramienta
JOIN finca.tareas t ON th.idTarea = t.idTarea;

-- 25. Obtener las ventas totales por cada producto
USE finca;
SELECT p.Nombre, SUM(v.Total) AS Total_Ventas
FROM productos p
JOIN productos_ventas pv ON p.idProducto = pv.idProducto
JOIN ventas v ON pv.idVenta = v.idVenta
GROUP BY p.Nombre;

-- 26. Obtener la cantidad de maquinaria por cada tipo
USE finca;
SELECT idTipo_Maquinaria, COUNT(*) AS Total_Maquinaria
FROM maquinaria
GROUP BY idTipo_Maquinaria;

-- 27. Obtener los productos con sus tipos
USE finca;
SELECT p.Nombre AS Producto, tp.Nombre AS Tipo
FROM productos p
JOIN tipo_productos tp ON p.idTipo = tp.idTipo;

-- 28. Obtener el mantenimiento requerido por la maquinaria
USE finca;
SELECT m.Fecha, ma.Nombre AS Maquinaria
FROM mantenimiento_maquinaria m
JOIN maquinaria ma ON m.idMaquinaria = ma.idMaquinaria;

-- 29. Obtener los productos del inventario junto a su estado
USE finca;
SELECT p.Nombre, i.Estado
FROM productos p
JOIN inventario_productos i ON p.idProducto = i.idProducto;

-- 30. Obtener los detalles de produccion de los cereales
USE finca;
SELECT p.Fecha, p.Cantidad
FROM produccion p
JOIN tipo_productos tp ON p.idPecuario = tp.idTipo
WHERE tp.Nombre = 'Cereales';

-- 31. Obtener la cantidad de productos por cada estado
USE finca;
SELECT Estado, COUNT(*) AS Cantidad
FROM productos
GROUP BY Estado;

-- 32. Obtener las herramientas disponibles
USE finca;
SELECT h.Nombre AS Herramienta
FROM herramientas h
WHERE Estado = 'Bueno';

-- 33. Obtener la cantidad de proveedores que tienen orden de compra
USE finca;
SELECT COUNT(DISTINCT idProveedor) AS Total_Proveedores
FROM ordenes_compra;

-- 34. Obtener la ultima fecha de mantenimiento de cada maquinaria
USE finca;
SELECT idMantenimiento_Maquinaria, MAX(Fecha) AS Ultimo_Mantenimiento
FROM mantenimiento_maquinaria
GROUP BY idMantenimiento_Maquinaria;

-- 35. Obtener la cantidad total de productos de cada proveedor
USE finca;
SELECT pv.Nombre AS Proveedor, COUNT(oc.idProducto) AS Productos
FROM ordenes_compra oc
JOIN proveedores pv ON pv.idProveedor = oc.idProveedor
GROUP BY pv.Nombre;

-- 36. Obtener las ventas con sus productos
USE finca;
SELECT v.idVenta, p.Nombre AS Producto
FROM ventas v
JOIN productos_ventas pv ON v.idVenta = pv.idVenta
JOIN productos p ON pv.idProducto = p.idProducto;

-- 37. Obtener la cantidad de tareas con sus herramientas usadas
USE finca;
SELECT COUNT(DISTINCT t.idTarea) AS Total_Tareas, COUNT(DISTINCT h.idHerramienta) AS Total_Herramientas
FROM tareas_herramientas th
JOIN tareas t ON th.idTarea = t.idTarea
JOIN herramientas h ON th.idHerramienta = h.idHerramienta;

-- 38. Obtener la cantidad de tipos de produccion hay
USE finca;
SELECT COUNT(DISTINCT idTipo) AS Total_Tipos
FROM productos;

-- 39. Obtener las herramientas mas usadas en tareas
USE finca;
SELECT h.Nombre, COUNT(th.idTarea) AS Uso
FROM herramientas h
JOIN tareas_herramientas th ON h.idHerramienta = th.idHerramienta
GROUP BY h.Nombre
ORDER BY Uso DESC;

-- 40. Obtener las ordenes de compra que son superiores a 2000.00
USE finca;
SELECT *
FROM finca.ordenes_compra
WHERE Total > 2000.00;

-- 41. Obtener el total de herramientas por cada estado
USE finca;
SELECT mh.Tipo, COUNT(*) AS Herramientas
FROM mantenimiento_herramientas mh
GROUP BY mh.Tipo;

-- 42. Obtener el total de compras por cada estado
USE finca;
SELECT Estado, COUNT(*) AS Total
FROM ordenes_compra
GROUP BY Estado;

-- 43. Obtener el precio promedio de los productos
USE finca;
SELECT AVG(Precio) AS Precio_Promedio
FROM productos;

-- 44. Obtener las ordenes de compra con sus proveedores
USE finca;
SELECT oc.idOrdenes_Compra, p.Nombre AS Proveedor
FROM ordenes_compra oc
JOIN proveedores p ON oc.idProveedor = p.idProveedor;

-- 45. Obtener tareas que utilizan pala
USE finca;
SELECT t.Nombre AS Tarea
FROM tareas t
JOIN tareas_herramientas th ON t.idTarea = th.idTarea
WHERE th.idHerramienta = 2;

-- 46. Obtener las ventas entre el mes de enero
USE finca;
SELECT *
FROM ventas
WHERE Fecha BETWEEN '2024-01-01' AND '2024-01-31';

-- 47. Obtener la cantidad de mantenimiento por tipo de maquinaria
USE finca;
SELECT m.idTipo_Maquinaria, COUNT(*) AS Total_Mantenimiento
FROM mantenimiento_maquinaria m
GROUP BY m.idTipo_Maquinaria;

-- 48. Obtener las herramientas por el tipo de su mantenimiento
USE finca;
SELECT mh.Tipo, COUNT(*) AS Herramientas
FROM mantenimiento_herramientas mh
GROUP BY mh.Tipo;

-- 49. Obtener los proveedores que no han tenido ordenes de compra
USE finca;
SELECT p.Nombre
FROM proveedores p
WHERE p.idProveedor NOT IN (
    SELECT oc.idProveedor
    FROM ordenes_compra oc
);

-- 50. Obtener los productos que estan agotados
USE finca;
SELECT COUNT(*) AS Productos_Agotados
FROM inventario_productos
WHERE Cantidad = 0;

-- 51. Obtener los productos mas vendidos
USE finca;
SELECT p.Nombre, COUNT(*) AS Total_Ventas
FROM productos p
JOIN productos_ventas pv ON p.idProducto = pv.idProducto
GROUP BY p.Nombre
ORDER BY Total_Ventas DESC
LIMIT 10;

-- 52. Obtener la cantidad de mantenimientos durante el ultimo mes
USE finca;
SELECT COUNT(*) AS Total_Mantenimiento
FROM mantenimiento_maquinaria
WHERE Fecha >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

-- 53. Obtener el total de ventas durante el mes de enero
USE finca;
SELECT COUNT(*) AS Total_Ventas, SUM(Total) AS Total_Venta
FROM ventas
WHERE Fecha BETWEEN '2024-01-01' AND '2024-01-31';

-- 54. Obetener la cantidad de proveedores que tiene la finca
USE finca;
SELECT COUNT(*) AS Total_Proveedores
FROM proveedores;

-- 55. Obtener todos los productos junto a su tipo
USE finca;
SELECT p.Nombre AS Producto, tp.Nombre AS Tipo_Producto
FROM productos p
JOIN tipo_productos tp ON p.idTipo = tp.idTipo;

-- 56. Obtener el total de ventas por fecha
USE finca;
SELECT v.Fecha, SUM(v.Total) AS Total_Ventas
FROM ventas v
GROUP BY v.Fecha
ORDER BY v.Fecha;

-- 57. Obtener herramientas que han sido mantenidas mas de una vez
USE finca;
SELECT h.Nombre, COUNT(mh.idMantenimiento_Herramientas) AS Total_Mantenimientos
FROM herramientas h
JOIN mantenimiento_herramientas mh ON h.idHerramienta = mh.idHerramienta
GROUP BY h.Nombre
HAVING Total_Mantenimientos > 1;

-- 58. Obtener productos con mas de 10 cantidades disponibles
USE finca;
SELECT p.Nombre, p.Cantidad_Disponible
FROM productos p
WHERE p.Cantidad_Disponible > 10;

-- 59. Obtener las ordenes de compra con su proveedor

USE finca;SELECT oc.idOrdenes_Compra, p.Nombre AS Producto, pr.Nombre AS Proveedor, oc.Total
FROM ordenes_compra oc
JOIN productos p ON oc.idProducto = p.idProducto
JOIN proveedores pr ON oc.idProveedor = pr.idProveedor;

-- 60. Obtener los terrenos con mas de 20 hectareas
USE finca;
SELECT idTerreno_Pecuario, Hectareas, Tipo, Estado
FROM terreno_pecuario
WHERE Hectareas > 20;


-- 61. Obtener el proveedor que más productos ha vendido:

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

-- 62. Obtener las herramientas que necesitan mantenimiento:

USE finca;
SELECT Nombre
FROM herramientas
WHERE idHerramienta IN (
    SELECT idHerramienta
    FROM mantenimiento_herramientas
);


-- 63. Obtener la cantidad de productos en el inventario:

USE finca;
SELECT COUNT(*) AS Total_Productos
FROM productos
WHERE idProducto IN (
    SELECT idProducto
    FROM inventario_productos
    WHERE Estado = 'Disponible'
);

-- 64. Obtener la cantidad de mantenimiento por cada tipo de maquinaria:

USE finca;
SELECT idTipo_Maquinaria, COUNT(*) AS Mantenimientos
FROM mantenimiento_maquinaria
WHERE idTipo_Maquinaria IN (
    SELECT idTipo_Maquinaria
    FROM tipo_maquinaria
)
GROUP BY idTipo_Maquinaria;

-- 65. Obtener la última fecha de producción agrícola cosechada:

USE finca;
SELECT Fecha AS Produccion
FROM produccion
WHERE idAgricola IN (
    SELECT idAgricola
    FROM agricola
    WHERE Estado = 'Cosechado'
);

-- 66. Obtener los productos vendidos en las ventas:

USE finca;
SELECT p.nombre AS Productos
FROM productos p
WHERE idProducto IN (
    SELECT idProducto
    FROM productos_ventas 
);

-- 67. Obtener los productos comprados más de una vez a proveedores:

USE finca;
SELECT p.Nombre
FROM productos p
WHERE p.idProducto IN (
    SELECT oc.idProducto
    FROM ordenes_compra oc
    GROUP BY oc.idProducto
    HAVING COUNT(oc.idOrdenes_Compra) > 1
);

-- 68. Obtener herramientas que se han usado en alguna tarea:

USE finca;
SELECT Nombre
FROM herramientas
WHERE idHerramienta IN (
    SELECT idHerramienta
    FROM tareas_herramientas
);

-- 69. Obtener la cantidad de productos por tipo:

USE finca;
SELECT Nombre, COUNT(*) AS Cantidad
FROM productos
WHERE idTipo IN (
    SELECT idTipo
    FROM tipo_productos
)
GROUP BY Nombre;

-- 70. Obtener productos cuyo precio es mayor al promedio:

USE finca;
SELECT p.Nombre, p.Precio
FROM productos p
WHERE p.Precio > (
    SELECT AVG(Precio)
    FROM productos
);

-- 71. Obtener el cliente que más ha comprado productos:

USE finca;
SELECT c.Nombre
FROM clientes c
JOIN ventas v ON c.idCliente = v.idCliente
GROUP BY c.Nombre
ORDER BY SUM(v.Total) DESC
LIMIT 1;

-- 72. Obtener la cantidad total de ventas por cada mes:

USE finca;
SELECT DATE_FORMAT(Fecha, '%Y-%m') AS Mes, COUNT(*) AS Total_Ventas
FROM ventas
GROUP BY Mes;


-- 73. Obtener las maquinarias que necesitan mantenimiento urgente:

USE finca;
SELECT Nombre
FROM maquinaria
WHERE idMaquinaria IN (
    SELECT idMaquinaria
    FROM mantenimiento_maquinaria
);

-- 74. Obtener las tareas asignadas a más de 3 herramientas

USE finca;
SELECT t.Nombre
FROM tareas t
JOIN tareas_herramientas th ON t.idTarea = th.idTarea
GROUP BY t.idTarea
HAVING COUNT(th.idHerramienta) > 3;

-- 75. Obtener la producción total de productos pecuarios durante el último trimestre:

USE finca;
SELECT SUM(p.Cantidad) AS Total_Produccion
FROM produccion p
JOIN pecuario pe ON p.idPecuario = pe.idPecuario
WHERE p.Fecha BETWEEN '2024-07-01' AND '2024-09-30';

-- 76. Obtener los empleados con salarios superiores al salario promedio:

USE finca;
SELECT Nombre, Salario
FROM empleados
WHERE Salario > (SELECT AVG(Salario) FROM empleados);

-- 77. Obtener las herramientas que no han sido mantenidas en los últimos 15 dias:

USE finca;
SELECT h.Nombre
FROM herramientas h
WHERE idHerramienta NOT IN (
    SELECT idHerramienta
    FROM mantenimiento_herramientas
    WHERE Fecha >= DATE_SUB(CURDATE(), INTERVAL 15 DAY)
);

-- 78. Obtener los productos cuyo inventario es menor a 100 unidades:

USE finca;
SELECT p.Nombre, i.Cantidad
FROM productos p
JOIN inventario_productos i ON p.idProducto = i.idProducto
WHERE i.Cantidad < 100;

-- 79. Obtener el proveedor con la mayor cantidad de ordenes de compra durante el año:

USE finca;
SELECT p.Nombre, COUNT(oc.idOrdenes_Compra) AS Total_Ordenes
FROM proveedores p
JOIN ordenes_compra oc ON p.idProveedor = oc.idProveedor
WHERE oc.Fecha BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY p.Nombre
ORDER BY Total_Ordenes DESC
LIMIT 1;


-- 80. Obtener las ventas que incluyen productos de más de un tipo:

USE finca;
SELECT v.idVenta, COUNT(DISTINCT tp.idTipo) AS Tipos_Distintos
FROM ventas v
JOIN productos_ventas pv ON v.idVenta = pv.idVenta
JOIN productos p ON pv.idProducto = p.idProducto
JOIN tipo_productos tp ON p.idTipo = tp.idTipo
GROUP BY v.idVenta
HAVING Tipos_Distintos > 1;


-- 81. Mostrar todos los productos que sean granos disponibles.
SELECT * FROM productos WHERE idTipo = (SELECT idTipo FROM tipo_productos WHERE Nombre = 'Granos');

-- 82. Listar todas las maquinarias de la finca.
SELECT * FROM maquinaria;

-- 83. Listar todos los clientes registrados.
SELECT * FROM clientes;

-- 84. Mostrar todos los empleados de la finca.
SELECT * FROM empleados;

-- 85. Mostrar todas las órdenes de compra a proveedores.
SELECT * FROM ordenes_compra;

-- 86. Listar todas las ventas superiores a $500.000 COP.
SELECT * FROM ventas WHERE Total > 500000;

-- 87. Mostrar todos los productos que sean de tipo 'lácteos'
SELECT * FROM productos WHERE idTipo = (SELECT idTipo FROM tipo_productos WHERE Nombre = 'Lácteos');

-- 88. Listar los proveedores con los que se trabaja regularmente.
SELECT * FROM proveedores;

-- 89. Mostrar las órdenes de compra que están pendientes.
SELECT * FROM ordenes_compra WHERE Fecha = '2024-05-25';

-- 90. Actualizar el precio de todos los productos agrícolas en un 5%.
UPDATE productos
SET Precio = Precio * 1.05
WHERE idTipo = (SELECT idTipo FROM tipo_productos WHERE Nombre = 'Agrícola');

-- 91. Modificar el inventario de un producto específico después de una venta.
UPDATE inventario_productos
SET Cantidad = Cantidad - 10
WHERE idProducto = 1; -- ID del producto específico

-- 92. Actualizar el estado de una orden de compra después de que los productos han sido entregados.
UPDATE ordenes_compra
SET Estado = 'Completada'
WHERE idOrdenes_Compra = 1;

-- 93. Modificar los datos de un cliente específico.
UPDATE clientes
SET Estado = 'Inactivo'
WHERE idCliente = 1;

-- 94. Actualizar el salario de un empleado después de una revisión anual.
UPDATE empleados
SET Salario = Salario * 1.10
WHERE idEmpleado = 1;

-- 95. Eliminar los productos que están agotados
SET SQL_SAFE_UPDATES = 0;
DELETE FROM inventario_productos WHERE Estado = 'Agotado';
SET SQL_SAFE_UPDATES = 1;

-- 96. Eliminar las órdenes de compra que ya han sido completadas hace más de un año
SET SQL_SAFE_UPDATES = 0;
DELETE FROM ordenes_compra
WHERE Estado = 'Completado' AND Fecha < NOW() - INTERVAL 1 YEAR;
SET SQL_SAFE_UPDATES = 1;

-- 97. Eliminar los registros de ventas de hace más de dos años.
SET SQL_SAFE_UPDATES = 0;
DELETE FROM ventas
WHERE Fecha < DATE_SUB(CURDATE(), INTERVAL 2 YEAR);
SET SQL_SAFE_UPDATES = 1;
-- 98. Borrar los clientes que no han realizado compras en los últimos tres años.
SET SQL_SAFE_UPDATES = 0;
DELETE FROM clientes
WHERE idCliente NOT IN (
    SELECT v.idCliente FROM ventas v WHERE v.Fecha >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
);
SET SQL_SAFE_UPDATES = 1;

-- 99. Obtener los productos que han estado en mantenimiento de maquinaria:
 
USE finca;
SELECT p.Nombre AS Producto, COUNT(mm.idMantenimiento_Maquinaria) AS Veces_Mantenimiento
FROM productos p
JOIN productos_maquinaria pm ON p.idProducto = pm.idProducto
JOIN mantenimiento_maquinaria mm ON pm.idMaquinaria = mm.idMaquinaria
GROUP BY p.Nombre
ORDER BY Veces_Mantenimiento DESC;

-- 100. Obtener las ventas totales por cliente (con tipo de cliente incluido):
USE finca;
SELECT c.Nombre AS Cliente, c.Tipo AS Tipo_Cliente, SUM(v.Total) AS Total_Ventas
FROM clientes c
JOIN ventas v ON c.idCliente = v.idCliente
GROUP BY c.Nombre, c.Tipo
ORDER BY Total_Ventas DESC;