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
-- Table `mydb`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`persona` (
  `idPERSONA` INT NOT NULL,
  `cedula` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPERSONA`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`contratista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`contratista` (
  `idCONTRATISTA` INT NOT NULL,
  `idPersona` INT NOT NULL,
  PRIMARY KEY (`idCONTRATISTA`),
  CONSTRAINT `fk_CONTRATISTA_PERSONA1`
    FOREIGN KEY (`idPersona`)
    REFERENCES `mydb`.`persona` (`idPERSONA`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`contrato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`contrato` (
  `idCONTRATO` INT NOT NULL,
  `objeto` VARCHAR(500) NOT NULL,
  `valorTotal` VARCHAR(45) NOT NULL,
  `fechaSubscripcion` DATE NOT NULL,
  `fechaTerminación` DATE NOT NULL,
  `estado` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idCONTRATO`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`contratistas_en_contratos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`contratistas_en_contratos` (
  `id` INT NOT NULL,
  `idContratista` INT NOT NULL,
  `idContrato` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_CONTRATISTAS_en_CONTRATOS_CONTRATISTA1`
    FOREIGN KEY (`idContratista`)
    REFERENCES `mydb`.`contratista` (`idCONTRATISTA`),
  CONSTRAINT `fk_CONTRATISTAS_en_CONTRATOS_CONTRATO1`
    FOREIGN KEY (`idContrato`)
    REFERENCES `mydb`.`contrato` (`idCONTRATO`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`servicio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`servicio` (
  `idPRODUCTO` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(200) NOT NULL,
  `valorUnidad` INT NOT NULL,
  `fechaEntrega` DATE NOT NULL,
  `fechaVencimiento` DATE NOT NULL,
  `activo` TINYINT NULL DEFAULT '1',
  PRIMARY KEY (`idPRODUCTO`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`productos_en_contratos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`productos_en_contratos` (
  `id` INT NOT NULL,
  `idContrato` INT NOT NULL,
  `idProducto` INT NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_PRODUCTOS_EN_CONTRATOS_CONTRATO1`
    FOREIGN KEY (`idContrato`)
    REFERENCES `mydb`.`contrato` (`idCONTRATO`),
  CONSTRAINT `fk_PRODUCTOS_EN_CONTRATOS_PRODUCTO_SERVICIO1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `mydb`.`servicio` (`idPRODUCTO`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`seguimiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`seguimiento` (
  `idSEGUIMIENTO` INT NOT NULL,
  `idContrato` INT NOT NULL,
  `seguimientoFinal` TINYINT NULL DEFAULT NULL,
  `fechaSeguimiento` DATE NULL,
  `observacion` VARCHAR(200) NULL,
  PRIMARY KEY (`idSEGUIMIENTO`),
  CONSTRAINT `fk_SEGUIMIENTO_CONTRATO1`
    FOREIGN KEY (`idContrato`)
    REFERENCES `mydb`.`contrato` (`idCONTRATO`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rol` (
  `idrol` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idrol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuario` (
  `idUSUARIO` INT NOT NULL,
  `rol` VARCHAR(45) NOT NULL,
  `login` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `idPersona` INT NOT NULL,
  `rol_idrol` INT NOT NULL,
  PRIMARY KEY (`idUSUARIO`),
  INDEX `fk_USUARIO_PERSONA1` (`idPersona` ASC) VISIBLE,
  INDEX `fk_usuario_rol1_idx` (`rol_idrol` ASC) VISIBLE,
  CONSTRAINT `fk_USUARIO_PERSONA1`
    FOREIGN KEY (`idPersona`)
    REFERENCES `mydb`.`persona` (`idPERSONA`),
  CONSTRAINT `fk_usuario_rol1`
    FOREIGN KEY (`rol_idrol`)
    REFERENCES `mydb`.`rol` (`idrol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
