CREATE DATABASE  IF NOT EXISTS `jpingenieria_jpnet2023` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `jpingenieria_jpnet2023`;
-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: jpingenieria_jpnet2023
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `adelantoocreditos`
--

DROP TABLE IF EXISTS `adelantoocreditos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adelantoocreditos` (
  `idAdelantoOCreditos` int NOT NULL AUTO_INCREMENT,
  `CreditoHastaElMomento` float NOT NULL,
  `MontoAAdelantarOCreditar` float NOT NULL,
  `FechaDeSolicitud` date NOT NULL,
  `LinkDeSolicitud` text NOT NULL,
  `FechaDeDeposito` date NOT NULL,
  PRIMARY KEY (`idAdelantoOCreditos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `asignaciondepersonal`
--

DROP TABLE IF EXISTS `asignaciondepersonal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asignaciondepersonal` (
  `idAsignacionDePersonal` int NOT NULL AUTO_INCREMENT,
  `FechaDeInicioDeAsignacion` date DEFAULT NULL,
  `FechaDeFinDeAsignacion` date DEFAULT NULL,
  `idRegistroDePersonal` int DEFAULT NULL,
  PRIMARY KEY (`idAsignacionDePersonal`),
  KEY `FK_AsignacionDePersona_RegistroDePersonal_idx` (`idRegistroDePersonal`),
  CONSTRAINT `FK_AsignacionDePersona_RegistroDePersonal` FOREIGN KEY (`idRegistroDePersonal`) REFERENCES `registrodehabilitacion` (`idRegistroDeHabilitacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bonos`
--

DROP TABLE IF EXISTS `bonos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bonos` (
  `idBonos` int NOT NULL AUTO_INCREMENT,
  `PagoHorasExtras` float DEFAULT '0',
  `Reintegro` float DEFAULT '0',
  `BonoDeclarado` float DEFAULT '0',
  `BonoProduce` float DEFAULT '0',
  `BonoNoche` float DEFAULT '0',
  `BonoConductor` float DEFAULT '0',
  `BonoRotacion` float DEFAULT '0',
  `BonoAsignacionFamiliar` float DEFAULT '0',
  `idGratificacion` int DEFAULT '0',
  PRIMARY KEY (`idBonos`),
  KEY `FK_Bonos_Gratificacion_idx` (`idGratificacion`),
  CONSTRAINT `FK_Bonos_Gratificacion` FOREIGN KEY (`idGratificacion`) REFERENCES `gratificacion` (`idGratificacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `campodeestudio`
--

DROP TABLE IF EXISTS `campodeestudio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campodeestudio` (
  `idCampoDeEstudio` int NOT NULL,
  `NombreCampoDeEstudio` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idCampoDeEstudio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `candidato`
--

DROP TABLE IF EXISTS `candidato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidato` (
  `idCandidato` int NOT NULL AUTO_INCREMENT,
  `idPersona` int NOT NULL,
  `PretencionSalaria` int NOT NULL,
  `MesesDeExperiencia` int NOT NULL,
  `EtapaPrevia` tinyint NOT NULL,
  `LinkCurriculum` text NOT NULL,
  `EtapaDeLlamada` tinyint DEFAULT '0',
  `EtapaDeEntrevista` tinyint DEFAULT '0',
  `EtapaDeContratacion` tinyint DEFAULT '0',
  `idCargoAOptar` int DEFAULT NULL,
  PRIMARY KEY (`idCandidato`),
  KEY `FK_Candidato_Persona` (`idPersona`),
  KEY `FK_Candidadto_Cargo_idx` (`idCargoAOptar`),
  CONSTRAINT `FK_Candidadto_Cargo` FOREIGN KEY (`idCargoAOptar`) REFERENCES `cargo` (`idCargo`),
  CONSTRAINT `FK_Candidato_Persona` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cargo`
--

DROP TABLE IF EXISTS `cargo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cargo` (
  `idCargo` int NOT NULL,
  `NombreCargo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idCargo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categoriadebrevete`
--

DROP TABLE IF EXISTS `categoriadebrevete`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoriadebrevete` (
  `idCategoriaDeBrevete` int NOT NULL,
  `NombreCategoriaDeBrevete` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`idCategoriaDeBrevete`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `condiciondecontrato`
--

DROP TABLE IF EXISTS `condiciondecontrato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `condiciondecontrato` (
  `idCondicionDeContrato` int NOT NULL,
  `NombreCondicionDeContrato` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idCondicionDeContrato`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `condiciondetareo`
--

DROP TABLE IF EXISTS `condiciondetareo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `condiciondetareo` (
  `idCondicionDeTareo` int NOT NULL AUTO_INCREMENT,
  `NombreCondicionDeTareo` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`idCondicionDeTareo`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contrato`
--

DROP TABLE IF EXISTS `contrato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contrato` (
  `idContrato` int NOT NULL AUTO_INCREMENT,
  `idCondicionDeContrato` int NOT NULL,
  `idMotivoDeCese` int DEFAULT NULL,
  `idEmpleado` int NOT NULL,
  `FechaDeInicioDeContrato` date NOT NULL,
  `FechaDeFinDeContrato` date NOT NULL,
  PRIMARY KEY (`idContrato`),
  KEY `FK_Contrato_CondicionDeContrato_idx` (`idCondicionDeContrato`),
  KEY `FK_Contrato_MotivoDeCese_idx` (`idMotivoDeCese`),
  KEY `FK_Contrato_Empleados_idx` (`idEmpleado`),
  CONSTRAINT `FK_Contrato_CondicionDeContrato` FOREIGN KEY (`idCondicionDeContrato`) REFERENCES `condiciondecontrato` (`idCondicionDeContrato`),
  CONSTRAINT `FK_Contrato_Empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Contrato_MotivoCese` FOREIGN KEY (`idMotivoDeCese`) REFERENCES `motivodecese` (`idMotivosDeCese`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cuentasporrendir`
--

DROP TABLE IF EXISTS `cuentasporrendir`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cuentasporrendir` (
  `idCuentasPorRendir` int NOT NULL AUTO_INCREMENT,
  `DiaDeRegistro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Motivo` varchar(500) NOT NULL,
  `Monto` float NOT NULL,
  PRIMARY KEY (`idCuentasPorRendir`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cursodehabilitacion`
--

DROP TABLE IF EXISTS `cursodehabilitacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cursodehabilitacion` (
  `idCursoDeHabilitacion` int NOT NULL,
  `NombreCursoDeHabilitacion` varchar(45) DEFAULT NULL,
  `LinkCurso` text,
  `idProyecto` int NOT NULL,
  PRIMARY KEY (`idCursoDeHabilitacion`),
  KEY `FK_CursoDeHabilitacion_Proyecto_idx` (`idProyecto`),
  CONSTRAINT `FK_CursoDeHabilitacion_Proyecto` FOREIGN KEY (`idProyecto`) REFERENCES `proyecto` (`idProyecto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cursoparahabilitacion`
--

DROP TABLE IF EXISTS `cursoparahabilitacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cursoparahabilitacion` (
  `idCursoParaHabilitacion` int NOT NULL,
  `idProcedimientoDeHabilitacion` int NOT NULL,
  `idCursoDeHabilitacion` int NOT NULL,
  `FechaDeInicioDeCertificacion` date NOT NULL,
  `FechaDeFinDeCertificacion` date NOT NULL,
  `idEstadoDeCurso` int NOT NULL,
  PRIMARY KEY (`idCursoParaHabilitacion`),
  KEY `FK_CursoDeHabilitacion__idx` (`idCursoDeHabilitacion`),
  KEY `FK_CursoParaHabilitacion_EstadoDeCurso_idx` (`idEstadoDeCurso`),
  KEY `FK_CursoParaHabilitacion_Procedimiento_idx` (`idProcedimientoDeHabilitacion`),
  CONSTRAINT `FK_CursoDeHabilitacion_` FOREIGN KEY (`idCursoDeHabilitacion`) REFERENCES `cursodehabilitacion` (`idCursoDeHabilitacion`),
  CONSTRAINT `FK_CursoParaHabilitacion_EstadoDeCurso` FOREIGN KEY (`idEstadoDeCurso`) REFERENCES `estadodecurso` (`idEstadoDeCurso`),
  CONSTRAINT `FK_CursoParaHabilitacion_Procedimiento` FOREIGN KEY (`idProcedimientoDeHabilitacion`) REFERENCES `procedimientodehabilitacion` (`idProcedimientoDeHabilitacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `datoscontables`
--

DROP TABLE IF EXISTS `datoscontables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `datoscontables` (
  `idDatosContables` int NOT NULL AUTO_INCREMENT,
  `SueldoBase` float NOT NULL,
  `CISPP` varchar(25) DEFAULT NULL,
  `NHijos` int NOT NULL DEFAULT '0',
  `idContrato` int NOT NULL,
  PRIMARY KEY (`idDatosContables`),
  KEY `FK_DatosContables_Contrato_idx` (`idContrato`),
  CONSTRAINT `FK_DatosContables_Contrato` FOREIGN KEY (`idContrato`) REFERENCES `contrato` (`idContrato`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `datosprofesionales`
--

DROP TABLE IF EXISTS `datosprofesionales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `datosprofesionales` (
  `idDatosProfesionales` int NOT NULL,
  `idEmpleado` int DEFAULT NULL,
  `Profesion` varchar(100) DEFAULT NULL,
  `idCampoDeEstudio` int DEFAULT NULL,
  `MesesDeExperiencia` int DEFAULT NULL,
  `idCategoriaDeBrevete` int DEFAULT NULL,
  PRIMARY KEY (`idDatosProfesionales`),
  KEY `FK_DatosProfesionales_CampoDeEstudio_idx` (`idCampoDeEstudio`),
  KEY `FK_DatosProfesionales_CategoriaDeBrevete_idx` (`idCategoriaDeBrevete`),
  KEY `FK_DatosProfesionales_Empleados_idx` (`idEmpleado`),
  CONSTRAINT `FK_DatosProfesionales_CampoDeEstudio` FOREIGN KEY (`idCampoDeEstudio`) REFERENCES `campodeestudio` (`idCampoDeEstudio`),
  CONSTRAINT `FK_DatosProfesionales_CategoriaDeBrevete` FOREIGN KEY (`idCategoriaDeBrevete`) REFERENCES `categoriadebrevete` (`idCategoriaDeBrevete`),
  CONSTRAINT `FK_DatosProfesionales_Empleados` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `descansomedico`
--

DROP TABLE IF EXISTS `descansomedico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `descansomedico` (
  `idDescansoMedico` int NOT NULL AUTO_INCREMENT,
  `FechaDeInicioDescansoMedico` date NOT NULL,
  `FechaDeFinDescansoMedico` date NOT NULL,
  `LinkDocumento` text,
  PRIMARY KEY (`idDescansoMedico`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `descuentos`
--

DROP TABLE IF EXISTS `descuentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `descuentos` (
  `idDescuentos` int NOT NULL AUTO_INCREMENT,
  `idPeriodo` int NOT NULL,
  `idContrato` int NOT NULL,
  `ImpuestoDeQuintaCategoria` float NOT NULL DEFAULT '0',
  `Tardanzas` float NOT NULL DEFAULT '0',
  `Faltas` int NOT NULL DEFAULT '0',
  `DescuentoFondoDePension` float NOT NULL DEFAULT '0',
  `idAdelantoOCredito` int DEFAULT NULL,
  `idCuentaPorRendir` int DEFAULT NULL,
  `idDescuentoRecursosHumanos` int DEFAULT NULL,
  PRIMARY KEY (`idDescuentos`),
  KEY `FK_Descuentos_Adelantos_idx` (`idAdelantoOCredito`),
  KEY `FK_Descuento_Periodo_idx` (`idPeriodo`),
  KEY `FK_Descuentos_IdContrato_idx` (`idContrato`),
  KEY `FK_Descuentos_CuentasPorRendir_idx` (`idCuentaPorRendir`),
  KEY `FK_Descuentos_IdDescuentoDeRecursosHumanos_idx` (`idDescuentoRecursosHumanos`),
  CONSTRAINT `FK_Descuento_Periodo` FOREIGN KEY (`idPeriodo`) REFERENCES `periodo` (`idPeriodo`),
  CONSTRAINT `FK_Descuentos_Adelantos` FOREIGN KEY (`idAdelantoOCredito`) REFERENCES `adelantoocreditos` (`idAdelantoOCreditos`),
  CONSTRAINT `FK_Descuentos_CuentasPorRendir` FOREIGN KEY (`idCuentaPorRendir`) REFERENCES `cuentasporrendir` (`idCuentasPorRendir`),
  CONSTRAINT `FK_Descuentos_IdContrato` FOREIGN KEY (`idContrato`) REFERENCES `contrato` (`idContrato`),
  CONSTRAINT `FK_Descuentos_IdDescuentoDeRecursosHumanos` FOREIGN KEY (`idDescuentoRecursosHumanos`) REFERENCES `descuentosderecursoshumanos` (`idDescuentosDeRecursosHumanos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `descuentosderecursoshumanos`
--

DROP TABLE IF EXISTS `descuentosderecursoshumanos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `descuentosderecursoshumanos` (
  `idDescuentosDeRecursosHumanos` int NOT NULL,
  `Motivo` varchar(500) NOT NULL,
  `Monto` float NOT NULL,
  PRIMARY KEY (`idDescuentosDeRecursosHumanos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `direccion`
--

DROP TABLE IF EXISTS `direccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `direccion` (
  `idDireccion` int NOT NULL AUTO_INCREMENT,
  `idTipoDeVia` int DEFAULT NULL,
  `NombreDeVia` varchar(45) DEFAULT NULL,
  `idTipoDeLocalidad` int DEFAULT NULL,
  `NombreLocalidad` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idDireccion`),
  KEY `FK_Direccion_TipoDeVia_idx` (`idTipoDeVia`),
  KEY `FK_Direccion_TipoDeLocalidad_idx` (`idTipoDeLocalidad`),
  CONSTRAINT `FK_Direccion_TipoDeLocalidad` FOREIGN KEY (`idTipoDeLocalidad`) REFERENCES `tipodelocalidad` (`idTipoDeLocalidad`),
  CONSTRAINT `FK_Direccion_TipoDeVia` FOREIGN KEY (`idTipoDeVia`) REFERENCES `tipodevia` (`idTipoDeVia`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empleado`
--

DROP TABLE IF EXISTS `empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleado` (
  `idEmpleado` int NOT NULL AUTO_INCREMENT,
  `idPersona` int NOT NULL,
  `idCargo` int NOT NULL,
  `idFondoDePension` int NOT NULL,
  PRIMARY KEY (`idEmpleado`),
  UNIQUE KEY `idPersona_UNIQUE` (`idPersona`),
  KEY `FK_Empleado_Cargo_idx` (`idCargo`),
  KEY `FK_FondoDePension_idx` (`idFondoDePension`),
  CONSTRAINT `empleado_ibfk_1` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Empleado_Cargo` FOREIGN KEY (`idCargo`) REFERENCES `cargo` (`idCargo`),
  CONSTRAINT `FK_FondoDePension` FOREIGN KEY (`idFondoDePension`) REFERENCES `fondodepension` (`idFondoDePension`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `estaciondetrabajo`
--

DROP TABLE IF EXISTS `estaciondetrabajo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estaciondetrabajo` (
  `idEstacionDeTrabajo` int NOT NULL AUTO_INCREMENT,
  `NombreEstacionDeTrabajo` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`idEstacionDeTrabajo`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `estadodecurso`
--

DROP TABLE IF EXISTS `estadodecurso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estadodecurso` (
  `idEstadoDeCurso` int NOT NULL AUTO_INCREMENT,
  `NombreEstadoDeCurso` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idEstadoDeCurso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `estadodehabilitacion`
--

DROP TABLE IF EXISTS `estadodehabilitacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estadodehabilitacion` (
  `idEstadoDeHabilitacion` int NOT NULL AUTO_INCREMENT,
  `NombreEstadoDeHabilitacion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idEstadoDeHabilitacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etapadeprocedimientodehabilitacion`
--

DROP TABLE IF EXISTS `etapadeprocedimientodehabilitacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etapadeprocedimientodehabilitacion` (
  `idEtapaDeProcedimientoDeHabilitacion` int NOT NULL AUTO_INCREMENT,
  `NombreEtapaDeProcedimientoDeHabilitacion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idEtapaDeProcedimientoDeHabilitacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `examenmedico`
--

DROP TABLE IF EXISTS `examenmedico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `examenmedico` (
  `idExamenMedico` int NOT NULL,
  `idTipoDeExamenMedico` int DEFAULT NULL,
  `FechaDeInicioVigencia` date DEFAULT NULL,
  `FechaDeFinVidencia` date DEFAULT NULL,
  `idEmpleado` int DEFAULT NULL,
  PRIMARY KEY (`idExamenMedico`),
  KEY `FK_ExamenMedico_TipoDeExamenMedico_idx` (`idTipoDeExamenMedico`),
  KEY `FK_ExamenMedico_Empleado_idx` (`idEmpleado`),
  CONSTRAINT `FK_ExamenMedico_Empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`),
  CONSTRAINT `FK_ExamenMedico_TipoDeExamenMedico` FOREIGN KEY (`idTipoDeExamenMedico`) REFERENCES `tipoexamenmedico` (`idTipoExamenMedico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fondodepension`
--

DROP TABLE IF EXISTS `fondodepension`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fondodepension` (
  `idFondoDePension` int NOT NULL AUTO_INCREMENT,
  `NombreEntidad` varchar(45) NOT NULL,
  `TipoDeFondo` varchar(45) NOT NULL,
  `TipoDeEmpresa` varchar(45) NOT NULL,
  `PorcentajeDeDescuento` float NOT NULL,
  PRIMARY KEY (`idFondoDePension`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gratificacion`
--

DROP TABLE IF EXISTS `gratificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gratificacion` (
  `idGratificacion` int NOT NULL AUTO_INCREMENT,
  `MesesConsiderados` int NOT NULL,
  `SueldoConsiderado` float NOT NULL,
  `TotalAConsiderar` float DEFAULT '0',
  PRIMARY KEY (`idGratificacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `horasextras`
--

DROP TABLE IF EXISTS `horasextras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `horasextras` (
  `idHorasExtras` int NOT NULL AUTO_INCREMENT,
  `LinkDocumento` text NOT NULL,
  `HoraDeRegistro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ValorDe25` float DEFAULT '0',
  `ValorDe35` float DEFAULT '0',
  PRIMARY KEY (`idHorasExtras`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `licenciacongocedehaber`
--

DROP TABLE IF EXISTS `licenciacongocedehaber`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `licenciacongocedehaber` (
  `idLicenciaConGoceDeHaber` int NOT NULL AUTO_INCREMENT,
  `FechaDeInicioConGoceDeHaber` date NOT NULL,
  `FechaDeFinSinGoceDeHaber` date NOT NULL,
  `DiasHabiles` int DEFAULT NULL,
  `LinkDelDocumento` text NOT NULL,
  PRIMARY KEY (`idLicenciaConGoceDeHaber`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `licenciasingocedehaber`
--

DROP TABLE IF EXISTS `licenciasingocedehaber`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `licenciasingocedehaber` (
  `idLicenciaSinGoceDeHaber` int NOT NULL AUTO_INCREMENT,
  `FechaDeInicioSinGoceDeHaber` date NOT NULL,
  `FechaDeFinSinGoceDeHaber` date NOT NULL,
  `DiasHabilesAConsiderar` int DEFAULT NULL,
  `LinkDelDocumento` text NOT NULL,
  PRIMARY KEY (`idLicenciaSinGoceDeHaber`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `liquidacion`
--

DROP TABLE IF EXISTS `liquidacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `liquidacion` (
  `idLiquidacion` int NOT NULL,
  `idContrato` int DEFAULT NULL,
  `FechaDeInicio` date DEFAULT NULL,
  `FechaDeFIn` date DEFAULT NULL,
  `MontoEstimado` float DEFAULT NULL,
  `BeneficiosNoPagados` float DEFAULT NULL,
  PRIMARY KEY (`idLiquidacion`),
  KEY `FK_Liquidacion_Contrato_idx` (`idContrato`),
  CONSTRAINT `FK_Liquidacion_Contrato` FOREIGN KEY (`idContrato`) REFERENCES `contrato` (`idContrato`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `localidad`
--

DROP TABLE IF EXISTS `localidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `localidad` (
  `idLocalidad` int NOT NULL,
  `Ubigeo` varchar(6) DEFAULT NULL,
  `Departamento` varchar(45) DEFAULT NULL,
  `Provincia` varchar(45) DEFAULT NULL,
  `Distrito` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idLocalidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login` (
  `idLogin` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(250) DEFAULT NULL,
  `PersonaId` int DEFAULT NULL,
  PRIMARY KEY (`idLogin`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `motivodecese`
--

DROP TABLE IF EXISTS `motivodecese`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `motivodecese` (
  `idMotivosDeCese` int NOT NULL,
  `NombreMotivosDeCese` varchar(19) NOT NULL,
  PRIMARY KEY (`idMotivosDeCese`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pagotareo`
--

DROP TABLE IF EXISTS `pagotareo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagotareo` (
  `idPagoTareo` int NOT NULL AUTO_INCREMENT,
  `idTareo` int NOT NULL,
  `CantidadDePago` float NOT NULL,
  `idPeriodo` int NOT NULL,
  PRIMARY KEY (`idPagoTareo`),
  UNIQUE KEY `idTareo_UNIQUE` (`idTareo`),
  KEY `FK_PagoTareo_Tareo_idx` (`idTareo`),
  KEY `FK_PagoTareo_Periodo_idx` (`idPeriodo`),
  CONSTRAINT `FK_PagoTareo_Periodo` FOREIGN KEY (`idPeriodo`) REFERENCES `periodo` (`idPeriodo`),
  CONSTRAINT `FK_PagoTareo_Tareo` FOREIGN KEY (`idTareo`) REFERENCES `tareo` (`idTareo`)
) ENGINE=InnoDB AUTO_INCREMENT=2478 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `periodo`
--

DROP TABLE IF EXISTS `periodo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `periodo` (
  `idPeriodo` int NOT NULL AUTO_INCREMENT,
  `NombrePeriodo` varchar(45) NOT NULL,
  `DiaDeInicioDelPeriodo` date NOT NULL,
  `DiaDeFinDelPeriodo` date NOT NULL,
  `CantidadDeDias` int NOT NULL,
  PRIMARY KEY (`idPeriodo`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `persona`
--

DROP TABLE IF EXISTS `persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `persona` (
  `idPersona` int NOT NULL AUTO_INCREMENT,
  `Nombres` varchar(45) NOT NULL,
  `ApellidoPaterno` varchar(45) NOT NULL,
  `ApellidoMaterno` varchar(45) NOT NULL,
  `DNI` varchar(10) NOT NULL,
  `Telefono` varchar(13) NOT NULL,
  `TelefonoFijo` varchar(10) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `ContactoDeEmergencia` varchar(100) DEFAULT NULL,
  `NumeroDeEmergencia` varchar(13) DEFAULT NULL,
  `idLocalidadDeNacimiento` int DEFAULT NULL,
  `idLocalidadActual` int DEFAULT NULL,
  `idDireccion` int DEFAULT NULL,
  `FechaDeNacimiento` date DEFAULT NULL,
  `idTipoDeSangre` int DEFAULT NULL,
  `Alergias` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idPersona`),
  UNIQUE KEY `DNI_UNIQUE` (`DNI`),
  KEY `FKPersona_Localidad` (`idLocalidadDeNacimiento`) /*!80000 INVISIBLE */,
  KEY `FK_Persona_TipoDeSangre_idx` (`idTipoDeSangre`),
  KEY `FK_Persona_LocalidadActual_idx` (`idLocalidadActual`),
  KEY `FK_Persona_Direccion_idx` (`idDireccion`),
  CONSTRAINT `FK_Persona_Direccion` FOREIGN KEY (`idDireccion`) REFERENCES `direccion` (`idDireccion`),
  CONSTRAINT `FK_Persona_LocalidadActual` FOREIGN KEY (`idLocalidadActual`) REFERENCES `localidad` (`idLocalidad`),
  CONSTRAINT `FK_Persona_LocalidadNacimiento` FOREIGN KEY (`idLocalidadDeNacimiento`) REFERENCES `localidad` (`idLocalidad`),
  CONSTRAINT `FK_Persona_TipoDeSangre` FOREIGN KEY (`idTipoDeSangre`) REFERENCES `tipodesangre` (`idTipoDeSangre`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `planilla`
--

DROP TABLE IF EXISTS `planilla`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `planilla` (
  `idPlanilla` int NOT NULL AUTO_INCREMENT,
  `idPeriodo` int NOT NULL,
  `idDatosContables` int NOT NULL,
  `TotalNetoAPagar` float NOT NULL DEFAULT '0',
  `PagoEsSalud` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`idPlanilla`),
  KEY `FK_Planilla_DatosContables_idx` (`idDatosContables`),
  KEY `FK_Planilla_Periodo_idx` (`idPeriodo`),
  CONSTRAINT `FK_Planilla_DatosContables` FOREIGN KEY (`idDatosContables`) REFERENCES `datoscontables` (`idDatosContables`),
  CONSTRAINT `FK_Planilla_Periodo` FOREIGN KEY (`idPeriodo`) REFERENCES `periodo` (`idPeriodo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `procedimientodehabilitacion`
--

DROP TABLE IF EXISTS `procedimientodehabilitacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `procedimientodehabilitacion` (
  `idProcedimientoDeHabilitacion` int NOT NULL AUTO_INCREMENT,
  `idProyecto` int DEFAULT NULL,
  `Nombre` text,
  `idEtapaDeProcemientoDeHabilitacion` int DEFAULT NULL,
  PRIMARY KEY (`idProcedimientoDeHabilitacion`),
  KEY `FK_ProcedimientoDeHabilitacion_Proyecto_idx` (`idProyecto`),
  KEY `FK_ProcdimientoDeHabilitacion_EtapaDeProcedimiento_idx` (`idEtapaDeProcemientoDeHabilitacion`),
  CONSTRAINT `FK_ProcdimientoDeHabilitacion_EtapaDeProcedimiento` FOREIGN KEY (`idEtapaDeProcemientoDeHabilitacion`) REFERENCES `etapadeprocedimientodehabilitacion` (`idEtapaDeProcedimientoDeHabilitacion`),
  CONSTRAINT `FK_ProcedimientoDeHabilitacion_Proyecto` FOREIGN KEY (`idProyecto`) REFERENCES `proyecto` (`idProyecto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `proyecto`
--

DROP TABLE IF EXISTS `proyecto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proyecto` (
  `idProyecto` int NOT NULL AUTO_INCREMENT,
  `NombreProyecto` varchar(100) NOT NULL,
  PRIMARY KEY (`idProyecto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `registrodehabilitacion`
--

DROP TABLE IF EXISTS `registrodehabilitacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registrodehabilitacion` (
  `idRegistroDeHabilitacion` int NOT NULL AUTO_INCREMENT,
  `idEmpleado` int NOT NULL,
  `idEstadoDeHabiliatacion` int NOT NULL,
  `idProcedimientoDeHabilitacion` int NOT NULL,
  PRIMARY KEY (`idRegistroDeHabilitacion`),
  KEY `FK_RegistroDeHabiliatacion_EstadoDeHabilitacion_idx` (`idEstadoDeHabiliatacion`),
  KEY `FK_RegistroDeHabiliatacion_ProcedimientoDeHabilitacion_idx` (`idProcedimientoDeHabilitacion`),
  KEY `FK_RegistroDeHabiliatacion_Empleado_idx` (`idEmpleado`),
  CONSTRAINT `FK_RegistroDeHabiliatacion_Empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`),
  CONSTRAINT `FK_RegistroDeHabiliatacion_EstadoDeHabilitacion` FOREIGN KEY (`idEstadoDeHabiliatacion`) REFERENCES `estadodehabilitacion` (`idEstadoDeHabilitacion`),
  CONSTRAINT `FK_RegistroDeHabiliatacion_ProcedimientoDeHabilitacion` FOREIGN KEY (`idProcedimientoDeHabilitacion`) REFERENCES `procedimientodehabilitacion` (`idProcedimientoDeHabilitacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `segurocomplementariodetrabajoderiesgo`
--

DROP TABLE IF EXISTS `segurocomplementariodetrabajoderiesgo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `segurocomplementariodetrabajoderiesgo` (
  `idSeguroComplementarioDeTrabajoDeRiesgo` int NOT NULL AUTO_INCREMENT,
  `idEmpleado` int NOT NULL,
  `idProyecto` int NOT NULL,
  `FechaDeEmisionDeCetificado` date DEFAULT NULL,
  `FechaDeCaducidadDeCertificado` date DEFAULT NULL,
  PRIMARY KEY (`idSeguroComplementarioDeTrabajoDeRiesgo`),
  KEY `FK_SCTR_Proyecto_idx` (`idProyecto`),
  KEY `FK_SCTR_Empleado_idx` (`idEmpleado`),
  CONSTRAINT `FK_SCTR_Empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`),
  CONSTRAINT `FK_SCTR_Proyecto` FOREIGN KEY (`idProyecto`) REFERENCES `proyecto` (`idProyecto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tareo`
--

DROP TABLE IF EXISTS `tareo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tareo` (
  `idTareo` int NOT NULL AUTO_INCREMENT,
  `idContrato` int NOT NULL,
  `Fecha` date NOT NULL,
  `HoraDeIngreso` time NOT NULL,
  `HoraDeInicioDeAlmuerzo` time NOT NULL,
  `HoraDeFinDeAlmuerzo` time NOT NULL,
  `HoraDeSalida` time NOT NULL,
  `idCondicionDeTareo` int DEFAULT NULL,
  `idEstacionDeTrabajo` int NOT NULL,
  `idLicenciaConGoceDeHaber` int DEFAULT NULL,
  `idLicenciaSinGoceDeHaber` int DEFAULT NULL,
  `idDescansoMedico` int DEFAULT NULL,
  `idHorasExtras` int DEFAULT NULL,
  `idVacaciones` int DEFAULT NULL,
  PRIMARY KEY (`idTareo`),
  KEY `FK_Tareo_CondicionDeTareo_idx` (`idCondicionDeTareo`),
  KEY `FK_Tareo_EstacionDeTrabajo_idx` (`idEstacionDeTrabajo`),
  KEY `FK_Tareo_LicenciaSinGoceDeHaber_idx` (`idLicenciaSinGoceDeHaber`),
  KEY `FK_Tareo_DescansoMedico_idx` (`idDescansoMedico`),
  KEY `FK_Tareo_Contrato_idx` (`idContrato`),
  KEY `FK_Tareo_HorasExtras_idx` (`idHorasExtras`),
  KEY `FK_Tareo_Vacaciones_idx` (`idVacaciones`),
  CONSTRAINT `FK_Tareo_CondicionDeTareo` FOREIGN KEY (`idCondicionDeTareo`) REFERENCES `condiciondetareo` (`idCondicionDeTareo`),
  CONSTRAINT `FK_Tareo_Contrato` FOREIGN KEY (`idContrato`) REFERENCES `contrato` (`idContrato`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Tareo_DescansoMedico` FOREIGN KEY (`idDescansoMedico`) REFERENCES `descansomedico` (`idDescansoMedico`),
  CONSTRAINT `FK_Tareo_EstacionDeTrabajo` FOREIGN KEY (`idEstacionDeTrabajo`) REFERENCES `estaciondetrabajo` (`idEstacionDeTrabajo`),
  CONSTRAINT `FK_Tareo_HorasExtras` FOREIGN KEY (`idHorasExtras`) REFERENCES `horasextras` (`idHorasExtras`),
  CONSTRAINT `FK_Tareo_LicenciaConGoceDeHaber` FOREIGN KEY (`idLicenciaSinGoceDeHaber`) REFERENCES `licenciacongocedehaber` (`idLicenciaConGoceDeHaber`),
  CONSTRAINT `FK_Tareo_LicenciaSinGoceDeHaber` FOREIGN KEY (`idLicenciaSinGoceDeHaber`) REFERENCES `licenciasingocedehaber` (`idLicenciaSinGoceDeHaber`),
  CONSTRAINT `FK_Tareo_Vacaciones` FOREIGN KEY (`idVacaciones`) REFERENCES `vacaciones` (`idVacaciones`)
) ENGINE=InnoDB AUTO_INCREMENT=563 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipodelocalidad`
--

DROP TABLE IF EXISTS `tipodelocalidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipodelocalidad` (
  `idTipoDeLocalidad` int NOT NULL AUTO_INCREMENT,
  `NombreTipoDeLocalidad` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idTipoDeLocalidad`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipodesangre`
--

DROP TABLE IF EXISTS `tipodesangre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipodesangre` (
  `idTipoDeSangre` int NOT NULL,
  `NombreTipoDeSangre` varchar(3) NOT NULL,
  PRIMARY KEY (`idTipoDeSangre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipodevia`
--

DROP TABLE IF EXISTS `tipodevia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipodevia` (
  `idTipoDeVia` int NOT NULL,
  `NombreTipoDeVia` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`idTipoDeVia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipoexamenmedico`
--

DROP TABLE IF EXISTS `tipoexamenmedico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipoexamenmedico` (
  `idTipoExamenMedico` int NOT NULL,
  `NombreTipoExamenMedico` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idTipoExamenMedico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vacaciones`
--

DROP TABLE IF EXISTS `vacaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vacaciones` (
  `idVacaciones` int NOT NULL AUTO_INCREMENT,
  `FechaDeInicioVacaciones` date NOT NULL,
  `FechaDeFinVacaciones` date NOT NULL,
  `LinkDeDocumento` text NOT NULL,
  `DiasAConsiderar` int DEFAULT NULL,
  PRIMARY KEY (`idVacaciones`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'jpingenieria_jpnet2023'
--

--
-- Dumping routines for database 'jpingenieria_jpnet2023'
--
/*!50003 DROP PROCEDURE IF EXISTS `ActualizarCandidato` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarCandidato`(IN IDCandidato_IN INT,IN EtapaPrevia_IN INT,IN EtapaDeLlamada_IN INT,IN EtapaEntrevista_IN INT,IN EtapaDeContratacion_IN INT)
BEGIN
	UPDATE jpingenieria_jpnet2023.candidato CAND SET 
    CAND.EtapaPrevia = EtapaPrevia_IN,
    CAND.EtapaDeLlamada = EtapaDeLlamada_IN,
    CAND.EtapaDeEntrevista = EtapaEntrevista_IN,
    CAND.EtapaDeContratacion = EtapaDeContratacion_IN 
    WHERE CAND.idCandidato = IDCandidato_IN; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ActualizarEmpleado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarEmpleado`(IN NOMBRE_IN VARCHAR(45),IN APELLIDO_PATERNO_IN VARCHAR(45),IN APELLIDO_MATERNO_IN VARCHAR(45),IN DNI_IN VARCHAR(10),IN TELEFONO_IN VARCHAR(12),
IN TELEFONOFIJO_IN VARCHAR(10),IN EMAIL_IN VARCHAR(100),IN CONTACTODEEMERGENCIA_IN VARCHAR(100),IN NUMERODEEMERGENCIA_IN VARCHAR(12),IN ID_LOCALIDAD_NACIMIENTO_IN INT,
IN ID_LOCALIDAD_ACTUAL_IN INT,IN ID_DIRECCION_IN INT,IN FECHA_DE_NACIMIENTO_IN DATE,IN ID_TIPO_DE_SANGRE_IN INT,IN ALERGIAS_IN VARCHAR(100))
BEGIN
	DECLARE idPERS INT;
	SET idPERS = (SELECT PER.idPersona FROM jpingenieria_jpnet2023.persona PER WHERE PER.DNI = DNI_IN);
	UPDATE jpingenieria_jpnet2023.persona PER SET 
    PER.Nombres = NOMBRE_IN,
    PER.ApellidoPaterno = APELLIDO_PATERNO_IN,
    PER.ApellidoMaterno = APELLIDO_MATERNO_IN,
    PER.Telefono =TELEFONO_IN,
    PER.TelefonoFijo = TELEFONOFIJO_IN,
    PER.Email =EMAIL_IN ,
    PER.ContactoDeEmergencia = CONTACTODEEMERGENCIA_IN,
    PER.NumeroDeEmergencia = NUMERODEEMERGENCIA_IN,
    PER.idLocalidadDeNacimiento = ID_LOCALIDAD_NACIMIENTO_IN,
    PER.idLocalidadActual = ID_LOCALIDAD_ACTUAL_IN,
    PER.idDireccion = ID_DIRECCION_IN,
    PER.FechaDeNacimiento = FECHA_DE_NACIMIENTO_IN,
    PER.idTipoDeSangre = ID_TIPO_DE_SANGRE_IN,
    PER.Alergias = ALERGIAS_IN
    WHERE PER.idPersona = idPERS;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ActualizarTareo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarTareo`(IN HoraDeIngreso_IN TIME, IN HoraDeInicioDeAlmuerzo_IN TIME, IN HoraDeFinDeAlmuerzo_IN TIME,IN HoraDeSalida_IN TIME,IN idEstacionDeTrabajo_IN INT ,IN idTareo_IN INT)
BEGIN
	UPDATE tareo SET 	HoraDeIngreso=HoraDeIngreso_IN, 
						HoraDeInicioDeAlmuerzo=HoraDeInicioDeAlmuerzo_IN,
                        HoraDeFinDeAlmuerzo=HoraDeFinDeAlmuerzo_IN,
                        HoraDeSalida=HoraDeSalida_IN,
                        idEstacionDeTrabajo=idEstacionDeTrabajo_IN 
						WHERE idTareo=idTareo_IN;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AgregarTareadoComun` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AgregarTareadoComun`(IN FECHA_IN DATE,IN HoraDeIngreso_IN TIME,IN HoraInicioAlmuerzo_IN TIME,IN HoraFinAlmuerzo_IN TIME,IN HoraSalida_IN TIME, IN idEmpleado_IN INT, IN EstacionDeTrabajo_IN INT)
BEGIN
	DECLARE ID_Contrato INT;
	SET ID_Contrato = (SELECT idContrato FROM contrato  WHERE idEmpleado = idEmpleado_IN AND idCondicionDeContrato = 1);
	INSERT INTO tareo(idContrato,Fecha,HoraDeIngreso, HoraDeInicioDeAlmuerzo,HoraDeFinDEAlmuerzo,HoraDeSalida,idEstacionDeTrabajo)
    VALUES(ID_Contrato,FECHA_IN,HoraDeIngreso_IN,HoraInicioAlmuerzo_IN,HoraFinAlmuerzo_IN,HoraSalida_IN,EstacionDeTrabajo_IN);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AgregarTareadoMina` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AgregarTareadoMina`(IN FECHA_IN DATE, IN ID_Operacion INT, IN idEmpleado_IN INT, IN CondicionDeTareo_IN INT)
BEGIN
	DECLARE ID_Contrato INT;
    SET ID_Contrato = (SELECT idContrato FROM contrato  WHERE idEmpleado = idEmpleado_IN AND idCondicionDeContrato = 1);
	
	INSERT INTO tareo(idContrato,Fecha,HoraDeIngreso, HoraDeInicioDeAlmuerzo,HoraDeFinDEAlmuerzo,HoraDeSalida,idCondicionDeTareo,idEstacionDeTrabajo)
    VALUES(ID_Contrato,FECHA_IN,'07:00:00','13:00:00','13:30:00','19:00:00',CondicionDeTareo_IN,ID_Operacion);
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CalcularRemuneracionBruta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CalcularRemuneracionBruta`(IN DNI_IN VARCHAR(10), IN FINICIO_IN DATE,IN FECHAFIN_IN DATE )
BEGIN
	DECLARE IDEmpleado INT;
    DECLARE IDContrato INT;
	SET IDEmpleado = (SELECT EMP.idEmpleado FROM empleado EMP INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN); 
	SET IDContrato = (SELECT CT.idContrato FROM jpingenieria_jpnet2023.contrato CT INNER JOIN jpingenieria_jpnet2023.empleado EMP ON CT.idEmpleado = EMP.idEmpleado INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN AND CT.idCondicionDeContrato =1);
	SELECT ROUND(SUM(PG.CantidadDePago), 2)AS SueldoBruto, ROUND(SUM(PG.CantidadDePago), 2)*0.09 AS EsSalud FROM jpingenieria_jpnet2023.pagotareo PG INNER JOIN jpingenieria_jpnet2023.tareo TAR ON PG.idTareo = TAR.idTareo WHERE TAR.Fecha >= FINICIO_IN AND FECHAFIN_IN >= TAR.Fecha AND TAR.idContrato = IDContrato;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CrearCandidato` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CrearCandidato`(IN NOMBRE_IN VARCHAR(45),IN APELLIDO_PATERNO_IN VARCHAR(45),IN APELLIDO_MATERNO_IN VARCHAR(45),IN DNI_IN VARCHAR(10),IN TELEFONO_IN VARCHAR(12),IN EMAIL_IN VARCHAR(100),IN SALARIO_IN FLOAT,IN CARGO_IN INT, IN NMESES INT , IN LINK_CV_IN VARCHAR(500))
BEGIN
	 DECLARE idPERS INT;
	 CALL CrearPersona(	NOMBRE_IN,    APELLIDO_PATERNO_IN,    APELLIDO_MATERNO_IN,	DNI_IN,	TELEFONO_IN,	"",	EMAIL_IN,	"",	"" ,	1 ,	1 ,	1 ,	2000-01-01 ,	1 ,	"");
	 SET idPERS = (SELECT idPersona FROM persona PER WHERE PER.DNI = DNI_IN);
	 INSERT INTO candidato(idPersona,PretencionSalaria,idCargoAOptar,MesesDeExperiencia,linkCurriculum,EtapaPrevia,EtapaDeLlamada,EtapaDeEntrevista,EtapaDeContratacion) VALUES (idPERS,SALARIO_IN,CARGO_IN,NMESES,LINK_CV_IN,0,0,0,0);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CrearCandidatoNuevo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CrearCandidatoNuevo`(IN NOMBRE_IN VARCHAR(45),IN APELLIDO_PATERNO_IN VARCHAR(45),IN APELLIDO_MATERNO_IN VARCHAR(45),IN DNI_IN VARCHAR(10),IN TELEFONO_IN VARCHAR(12),IN EMAIL_IN VARCHAR(100),IN SALARIO_IN FLOAT,IN CARGO_IN INT, IN NMESES INT , IN LINK_CV_IN VARCHAR(500))
BEGIN
	DECLARE idPERS INT;
	SET idPERS = (SELECT idPersona FROM persona PER WHERE PER.DNI = DNI_IN);
    IF idPERS > 0 THEN
		INSERT INTO candidato(idPersona,PretencionSalaria,idCargoAOptar,MesesDeExperiencia,linkCurriculum,EtapaPrevia,EtapaDeLlamada,EtapaDeEntrevista,EtapaDeContratacion) VALUES (idPERS,SALARIO_IN,CARGO_IN,NMESES,LINK_CV_IN,0,0,0,0);
	ELSE
		CALL CrearPersona(	NOMBRE_IN,    APELLIDO_PATERNO_IN,    APELLIDO_MATERNO_IN,	DNI_IN,	TELEFONO_IN,	"",	EMAIL_IN,	"",	"" ,	1 ,	1 ,	1 ,	"2000-01-01" ,	1 ,	"");
		SET idPERS = (SELECT idPersona FROM persona PER WHERE PER.DNI = DNI_IN);
		INSERT INTO candidato(idPersona,PretencionSalaria,idCargoAOptar,MesesDeExperiencia,linkCurriculum,EtapaPrevia,EtapaDeLlamada,EtapaDeEntrevista,EtapaDeContratacion) VALUES (idPERS,SALARIO_IN,CARGO_IN,NMESES,LINK_CV_IN,0,0,0,0);	 
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CrearContratoVigente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CrearContratoVigente`(IN DNI_IN VARCHAR(10), IN FINICIO_IN DATE,IN FECHAFIN_IN DATE, IN SUELDO_BASE_IN FLOAT,IN CISPP_IN VARCHAR(25),IN NHijos_IN INT )
BEGIN
	DECLARE IDEmpleado INT;
    DECLARE IDContrato INT;
    /*Handler para error SQL*/
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT 1 as error;
	ROLLBACK;
	END;

	/*Handler para error SQL*/
	DECLARE EXIT HANDLER FOR SQLWARNING
	BEGIN
		SELECT 1 as error;
	ROLLBACK;
	END;
	START TRANSACTION;
		SET IDEmpleado = (SELECT EMP.idEmpleado FROM empleado EMP INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN); 
		INSERT INTO contrato(idCondicionDeContrato,idEmpleado,FechaDeInicioDeContrato,FechaDeFinDeContrato) VALUES (1,IDEmpleado,FINICIO_IN,FECHAFIN_IN);
		SET IDContrato = (SELECT CT.idContrato FROM jpingenieria_jpnet2023.contrato CT INNER JOIN jpingenieria_jpnet2023.empleado EMP ON CT.idEmpleado = EMP.idEmpleado INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN AND CT.idCondicionDeContrato =1);
		INSERT INTO datoscontables(SueldoBase,CISPP,NHijos,idContrato) VALUES (SUELDO_BASE_IN,CISPP_IN,NHijos_IN,IDContrato);
		COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CrearDireccion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CrearDireccion`(IN idTipoDeVia_IN INT,IN NombreDeVia_IN VARCHAR(45),IN idTipoDeLocalidad_IN INT,IN NombreLocalidad_IN VARCHAR(45))
BEGIN
	 INSERT INTO direccion (idTipoDeVia,NombreDeVia,idTipoDeLocalidad,NombreLocalidad) VALUES (idTipoDeVia_IN ,NombreDeVia_IN, idTipoDeLocalidad_IN, NombreLocalidad_IN);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CrearEmpleado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CrearEmpleado`(IN NOMBRE_IN VARCHAR(45),IN APELLIDO_PATERNO_IN VARCHAR(45),IN APELLIDO_MATERNO_IN VARCHAR(45),IN DNI_IN VARCHAR(10),IN TELEFONO_IN VARCHAR(12),
IN TELEFONOFIJO_IN VARCHAR(10),IN EMAIL_IN VARCHAR(100),IN CONTACTODEEMERGENCIA_IN VARCHAR(100),IN NUMERODEEMERGENCIA_IN VARCHAR(12),IN ID_LOCALIDAD_NACIMIENTO_IN INT,
IN ID_LOCALIDAD_ACTUAL_IN INT,IN ID_DIRECCION_IN INT,IN FECHA_DE_NACIMIENTO_IN DATE,IN ID_TIPO_DE_SANGRE_IN INT,IN ALERGIAS_IN VARCHAR(100),IN ID_CARGO_IN INT, IN FONDO_PENSIONES_IN INT)
BEGIN
	DECLARE idPERS INT;
	SET idPERS = (SELECT idPersona FROM persona PER WHERE PER.DNI = DNI_IN);
    IF idPERS > 0 THEN
		CALL ActualizarEmpleado(NOMBRE_IN,    APELLIDO_PATERNO_IN,    APELLIDO_MATERNO_IN,	DNI_IN,	TELEFONO_IN,	TELEFONOFIJO_IN,	EMAIL_IN,	CONTACTODEEMERGENCIA_IN,	NUMERODEEMERGENCIA_IN ,	ID_LOCALIDAD_NACIMIENTO_IN ,	ID_LOCALIDAD_ACTUAL_IN ,	ID_DIRECCION_IN ,	FECHA_DE_NACIMIENTO_IN ,	ID_TIPO_DE_SANGRE_IN ,	ALERGIAS_IN);
		INSERT INTO empleado(idPersona,idCargo,idFondoDePension) VALUES (idPERS,ID_CARGO_IN,FONDO_PENSIONES_IN);
	ELSE
		CALL CrearPersona(NOMBRE_IN,    APELLIDO_PATERNO_IN,    APELLIDO_MATERNO_IN,	DNI_IN,	TELEFONO_IN,	TELEFONOFIJO_IN,	EMAIL_IN,	CONTACTODEEMERGENCIA_IN,	NUMERODEEMERGENCIA_IN ,	ID_LOCALIDAD_NACIMIENTO_IN ,	ID_LOCALIDAD_ACTUAL_IN ,	ID_DIRECCION_IN ,	FECHA_DE_NACIMIENTO_IN ,	ID_TIPO_DE_SANGRE_IN ,	ALERGIAS_IN);
		SET idPERS = (SELECT idPersona FROM persona PER WHERE PER.DNI = DNI_IN);
		INSERT INTO empleado(idPersona,idCargo,idFondoDePension) VALUES (idPERS,ID_CARGO_IN,FONDO_PENSIONES_IN);	 
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CrearPagoDelTareo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CrearPagoDelTareo`(IN IDTAREO_IN INT,  IN CANTIDAD_PAGO_IN FLOAT, IDPERIODO_IN INT)
BEGIN
    /*Handler para error SQL*/
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT 1 as error;
	ROLLBACK;
	END;

	/*Handler para error SQL*/
	DECLARE EXIT HANDLER FOR SQLWARNING
	BEGIN
		SELECT 1 as error;
	ROLLBACK;
	END;
	START TRANSACTION;
		INSERT INTO pagotareo(idTareo,CantidadDePago,idPeriodo) VALUES (IDTAREO_IN,CANTIDAD_PAGO_IN,IDPERIODO_IN);
		COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CrearPersona` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CrearPersona`(IN NOMBRE_IN VARCHAR(45),IN APELLIDO_PATERNO_IN VARCHAR(45),IN APELLIDO_MATERNO_IN VARCHAR(45),IN DNI_IN VARCHAR(10),IN TELEFONO_IN VARCHAR(12),
IN TELEFONOFIJO_IN VARCHAR(10),IN EMAIL_IN VARCHAR(100),IN CONTACTODEEMERGENCIA_IN VARCHAR(100),IN NUMERODEEMERGENCIA_IN VARCHAR(12),IN ID_LOCALIDAD_NACIMIENTO_IN INT,
IN ID_LOCALIDAD_ACTUAL_IN INT,IN ID_DIRECCION_IN INT,IN FECHA_DE_NACIMIENTO_IN DATE,IN ID_TIPO_DE_SANGRE_IN INT,IN ALERGIAS_IN VARCHAR(100)
)
BEGIN
INSERT INTO persona(
     Nombres,     ApellidoPaterno,     ApellidoMaterno,     DNI,     Telefono,     TelefonoFijo,     Email,     ContactoDeEmergencia,     NumeroDeEmergencia,     idLocalidadDeNacimiento,     idLocalidadActual,
     idDireccion,     FechaDeNacimiento,     idTipoDeSangre,     Alergias     ) VALUES (
	NOMBRE_IN,    APELLIDO_PATERNO_IN,    APELLIDO_MATERNO_IN,	DNI_IN,	TELEFONO_IN,	TELEFONOFIJO_IN,	EMAIL_IN,	CONTACTODEEMERGENCIA_IN,	NUMERODEEMERGENCIA_IN ,	ID_LOCALIDAD_NACIMIENTO_IN ,
	ID_LOCALIDAD_ACTUAL_IN ,	ID_DIRECCION_IN ,	FECHA_DE_NACIMIENTO_IN ,	ID_TIPO_DE_SANGRE_IN ,	ALERGIAS_IN);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CrearUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CrearUsuario`(IN Email_IN VARCHAR(100),IN PassWord_IN VARCHAR(100), IN PersonaID_IN INT)
BEGIN
	INSERT INTO login(email,password,PersonaId) values (Email_IN,PassWord_IN,PersonaID_IN);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EliminarCandidato` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarCandidato`(IN REG_IN INT)
BEGIN
	DELETE FROM jpingenieria_jpnet2023.candidato CN WHERE CN.idCandidato = REG_IN;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EliminarEmpleado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarEmpleado`(IN REG_IN INT)
BEGIN
	DELETE FROM jpingenieria_jpnet2023.empleado CN WHERE CN.idEmpleado = REG_IN;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EliminarHorasExtras` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarHorasExtras`(IN idHorasExtras_IN INT)
BEGIN
	DELETE FROM horasextras WHERE idHorasExtras = idHorasExtras_IN;
	UPDATE tareo TRA SET idHorasExtras = NULL WHERE idHorasExtras = idHorasExtras_IN;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerCandidato` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerCandidato`(IN idCandidato_IN INT)
BEGIN
	SELECT * FROM jpingenieria_jpnet2023.candidato CN INNER JOIN jpingenieria_jpnet2023.persona PO on CN.idPersona = PO.idPersona INNER JOIN jpingenieria_jpnet2023.cargo CAR ON CN.idCargoAOptar = CAR.idCargo WHERE CN.idCandidato = idCandidato_IN ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerCandidatos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerCandidatos`(IN REG_INICIO INT, IN CANTIDAD_IN INT)
BEGIN
	SELECT CN.idCandidato,PO.DNI,CN.idPersona,PO.Nombres, PO.ApellidoPaterno, PO.ApellidoMaterno, CAR.NombreCargo ,CN.PretencionSalaria,CN.EtapaPrevia,CN.EtapaDeLlamada,CN.EtapaDeEntrevista,CN.EtapaDeContratacion, CN.LinkCurriculum FROM jpingenieria_jpnet2023.candidato CN INNER JOIN jpingenieria_jpnet2023.persona PO on CN.idPersona = PO.idPersona INNER JOIN jpingenieria_jpnet2023.cargo CAR ON CN.idCargoAOptar = CAR.idCargo WHERE CN.idCandidato >= REG_INICIO LIMIT CANTIDAD_IN;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerCargos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerCargos`()
BEGIN
	SELECT * FROM jpingenieria_jpnet2023.cargo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerDatosPeriodo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerDatosPeriodo`()
BEGIN
	SELECT * FROM jpingenieria_jpnet2023.periodo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerDescansosMedicosPorDNI` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerDescansosMedicosPorDNI`( IN DNI_IN VARCHAR(10) ,IN FINICIO_IN DATE,IN FECHAFIN_IN DATE )
BEGIN
	DECLARE IDEmpleado INT;
    DECLARE IDContrato INT;
	SET IDEmpleado = (SELECT EMP.idEmpleado FROM empleado EMP INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN); 
	SET IDContrato = (SELECT CT.idContrato FROM jpingenieria_jpnet2023.contrato CT INNER JOIN jpingenieria_jpnet2023.empleado EMP ON CT.idEmpleado = EMP.idEmpleado INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN AND CT.idCondicionDeContrato =1);
	SELECT COUNT(TR.idTareo) AS CantidadDeLicenciasSinGoce  FROM tareo TR WHERE TR.idCondicionDeTareo = 4 AND TR.idContrato = IDContrato;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerDireccion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerDireccion`(IN idDireccion_IN INT)
BEGIN
	 SELECT * FROM jpingenieria_jpnet2023.direccion DI INNER JOIN jpingenieria_jpnet2023.tipodelocalidad TLO ON DI.idTipoDeLocalidad=TLO.idTipoDeLocalidad INNER JOIN jpingenieria_jpnet2023.tipodevia TLV ON DI.idTipoDeVia=TLV.idTipoDeVia WHERE DI.idDireccion = idDireccion_IN;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerEmpleado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerEmpleado`(IN DNI_IN VARCHAR(10))
BEGIN
	SELECT idEmpleado FROM jpingenieria_jpnet2023.empleado CN INNER JOIN  jpingenieria_jpnet2023.persona PO ON CN.idPersona = PO.idPersona WHERE PO.DNI = DNI_IN;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerEmpleados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerEmpleados`(IN REG_INICIO INT, IN CANTIDAD_IN INT)
BEGIN
	SELECT * FROM jpingenieria_jpnet2023.empleado CN INNER JOIN  jpingenieria_jpnet2023.persona PO ON CN.idPersona = PO.idPersona INNER JOIN jpingenieria_jpnet2023.cargo CG ON CG.idCargo = CN.idCargo INNER JOIN jpingenieria_jpnet2023.contrato CT ON CT.idEmpleado = CN.idEmpleado WHERE CN.idEmpleado >= REG_INICIO AND CT.idCondicionDeContrato = 1 LIMIT CANTIDAD_IN;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerEmpleadosParaPlanilla` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerEmpleadosParaPlanilla`(IN REG_INICIO INT, IN CANTIDAD_IN INT)
BEGIN
	SELECT * FROM jpingenieria_jpnet2023.empleado CN INNER JOIN  jpingenieria_jpnet2023.persona PO ON CN.idPersona = PO.idPersona INNER JOIN jpingenieria_jpnet2023.cargo CG ON CG.idCargo = CN.idCargo   INNER JOIN jpingenieria_jpnet2023.contrato CT ON CT.idEmpleado = CN.idEmpleado INNER JOIN jpingenieria_jpnet2023.datoscontables DC ON DC.idContrato = CT.idContrato WHERE CN.idEmpleado >= REG_INICIO AND CT.idCondicionDeContrato = 1 LIMIT CANTIDAD_IN;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerIdEmpleado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerIdEmpleado`(IN DNI_IN VARCHAR(10))
BEGIN
	SELECT * FROM jpingenieria_jpnet2023.empleado CN INNER JOIN  jpingenieria_jpnet2023.persona PO ON CN.idPersona = PO.idPersona WHERE PO.DNI = DNI_IN;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerIdPorUbigeo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerIdPorUbigeo`(IN Ubigeo_IN VARCHAR(6))
BEGIN
	SELECT idLocalidad FROM jpingenieria_jpnet2023.localidad LO WHERE LO.Ubigeo = Ubigeo_IN;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerLicenciasConGocePorDNI` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerLicenciasConGocePorDNI`( IN DNI_IN VARCHAR(10) ,IN FINICIO_IN DATE,IN FECHAFIN_IN DATE )
BEGIN
	DECLARE IDEmpleado INT;
    DECLARE IDContrato INT;
	SET IDEmpleado = (SELECT EMP.idEmpleado FROM empleado EMP INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN); 
	SET IDContrato = (SELECT CT.idContrato FROM jpingenieria_jpnet2023.contrato CT INNER JOIN jpingenieria_jpnet2023.empleado EMP ON CT.idEmpleado = EMP.idEmpleado INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN AND CT.idCondicionDeContrato =1);
	SELECT COUNT(TR.idTareo) AS CantidadDeLicenciasConGoce  FROM tareo TR WHERE TR.idCondicionDeTareo = 6 AND TR.idContrato = IDContrato;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerLicenciasSinGocePorDNI` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerLicenciasSinGocePorDNI`( IN DNI_IN VARCHAR(10) ,IN FINICIO_IN DATE,IN FECHAFIN_IN DATE )
BEGIN
	DECLARE IDEmpleado INT;
    DECLARE IDContrato INT;
	SET IDEmpleado = (SELECT EMP.idEmpleado FROM empleado EMP INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN); 
	SET IDContrato = (SELECT CT.idContrato FROM jpingenieria_jpnet2023.contrato CT INNER JOIN jpingenieria_jpnet2023.empleado EMP ON CT.idEmpleado = EMP.idEmpleado INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN AND CT.idCondicionDeContrato =1);
	SELECT COUNT(TR.idTareo) AS CantidadDeLicenciasSinGoce  FROM tareo TR WHERE TR.idCondicionDeTareo = 5 AND TR.idContrato = IDContrato;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerLocalidad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerLocalidad`(IN ubigeo_IN VARCHAR(6))
BEGIN
	 SELECT idLocalidad FROM localidad LC WHERE LC.Ubigeo = ubigeo_IN;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerPersona` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerPersona`(IN DNI_IN INT)
BEGIN
	 SELECT idPersona FROM persona PER WHERE PER.DNI = DNI_IN;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerPlanilla` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerPlanilla`(IN REG_INICIO INT, IN CANTIDAD_IN INT)
BEGIN
	SELECT * FROM jpingenieria_jpnet2023.empleado CN INNER JOIN  jpingenieria_jpnet2023.persona PO ON CN.idPersona = PO.idPersona  INNER JOIN jpingenieria_jpnet2023.contrato CT ON CT.idEmpleado = CN.idEmpleado WHERE CN.idEmpleado >= REG_INICIO AND CT.idCondicionDeContrato = 1 LIMIT CANTIDAD_IN;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerPlanillaEmpleados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerPlanillaEmpleados`( IN FINICIO_IN DATE,IN FECHAFIN_IN DATE )
BEGIN
	SELECT CT.idContrato,CT.FechaDeInicioDeContrato,CT.FechaDeFinDeContrato,CT.idEmpleado,PRS.Nombres,PRS.ApellidoPaterno,PRS.ApellidoMaterno,PRS.DNI FROM jpingenieria_jpnet2023.contrato CT INNER JOIN jpingenieria_jpnet2023.empleado EMP ON CT.idEmpleado = EMP.idEmpleado INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE CT.FechaDeInicioDeContrato >= FINICIO_IN AND FECHAFIN_IN <= CT.FechaDeFinDeContrato AND CT.idCondicionDeContrato =1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerTardanzasPorDNI` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerTardanzasPorDNI`( IN DNI_IN VARCHAR(10) ,IN FINICIO_IN DATE,IN FECHAFIN_IN DATE )
BEGIN
	DECLARE IDEmpleado INT;
    DECLARE IDContrato INT;
	SET IDEmpleado = (SELECT EMP.idEmpleado FROM empleado EMP INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN); 
	SET IDContrato = (SELECT CT.idContrato FROM jpingenieria_jpnet2023.contrato CT INNER JOIN jpingenieria_jpnet2023.empleado EMP ON CT.idEmpleado = EMP.idEmpleado INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN AND CT.idCondicionDeContrato =1);
	SELECT COUNT(TR.idTareo) AS Faltas  FROM tareo TR WHERE TR.idCondicionDeTareo = 3 AND TR.idContrato = IDContrato;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerTareos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerTareos`(IN DNI_IN VARCHAR(10), IN FINICIO_IN DATE,IN FECHAFIN_IN DATE )
BEGIN
	DECLARE IDEmpleado INT;
    DECLARE IDContrato INT;
	SET IDEmpleado = (SELECT EMP.idEmpleado FROM empleado EMP INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN); 
	SET IDContrato = (SELECT CT.idContrato FROM jpingenieria_jpnet2023.contrato CT INNER JOIN jpingenieria_jpnet2023.empleado EMP ON CT.idEmpleado = EMP.idEmpleado INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN AND CT.idCondicionDeContrato =1);
	SELECT *  FROM jpingenieria_jpnet2023.pagotareo PG INNER JOIN jpingenieria_jpnet2023.tareo TAR ON PG.idTareo = TAR.idTareo WHERE TAR.Fecha >= FINICIO_IN AND FECHAFIN_IN >= TAR.Fecha AND TAR.idContrato = IDContrato;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerUltimaDireccion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerUltimaDireccion`()
BEGIN
	SELECT * FROM jpingenieria_jpnet2023.direccion DI INNER JOIN jpingenieria_jpnet2023.tipodelocalidad TLO ON DI.idTipoDeLocalidad=TLO.idTipoDeLocalidad INNER JOIN jpingenieria_jpnet2023.tipodevia TLV ON DI.idTipoDeVia=TLV.idTipoDeVia  ORDER BY idDireccion DESC LIMIT 1 ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerUsuario`(IN Email_IN VARCHAR(100))
BEGIN
	 SELECT * FROM login WHERE Email = Email_IN;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerUsuarios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerUsuarios`()
BEGIN
	SELECT * FROM jpingenieria_jpnet2023.login;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerVacaciones` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerVacaciones`( IN DNI_IN VARCHAR(10) ,IN FINICIO_IN DATE,IN FECHAFIN_IN DATE )
BEGIN
	DECLARE IDEmpleado INT;
    DECLARE IDContrato INT;
	SET IDEmpleado = (SELECT EMP.idEmpleado FROM empleado EMP INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN); 
	SET IDContrato = (SELECT CT.idContrato FROM jpingenieria_jpnet2023.contrato CT INNER JOIN jpingenieria_jpnet2023.empleado EMP ON CT.idEmpleado = EMP.idEmpleado INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN AND CT.idCondicionDeContrato =1);
	SELECT COUNT(TR.idTareo) AS DiasDeVacaciones  FROM tareo TR WHERE TR.idCondicionDeTareo = 9 AND TR.idContrato = IDContrato;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RegistrarBonos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarBonos`(IN PagoHorasExtras_IN FLOAT,IN Reintegro_IN FLOAT,IN BonoDeclarado_IN FLOAT,IN BonoProduce_IN FLOAT,IN BonoNoche_IN FLOAT,IN BonoRotacion FLOAT, IN BonoAsignacionFamiliar FLOAT)
BEGIN
	DECLARE ID_HoraExtra INT; 
    /*Handler para error SQL*/
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT 1 as error;
	ROLLBACK;
	END;
	/*Handler para error SQL*/
	DECLARE EXIT HANDLER FOR SQLWARNING
	BEGIN
		SELECT 1 as error;
	ROLLBACK;
	END;
    
	START TRANSACTION;
		INSERT INTO jpingenieria_jpnet2023.bonos(PagoHorasExtras,Reintegro, BonoDeclarado, BonoProduce, BonoConductor, BonoRotacion, BonoAsignacionFamiliar) VALUES (PagoHorasExtras_IN,Reintegro_IN,BonoDeclarado_IN,BonoProduce_IN,BonoNoche_IN,BonoRotacion,BonoAsignacionFamiliar);
        COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RegistrarDescansoMedico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarDescansoMedico`(IN Link_IN TEXT , IN idEmpleado_IN INT,IN Day_INICIO_IN DATE,IN Day_FIN_IN DATE)
BEGIN
	DECLARE ID_DescansoMedico INT; 
	DECLARE ID_Contrato INT; 
    /*Handler para error SQL*/
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT 1 as error;
	ROLLBACK;
	END;
	/*Handler para error SQL*/
	DECLARE EXIT HANDLER FOR SQLWARNING
	BEGIN
		SELECT 1 as error;
	ROLLBACK;
	END;
    
	START TRANSACTION;
		SET ID_Contrato = (SELECT idContrato FROM contrato  WHERE idEmpleado = idEmpleado_IN AND idCondicionDeContrato = 1);
        INSERT INTO jpingenieria_jpnet2023.descansomedico(LinkDocumento,FechaDeInicioDescansoMedico,FechaDeFinDescansoMedico) VALUES(Link_IN,Day_INICIO_IN,Day_FIN_IN);
		SET ID_DescansoMedico = (SELECT idDescansoMedico FROM descansomedico ORDER BY idDescansoMedico DESC LIMIT 1);
		UPDATE tareo TRA SET TRA.idDescansoMedico = ID_DescansoMedico, TRA.idCondicionDeTareo = 4 WHERE TRA.idContrato = ID_Contrato AND TRA.Fecha >=  Day_INICIO_IN AND TRA.Fecha <=  Day_FIN_IN ;
		COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RegistrarHorasExtra` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarHorasExtra`(IN Link_IN TEXT , IN idEmpleado_IN INT,IN Day_IN DATE, IN ValorDe25_IN FLOAT, IN ValorDe35_IN FLOAT)
BEGIN
	DECLARE ID_HoraExtra INT; 
	DECLARE ID_Contrato INT; 
    DECLARE ID_Tareo INT;
    /*Handler para error SQL*/
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT 1 as error;
	ROLLBACK;
	END;
	/*Handler para error SQL*/
	DECLARE EXIT HANDLER FOR SQLWARNING
	BEGIN
		SELECT 1 as error;
	ROLLBACK;
	END;
    
	START TRANSACTION;
		SET ID_Contrato = (SELECT idContrato FROM contrato  WHERE idEmpleado = idEmpleado_IN AND idCondicionDeContrato = 1);
		SET ID_Tareo = (SELECT TRA.idTareo  FROM tareo TRA WHERE TRA.idContrato = ID_Contrato AND TRA.Fecha =  Day_IN);
        INSERT INTO jpingenieria_jpnet2023.horasextras(LinkDocumento,ValorDe25,ValorDe35) VALUES(Link_IN,ValorDe25_IN,ValorDe35_IN);
		SET ID_HoraExtra = (SELECT idHorasExtras FROM horasextras ORDER BY HoraDeRegistro DESC LIMIT 1);
		UPDATE tareo TRA SET TRA.idHorasExtras = ID_HoraExtra WHERE idTareo = ID_Tareo;
		COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RegistrarLicenciasConGoceDeHaber` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarLicenciasConGoceDeHaber`(
IN FechaDeInicioConGoceDeHaber_IN DATE,
IN FechasDeFinConGoceDeHaber_IN DATE,
IN LinkDelDocumento_IN TEXT,
IN idEmpleado_IN INT)
BEGIN
	DECLARE ID_Contrato INT;
    DECLARE ID_LICENCIACON INT;
    /*Handler para error SQL*/
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT 1 as error;
	ROLLBACK;
	END;
	/*Handler para error SQL*/
	DECLARE EXIT HANDLER FOR SQLWARNING
	BEGIN
		SELECT 1 as error;
	ROLLBACK;
	END;
    
	START TRANSACTION;
		SET ID_Contrato = (SELECT idContrato FROM contrato  WHERE idEmpleado = idEmpleado_IN AND idCondicionDeContrato = 1);
		INSERT INTO jpingenieria_jpnet2023.licenciacongocedehaber(FechaDeInicioConGoceDeHaber,   FechaDeFinSinGoceDeHaber, LinkDelDocumento ) 
        VALUES (FechaDeInicioConGoceDeHaber_IN,        FechasDeFinConGoceDeHaber_IN,        LinkDelDocumento_IN);
		SET ID_LICENCIACON = (SELECT idLicenciaConGoceDeHaber FROM licenciacongocedehaber ORDER BY idLicenciaConGoceDeHaber DESC LIMIT 1);
		UPDATE tareo TRA SET TRA.idCondicionDeTareo = 6,TRA.idLicenciaConGoceDeHaber = ID_LICENCIACON WHERE  TRA.Fecha >=  FechaDeInicioConGoceDeHaber_IN AND TRA.Fecha <=  FechasDeFinConGoceDeHaber_IN AND TRA.idContrato = ID_Contrato;
		COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RegistrarLicenciasSinGoceDeHaber` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarLicenciasSinGoceDeHaber`(
IN FechaDeInicioSinGoceDeHaber_IN DATE,
IN FechasDeFinSinGoceDeHaber_IN DATE,
IN LinkDelDocumento_IN TEXT,
IN idEmpleado_IN INT)
BEGIN
	DECLARE ID_Contrato INT;
    DECLARE ID_LICENCIACON INT;
    /*Handler para error SQL*/
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT 1 as error;
	ROLLBACK;
	END;
	/*Handler para error SQL*/
	DECLARE EXIT HANDLER FOR SQLWARNING
	BEGIN
		SELECT 1 as error;
	ROLLBACK;
	END;
    
	START TRANSACTION;
		SET ID_Contrato = (SELECT idContrato FROM contrato  WHERE idEmpleado = idEmpleado_IN AND idCondicionDeContrato = 1);
		INSERT INTO jpingenieria_jpnet2023.licenciasingocedehaber(FechaDeInicioSinGoceDeHaber,   FechaDeFinSinGoceDeHaber, LinkDelDocumento ) 
        VALUES (FechaDeInicioSinGoceDeHaber_IN,        FechasDeFinSinGoceDeHaber_IN,        LinkDelDocumento_IN);
		SET ID_LICENCIACON = (SELECT idLicenciaSinGoceDeHaber FROM licenciasingocedehaber ORDER BY idLicenciaSinGoceDeHaber DESC LIMIT 1);
		UPDATE tareo TRA SET TRA.idCondicionDeTareo = 5,TRA.idLicenciaSinGoceDeHaber = ID_LICENCIACON WHERE  TRA.Fecha >=  FechaDeInicioSinGoceDeHaber_IN AND TRA.Fecha <=  FechasDeFinSinGoceDeHaber_IN AND TRA.idContrato = ID_Contrato;
		COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RegistrarVacaciones` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarVacaciones`(
IN FechaDeInicioDeVacaciones_IN DATE,
IN FechaDeFinDeVacaciones_IN DATE,
IN LinkDelDocumento_IN TEXT,
IN idEmpleado_IN INT)
BEGIN
	DECLARE ID_Contrato INT;
    DECLARE ID_VACACIONES INT;
    DECLARE ID_DIAS INT;
    DECLARE ID_DIAS_ITER INT;
    DECLARE FECHA_ITERADA DATE;
    /*Handler para error SQL*/
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT 1 as error;
	ROLLBACK;
	END;
	/*Handler para error SQL*/
	DECLARE EXIT HANDLER FOR SQLWARNING
	BEGIN
		SELECT 1 as error;
	ROLLBACK;
	END;
    
	START TRANSACTION;
		SET ID_Contrato = (SELECT idContrato FROM contrato  WHERE idEmpleado = idEmpleado_IN AND idCondicionDeContrato = 1);
		INSERT INTO jpingenieria_jpnet2023.vacaciones(FechaDeInicioVacaciones,   FechaDeFinVacaciones, LinkDeDocumento ) 
        VALUES (FechaDeInicioDeVacaciones_IN,        FechaDeFinDeVacaciones_IN,        LinkDelDocumento_IN);
		SET ID_VACACIONES = (SELECT idVacaciones FROM vacaciones ORDER BY idVacaciones DESC LIMIT 1);
        SET ID_DIAS = (SELECT DATEDIFF (FechaDeFinDeVacaciones_IN,FechaDeInicioDeVacaciones_IN));
		SET ID_DIAS_ITER = 0;
        loop_label: LOOP
			IF ID_DIAS_ITER >= ID_DIAS THEN
				LEAVE loop_label;
			END IF;
			SET FECHA_ITERADA = DATE_ADD(FechaDeInicioDeVacaciones_IN, INTERVAL ID_DIAS_ITER DAY);
            INSERT INTO tareo(idContrato,Fecha,HoraDeIngreso , HoraDeInicioDeAlmuerzo , HoraDeFinDeAlmuerzo , HoraDeSalida, idCondicionDeTareo, idEstacionDeTrabajo, idVacaciones)
            VALUES (ID_Contrato,FECHA_ITERADA,"0:00","00:00","00:00","00:00",9,11,ID_VACACIONES);
			SET ID_DIAS_ITER = ID_DIAS_ITER + 1;
			ITERATE loop_label;
		END LOOP;
        COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `VerHorasExtras` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `VerHorasExtras`(IN FECHA_IN DATE, IN FechaFIN DATE, IN idEmpleado_IN INT)
BEGIN
	DECLARE ID_Contrato INT;
    SET ID_Contrato = (SELECT idContrato FROM contrato  WHERE idEmpleado = idEmpleado_IN AND idCondicionDeContrato = 1);
	SELECT TRE.Fecha, TIMESTAMPDIFF(minute,HoraDeIngreso,HoraDeSalida) AS TiempoTotal ,
					  TIMESTAMPDIFF(minute,HoraDeInicioDeAlmuerzo,HoraDeFinDeAlmuerzo) AS TiempoDeAlmuerzo ,
					  (TIMESTAMPDIFF(minute,HoraDeIngreso,HoraDeSalida)-TIMESTAMPDIFF(minute,HoraDeInicioDeAlmuerzo,HoraDeFinDeAlmuerzo)) AS TiempoNeto,
					  (TIMESTAMPDIFF(minute,HoraDeIngreso,HoraDeSalida)-TIMESTAMPDIFF(minute,HoraDeInicioDeAlmuerzo,HoraDeFinDeAlmuerzo))-510 AS TiempoExtra
	FROM tareo TRE 
	WHERE idContrato = ID_Contrato 
	AND TRE.Fecha >= FECHA_IN 
	AND FechaFIN  > TRE.Fecha 
	AND TIMESTAMPDIFF(minute,HoraDeIngreso,HoraDeSalida)>0 
	ORDER BY TRE.Fecha;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `VerTareadoHistoricoTrabajadorActivo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `VerTareadoHistoricoTrabajadorActivo`(IN FECHA_IN DATE, IN FechaFIN DATE, IN idEmpleado_IN INT)
BEGIN
	DECLARE ID_Contrato INT;
    SET ID_Contrato = (SELECT idContrato FROM contrato  WHERE idEmpleado = idEmpleado_IN AND idCondicionDeContrato = 1);
	SELECT idTareo ,date_format(Fecha, "%d-%m-%Y") as Fecha,HoraDeIngreso, HoraDeInicioDeAlmuerzo, HoraDeFinDeAlmuerzo, HoraDeSalida FROM tareo TRE WHERE TRE.Fecha >= FECHA_IN AND FechaFIN >= TRE.Fecha;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `VerTareadoHistoricoTrabajadorActivo2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `VerTareadoHistoricoTrabajadorActivo2`(IN FECHA_IN DATE, IN FechaFIN DATE, IN idEmpleado_IN INT)
BEGIN
	DECLARE ID_Contrato INT;
    SET ID_Contrato = (SELECT idContrato FROM contrato  WHERE idEmpleado = idEmpleado_IN AND idCondicionDeContrato = 1);
	SELECT  TRE.Fecha,(TIMESTAMPDIFF(MINUTE,TRE.HoraDeIngreso,TRE.HoraDeSalida)-TIMESTAMPDIFF(MINUTE,TRE.HoraDeInicioDeAlmuerzo,TRE.HoraDeFinDeAlmuerzo)) FROM tareo TRE WHERE TRE.Fecha >= FECHA_IN AND FechaFIN >= TRE.Fecha;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `VerTareadoHistoricoTrabajadorCalculadoEnMinutos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `VerTareadoHistoricoTrabajadorCalculadoEnMinutos`(IN FECHA_IN DATE, IN FechaFIN DATE, IN idEmpleado_IN INT)
BEGIN
	DECLARE ID_Contrato INT;
    SET ID_Contrato = (SELECT idContrato FROM contrato  WHERE idEmpleado = idEmpleado_IN AND idCondicionDeContrato = 1);
	SELECT TRE.idTareo ,TRE.Fecha, idContrato,TIMESTAMPDIFF(MINUTE,TRE.HoraDeIngreso,TRE.HoraDeSalida)-TIMESTAMPDIFF(MINUTE,TRE.HoraDeInicioDeAlmuerzo,TRE.HoraDeFinDeAlmuerzo) AS "TiempoCalculado" FROM tareo TRE WHERE TRE.Fecha >= FECHA_IN AND FechaFIN >= TRE.Fecha AND TRE.idContrato = ID_Contrato;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `VerTareadoHistoricoTrabajadorCesado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `VerTareadoHistoricoTrabajadorCesado`(IN FECHA_IN DATE, IN FechaFIN DATE, IN idEmpleado_IN INT)
BEGIN
	DECLARE ID_Contrato INT;
    SET ID_Contrato = (SELECT idContrato FROM contrato  WHERE idEmpleado = idEmpleado_IN AND idCondicionDeContrato > 1);
	SELECT * FROM tareo TRE WHERE TRE.idContrato = ID_Contrato AND TRE.Fecha >= FECHA_IN AND FechaFIN >= TRE.Fecha ORDER BY TRE.Fecha ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `VerTiempoExtra` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `VerTiempoExtra`(IN FECHA_IN DATE, IN FechaFIN DATE, IN idEmpleado_IN INT)
BEGIN
	DECLARE ID_Contrato INT;
    SET ID_Contrato = (SELECT idContrato FROM contrato  WHERE idEmpleado = idEmpleado_IN AND idCondicionDeContrato = 1);
	SELECT TRE.Fecha, TIMESTAMPDIFF(minute,HoraDeIngreso,HoraDeSalida) AS TiempoTotal ,
					  TIMESTAMPDIFF(minute,HoraDeInicioDeAlmuerzo,HoraDeFinDeAlmuerzo) AS TiempoDeAlmuerzo ,
					  (TIMESTAMPDIFF(minute,HoraDeIngreso,HoraDeSalida)-TIMESTAMPDIFF(minute,HoraDeInicioDeAlmuerzo,HoraDeFinDeAlmuerzo)) AS TiempoNeto,
					  (TIMESTAMPDIFF(minute,HoraDeIngreso,HoraDeSalida)-TIMESTAMPDIFF(minute,HoraDeInicioDeAlmuerzo,HoraDeFinDeAlmuerzo))-510 AS TiempoExtra
	FROM tareo TRE 
	WHERE idContrato = ID_Contrato 
	AND TRE.Fecha >= FECHA_IN 
	AND FechaFIN  > TRE.Fecha 
	AND TIMESTAMPDIFF(minute,HoraDeIngreso,HoraDeSalida)>0 
	ORDER BY TRE.Fecha;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-10 15:55:02
