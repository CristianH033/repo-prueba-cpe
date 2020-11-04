-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`PERSONA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PERSONA` (
  `idPERSONA` INT NOT NULL,
  `cedula` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPERSONA`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`USUARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`USUARIO` (
  `idUSUARIO` INT NOT NULL,
  `rol` VARCHAR(45) NOT NULL,
  `login` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `idPersona` INT NOT NULL,
  PRIMARY KEY (`idUSUARIO`),
  INDEX `fk_USUARIO_PERSONA1_idx` (`idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_USUARIO_PERSONA1`
    FOREIGN KEY (`idPersona`)
    REFERENCES `mydb`.`PERSONA` (`idPERSONA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PRODUCTO_SERVICIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PRODUCTO_SERVICIO` (
  `idPRODUCTO` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(200) NOT NULL,
  `valorUnidad` INT NOT NULL,
  `fechaEntrega` DATE NOT NULL,
  `fechaVencimiento` DATE GENERATED ALWAYS AS () VIRTUAL,
  `activo` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`idPRODUCTO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CONTRATO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CONTRATO` (
  `idCONTRATO` INT NOT NULL,
  `objeto` VARCHAR(500) NOT NULL,
  `valorTotal` VARCHAR(45) NOT NULL,
  `fechaSubscripcion` DATE NOT NULL,
  `fechaTerminación` DATE NOT NULL,
  `estado` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idCONTRATO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SEGUIMIENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`SEGUIMIENTO` (
  `idSEGUIMIENTO` INT NOT NULL,
  `idContrato` INT NOT NULL,
  `entregado` TINYINT NULL,
  PRIMARY KEY (`idSEGUIMIENTO`),
  INDEX `fk_SEGUIMIENTO_CONTRATO1_idx` (`idContrato` ASC) VISIBLE,
  CONSTRAINT `fk_SEGUIMIENTO_CONTRATO1`
    FOREIGN KEY (`idContrato`)
    REFERENCES `mydb`.`CONTRATO` (`idCONTRATO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CONTRATISTA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CONTRATISTA` (
  `idCONTRATISTA` INT NOT NULL,
  `idPersona` INT NOT NULL,
  `idProducto` INT NOT NULL,
  PRIMARY KEY (`idCONTRATISTA`),
  INDEX `fk_CONTRATISTA_PERSONA1_idx` (`idPersona` ASC) VISIBLE,
  INDEX `fk_CONTRATISTA_PRODUCTO_SERVICIO1_idx` (`idProducto` ASC) VISIBLE,
  CONSTRAINT `fk_CONTRATISTA_PERSONA1`
    FOREIGN KEY (`idPersona`)
    REFERENCES `mydb`.`PERSONA` (`idPERSONA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CONTRATISTA_PRODUCTO_SERVICIO1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `mydb`.`PRODUCTO_SERVICIO` (`idPRODUCTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CONTRATISTAS_en_CONTRATOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CONTRATISTAS_en_CONTRATOS` (
  `id` INT NOT NULL,
  `idContratista` INT NOT NULL,
  `idContrato` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_CONTRATISTAS_en_CONTRATOS_CONTRATISTA1_idx` (`idContratista` ASC) VISIBLE,
  INDEX `fk_CONTRATISTAS_en_CONTRATOS_CONTRATO1_idx` (`idContrato` ASC) VISIBLE,
  CONSTRAINT `fk_CONTRATISTAS_en_CONTRATOS_CONTRATISTA1`
    FOREIGN KEY (`idContratista`)
    REFERENCES `mydb`.`CONTRATISTA` (`idCONTRATISTA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CONTRATISTAS_en_CONTRATOS_CONTRATO1`
    FOREIGN KEY (`idContrato`)
    REFERENCES `mydb`.`CONTRATO` (`idCONTRATO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PRODUCTOS_EN_CONTRATOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PRODUCTOS_EN_CONTRATOS` (
  `id` INT NOT NULL,
  `idContrato` INT NOT NULL,
  `idProducto` INT NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_PRODUCTOS_EN_CONTRATOS_CONTRATO1_idx` (`idContrato` ASC) VISIBLE,
  INDEX `fk_PRODUCTOS_EN_CONTRATOS_PRODUCTO_SERVICIO1_idx` (`idProducto` ASC) VISIBLE,
  CONSTRAINT `fk_PRODUCTOS_EN_CONTRATOS_CONTRATO1`
    FOREIGN KEY (`idContrato`)
    REFERENCES `mydb`.`CONTRATO` (`idCONTRATO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUCTOS_EN_CONTRATOS_PRODUCTO_SERVICIO1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `mydb`.`PRODUCTO_SERVICIO` (`idPRODUCTO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
