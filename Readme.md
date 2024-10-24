# Finca de produccion agricola 👨🏾‍🌾

Este proyecto consta de la gestion y manipulación de una base de datos de una finca la cual se manejarán aspectos relacionados con los productos, clientes, terrenos, proveedores, empleados y demás campos de esta área.

## Tabla de contenidos 📋
| Indice | Titulo  |
|--|--|
| 1 | [Requerimientos](#requerimientos) |
| 2 | [Instalación](#tinstalacion) |
| 3 | [Estructuracion](#estructura-base-de-datos) |
| 4 | [Cosultas SQL](#consultas-sql) |
| 5 | [Procedimientos, Funciones, Eventos y Triggers](#procedimientos-funciones-eventos-y-triggers) |
| 6 | [Roles de usuario](#roles-de-usuario) |
| 7 | [Contribuciones](#contribuciones) |
| 8 | [Licencia y contacto](#licencia-y-contacto) |
| 9 | [Autores](#autores) |

## Requerimientos
🐬
MySQL o cualquier base de datos compatible con SQL como Postgres o MySQL Workbench

## Instalacion
⏬
1. Abrir MySQL Workbench o editor de SQL
2. Seleccionar el entorno con el usuario y la contraseña
3. Crear una hoja de SQL
4. Copiar archivo DDL y DML y ejecutrarlo en el programa dandole al rayo que se encuentra en la parte superior izquierda
5. Manipular las consultas, procedimientos, funciones, eventos y trigger con os archivos DQL

## Estructura Base de Datos
💾

1. `agricola` -> tabla enfocada a la materia prima producida por el suelo y su cultivacion, donde se relaciona con los productos y el terreno en que fueron cultivadas
2. `cargo` -> tabla enfocada al cargo correspondiente de los empleados de la finca estando directamente relacionada con los empleados
3. `ciudad` -> tabla enfocada a tener registro de las ciudades de las direcciones registradas de el sistema
4. `clientes` -> tabla enfocada el registro de los clientes con toda su informacion y relacionados con su direccion 
5. `dirección` -> tabla enfocada para registrar la direccion de los clientes de la finca
6. `empleados` -> tabla enfocada para guardar la informacion de los empleados vinculados a la finca, relacionandolos con su cargo correspondiente 
7. `empleados_maquinaria` -> tabla enfocada a guardar la informacion de la maquinaria la cual le corresponde al empleado
8. `herramientas` -> tabla enfocada a guardar informacion de las herramientas y su estado que se usan en la finca
9. `historial_ventas` -> tabla enfocada a guardar el historial de cada venta, relacionandose con las ventas
10. `inventario_herramientas` -> tabla enfocada a guardar informacion de la cantidad de herramientas con las que cuenta la finca
11. `inventario_maquinaria` -> tabla enfocada a guardar la informacion de la cantidad de maquinaria con las que cuenta la finca 
12. `inventario_productos` -> tabla enfoca a guardar la informacion de la cantidad de productos con las cuenta la empresa
13. `log_empleados` -> tabla enfocada a guardar registros que se relacionen con la manipulacion de empleados 
14. `log_maquinaría` -> tabla enfocada a guardar registros que se relacionen con la manipulacion de la maquinaria
15. `log_productos` -> tabla enfocada a guardar registros que se relacionen con la manipulacion de los productos
16. `log_proveedores` -> tabla enfocada a guardar registros que se relacionen con la manipulacion de los proveedores
17. `log_ventas` -> tabla enfocada a guardar registros que se relacionen con la manipulacion de las ventas
18. `mantenimiento_herramientas` -> tabla enfocada a guardar el mantenimiento que requieren las herramientas de la finca
19. `mantenimiento_maquinaria`-> tabla enfocada a guardar el mantenimiento que requieren la maquinaria de la finca
20. `maquinaria` -> tabla enfocada para guardar la informacion de la maquinaria que se usa en la finca
21. `ordenes_compra` -> tabla enfocada a registrar las ordenes de compra que se realizan entre los proveedores y los productos a pedir
22. `país` -> tabla enfocada a guardar informacion de los paises de la ciudades registradas en el sistema
23. `pecuario` -> tabla enfocada a guardar informacion y estado de salud de los animales que se encuentran en la finca
24. `producción` -> tabla enfocada a guardar la informacion de la produccion que proporcionan los cultivos y los animales de la finca
25. `productos` -> tabla enfocada a guardar la informacion, cantidad y estado de los productos de la finca 
26. `productos_maquinaria` -> tabla enfocada a guardar la informacion de los productos que pasan por una maquinaria en el momento de la produccion
27. `productos_ventas` -> tabla enfocada a guardar la informacion de la relacion entre las ventas y los productos
28. `proveedores` -> tabla enfocada a guardar la informacion de los proveedores que tiene la finca
29. `tareas` -> tabla enfocada para registrar las tareas que le corresponden a las herramientas 
30. `tareas_herramientas` -> tabla enfocada a registrar la relacion de las herramientas que tienen varias tareas
31. `terreno_agricola` -> tabla enfocada a registrar los terrenos que se utilizan para la produccion agricola de la finca
32. `terreno_pecuario` -> tabla enfocada a registrar los terrenos que se utilizan para la produccion por parte de los animales de la finca
33. `tipo_maquinaria` -> tabla enfocada a registrar el tipo de maquinaria que hay en la finca
34. `tipo_productos` -> tabla enfocada a registrar el tipo de productos que hay en la finca
35. `ventas` -> tabla para registar las ventas que tiene la finca


## Consultas SQL
🔍
Se podrán encontrar algunas consultas realizadas:

1. Obtener el proveedor que mas productos ha vendido
```sql
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
```

2. Obtener las herramientas que necesitan mantenimiento
```sql
USE finca;
SELECT Nombre
FROM herramientas
WHERE idHerramienta IN (
    SELECT idHerramienta
    FROM mantenimiento_herramientas
);
```

3. Obtener la cantidad de productos en el inventario
```sql
USE finca;
SELECT COUNT(*) AS Total_Productos
FROM productos
WHERE idProducto IN (
    SELECT idProducto
    FROM inventario_productos
    WHERE Estado = 'Disponible'
);
```

4. Obtener cantidad de mantenimiento por cada tipo de maquinaria
```sql
USE finca;
SELECT idTipo_Maquinaria, COUNT(*) AS Mantenimientos
FROM mantenimiento_maquinaria
WHERE idTipo_Maquinaria IN (
    SELECT idTipo_Maquinaria
    FROM tipo_maquinaria
)
GROUP BY idTipo_Maquinaria;
```

5. Obtener la ultima fecha de produccion agricola cosechada
```sql
USE finca;
SELECT Fecha AS Produccion
FROM produccion
WHERE idAgricola IN (
    SELECT idAgricola
    FROM agricola
    WHERE Estado = 'Cosechado'
);
```

6. Obtener los productos vendidos en las ventas
```sql
USE finca;
SELECT p.nombre AS Productos
FROM productos p
WHERE idProducto IN (
    SELECT idProducto
    FROM productos_ventas 
);
```

7. Obtener las tareas asignadas a más de 3 herramientas
```sql
USE finca;
SELECT t.Nombre
FROM tareas t
JOIN tareas_herramientas th ON t.idTarea = th.idTarea
GROUP BY t.idTarea
HAVING COUNT(th.idHerramienta) > 3;
```

8. Obtener la producción total de productos pecuarios durante el último trimestre
```sql
USE finca;
SELECT SUM(p.Cantidad) AS Total_Produccion
FROM produccion p
JOIN pecuario pe ON p.idPecuario = pe.idPecuario
WHERE p.Fecha BETWEEN '2024-07-01' AND '2024-09-30';
```

9. Obtener los empleados con salarios superiores al salario promedio
```sql
USE finca;
SELECT Nombre, Salario
FROM empleados
WHERE Salario > (SELECT AVG(Salario) FROM empleados);
```

10. Obtener los productos cuyo inventario es menor a 100 unidades:
```sql
USE finca;
SELECT p.Nombre, i.Cantidad
FROM productos p
JOIN inventario_productos i ON p.idProducto = i.idProducto
WHERE i.Cantidad < 100;
```

## Procedimientos, Funciones, Eventos y Triggers
🛠️
Se encontraran algunos como estos:

### Procedimientos

1. Actualizar el inventario al comprar un producto
```sql
DELIMITER //
CREATE PROCEDURE ActualizarInventarioCompra(IN idproducto INT, IN cantidad INT, IN total INT, IN idmaquinaria INT, IN idproveedor INT, IN idherramienta INT)
BEGIN
	SET SQL_SAFE_UPDATES = 0;
    UPDATE inventario_productos
    SET Cantidad = Cantidad + cantidad
    WHERE idProducto = idproducto;
    INSERT INTO ordenes_compra (idProducto, Estado, Fecha, Total, idMaquinaria, idProveedor, idHerramienta)
    VALUES (idproducto, 'Pendiente', CURDATE() , total, idmaquinaria, idproveedor, idherramienta);
    SET SQL_SAFE_UPDATES = 1;
END //
DELIMITER ;

CALL ActualizarInventarioCompra(1, 50, 2342, 1, 1, 1);
```

2. Registrar tareas a las herramientas
```sql
DELIMITER //
CREATE PROCEDURE RegistrarTareaConHerramientas(IN tarea VARCHAR(45), IN idherramienta INT, IN fechai DATETIME, IN fechaf DATETIME, IN prioridad VARCHAR(45), IN tipo VARCHAR(45), IN cargo INT)
BEGIN
    INSERT INTO tareas (Nombre, Fecha_Inicio, Fecha_Final, Prioridad, Tipo, idCargo)
    VALUES (tarea, fechai, fechaf, prioridad,tipo,cargo);
    SET @idTarea = LAST_INSERT_ID();
    INSERT INTO tareas_herramientas (idTarea, idHerramienta)
    VALUES (@idTarea, idherramienta);
END //
DELIMITER ;

CALL RegistrarTareaConHerramientas('Preparar terreno', 2, '2024-10-24', '2024-10-30', 'Alta', 'Agricola', 1);
```

3. Obtener el mantenimiento que requiere una maquinaria
```sql
DELIMITER //
CREATE PROCEDURE ObtenerMantenimientoMaquinaria(IN idmaquinaria INT)
BEGIN
    SELECT *
    FROM mantenimiento_maquinaria
    WHERE idMaquinaria = idmaquinaria;
END //
DELIMITER ;

CALL ObtenerMantenimientoMaquinaria(3);
```

4. Actualizar el estado de un producto en inventario
```sql 
DELIMITER //
CREATE PROCEDURE ActualizarEstadoProducto(IN idproducto INT, IN estado VARCHAR(45))
BEGIN
    SET SQL_SAFE_UPDATES = 0;
    UPDATE inventario_productos
    SET Estado = estado
    WHERE idProducto = idproducto;
    SET SQL_SAFE_UPDATES = 1;
END //
DELIMITER ;

CALL ActualizarEstadoProducto(1, 'Agotado');
```

5. Registrar nueva produccion agricola y pecuaria
```sql
DELIMITER //
CREATE PROCEDURE RegistrarProduccionAgricola(IN idagricola INT, IN idpecuario INT, IN cantidad INT)
BEGIN   
    INSERT INTO produccion (idAgricola, idPecuario, Cantidad, Fecha)
    VALUES (idagricola, idpecuario, cantidad, CURDATE());
END //
DELIMITER ;

CALL RegistrarProduccionAgricola(4, 5, 100);
```


### Funciones

1. Funcion para calcular el total de las ordenes de compra a proveedores
```sql
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
```

2. Funcion para calcular el precio promedio de las ventas
```sql
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
```

3. Funcion para calcular el precio de los productos con el 10% de descuento
```sql
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
```

4. Funcion para calcular el costo total de una venta
```sql
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
```

5. Funcion para obtener la cantidad de productos vendidos en un dia en especifico
```sql
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
```

### Eventos

1. Verificar el Cumplimiento del Plan de Rotación Agrícola
```sql
DELIMITER //
CREATE EVENT IF NOT EXISTS verificar_plan_rotacion
ON SCHEDULE EVERY 1 WEEK
STARTS '2024-10-22 00:00:00'
DO
BEGIN
    INSERT INTO log_agricola (Fecha, Mensaje, idTerreno)
    SELECT CURDATE(), CONCAT('Terreno ', idTerreno, ' no ha completado su rotación programada'), idTerreno
    FROM terreno_agricola
    WHERE Estado_Rotacion = 'Pendiente';
END //
DELIMITER ;
```

2. Ajustar el Stock de Productos Basado en Ventas Semanales
```sql
DELIMITER //
CREATE EVENT IF NOT EXISTS ajustar_stock_semanal
ON SCHEDULE EVERY 1 WEEK
STARTS '2024-10-25 00:00:00'
DO
BEGIN
    UPDATE inventario_productos ip
    JOIN (SELECT idProducto, SUM(Cantidad) AS vendidos
          FROM producto_venta pv
          JOIN ventas v ON pv.idVenta = v.idVenta
          WHERE v.Fecha BETWEEN CURDATE() - INTERVAL 7 DAY AND CURDATE()
          GROUP BY idProducto) AS ventas_semanales
    ON ip.idProducto = ventas_semanales.idProducto
    SET ip.Cantidad = ip.Cantidad - ventas_semanales.vendidos;
END //
DELIMITER ;
```

3. Enviar Recordatorios para Capacitación de Personal
```sql
DELIMITER //
CREATE EVENT IF NOT EXISTS recordatorio_capacitacion_personal
ON SCHEDULE EVERY 1 WEEK
STARTS '2024-10-24 09:00:00'
DO
BEGIN
    INSERT INTO log_empleados (Fecha, Mensaje, idEmpleado)
    SELECT CURDATE(), CONCAT('Capacitación programada el ', Fecha_Capacitacion), idEmpleado
    FROM empleados
    WHERE Fecha_Capacitacion BETWEEN CURDATE() AND CURDATE() + INTERVAL 7 DAY;
END //
DELIMITER ;
```

4. Limpieza Automática de Registros Antiguos en la Tabla Log
```sql
DELIMITER //
CREATE EVENT IF NOT EXISTS limpiar_registros_antiguos_log
ON SCHEDULE EVERY 1 MONTH
STARTS '2024-11-01 00:00:00'
DO
BEGIN
    DELETE FROM log_ventas
    WHERE Fecha < CURDATE() - INTERVAL 1 YEAR;
END //
DELIMITER ;
```

5. Recalcular el Precio de Productos Basado en su Demanda
```sql
DELIMITER //
CREATE EVENT IF NOT EXISTS ajustar_precios_por_demanda
ON SCHEDULE EVERY 1 MONTH
DO
BEGIN
    UPDATE productos p
    SET p.Precio = p.Precio * 1.05
    WHERE p.idProducto IN (
        SELECT idProducto
        FROM producto_venta
        GROUP BY idProducto
        HAVING COUNT(idProducto) > 50  
    );
END //
DELIMITER ;
```

### Triggers

1. Actualizar la cantidad de productos despues de una venta
```sql 
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
```

2. Reportar en la tabla log de productos cuando un producto se le modifique el precio
```sql
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
```

3. Validar la eliminacion de un cliente si es inactivo y no tiene ventas
```sql
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
```

4. Verificar que los datos de un cliente esten completos antes de insertarlo
```sql
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
```

5. Generar una orden de compra si un producto esta bajo en inventario
```sql
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
```


## Roles de usuario
🤖
1. Rol de administrador
```sql
CREATE ROLE 'Admin';
GRANT ALL PRIVILEGES ON *.* TO 'Admin' WITH GRANT OPTION;
```

2. Rol de gerente
```sql
CREATE ROLE 'Gerente';
GRANT SELECT, INSERT, UPDATE, DELETE ON empleados TO 'Gerente';
GRANT SELECT, INSERT, UPDATE, DELETE ON clientes TO 'Gerente';
GRANT SELECT, INSERT, UPDATE, DELETE ON historial_ventas TO 'Gerente';
GRANT SELECT, INSERT, UPDATE, DELETE ON mantenimiento_herramientas TO 'Gerente';
GRANT SELECT, INSERT, UPDATE, DELETE ON mantenimiento_maquinaria TO 'Gerente';
```

3. Rol de empleado
```sql
CREATE ROLE 'Empleado';
GRANT SELECT, INSERT, UPDATE ON agricola TO 'Empleado';
GRANT SELECT, INSERT, UPDATE ON produccion TO 'Empleado';
GRANT SELECT, INSERT, UPDATE ON inventario_productos TO 'Empleado';
```

4. Rol de vendedor
```sql
CREATE ROLE 'Vendedor';
GRANT SELECT, INSERT, UPDATE ON clientes TO 'Vendedor';
GRANT SELECT, INSERT, UPDATE, DELETE ON ventas TO 'Vendedor';
GRANT SELECT, INSERT, UPDATE ON productos_ventas TO 'Vendedor';
```

5. Rol de mantenimiento
```sql
CREATE ROLE 'Mantenimiento';
GRANT SELECT, INSERT, UPDATE ON mantenimiento_herramientas TO 'Mantenimiento';
GRANT SELECT, INSERT, UPDATE ON mantenimiento_maquinaria TO 'Mantenimiento';
GRANT SELECT, INSERT, UPDATE ON herramientas TO 'Mantenimiento';
GRANT SELECT, INSERT, UPDATE ON inventario_maquinaria TO 'Mantenimiento';
```

- Asignacion de roles
```sql
GRANT 'Admin' TO 'usuario1'@'localhost';
GRANT 'Gerente' TO 'usuario2'@'localhost';
GRANT 'Agricultor' TO 'usuario3'@'localhost';
GRANT 'Vendedor' TO 'usuario4'@'localhost';
GRANT 'Mantenimiento' TO 'usuario5'@'localhost';
```

## Contribuciones
🫱🏼‍🫲🏾

- **Michel Adrian Torrado Roa:** Modelo UML, Inserciones (15) tablas, Consultas SQL (50), Procedimientos Almacenados (10), Funciones (10), Eventos (10), Triggers (10), Roles de usuarios (5).

- **Juan David Conde Martínez** Archivo DDL, Inserciones (15) tablas, Consultas (50), Procedimientos Almacenados (10), Funciones (10), Eventos (10), Triggers (10), Readme.

## Licencia y contacto
📱

Este proyecto no está bajo una licencia, puedes usar, modificar y distribuir el código

Para preguntas o contribuciones, puedes contactarnos en:

- **Nombre**: Juan David Conde Martínez
- **Correo Electrónico**: juanconde1309@gmail.com

- **Nombre**: Michel Adrian Torrado Roa
- **Correo Electrónico**: micheltorrado12@gmail.com

# Autores
🖌️

Hecho por [@MichelAdrianTorradoRoa](https://github.com/MichelAdrianTorradoRoa) y [@JuanDavidCondeMartinez](https://github.com/juanconde025)
