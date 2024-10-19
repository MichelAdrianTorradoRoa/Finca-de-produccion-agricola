-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema fincaproduccionagricola
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema fincaproduccionagricola
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fincaproduccionagricola` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `fincaproduccionagricola` ;

-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Terreno_Agricola`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Terreno_Agricola` (
  `idTerreno_Agricola` INT NOT NULL AUTO_INCREMENT,
  `Hectareas` INT NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTerreno_Agricola`),
  UNIQUE INDEX `idTerreno_Agricola_UNIQUE` (`idTerreno_Agricola` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Agricola`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Agricola` (
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
    REFERENCES `fincaproduccionagricola`.`Terreno_Agricola` (`idTerreno_Agricola`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Terreno_Pecuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Terreno_Pecuario` (
  `idTerreno_Pecuario` INT NOT NULL AUTO_INCREMENT,
  `Hectareas` INT NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTerreno_Pecuario`),
  UNIQUE INDEX `idTerreno_Pecuario_UNIQUE` (`idTerreno_Pecuario` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Pecuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Pecuario` (
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
    REFERENCES `fincaproduccionagricola`.`Terreno_Pecuario` (`idTerreno_Pecuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Produccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Produccion` (
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
    REFERENCES `fincaproduccionagricola`.`Agricola` (`idAgricola`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produccion_Pecuario1`
    FOREIGN KEY (`idPecuario`)
    REFERENCES `fincaproduccionagricola`.`Pecuario` (`idPecuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Tipo_Productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Tipo_Productos` (
  `idTipo` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipo`),
  UNIQUE INDEX `idTipo_UNIQUE` (`idTipo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Productos` (
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
    REFERENCES `fincaproduccionagricola`.`Produccion` (`idProduccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Productos_Tipo_Productos1`
    FOREIGN KEY (`idTipo`)
    REFERENCES `fincaproduccionagricola`.`Tipo_Productos` (`idTipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Tipo_Maquinaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Tipo_Maquinaria` (
  `idTipo_Maquinaria` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipo_Maquinaria`),
  UNIQUE INDEX `idTipo_Maquinaria_UNIQUE` (`idTipo_Maquinaria` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Tareas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Tareas` (
  `idTarea` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Fecha_Inicio` DATETIME NOT NULL,
  `Fecha_Final` DATETIME NOT NULL,
  `Prioridad` VARCHAR(45) NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTarea`),
  UNIQUE INDEX `idTarea_UNIQUE` (`idTarea` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Maquinaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Maquinaria` (
  `idMaquinaria` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Cantidad` INT NOT NULL,
  `Horas_Operativas` INT NOT NULL,
  `idTipo_Maquinaria` INT NOT NULL,
  `idTarea` INT NOT NULL,
  PRIMARY KEY (`idMaquinaria`, `idTipo_Maquinaria`, `idTarea`),
  UNIQUE INDEX `idMaquinaria_UNIQUE` (`idMaquinaria` ASC) VISIBLE,
  UNIQUE INDEX `Nombre_UNIQUE` (`Nombre` ASC) VISIBLE,
  INDEX `fk_Maquinaria_Tipo_Maquinaria1_idx` (`idTipo_Maquinaria` ASC) VISIBLE,
  INDEX `fk_Maquinaria_Tareas1_idx` (`idTarea` ASC) VISIBLE,
  CONSTRAINT `fk_Maquinaria_Tipo_Maquinaria1`
    FOREIGN KEY (`idTipo_Maquinaria`)
    REFERENCES `fincaproduccionagricola`.`Tipo_Maquinaria` (`idTipo_Maquinaria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Maquinaria_Tareas1`
    FOREIGN KEY (`idTarea`)
    REFERENCES `fincaproduccionagricola`.`Tareas` (`idTarea`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Productos_Maquinaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Productos_Maquinaria` (
  `idProductos_Maquinaria` INT NOT NULL AUTO_INCREMENT,
  `Cantidad` INT NOT NULL,
  `idProducto` INT NOT NULL,
  `idMaquinaria` INT NOT NULL,
  PRIMARY KEY (`idProductos_Maquinaria`, `idProducto`, `idMaquinaria`),
  UNIQUE INDEX `idProductos_Maquinaria_UNIQUE` (`idProductos_Maquinaria` ASC) VISIBLE,
  INDEX `fk_Productos_Maquinaria_Productos1_idx` (`idProducto` ASC) VISIBLE,
  INDEX `fk_Productos_Maquinaria_Maquinaria1_idx` (`idMaquinaria` ASC) VISIBLE,
  CONSTRAINT `fk_Productos_Maquinaria_Productos1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `fincaproduccionagricola`.`Productos` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Productos_Maquinaria_Maquinaria1`
    FOREIGN KEY (`idMaquinaria`)
    REFERENCES `fincaproduccionagricola`.`Maquinaria` (`idMaquinaria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Inventario_Maquinaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Inventario_Maquinaria` (
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
    REFERENCES `fincaproduccionagricola`.`Maquinaria` (`idMaquinaria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Proveedores` (
  `idProveedor` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Fecha_uso_servcios` DATE NOT NULL,
  `Telefono` INT NOT NULL,
  PRIMARY KEY (`idProveedor`),
  UNIQUE INDEX `idProveedor_UNIQUE` (`idProveedor` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Cargo` (
  `idCargo` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Requisitos` VARCHAR(45) NOT NULL,
  `Nivel` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCargo`),
  UNIQUE INDEX `idCargo_UNIQUE` (`idCargo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Empleados` (
  `idEmpleado` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Apellido` VARCHAR(45) NOT NULL,
  `Salario` DECIMAL(10,2) NOT NULL,
  `Fecha_Contratacion` DATE NOT NULL,
  `Fecha_Nacimiento` DATE NOT NULL,
  `Hora_inicio` TIME NOT NULL,
  `Hora_Finalizacion` TIME NOT NULL,
  `Teleono` INT NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  `idCargo` INT NOT NULL,
  PRIMARY KEY (`idEmpleado`, `idCargo`),
  UNIQUE INDEX `idEmpleado_UNIQUE` (`idEmpleado` ASC) VISIBLE,
  INDEX `fk_Empleados_Cargo1_idx` (`idCargo` ASC) VISIBLE,
  CONSTRAINT `fk_Empleados_Cargo1`
    FOREIGN KEY (`idCargo`)
    REFERENCES `fincaproduccionagricola`.`Cargo` (`idCargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Pais` (
  `idPais` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPais`),
  UNIQUE INDEX `idPais_UNIQUE` (`idPais` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Ciudad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Ciudad` (
  `idCiudad` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `idPais` INT NOT NULL,
  PRIMARY KEY (`idCiudad`, `idPais`),
  INDEX `fk_Ciudad_Pais1_idx` (`idPais` ASC) VISIBLE,
  UNIQUE INDEX `idCiudad_UNIQUE` (`idCiudad` ASC) VISIBLE,
  CONSTRAINT `fk_Ciudad_Pais1`
    FOREIGN KEY (`idPais`)
    REFERENCES `fincaproduccionagricola`.`Pais` (`idPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Direccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Direccion` (
  `idDireccion` INT NOT NULL AUTO_INCREMENT,
  `Direccion` VARCHAR(45) NOT NULL,
  `idCiudad` INT NOT NULL,
  PRIMARY KEY (`idDireccion`, `idCiudad`),
  INDEX `fk_Direccion_Ciudad1_idx` (`idCiudad` ASC) VISIBLE,
  UNIQUE INDEX `idDireccion_UNIQUE` (`idDireccion` ASC) VISIBLE,
  CONSTRAINT `fk_Direccion_Ciudad1`
    FOREIGN KEY (`idCiudad`)
    REFERENCES `fincaproduccionagricola`.`Ciudad` (`idCiudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Cientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Cientes` (
  `idCiente` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `Fecha_Nacimiento` DATE NOT NULL,
  `idDireccion` INT NOT NULL,
  PRIMARY KEY (`idCiente`, `idDireccion`),
  UNIQUE INDEX `idCiente_UNIQUE` (`idCiente` ASC) VISIBLE,
  INDEX `fk_Cientes_Direccion1_idx` (`idDireccion` ASC) VISIBLE,
  CONSTRAINT `fk_Cientes_Direccion1`
    FOREIGN KEY (`idDireccion`)
    REFERENCES `fincaproduccionagricola`.`Direccion` (`idDireccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Ventas` (
  `idVenta` INT NOT NULL AUTO_INCREMENT,
  `Fecha` DATE NOT NULL,
  `Total` DECIMAL(10,2) NOT NULL,
  `idEmpleado` INT NOT NULL,
  `idCiente` INT NOT NULL,
  PRIMARY KEY (`idVenta`, `idEmpleado`, `idCiente`),
  UNIQUE INDEX `idVenta_UNIQUE` (`idVenta` ASC) VISIBLE,
  INDEX `fk_Ventas_Empleados1_idx` (`idEmpleado` ASC) VISIBLE,
  INDEX `fk_Ventas_Cientes1_idx` (`idCiente` ASC) VISIBLE,
  CONSTRAINT `fk_Ventas_Empleados1`
    FOREIGN KEY (`idEmpleado`)
    REFERENCES `fincaproduccionagricola`.`Empleados` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ventas_Cientes1`
    FOREIGN KEY (`idCiente`)
    REFERENCES `fincaproduccionagricola`.`Cientes` (`idCiente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Historial_Ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Historial_Ventas` (
  `idHistorial` INT NOT NULL AUTO_INCREMENT,
  `Fecha` VARCHAR(45) NOT NULL,
  `idVenta` INT NOT NULL,
  PRIMARY KEY (`idHistorial`, `idVenta`),
  UNIQUE INDEX `idHistorial_UNIQUE` (`idHistorial` ASC) VISIBLE,
  INDEX `fk_Historial_Ventas_Ventas_idx` (`idVenta` ASC) VISIBLE,
  CONSTRAINT `fk_Historial_Ventas_Ventas`
    FOREIGN KEY (`idVenta`)
    REFERENCES `fincaproduccionagricola`.`Ventas` (`idVenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Mantenimiento_Maquinaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Mantenimiento_Maquinaria` (
  `idMantenimiento_Maquinaria` INT NOT NULL AUTO_INCREMENT,
  `Fecha` DATE NOT NULL,
  `idTipo_Maquinaria` INT NOT NULL,
  `idMaquinaria` INT NOT NULL,
  PRIMARY KEY (`idMantenimiento_Maquinaria`, `idTipo_Maquinaria`, `idMaquinaria`),
  UNIQUE INDEX `idMantenimiento_Maquinaria_UNIQUE` (`idMantenimiento_Maquinaria` ASC) VISIBLE,
  INDEX `fk_Mantenimiento_Maquinaria_Tipo_Maquinaria1_idx` (`idTipo_Maquinaria` ASC) VISIBLE,
  INDEX `fk_Mantenimiento_Maquinaria_Maquinaria1_idx` (`idMaquinaria` ASC) VISIBLE,
  CONSTRAINT `fk_Mantenimiento_Maquinaria_Tipo_Maquinaria1`
    FOREIGN KEY (`idTipo_Maquinaria`)
    REFERENCES `fincaproduccionagricola`.`Tipo_Maquinaria` (`idTipo_Maquinaria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mantenimiento_Maquinaria_Maquinaria1`
    FOREIGN KEY (`idMaquinaria`)
    REFERENCES `fincaproduccionagricola`.`Maquinaria` (`idMaquinaria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Herramientas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Herramientas` (
  `idHerramienta` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Cantidad` INT NOT NULL,
  `Ubicacion` VARCHAR(45) NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  `Fecha_Adquisicion` DATE NOT NULL,
  PRIMARY KEY (`idHerramienta`),
  UNIQUE INDEX `idHerramienta_UNIQUE` (`idHerramienta` ASC) VISIBLE,
  UNIQUE INDEX `Nombre_UNIQUE` (`Nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Ordenes_Compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Ordenes_Compra` (
  `idOrdenes_Compra` INT NOT NULL AUTO_INCREMENT,
  `Estado` VARCHAR(45) NOT NULL,
  `Fecha` DATE NOT NULL,
  `Total` DECIMAL(10,2) NOT NULL,
  `idProducto` INT NOT NULL,
  `idMaquinaria` INT NOT NULL,
  `idProveedor` INT NOT NULL,
  `idHerramienta` INT NOT NULL,
  PRIMARY KEY (`idOrdenes_Compra`, `idProducto`, `idMaquinaria`, `idProveedor`, `idHerramienta`),
  INDEX `fk_Ordenes_Compra_Productos1_idx` (`idProducto` ASC) VISIBLE,
  INDEX `fk_Ordenes_Compra_Maquinaria1_idx` (`idMaquinaria` ASC) VISIBLE,
  INDEX `fk_Ordenes_Compra_Proveedores1_idx` (`idProveedor` ASC) VISIBLE,
  INDEX `fk_Ordenes_Compra_Herramientas1_idx` (`idHerramienta` ASC) VISIBLE,
  UNIQUE INDEX `idOrdenes_Compra_UNIQUE` (`idOrdenes_Compra` ASC) VISIBLE,
  CONSTRAINT `fk_Ordenes_Compra_Productos1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `fincaproduccionagricola`.`Productos` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordenes_Compra_Maquinaria1`
    FOREIGN KEY (`idMaquinaria`)
    REFERENCES `fincaproduccionagricola`.`Maquinaria` (`idMaquinaria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordenes_Compra_Proveedores1`
    FOREIGN KEY (`idProveedor`)
    REFERENCES `fincaproduccionagricola`.`Proveedores` (`idProveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordenes_Compra_Herramientas1`
    FOREIGN KEY (`idHerramienta`)
    REFERENCES `fincaproduccionagricola`.`Herramientas` (`idHerramienta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Empleados_Maquinaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Empleados_Maquinaria` (
  `idMaquinaria` INT NOT NULL,
  `idEmpleado` INT NOT NULL,
  PRIMARY KEY (`idMaquinaria`, `idEmpleado`),
  INDEX `fk_Empleados_Maquinaria_Empleados1_idx` (`idEmpleado` ASC) VISIBLE,
  CONSTRAINT `fk_Empleados_Maquinaria_Maquinaria1`
    FOREIGN KEY (`idMaquinaria`)
    REFERENCES `fincaproduccionagricola`.`Maquinaria` (`idMaquinaria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empleados_Maquinaria_Empleados1`
    FOREIGN KEY (`idEmpleado`)
    REFERENCES `fincaproduccionagricola`.`Empleados` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Inventario_Productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Inventario_Productos` (
  `idInventario_Productos` INT NOT NULL AUTO_INCREMENT,
  `Cantidad` INT NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  `Fecha` DATE NOT NULL,
  `idProducto` INT NOT NULL,
  `idVenta` INT NOT NULL,
  PRIMARY KEY (`idInventario_Productos`, `idProducto`, `idVenta`),
  INDEX `fk_Imventario_Productos_Productos1_idx` (`idProducto` ASC) VISIBLE,
  INDEX `fk_Imventario_Productos_Ventas1_idx` (`idVenta` ASC) VISIBLE,
  UNIQUE INDEX `idImventario_Productos_UNIQUE` (`idInventario_Productos` ASC) VISIBLE,
  CONSTRAINT `fk_Imventario_Productos_Productos1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `fincaproduccionagricola`.`Productos` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Imventario_Productos_Ventas1`
    FOREIGN KEY (`idVenta`)
    REFERENCES `fincaproduccionagricola`.`Ventas` (`idVenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Productos_Ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Productos_Ventas` (
  `idProducto` INT NOT NULL,
  `idVenta` INT NOT NULL,
  PRIMARY KEY (`idProducto`, `idVenta`),
  INDEX `fk_Productos_Ventas_Ventas1_idx` (`idVenta` ASC) VISIBLE,
  CONSTRAINT `fk_Productos_Ventas_Productos1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `fincaproduccionagricola`.`Productos` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Productos_Ventas_Ventas1`
    FOREIGN KEY (`idVenta`)
    REFERENCES `fincaproduccionagricola`.`Ventas` (`idVenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Tares_Herramientas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Tares_Herramientas` (
  `idTarea` INT NOT NULL,
  `idHerramienta` INT NOT NULL,
  PRIMARY KEY (`idTarea`, `idHerramienta`),
  INDEX `fk_Tares_Herramientas_Herramientas1_idx` (`idHerramienta` ASC) VISIBLE,
  CONSTRAINT `fk_Tares_Herramientas_Tareas1`
    FOREIGN KEY (`idTarea`)
    REFERENCES `fincaproduccionagricola`.`Tareas` (`idTarea`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tares_Herramientas_Herramientas1`
    FOREIGN KEY (`idHerramienta`)
    REFERENCES `fincaproduccionagricola`.`Herramientas` (`idHerramienta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Inventario_Herramientas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Inventario_Herramientas` (
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
    REFERENCES `fincaproduccionagricola`.`Herramientas` (`idHerramienta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Manteniminto_Herramientas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Manteniminto_Herramientas` (
  `idManteniminto_Herramientas` INT NOT NULL AUTO_INCREMENT,
  `Fecha` DATE NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `idHerramienta` INT NOT NULL,
  PRIMARY KEY (`idManteniminto_Herramientas`, `idHerramienta`),
  UNIQUE INDEX `idManteniminto_Herramientas_UNIQUE` (`idManteniminto_Herramientas` ASC) VISIBLE,
  INDEX `fk_Manteniminto_Herramientas_Herramientas1_idx` (`idHerramienta` ASC) VISIBLE,
  CONSTRAINT `fk_Manteniminto_Herramientas_Herramientas1`
    FOREIGN KEY (`idHerramienta`)
    REFERENCES `fincaproduccionagricola`.`Herramientas` (`idHerramienta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Log_Productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Log_Productos` (
  `idLog_Productos` INT NOT NULL AUTO_INCREMENT,
  `Mensaje` VARCHAR(45) NOT NULL,
  `Fecha` DATE NOT NULL,
  `idProducto` INT NOT NULL,
  PRIMARY KEY (`idLog_Productos`, `idProducto`),
  INDEX `fk_Log_Productos_Productos1_idx` (`idProducto` ASC) VISIBLE,
  CONSTRAINT `fk_Log_Productos_Productos1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `fincaproduccionagricola`.`Productos` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Log_Empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Log_Empleados` (
  `idLog_Empleados` INT NOT NULL AUTO_INCREMENT,
  `Mensaje` VARCHAR(45) NOT NULL,
  `Fecha` DATE NOT NULL,
  `idEmpleado` INT NOT NULL,
  PRIMARY KEY (`idLog_Empleados`, `idEmpleado`),
  UNIQUE INDEX `idLog_Empleados_UNIQUE` (`idLog_Empleados` ASC) VISIBLE,
  INDEX `fk_Log_Empleados_Empleados1_idx` (`idEmpleado` ASC) VISIBLE,
  CONSTRAINT `fk_Log_Empleados_Empleados1`
    FOREIGN KEY (`idEmpleado`)
    REFERENCES `fincaproduccionagricola`.`Empleados` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Log_Maquinaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Log_Maquinaria` (
  `idLog_Maquinaria` INT NOT NULL AUTO_INCREMENT,
  `Mensaje` VARCHAR(45) NOT NULL,
  `Fecha` DATE NOT NULL,
  `idMaquinaria` INT NOT NULL,
  PRIMARY KEY (`idLog_Maquinaria`, `idMaquinaria`),
  UNIQUE INDEX `idLog_Maquinaria_UNIQUE` (`idLog_Maquinaria` ASC) VISIBLE,
  INDEX `fk_Log_Maquinaria_Maquinaria1_idx` (`idMaquinaria` ASC) VISIBLE,
  CONSTRAINT `fk_Log_Maquinaria_Maquinaria1`
    FOREIGN KEY (`idMaquinaria`)
    REFERENCES `fincaproduccionagricola`.`Maquinaria` (`idMaquinaria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Log_Ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Log_Ventas` (
  `idLog_Ventas` INT NOT NULL AUTO_INCREMENT,
  `Mensaje` VARCHAR(45) NOT NULL,
  `Fecha` DATE NOT NULL,
  `idVenta` INT NOT NULL,
  PRIMARY KEY (`idLog_Ventas`, `idVenta`),
  UNIQUE INDEX `idLog_Ventas_UNIQUE` (`idLog_Ventas` ASC) VISIBLE,
  INDEX `fk_Log_Ventas_Ventas1_idx` (`idVenta` ASC) VISIBLE,
  CONSTRAINT `fk_Log_Ventas_Ventas1`
    FOREIGN KEY (`idVenta`)
    REFERENCES `fincaproduccionagricola`.`Ventas` (`idVenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fincaproduccionagricola`.`Log_Proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fincaproduccionagricola`.`Log_Proveedores` (
  `idLog_Proveedores` INT NOT NULL AUTO_INCREMENT,
  `Mensaje` VARCHAR(45) NOT NULL,
  `Fecha` DATE NOT NULL,
  `idProveedor` INT NOT NULL,
  PRIMARY KEY (`idLog_Proveedores`, `idProveedor`),
  UNIQUE INDEX `idLog_Proveedores_UNIQUE` (`idLog_Proveedores` ASC) VISIBLE,
  INDEX `fk_Log_Proveedores_Proveedores1_idx` (`idProveedor` ASC) VISIBLE,
  CONSTRAINT `fk_Log_Proveedores_Proveedores1`
    FOREIGN KEY (`idProveedor`)
    REFERENCES `fincaproduccionagricola`.`Proveedores` (`idProveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
