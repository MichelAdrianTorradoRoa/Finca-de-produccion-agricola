-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: fincaproduccionagricola
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `agricola`
--

DROP TABLE IF EXISTS `agricola`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agricola` (
  `idAgricola` int NOT NULL AUTO_INCREMENT,
  `Tipo` varchar(45) NOT NULL,
  `Cantidad` int NOT NULL,
  `Fecha_Siembra` date NOT NULL,
  `Fecha_Cosecha` date NOT NULL,
  `Estado` varchar(45) NOT NULL,
  `idTerreno_Agricola` int NOT NULL,
  PRIMARY KEY (`idAgricola`,`idTerreno_Agricola`),
  UNIQUE KEY `idAgricola_UNIQUE` (`idAgricola`),
  KEY `fk_Agricola_Terreno_Agricola1_idx` (`idTerreno_Agricola`),
  CONSTRAINT `fk_Agricola_Terreno_Agricola1` FOREIGN KEY (`idTerreno_Agricola`) REFERENCES `terreno_agricola` (`idTerreno_Agricola`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agricola`
--

LOCK TABLES `agricola` WRITE;
/*!40000 ALTER TABLE `agricola` DISABLE KEYS */;
/*!40000 ALTER TABLE `agricola` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cargo`
--

DROP TABLE IF EXISTS `cargo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cargo` (
  `idCargo` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) NOT NULL,
  `Requisitos` varchar(45) NOT NULL,
  `Nivel` varchar(45) NOT NULL,
  PRIMARY KEY (`idCargo`),
  UNIQUE KEY `idCargo_UNIQUE` (`idCargo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cargo`
--

LOCK TABLES `cargo` WRITE;
/*!40000 ALTER TABLE `cargo` DISABLE KEYS */;
/*!40000 ALTER TABLE `cargo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cientes`
--

DROP TABLE IF EXISTS `cientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cientes` (
  `idCiente` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) NOT NULL,
  `Estado` varchar(45) NOT NULL,
  `Tipo` varchar(45) NOT NULL,
  `Fecha_Nacimiento` date NOT NULL,
  `idDireccion` int NOT NULL,
  PRIMARY KEY (`idCiente`,`idDireccion`),
  UNIQUE KEY `idCiente_UNIQUE` (`idCiente`),
  KEY `fk_Cientes_Direccion1_idx` (`idDireccion`),
  CONSTRAINT `fk_Cientes_Direccion1` FOREIGN KEY (`idDireccion`) REFERENCES `direccion` (`idDireccion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cientes`
--

LOCK TABLES `cientes` WRITE;
/*!40000 ALTER TABLE `cientes` DISABLE KEYS */;
/*!40000 ALTER TABLE `cientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ciudad`
--

DROP TABLE IF EXISTS `ciudad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ciudad` (
  `idCiudad` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) NOT NULL,
  `idPais` int NOT NULL,
  PRIMARY KEY (`idCiudad`,`idPais`),
  UNIQUE KEY `idCiudad_UNIQUE` (`idCiudad`),
  KEY `fk_Ciudad_Pais1_idx` (`idPais`),
  CONSTRAINT `fk_Ciudad_Pais1` FOREIGN KEY (`idPais`) REFERENCES `pais` (`idPais`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ciudad`
--

LOCK TABLES `ciudad` WRITE;
/*!40000 ALTER TABLE `ciudad` DISABLE KEYS */;
/*!40000 ALTER TABLE `ciudad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `direccion`
--

DROP TABLE IF EXISTS `direccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `direccion` (
  `idDireccion` int NOT NULL AUTO_INCREMENT,
  `Direccion` varchar(45) NOT NULL,
  `idCiudad` int NOT NULL,
  PRIMARY KEY (`idDireccion`,`idCiudad`),
  UNIQUE KEY `idDireccion_UNIQUE` (`idDireccion`),
  KEY `fk_Direccion_Ciudad1_idx` (`idCiudad`),
  CONSTRAINT `fk_Direccion_Ciudad1` FOREIGN KEY (`idCiudad`) REFERENCES `ciudad` (`idCiudad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `direccion`
--

LOCK TABLES `direccion` WRITE;
/*!40000 ALTER TABLE `direccion` DISABLE KEYS */;
/*!40000 ALTER TABLE `direccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleados` (
  `idEmpleado` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) NOT NULL,
  `Apellido` varchar(45) NOT NULL,
  `Salario` decimal(10,2) NOT NULL,
  `Fecha_Contratacion` date NOT NULL,
  `Fecha_Nacimiento` date NOT NULL,
  `Hora_inicio` time NOT NULL,
  `Hora_Finalizacion` time NOT NULL,
  `Teleono` int NOT NULL,
  `Estado` varchar(45) NOT NULL,
  `idCargo` int NOT NULL,
  PRIMARY KEY (`idEmpleado`,`idCargo`),
  UNIQUE KEY `idEmpleado_UNIQUE` (`idEmpleado`),
  KEY `fk_Empleados_Cargo1_idx` (`idCargo`),
  CONSTRAINT `fk_Empleados_Cargo1` FOREIGN KEY (`idCargo`) REFERENCES `cargo` (`idCargo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleados_maquinaria`
--

DROP TABLE IF EXISTS `empleados_maquinaria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleados_maquinaria` (
  `idMaquinaria` int NOT NULL,
  `idEmpleado` int NOT NULL,
  PRIMARY KEY (`idMaquinaria`,`idEmpleado`),
  KEY `fk_Empleados_Maquinaria_Empleados1_idx` (`idEmpleado`),
  CONSTRAINT `fk_Empleados_Maquinaria_Empleados1` FOREIGN KEY (`idEmpleado`) REFERENCES `empleados` (`idEmpleado`),
  CONSTRAINT `fk_Empleados_Maquinaria_Maquinaria1` FOREIGN KEY (`idMaquinaria`) REFERENCES `maquinaria` (`idMaquinaria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados_maquinaria`
--

LOCK TABLES `empleados_maquinaria` WRITE;
/*!40000 ALTER TABLE `empleados_maquinaria` DISABLE KEYS */;
/*!40000 ALTER TABLE `empleados_maquinaria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `herramientas`
--

DROP TABLE IF EXISTS `herramientas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `herramientas` (
  `idHerramienta` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) NOT NULL,
  `Cantidad` int NOT NULL,
  `Ubicacion` varchar(45) NOT NULL,
  `Estado` varchar(45) NOT NULL,
  `Fecha_Adquisicion` date NOT NULL,
  PRIMARY KEY (`idHerramienta`),
  UNIQUE KEY `idHerramienta_UNIQUE` (`idHerramienta`),
  UNIQUE KEY `Nombre_UNIQUE` (`Nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `herramientas`
--

LOCK TABLES `herramientas` WRITE;
/*!40000 ALTER TABLE `herramientas` DISABLE KEYS */;
/*!40000 ALTER TABLE `herramientas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historial_ventas`
--

DROP TABLE IF EXISTS `historial_ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historial_ventas` (
  `idHistorial` int NOT NULL AUTO_INCREMENT,
  `Fecha` varchar(45) NOT NULL,
  `idVenta` int NOT NULL,
  PRIMARY KEY (`idHistorial`,`idVenta`),
  UNIQUE KEY `idHistorial_UNIQUE` (`idHistorial`),
  KEY `fk_Historial_Ventas_Ventas_idx` (`idVenta`),
  CONSTRAINT `fk_Historial_Ventas_Ventas` FOREIGN KEY (`idVenta`) REFERENCES `ventas` (`idVenta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historial_ventas`
--

LOCK TABLES `historial_ventas` WRITE;
/*!40000 ALTER TABLE `historial_ventas` DISABLE KEYS */;
/*!40000 ALTER TABLE `historial_ventas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario_herramientas`
--

DROP TABLE IF EXISTS `inventario_herramientas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario_herramientas` (
  `idInventario_Herramientas` int NOT NULL AUTO_INCREMENT,
  `Cantidad` int NOT NULL,
  `Estado` varchar(45) NOT NULL,
  `Fecha` date NOT NULL,
  `idHerramienta` int NOT NULL,
  PRIMARY KEY (`idInventario_Herramientas`,`idHerramienta`),
  UNIQUE KEY `idInventario_Herramientas_UNIQUE` (`idInventario_Herramientas`),
  KEY `fk_Inventario_Herramientas_Herramientas1_idx` (`idHerramienta`),
  CONSTRAINT `fk_Inventario_Herramientas_Herramientas1` FOREIGN KEY (`idHerramienta`) REFERENCES `herramientas` (`idHerramienta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario_herramientas`
--

LOCK TABLES `inventario_herramientas` WRITE;
/*!40000 ALTER TABLE `inventario_herramientas` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventario_herramientas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario_maquinaria`
--

DROP TABLE IF EXISTS `inventario_maquinaria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario_maquinaria` (
  `idInventario_Maquinaria` int NOT NULL AUTO_INCREMENT,
  `Cantidad` int NOT NULL,
  `Estado` varchar(45) NOT NULL,
  `Fecha` date NOT NULL,
  `idMaquinaria` int NOT NULL,
  PRIMARY KEY (`idInventario_Maquinaria`,`idMaquinaria`),
  UNIQUE KEY `idInventario_Maquinaria_UNIQUE` (`idInventario_Maquinaria`),
  KEY `fk_Inventario_Maquinaria_Maquinaria1_idx` (`idMaquinaria`),
  CONSTRAINT `fk_Inventario_Maquinaria_Maquinaria1` FOREIGN KEY (`idMaquinaria`) REFERENCES `maquinaria` (`idMaquinaria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario_maquinaria`
--

LOCK TABLES `inventario_maquinaria` WRITE;
/*!40000 ALTER TABLE `inventario_maquinaria` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventario_maquinaria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario_productos`
--

DROP TABLE IF EXISTS `inventario_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario_productos` (
  `idInventario_Productos` int NOT NULL AUTO_INCREMENT,
  `Cantidad` int NOT NULL,
  `Estado` varchar(45) NOT NULL,
  `Fecha` date NOT NULL,
  `idProducto` int NOT NULL,
  `idVenta` int NOT NULL,
  PRIMARY KEY (`idInventario_Productos`,`idProducto`,`idVenta`),
  UNIQUE KEY `idImventario_Productos_UNIQUE` (`idInventario_Productos`),
  KEY `fk_Imventario_Productos_Productos1_idx` (`idProducto`),
  KEY `fk_Imventario_Productos_Ventas1_idx` (`idVenta`),
  CONSTRAINT `fk_Imventario_Productos_Productos1` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`),
  CONSTRAINT `fk_Imventario_Productos_Ventas1` FOREIGN KEY (`idVenta`) REFERENCES `ventas` (`idVenta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario_productos`
--

LOCK TABLES `inventario_productos` WRITE;
/*!40000 ALTER TABLE `inventario_productos` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventario_productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mantenimiento_maquinaria`
--

DROP TABLE IF EXISTS `mantenimiento_maquinaria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mantenimiento_maquinaria` (
  `idMantenimiento_Maquinaria` int NOT NULL AUTO_INCREMENT,
  `Fecha` date NOT NULL,
  `idTipo_Maquinaria` int NOT NULL,
  `idMaquinaria` int NOT NULL,
  PRIMARY KEY (`idMantenimiento_Maquinaria`,`idTipo_Maquinaria`,`idMaquinaria`),
  UNIQUE KEY `idMantenimiento_Maquinaria_UNIQUE` (`idMantenimiento_Maquinaria`),
  KEY `fk_Mantenimiento_Maquinaria_Tipo_Maquinaria1_idx` (`idTipo_Maquinaria`),
  KEY `fk_Mantenimiento_Maquinaria_Maquinaria1_idx` (`idMaquinaria`),
  CONSTRAINT `fk_Mantenimiento_Maquinaria_Maquinaria1` FOREIGN KEY (`idMaquinaria`) REFERENCES `maquinaria` (`idMaquinaria`),
  CONSTRAINT `fk_Mantenimiento_Maquinaria_Tipo_Maquinaria1` FOREIGN KEY (`idTipo_Maquinaria`) REFERENCES `tipo_maquinaria` (`idTipo_Maquinaria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mantenimiento_maquinaria`
--

LOCK TABLES `mantenimiento_maquinaria` WRITE;
/*!40000 ALTER TABLE `mantenimiento_maquinaria` DISABLE KEYS */;
/*!40000 ALTER TABLE `mantenimiento_maquinaria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manteniminto_herramientas`
--

DROP TABLE IF EXISTS `manteniminto_herramientas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manteniminto_herramientas` (
  `idManteniminto_Herramientas` int NOT NULL AUTO_INCREMENT,
  `Fecha` date NOT NULL,
  `Tipo` varchar(45) NOT NULL,
  `idHerramienta` int NOT NULL,
  PRIMARY KEY (`idManteniminto_Herramientas`,`idHerramienta`),
  UNIQUE KEY `idManteniminto_Herramientas_UNIQUE` (`idManteniminto_Herramientas`),
  KEY `fk_Manteniminto_Herramientas_Herramientas1_idx` (`idHerramienta`),
  CONSTRAINT `fk_Manteniminto_Herramientas_Herramientas1` FOREIGN KEY (`idHerramienta`) REFERENCES `herramientas` (`idHerramienta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manteniminto_herramientas`
--

LOCK TABLES `manteniminto_herramientas` WRITE;
/*!40000 ALTER TABLE `manteniminto_herramientas` DISABLE KEYS */;
/*!40000 ALTER TABLE `manteniminto_herramientas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maquinaria`
--

DROP TABLE IF EXISTS `maquinaria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maquinaria` (
  `idMaquinaria` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) NOT NULL,
  `Cantidad` int NOT NULL,
  `Horas_Operativas` int NOT NULL,
  `idTipo_Maquinaria` int NOT NULL,
  `idTarea` int NOT NULL,
  PRIMARY KEY (`idMaquinaria`,`idTipo_Maquinaria`,`idTarea`),
  UNIQUE KEY `idMaquinaria_UNIQUE` (`idMaquinaria`),
  UNIQUE KEY `Nombre_UNIQUE` (`Nombre`),
  KEY `fk_Maquinaria_Tipo_Maquinaria1_idx` (`idTipo_Maquinaria`),
  KEY `fk_Maquinaria_Tareas1_idx` (`idTarea`),
  CONSTRAINT `fk_Maquinaria_Tareas1` FOREIGN KEY (`idTarea`) REFERENCES `tareas` (`idTarea`),
  CONSTRAINT `fk_Maquinaria_Tipo_Maquinaria1` FOREIGN KEY (`idTipo_Maquinaria`) REFERENCES `tipo_maquinaria` (`idTipo_Maquinaria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maquinaria`
--

LOCK TABLES `maquinaria` WRITE;
/*!40000 ALTER TABLE `maquinaria` DISABLE KEYS */;
/*!40000 ALTER TABLE `maquinaria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordenes_compra`
--

DROP TABLE IF EXISTS `ordenes_compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordenes_compra` (
  `idOrdenes_Compra` int NOT NULL AUTO_INCREMENT,
  `Estado` varchar(45) NOT NULL,
  `Fecha` date NOT NULL,
  `Total` decimal(10,2) NOT NULL,
  `idProducto` int NOT NULL,
  `idMaquinaria` int NOT NULL,
  `idProveedor` int NOT NULL,
  `idHerramienta` int NOT NULL,
  PRIMARY KEY (`idOrdenes_Compra`,`idProducto`,`idMaquinaria`,`idProveedor`,`idHerramienta`),
  UNIQUE KEY `idOrdenes_Compra_UNIQUE` (`idOrdenes_Compra`),
  KEY `fk_Ordenes_Compra_Productos1_idx` (`idProducto`),
  KEY `fk_Ordenes_Compra_Maquinaria1_idx` (`idMaquinaria`),
  KEY `fk_Ordenes_Compra_Proveedores1_idx` (`idProveedor`),
  KEY `fk_Ordenes_Compra_Herramientas1_idx` (`idHerramienta`),
  CONSTRAINT `fk_Ordenes_Compra_Herramientas1` FOREIGN KEY (`idHerramienta`) REFERENCES `herramientas` (`idHerramienta`),
  CONSTRAINT `fk_Ordenes_Compra_Maquinaria1` FOREIGN KEY (`idMaquinaria`) REFERENCES `maquinaria` (`idMaquinaria`),
  CONSTRAINT `fk_Ordenes_Compra_Productos1` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`),
  CONSTRAINT `fk_Ordenes_Compra_Proveedores1` FOREIGN KEY (`idProveedor`) REFERENCES `proveedores` (`idProveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenes_compra`
--

LOCK TABLES `ordenes_compra` WRITE;
/*!40000 ALTER TABLE `ordenes_compra` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordenes_compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pais`
--

DROP TABLE IF EXISTS `pais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pais` (
  `idPais` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`idPais`),
  UNIQUE KEY `idPais_UNIQUE` (`idPais`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pais`
--

LOCK TABLES `pais` WRITE;
/*!40000 ALTER TABLE `pais` DISABLE KEYS */;
/*!40000 ALTER TABLE `pais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pecuario`
--

DROP TABLE IF EXISTS `pecuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pecuario` (
  `idPecuario` int NOT NULL AUTO_INCREMENT,
  `Tipo` varchar(45) NOT NULL,
  `Cantidad` int NOT NULL,
  `Estado_Salud` varchar(45) NOT NULL,
  `idTerreno_Pecuario` int NOT NULL,
  PRIMARY KEY (`idPecuario`,`idTerreno_Pecuario`),
  UNIQUE KEY `idPecuario_UNIQUE` (`idPecuario`),
  KEY `fk_Pecuario_Terreno_Pecuario1_idx` (`idTerreno_Pecuario`),
  CONSTRAINT `fk_Pecuario_Terreno_Pecuario1` FOREIGN KEY (`idTerreno_Pecuario`) REFERENCES `terreno_pecuario` (`idTerreno_Pecuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pecuario`
--

LOCK TABLES `pecuario` WRITE;
/*!40000 ALTER TABLE `pecuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `pecuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produccion`
--

DROP TABLE IF EXISTS `produccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produccion` (
  `idProduccion` int NOT NULL AUTO_INCREMENT,
  `Fecha` date NOT NULL,
  `Cantidad` int NOT NULL,
  `idAgricola` int NOT NULL,
  `idPecuario` int NOT NULL,
  PRIMARY KEY (`idProduccion`,`idAgricola`,`idPecuario`),
  UNIQUE KEY `idProduccion_UNIQUE` (`idProduccion`),
  KEY `fk_Produccion_Agricola1_idx` (`idAgricola`),
  KEY `fk_Produccion_Pecuario1_idx` (`idPecuario`),
  CONSTRAINT `fk_Produccion_Agricola1` FOREIGN KEY (`idAgricola`) REFERENCES `agricola` (`idAgricola`),
  CONSTRAINT `fk_Produccion_Pecuario1` FOREIGN KEY (`idPecuario`) REFERENCES `pecuario` (`idPecuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produccion`
--

LOCK TABLES `produccion` WRITE;
/*!40000 ALTER TABLE `produccion` DISABLE KEYS */;
/*!40000 ALTER TABLE `produccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `idProducto` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) NOT NULL,
  `Estado` varchar(45) NOT NULL,
  `Precio` int NOT NULL,
  `Cantidad_Disponible` int NOT NULL,
  `CantidadLote` int NOT NULL,
  `Unidad_Medida` varchar(45) NOT NULL,
  `Fecha_Vencimiento` date NOT NULL,
  `idProduccion` int NOT NULL,
  `idTipo` int NOT NULL,
  PRIMARY KEY (`idProducto`,`idProduccion`,`idTipo`),
  UNIQUE KEY `Nombre_UNIQUE` (`Nombre`),
  UNIQUE KEY `idProducto_UNIQUE` (`idProducto`),
  KEY `fk_Productos_Produccion1_idx` (`idProduccion`),
  KEY `fk_Productos_Tipo_Productos1_idx` (`idTipo`),
  CONSTRAINT `fk_Productos_Produccion1` FOREIGN KEY (`idProduccion`) REFERENCES `produccion` (`idProduccion`),
  CONSTRAINT `fk_Productos_Tipo_Productos1` FOREIGN KEY (`idTipo`) REFERENCES `tipo_productos` (`idTipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos_maquinaria`
--

DROP TABLE IF EXISTS `productos_maquinaria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos_maquinaria` (
  `idProductos_Maquinaria` int NOT NULL AUTO_INCREMENT,
  `Cantidad` int NOT NULL,
  `idProducto` int NOT NULL,
  `idMaquinaria` int NOT NULL,
  PRIMARY KEY (`idProductos_Maquinaria`,`idProducto`,`idMaquinaria`),
  UNIQUE KEY `idProductos_Maquinaria_UNIQUE` (`idProductos_Maquinaria`),
  KEY `fk_Productos_Maquinaria_Productos1_idx` (`idProducto`),
  KEY `fk_Productos_Maquinaria_Maquinaria1_idx` (`idMaquinaria`),
  CONSTRAINT `fk_Productos_Maquinaria_Maquinaria1` FOREIGN KEY (`idMaquinaria`) REFERENCES `maquinaria` (`idMaquinaria`),
  CONSTRAINT `fk_Productos_Maquinaria_Productos1` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos_maquinaria`
--

LOCK TABLES `productos_maquinaria` WRITE;
/*!40000 ALTER TABLE `productos_maquinaria` DISABLE KEYS */;
/*!40000 ALTER TABLE `productos_maquinaria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos_ventas`
--

DROP TABLE IF EXISTS `productos_ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos_ventas` (
  `idProducto` int NOT NULL,
  `idVenta` int NOT NULL,
  PRIMARY KEY (`idProducto`,`idVenta`),
  KEY `fk_Productos_Ventas_Ventas1_idx` (`idVenta`),
  CONSTRAINT `fk_Productos_Ventas_Productos1` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`),
  CONSTRAINT `fk_Productos_Ventas_Ventas1` FOREIGN KEY (`idVenta`) REFERENCES `ventas` (`idVenta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos_ventas`
--

LOCK TABLES `productos_ventas` WRITE;
/*!40000 ALTER TABLE `productos_ventas` DISABLE KEYS */;
/*!40000 ALTER TABLE `productos_ventas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedores` (
  `idProveedor` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) NOT NULL,
  `Fecha_uso_servcios` date NOT NULL,
  `Telefono` int NOT NULL,
  PRIMARY KEY (`idProveedor`),
  UNIQUE KEY `idProveedor_UNIQUE` (`idProveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores`
--

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
/*!40000 ALTER TABLE `proveedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tareas`
--

DROP TABLE IF EXISTS `tareas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tareas` (
  `idTarea` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) NOT NULL,
  `Fecha_Inicio` datetime NOT NULL,
  `Fecha_Final` datetime NOT NULL,
  `Prioridad` varchar(45) NOT NULL,
  `Tipo` varchar(45) NOT NULL,
  PRIMARY KEY (`idTarea`),
  UNIQUE KEY `idTarea_UNIQUE` (`idTarea`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tareas`
--

LOCK TABLES `tareas` WRITE;
/*!40000 ALTER TABLE `tareas` DISABLE KEYS */;
/*!40000 ALTER TABLE `tareas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tares_herramientas`
--

DROP TABLE IF EXISTS `tares_herramientas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tares_herramientas` (
  `idTarea` int NOT NULL,
  `idHerramienta` int NOT NULL,
  PRIMARY KEY (`idTarea`,`idHerramienta`),
  KEY `fk_Tares_Herramientas_Herramientas1_idx` (`idHerramienta`),
  CONSTRAINT `fk_Tares_Herramientas_Herramientas1` FOREIGN KEY (`idHerramienta`) REFERENCES `herramientas` (`idHerramienta`),
  CONSTRAINT `fk_Tares_Herramientas_Tareas1` FOREIGN KEY (`idTarea`) REFERENCES `tareas` (`idTarea`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tares_herramientas`
--

LOCK TABLES `tares_herramientas` WRITE;
/*!40000 ALTER TABLE `tares_herramientas` DISABLE KEYS */;
/*!40000 ALTER TABLE `tares_herramientas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `terreno_agricola`
--

DROP TABLE IF EXISTS `terreno_agricola`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `terreno_agricola` (
  `idTerreno_Agricola` int NOT NULL AUTO_INCREMENT,
  `Hectareas` int NOT NULL,
  `Tipo` varchar(45) NOT NULL,
  `Estado` varchar(45) NOT NULL,
  PRIMARY KEY (`idTerreno_Agricola`),
  UNIQUE KEY `idTerreno_Agricola_UNIQUE` (`idTerreno_Agricola`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `terreno_agricola`
--

LOCK TABLES `terreno_agricola` WRITE;
/*!40000 ALTER TABLE `terreno_agricola` DISABLE KEYS */;
/*!40000 ALTER TABLE `terreno_agricola` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `terreno_pecuario`
--

DROP TABLE IF EXISTS `terreno_pecuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `terreno_pecuario` (
  `idTerreno_Pecuario` int NOT NULL AUTO_INCREMENT,
  `Hectareas` int NOT NULL,
  `Tipo` varchar(45) NOT NULL,
  `Estado` varchar(45) NOT NULL,
  PRIMARY KEY (`idTerreno_Pecuario`),
  UNIQUE KEY `idTerreno_Pecuario_UNIQUE` (`idTerreno_Pecuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `terreno_pecuario`
--

LOCK TABLES `terreno_pecuario` WRITE;
/*!40000 ALTER TABLE `terreno_pecuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `terreno_pecuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_maquinaria`
--

DROP TABLE IF EXISTS `tipo_maquinaria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_maquinaria` (
  `idTipo_Maquinaria` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`idTipo_Maquinaria`),
  UNIQUE KEY `idTipo_Maquinaria_UNIQUE` (`idTipo_Maquinaria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_maquinaria`
--

LOCK TABLES `tipo_maquinaria` WRITE;
/*!40000 ALTER TABLE `tipo_maquinaria` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_maquinaria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_productos`
--

DROP TABLE IF EXISTS `tipo_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_productos` (
  `idTipo` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`idTipo`),
  UNIQUE KEY `idTipo_UNIQUE` (`idTipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_productos`
--

LOCK TABLES `tipo_productos` WRITE;
/*!40000 ALTER TABLE `tipo_productos` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas` (
  `idVenta` int NOT NULL AUTO_INCREMENT,
  `Fecha` date NOT NULL,
  `Total` decimal(10,2) NOT NULL,
  `idEmpleado` int NOT NULL,
  `idCiente` int NOT NULL,
  PRIMARY KEY (`idVenta`,`idEmpleado`,`idCiente`),
  UNIQUE KEY `idVenta_UNIQUE` (`idVenta`),
  KEY `fk_Ventas_Empleados1_idx` (`idEmpleado`),
  KEY `fk_Ventas_Cientes1_idx` (`idCiente`),
  CONSTRAINT `fk_Ventas_Cientes1` FOREIGN KEY (`idCiente`) REFERENCES `cientes` (`idCiente`),
  CONSTRAINT `fk_Ventas_Empleados1` FOREIGN KEY (`idEmpleado`) REFERENCES `empleados` (`idEmpleado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-19  9:27:54
