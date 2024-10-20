-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema finca
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema finca
-- -----------------------------------------------------
DROP DATABASE finca;
CREATE SCHEMA IF NOT EXISTS `finca` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `finca` ;

-- -----------------------------------------------------
-- Table `finca`.`terreno_agricola`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`terreno_agricola` (
  `idTerreno_Agricola` INT NOT NULL AUTO_INCREMENT,
  `Hectareas` INT NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTerreno_Agricola`),
  UNIQUE INDEX `idTerreno_Agricola_UNIQUE` (`idTerreno_Agricola` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finca`.`agricola`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`agricola` (
  `idAgricola` INT NOT NULL AUTO_INCREMENT,
  `Tipo` VARCHAR(45) NOT NULL,
  `Cantidad` INT NOT NULL,
  `Fecha_Siembra` DATE NOT NULL,
  `Fecha_Cosecha` DATE NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  `idTerreno_Agricola` INT NOT NULL,
  PRIMARY KEY (`idAgricola`, `idTerreno_Agricola`),
  UNIQUE INDEX `idAgricola_UNIQUE` (`idAgricola` ASC) VISIBLE,
  INDEX `fk_Agricola_Terreno_Agricola1_idx` (`idTerreno_Agricola` ASC) VISIBLE,
  CONSTRAINT `fk_Agricola_Terreno_Agricola1`
    FOREIGN KEY (`idTerreno_Agricola`)
    REFERENCES `finca`.`terreno_agricola` (`idTerreno_Agricola`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finca`.`cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`cargo` (
  `idCargo` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Requisitos` VARCHAR(45) NOT NULL,
  `Nivel` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCargo`),
  UNIQUE INDEX `idCargo_UNIQUE` (`idCargo` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finca`.`pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`pais` (
  `idPais` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPais`),
  UNIQUE INDEX `idPais_UNIQUE` (`idPais` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finca`.`ciudad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`ciudad` (
  `idCiudad` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `idPais` INT NOT NULL,
  PRIMARY KEY (`idCiudad`, `idPais`),
  UNIQUE INDEX `idCiudad_UNIQUE` (`idCiudad` ASC) VISIBLE,
  INDEX `fk_Ciudad_Pais1_idx` (`idPais` ASC) VISIBLE,
  CONSTRAINT `fk_Ciudad_Pais1`
    FOREIGN KEY (`idPais`)
    REFERENCES `finca`.`pais` (`idPais`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finca`.`direccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`direccion` (
  `idDireccion` INT NOT NULL AUTO_INCREMENT,
  `Direccion` VARCHAR(45) NOT NULL,
  `idCiudad` INT NOT NULL,
  PRIMARY KEY (`idDireccion`, `idCiudad`),
  UNIQUE INDEX `idDireccion_UNIQUE` (`idDireccion` ASC) VISIBLE,
  INDEX `fk_Direccion_Ciudad1_idx` (`idCiudad` ASC) VISIBLE,
  CONSTRAINT `fk_Direccion_Ciudad1`
    FOREIGN KEY (`idCiudad`)
    REFERENCES `finca`.`ciudad` (`idCiudad`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finca`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`clientes` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `Fecha_Nacimiento` DATE NOT NULL,
  `idDireccion` INT NOT NULL,
  PRIMARY KEY (`idCliente`, `idDireccion`),
  UNIQUE INDEX `idCiente_UNIQUE` (`idCliente` ASC) VISIBLE,
  INDEX `fk_Cientes_Direccion1_idx` (`idDireccion` ASC) VISIBLE,
  CONSTRAINT `fk_Cientes_Direccion1`
    FOREIGN KEY (`idDireccion`)
    REFERENCES `finca`.`direccion` (`idDireccion`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finca`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`empleados` (
  `idEmpleado` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Apellido` VARCHAR(45) NOT NULL,
  `Salario` DECIMAL(10,2) NOT NULL,
  `Fecha_Contratacion` DATE NOT NULL,
  `Fecha_Nacimiento` DATE NOT NULL,
  `Hora_inicio` TIME NOT NULL,
  `Hora_Finalizacion` TIME NOT NULL,
  `Telefono` INT NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  `idCargo` INT NOT NULL,
  PRIMARY KEY (`idEmpleado`, `idCargo`),
  UNIQUE INDEX `idEmpleado_UNIQUE` (`idEmpleado` ASC) VISIBLE,
  INDEX `fk_Empleados_Cargo1_idx` (`idCargo` ASC) VISIBLE,
  CONSTRAINT `fk_Empleados_Cargo1`
    FOREIGN KEY (`idCargo`)
    REFERENCES `finca`.`cargo` (`idCargo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finca`.`tareas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`tareas` (
  `idTarea` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Fecha_Inicio` DATETIME NOT NULL,
  `Fecha_Final` DATETIME NOT NULL,
  `Prioridad` VARCHAR(45) NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTarea`),
  UNIQUE INDEX `idTarea_UNIQUE` (`idTarea` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finca`.`tipo_maquinaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`tipo_maquinaria` (
  `idTipo_Maquinaria` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipo_Maquinaria`),
  UNIQUE INDEX `idTipo_Maquinaria_UNIQUE` (`idTipo_Maquinaria` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finca`.`maquinaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`maquinaria` (
  `idMaquinaria` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Cantidad` INT NOT NULL,
  `Horas_Operativas` INT NOT NULL,
  `idTipo_Maquinaria` INT NOT NULL,
  `idTarea` INT NOT NULL,
  PRIMARY KEY (`idMaquinaria`, `idTipo_Maquinaria`, `idTarea`),
  UNIQUE INDEX `idMaquinaria_UNIQUE` (`idMaquinaria` ASC) VISIBLE,
  INDEX `fk_Maquinaria_Tipo_Maquinaria1_idx` (`idTipo_Maquinaria` ASC) VISIBLE,
  INDEX `fk_Maquinaria_Tareas1_idx` (`idTarea` ASC) VISIBLE,
  CONSTRAINT `fk_Maquinaria_Tareas1`
    FOREIGN KEY (`idTarea`)
    REFERENCES `finca`.`tareas` (`idTarea`),
  CONSTRAINT `fk_Maquinaria_Tipo_Maquinaria1`
    FOREIGN KEY (`idTipo_Maquinaria`)
    REFERENCES `finca`.`tipo_maquinaria` (`idTipo_Maquinaria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;



-- -----------------------------------------------------
-- Table `finca`.`empleados_maquinaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`empleados_maquinaria` (
  `idMaquinaria` INT NOT NULL,
  `idEmpleado` INT NOT NULL,
  PRIMARY KEY (`idMaquinaria`, `idEmpleado`),
  INDEX `fk_Empleados_Maquinaria_Empleados1_idx` (`idEmpleado` ASC) VISIBLE,
  CONSTRAINT `fk_Empleados_Maquinaria_Empleados1`
    FOREIGN KEY (`idEmpleado`)
    REFERENCES `finca`.`empleados` (`idEmpleado`),
  CONSTRAINT `fk_Empleados_Maquinaria_Maquinaria1`
    FOREIGN KEY (`idMaquinaria`)
    REFERENCES `finca`.`maquinaria` (`idMaquinaria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finca`.`herramientas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`herramientas` (
  `idHerramienta` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Cantidad` INT NOT NULL,
  `Ubicacion` VARCHAR(45) NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  `Fecha_Adquisicion` DATE NOT NULL,
  PRIMARY KEY (`idHerramienta`),
  UNIQUE INDEX `idHerramienta_UNIQUE` (`idHerramienta` ASC) VISIBLE,
  UNIQUE INDEX `Nombre_UNIQUE` (`Nombre` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finca`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`ventas` (
  `idVenta` INT NOT NULL AUTO_INCREMENT,
  `Fecha` DATE NOT NULL,
  `Total` DECIMAL(10,2) NOT NULL,
  `idEmpleado` INT NOT NULL,
  `idCliente` INT NOT NULL,
  PRIMARY KEY (`idVenta`, `idEmpleado`, `idCliente`),
  UNIQUE INDEX `idVenta_UNIQUE` (`idVenta` ASC) VISIBLE,
  INDEX `fk_Ventas_Empleados1_idx` (`idEmpleado` ASC) VISIBLE,
  INDEX `fk_Ventas_Cientes1_idx` (`idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Ventas_Cientes1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `finca`.`clientes` (`idCliente`),
  CONSTRAINT `fk_Ventas_Empleados1`
    FOREIGN KEY (`idEmpleado`)
    REFERENCES `finca`.`empleados` (`idEmpleado`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finca`.`historial_ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`historial_ventas` (
  `idHistorial` INT NOT NULL AUTO_INCREMENT,
  `Fecha` DATE NOT NULL,
  `idVenta` INT NOT NULL,
  PRIMARY KEY (`idHistorial`, `idVenta`),
  UNIQUE INDEX `idHistorial_UNIQUE` (`idHistorial` ASC) VISIBLE,
  INDEX `fk_Historial_Ventas_Ventas_idx` (`idVenta` ASC) VISIBLE,
  CONSTRAINT `fk_Historial_Ventas_Ventas`
    FOREIGN KEY (`idVenta`)
    REFERENCES `finca`.`ventas` (`idVenta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finca`.`inventario_herramientas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`inventario_herramientas` (
  `idInventario_Herramientas` INT NOT NULL AUTO_INCREMENT,
  `Cantidad` INT NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  `Fecha` DATE NOT NULL,
  `idHerramienta` INT NOT NULL,
  PRIMARY KEY (`idInventario_Herramientas`, `idHerramienta`),
  UNIQUE INDEX `idInventario_Herramientas_UNIQUE` (`idInventario_Herramientas` ASC) VISIBLE,
  INDEX `fk_Inventario_Herramientas_Herramientas1_idx` (`idHerramienta` ASC) VISIBLE,
  CONSTRAINT `fk_Inventario_Herramientas_Herramientas1`
    FOREIGN KEY (`idHerramienta`)
    REFERENCES `finca`.`herramientas` (`idHerramienta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finca`.`inventario_maquinaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`inventario_maquinaria` (
  `idInventario_Maquinaria` INT NOT NULL AUTO_INCREMENT,
  `Cantidad` INT NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  `Fecha` DATE NOT NULL,
  `idMaquinaria` INT NOT NULL,
  PRIMARY KEY (`idInventario_Maquinaria`, `idMaquinaria`),
  UNIQUE INDEX `idInventario_Maquinaria_UNIQUE` (`idInventario_Maquinaria` ASC) VISIBLE,
  INDEX `fk_Inventario_Maquinaria_Maquinaria1_idx` (`idMaquinaria` ASC) VISIBLE,
  CONSTRAINT `fk_Inventario_Maquinaria_Maquinaria1`
    FOREIGN KEY (`idMaquinaria`)
    REFERENCES `finca`.`maquinaria` (`idMaquinaria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finca`.`terreno_pecuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`terreno_pecuario` (
  `idTerreno_Pecuario` INT NOT NULL AUTO_INCREMENT,
  `Hectareas` INT NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTerreno_Pecuario`),
  UNIQUE INDEX `idTerreno_Pecuario_UNIQUE` (`idTerreno_Pecuario` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finca`.`pecuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`pecuario` (
  `idPecuario` INT NOT NULL AUTO_INCREMENT,
  `Tipo` VARCHAR(45) NOT NULL,
  `Cantidad` INT NOT NULL,
  `Estado_Salud` VARCHAR(45) NOT NULL,
  `idTerreno_Pecuario` INT NOT NULL,
  PRIMARY KEY (`idPecuario`, `idTerreno_Pecuario`),
  UNIQUE INDEX `idPecuario_UNIQUE` (`idPecuario` ASC) VISIBLE,
  INDEX `fk_Pecuario_Terreno_Pecuario1_idx` (`idTerreno_Pecuario` ASC) VISIBLE,
  CONSTRAINT `fk_Pecuario_Terreno_Pecuario1`
    FOREIGN KEY (`idTerreno_Pecuario`)
    REFERENCES `finca`.`terreno_pecuario` (`idTerreno_Pecuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finca`.`produccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`produccion` (
  `idProduccion` INT NOT NULL AUTO_INCREMENT,
  `Fecha` DATE NOT NULL,
  `Cantidad` INT NOT NULL,
  `idAgricola` INT NOT NULL,
  `idPecuario` INT NOT NULL,
  PRIMARY KEY (`idProduccion`, `idAgricola`, `idPecuario`),
  UNIQUE INDEX `idProduccion_UNIQUE` (`idProduccion` ASC) VISIBLE,
  INDEX `fk_Produccion_Agricola1_idx` (`idAgricola` ASC) VISIBLE,
  INDEX `fk_Produccion_Pecuario1_idx` (`idPecuario` ASC) VISIBLE,
  CONSTRAINT `fk_Produccion_Agricola1`
    FOREIGN KEY (`idAgricola`)
    REFERENCES `finca`.`agricola` (`idAgricola`),
  CONSTRAINT `fk_Produccion_Pecuario1`
    FOREIGN KEY (`idPecuario`)
    REFERENCES `finca`.`pecuario` (`idPecuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finca`.`tipo_productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`tipo_productos` (
  `idTipo` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipo`),
  UNIQUE INDEX `idTipo_UNIQUE` (`idTipo` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finca`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`productos` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  `Precio` INT NOT NULL,
  `Cantidad_Disponible` INT NOT NULL,
  `CantidadLote` INT NOT NULL,
  `Unidad_Medida` VARCHAR(45) NOT NULL,
  `Fecha_Vencimiento` DATE NOT NULL,
  `idProduccion` INT NOT NULL,
  `idTipo` INT NOT NULL,
  PRIMARY KEY (`idProducto`, `idProduccion`, `idTipo`),
  UNIQUE INDEX `Nombre_UNIQUE` (`Nombre` ASC) VISIBLE,
  UNIQUE INDEX `idProducto_UNIQUE` (`idProducto` ASC) VISIBLE,
  INDEX `fk_Productos_Produccion1_idx` (`idProduccion` ASC) VISIBLE,
  INDEX `fk_Productos_Tipo_Productos1_idx` (`idTipo` ASC) VISIBLE,
  CONSTRAINT `fk_Productos_Produccion1`
    FOREIGN KEY (`idProduccion`)
    REFERENCES `finca`.`produccion` (`idProduccion`),
  CONSTRAINT `fk_Productos_Tipo_Productos1`
    FOREIGN KEY (`idTipo`)
    REFERENCES `finca`.`tipo_productos` (`idTipo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finca`.`inventario_productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`inventario_productos` (
  `idInventario_Productos` INT NOT NULL AUTO_INCREMENT,
  `Cantidad` INT NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  `Fecha` DATE NOT NULL,
  `idProducto` INT NOT NULL,
  `idVenta` INT NOT NULL,
  PRIMARY KEY (`idInventario_Productos`, `idProducto`, `idVenta`),
  UNIQUE INDEX `idImventario_Productos_UNIQUE` (`idInventario_Productos` ASC) VISIBLE,
  INDEX `fk_Imventario_Productos_Productos1_idx` (`idProducto` ASC) VISIBLE,
  INDEX `fk_Imventario_Productos_Ventas1_idx` (`idVenta` ASC) VISIBLE,
  CONSTRAINT `fk_Imventario_Productos_Productos1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `finca`.`productos` (`idProducto`),
  CONSTRAINT `fk_Imventario_Productos_Ventas1`
    FOREIGN KEY (`idVenta`)
    REFERENCES `finca`.`ventas` (`idVenta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finca`.`mantenimiento_maquinaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`mantenimiento_maquinaria` (
  `idMantenimiento_Maquinaria` INT NOT NULL AUTO_INCREMENT,
  `Fecha` DATE NOT NULL,
  `idTipo_Maquinaria` INT NOT NULL,
  `idMaquinaria` INT NOT NULL,
  PRIMARY KEY (`idMantenimiento_Maquinaria`, `idTipo_Maquinaria`, `idMaquinaria`),
  UNIQUE INDEX `idMantenimiento_Maquinaria_UNIQUE` (`idMantenimiento_Maquinaria` ASC) VISIBLE,
  INDEX `fk_Mantenimiento_Maquinaria_Tipo_Maquinaria1_idx` (`idTipo_Maquinaria` ASC) VISIBLE,
  INDEX `fk_Mantenimiento_Maquinaria_Maquinaria1_idx` (`idMaquinaria` ASC) VISIBLE,
  CONSTRAINT `fk_Mantenimiento_Maquinaria_Maquinaria1`
    FOREIGN KEY (`idMaquinaria`)
    REFERENCES `finca`.`maquinaria` (`idMaquinaria`),
  CONSTRAINT `fk_Mantenimiento_Maquinaria_Tipo_Maquinaria1`
    FOREIGN KEY (`idTipo_Maquinaria`)
    REFERENCES `finca`.`tipo_maquinaria` (`idTipo_Maquinaria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finca`.`mantenimiento_herramientas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`mantenimiento_herramientas` (
  `idMantenimiento_Herramientas` INT NOT NULL AUTO_INCREMENT,
  `Fecha` DATE NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `idHerramienta` INT NOT NULL,
  PRIMARY KEY (`idMantenimiento_Herramientas`, `idHerramienta`),
  UNIQUE INDEX `idMantenimiento_Herramientas_UNIQUE` (`idMantenimiento_Herramientas` ASC) VISIBLE,
  INDEX `fk_Mantenimiento_Herramientas_Herramientas1_idx` (`idHerramienta` ASC) VISIBLE,
  CONSTRAINT `fk_Mantenimiento_Herramientas_Herramientas1`
    FOREIGN KEY (`idHerramienta`)
    REFERENCES `finca`.`herramientas` (`idHerramienta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finca`.`proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`proveedores` (
  `idProveedor` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Fecha_uso_servcios` DATE NOT NULL,
  `Telefono` INT NOT NULL,
  PRIMARY KEY (`idProveedor`),
  UNIQUE INDEX `idProveedor_UNIQUE` (`idProveedor` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finca`.`ordenes_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`ordenes_compra` (
  `idOrdenes_Compra` INT NOT NULL AUTO_INCREMENT,
  `Estado` VARCHAR(45) NOT NULL,
  `Fecha` DATE NOT NULL,
  `Total` DECIMAL(10,2) NOT NULL,
  `idProducto` INT NOT NULL,
  `idMaquinaria` INT NOT NULL,
  `idProveedor` INT NOT NULL,
  `idHerramienta` INT NOT NULL,
  PRIMARY KEY (`idOrdenes_Compra`, `idProducto`, `idMaquinaria`, `idProveedor`, `idHerramienta`),
  UNIQUE INDEX `idOrdenes_Compra_UNIQUE` (`idOrdenes_Compra` ASC) VISIBLE,
  INDEX `fk_Ordenes_Compra_Productos1_idx` (`idProducto` ASC) VISIBLE,
  INDEX `fk_Ordenes_Compra_Maquinaria1_idx` (`idMaquinaria` ASC) VISIBLE,
  INDEX `fk_Ordenes_Compra_Proveedores1_idx` (`idProveedor` ASC) VISIBLE,
  INDEX `fk_Ordenes_Compra_Herramientas1_idx` (`idHerramienta` ASC) VISIBLE,
  CONSTRAINT `fk_Ordenes_Compra_Herramientas1`
    FOREIGN KEY (`idHerramienta`)
    REFERENCES `finca`.`herramientas` (`idHerramienta`),
  CONSTRAINT `fk_Ordenes_Compra_Maquinaria1`
    FOREIGN KEY (`idMaquinaria`)
    REFERENCES `finca`.`maquinaria` (`idMaquinaria`),
  CONSTRAINT `fk_Ordenes_Compra_Productos1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `finca`.`productos` (`idProducto`),
  CONSTRAINT `fk_Ordenes_Compra_Proveedores1`
    FOREIGN KEY (`idProveedor`)
    REFERENCES `finca`.`proveedores` (`idProveedor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finca`.`productos_maquinaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`productos_maquinaria` (
  `idProductos_Maquinaria` INT NOT NULL AUTO_INCREMENT,
  `Cantidad` INT NOT NULL,
  `idProducto` INT NOT NULL,
  `idMaquinaria` INT NOT NULL,
  PRIMARY KEY (`idProductos_Maquinaria`, `idProducto`, `idMaquinaria`),
  UNIQUE INDEX `idProductos_Maquinaria_UNIQUE` (`idProductos_Maquinaria` ASC) VISIBLE,
  INDEX `fk_Productos_Maquinaria_Productos1_idx` (`idProducto` ASC) VISIBLE,
  INDEX `fk_Productos_Maquinaria_Maquinaria1_idx` (`idMaquinaria` ASC) VISIBLE,
  CONSTRAINT `fk_Productos_Maquinaria_Maquinaria1`
    FOREIGN KEY (`idMaquinaria`)
    REFERENCES `finca`.`maquinaria` (`idMaquinaria`),
  CONSTRAINT `fk_Productos_Maquinaria_Productos1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `finca`.`productos` (`idProducto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finca`.`productos_ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`productos_ventas` (
  `idProducto` INT NOT NULL,
  `idVenta` INT NOT NULL,
  PRIMARY KEY (`idProducto`, `idVenta`),
  INDEX `fk_Productos_Ventas_Ventas1_idx` (`idVenta` ASC) VISIBLE,
  CONSTRAINT `fk_Productos_Ventas_Productos1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `finca`.`productos` (`idProducto`),
  CONSTRAINT `fk_Productos_Ventas_Ventas1`
    FOREIGN KEY (`idVenta`)
    REFERENCES `finca`.`ventas` (`idVenta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finca`.`tareas_herramientas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finca`.`tareas_herramientas` (
  `idTarea` INT NOT NULL,
  `idHerramienta` INT NOT NULL,
  PRIMARY KEY (`idTarea`, `idHerramienta`),
  INDEX `fk_Tares_Herramientas_Herramientas1_idx` (`idHerramienta` ASC) VISIBLE,
  CONSTRAINT `fk_Tares_Herramientas_Herramientas1`
    FOREIGN KEY (`idHerramienta`)
    REFERENCES `finca`.`herramientas` (`idHerramienta`),
  CONSTRAINT `fk_Tares_Herramientas_Tareas1`
    FOREIGN KEY (`idTarea`)
    REFERENCES `finca`.`tareas` (`idTarea`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


--
-- Table structure for table `log_empleados`
--

DROP TABLE IF EXISTS `log_empleados`;
CREATE TABLE `log_empleados` (
  `idLog_Empleados` int NOT NULL AUTO_INCREMENT,
  `Mensaje` varchar(45) NOT NULL,
  `Fecha` date NOT NULL,
  `idEmpleado` int NOT NULL,
  PRIMARY KEY (`idLog_Empleados`,`idEmpleado`),
  UNIQUE KEY `idLog_Empleados_UNIQUE` (`idLog_Empleados`),
  KEY `fk_Log_Empleados_Empleados1_idx` (`idEmpleado`),
  CONSTRAINT `fk_Log_Empleados_Empleados1` FOREIGN KEY (`idEmpleado`) REFERENCES `empleados` (`idEmpleado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `log_maquinaria`
--

DROP TABLE IF EXISTS `log_maquinaria`;
CREATE TABLE `log_maquinaria` (
  `idLog_Maquinaria` int NOT NULL AUTO_INCREMENT,
  `Mensaje` varchar(45) NOT NULL,
  `Fecha` date NOT NULL,
  `idMaquinaria` int NOT NULL,
  PRIMARY KEY (`idLog_Maquinaria`,`idMaquinaria`),
  UNIQUE KEY `idLog_Maquinaria_UNIQUE` (`idLog_Maquinaria`),
  KEY `fk_Log_Maquinaria_Maquinaria1_idx` (`idMaquinaria`),
  CONSTRAINT `fk_Log_Maquinaria_Maquinaria1` FOREIGN KEY (`idMaquinaria`) REFERENCES `maquinaria` (`idMaquinaria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `log_productos`
--

DROP TABLE IF EXISTS `log_productos`;
CREATE TABLE `log_productos` (
  `idLog_Productos` int NOT NULL AUTO_INCREMENT,
  `Mensaje` varchar(45) NOT NULL,
  `Fecha` date NOT NULL,
  `idProducto` int NOT NULL,
  PRIMARY KEY (`idLog_Productos`,`idProducto`),
  KEY `fk_Log_Productos_Productos1_idx` (`idProducto`),
  CONSTRAINT `fk_Log_Productos_Productos1` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `log_proveedores`
--

DROP TABLE IF EXISTS `log_proveedores`;
CREATE TABLE `log_proveedores` (
  `idLog_Proveedores` int NOT NULL AUTO_INCREMENT,
  `Mensaje` varchar(45) NOT NULL,
  `Fecha` date NOT NULL,
  `idProveedor` int NOT NULL,
  PRIMARY KEY (`idLog_Proveedores`,`idProveedor`),
  UNIQUE KEY `idLog_Proveedores_UNIQUE` (`idLog_Proveedores`),
  KEY `fk_Log_Proveedores_Proveedores1_idx` (`idProveedor`),
  CONSTRAINT `fk_Log_Proveedores_Proveedores1` FOREIGN KEY (`idProveedor`) REFERENCES `proveedores` (`idProveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `log_ventas`
--

DROP TABLE IF EXISTS `log_ventas`;
CREATE TABLE `log_ventas` (
  `idLog_Ventas` int NOT NULL AUTO_INCREMENT,
  `Mensaje` varchar(45) NOT NULL,
  `Fecha` date NOT NULL,
  `idVenta` int NOT NULL,
  PRIMARY KEY (`idLog_Ventas`,`idVenta`),
  UNIQUE KEY `idLog_Ventas_UNIQUE` (`idLog_Ventas`),
  KEY `fk_Log_Ventas_Ventas1_idx` (`idVenta`),
  CONSTRAINT `fk_Log_Ventas_Ventas1` FOREIGN KEY (`idVenta`) REFERENCES `ventas` (`idVenta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;