DROP TABLE IF EXISTS `Persona`;
		
CREATE TABLE `Persona` (
  `idPersona` INTEGER  AUTO_INCREMENT ,
  `Nombres` VARCHAR(255) ,
  `ApellidoMaterno` VARCHAR(255) ,
  `ApellidoMaterno` VARCHAR(255) ,
  `DNI` VARCHAR(255)(8) ,
  `Telefono` VARCHAR(255) ,
  `TelefonoFijo` VARCHAR(255) ,
  `Email` VARCHAR(255) ,
  `ContactoDeEmergencia` VARCHAR(255) ,
  `Numero de Emergencia` VARCHAR(255) ,
  `idLocalidadDeNacimiento` INTEGER ,
  `idLocalidadActual` INTEGER ,
  `idDireccion` INTEGER ,
  `FechaDeNacimiento` DATE ,
  `idTipoDeSangre` INTEGER ,
  `Alergias` INTEGER ,
  PRIMARY KEY (`idPersona`)
);

-- ---
-- Table 'Cargo'
-- 
-- ---

DROP TABLE IF EXISTS `Cargo`;
		
CREATE TABLE `Cargo` (
  `idCargo` INTEGER  AUTO_INCREMENT ,
  `NombreCargo` VARCHAR(255) ,
  PRIMARY KEY (`idCargo`)
);

-- ---
-- Table 'CondicionDeContrato'
-- 
-- ---

DROP TABLE IF EXISTS `CondicionDeContrato`;
		
CREATE TABLE `CondicionDeContrato` (
  `idCondicionDeContrato` INTEGER  AUTO_INCREMENT ,
  `NombreCondicionDeContrato` VARCHAR(255) ,
  PRIMARY KEY (`idCondicionDeContrato`)
);

-- ---
-- Table 'EstacionDeTrabajo'
-- 
-- ---

DROP TABLE IF EXISTS `EstacionDeTrabajo`;
		
CREATE TABLE `EstacionDeTrabajo` (
  `idEstacionDeTrabajo` INTEGER  AUTO_INCREMENT ,
  `NombreEstacionDeTrabajo` VARCHAR(255) ,
  PRIMARY KEY (`idEstacionDeTrabajo`)
);

-- ---
-- Table 'Tareo'
-- 
-- ---

DROP TABLE IF EXISTS `Tareo`;
		
CREATE TABLE `Tareo` (
  `idTareo` INTEGER  AUTO_INCREMENT ,
  `HoraDeIngreso` INTEGER ,
  `Fecha` INTEGER ,
  `idCondicionDeTareo` INTEGER ,
  `idEstacionDeTrabajo` INTEGER ,
  `idLicenciaConGoceDeHAber` INTEGER ,
  `idLicenciaSinGoceDeHaber` INTEGER ,
  `idDescansoMedico` INTEGER ,
  `idContrato` INTEGER ,
  `HoraDeSalida` INTEGER ,
  `HoraDeInicioDeAlmuerzo` INTEGER ,
  `HoraDeFinDeAlmuerzo` INTEGER ,
  PRIMARY KEY (`idTareo`)
);

-- ---
-- Table 'CondicionDeTareo'
-- 
-- ---

DROP TABLE IF EXISTS `CondicionDeTareo`;
		
CREATE TABLE `CondicionDeTareo` (
  `idCondicionDeTareo` INTEGER  AUTO_INCREMENT ,
  `NombreCondicionDeTareo` VARCHAR(255) ,
  PRIMARY KEY (`idCondicionDeTareo`)
);

-- ---
-- Table 'Empleado'
-- 
-- ---

DROP TABLE IF EXISTS `Empleado`;
		
CREATE TABLE `Empleado` (
  `idEmpleado` INTEGER  AUTO_INCREMENT ,
  `idPersona` INTEGER ,
  `idCargo` INTEGER ,
  `idFondoDePension` INTEGER ,
  `idDatosProfesionales` INTEGER ,
  PRIMARY KEY (`idEmpleado`)
);

-- ---
-- Table 'Contrato'
-- 
-- ---

DROP TABLE IF EXISTS `Contrato`;
		
CREATE TABLE `Contrato` (
  `idContrato` INTEGER  AUTO_INCREMENT ,
  `idCondicionDeContrato` INTEGER ,
  `idEmpleado` INTEGER ,
  `FechaDeInicioDeContrato` INTEGER ,
  `FechaDeFinDeContrato` INTEGER ,
  PRIMARY KEY (`idContrato`)
);

-- ---
-- Table 'DatosContables'
-- 
-- ---

DROP TABLE IF EXISTS `DatosContables`;
		
CREATE TABLE `DatosContables` (
  `idDatosContables` INTEGER  AUTO_INCREMENT ,
  `SueldoBase` INTEGER ,
  `HoraHombre` INTEGER ,
  `CISPP` INTEGER ,
  `idFondoDePension` INTEGER ,
  `N°DeHijos` INTEGER ,
  `idContrato` INTEGER ,
  `idFondoDePension` INTEGER ,
  PRIMARY KEY (`idDatosContables`)
);

-- ---
-- Table 'FondoDePension'
-- 
-- ---

DROP TABLE IF EXISTS `FondoDePension`;
		
CREATE TABLE `FondoDePension` (
  `idFondoDePension` INTEGER  AUTO_INCREMENT ,
  `NombreEntidad` INTEGER ,
  `TipoDeFondo` INTEGER ,
  `TipoDeEmpresa` INTEGER ,
  `PorcentajeDeDescuento` INTEGER ,
  PRIMARY KEY (`idFondoDePension`)
);

-- ---
-- Table 'Planilla'
-- 
-- ---

DROP TABLE IF EXISTS `Planilla`;
		
CREATE TABLE `Planilla` (
  `idPlanilla` INTEGER  AUTO_INCREMENT ,
  `idPeriodo` INTEGER ,
  `idDatosContables` INTEGER ,
  `idBonos` INTEGER ,
  `idDescuentos` INTEGER ,
  `TotalNetoAPagar` INTEGER ,
  `PagoEsSalud` INTEGER ,
  PRIMARY KEY (`idPlanilla`)
);

-- ---
-- Table 'Descuentos'
-- 
-- ---

DROP TABLE IF EXISTS `Descuentos`;
		
CREATE TABLE `Descuentos` (
  `idDescuento` INTEGER  AUTO_INCREMENT ,
  `ImpuestoDeQuinta` INTEGER ,
  `Tardanzas` INTEGER ,
  `Faltas` INTEGER ,
  `DescuentoFondoDePension` INTEGER ,
  `idAdelandoOCreditos` INTEGER ,
  PRIMARY KEY (`idDescuento`)
);

-- ---
-- Table 'idBonos'
-- 
-- ---

DROP TABLE IF EXISTS `idBonos`;
		
CREATE TABLE `idBonos` (
  `idBonos` INTEGER  AUTO_INCREMENT ,
  `PagoHorasExtras` INTEGER ,
  `Reintegro` INTEGER ,
  `BonoDeclarado` INTEGER ,
  `BonoProduce` INTEGER ,
  `BonoNoche` INTEGER ,
  `BonoConductor` INTEGER ,
  `BonoRotacion` INTEGER ,
  `BonoAsignacionFamiliar` INTEGER ,
  `idGratificacion` INTEGER ,
  PRIMARY KEY (`idBonos`)
);

-- ---
-- Table 'Localidad'
-- 
-- ---

DROP TABLE IF EXISTS `Localidad`;
		
CREATE TABLE `Localidad` (
  `idLocalidad` INTEGER  AUTO_INCREMENT ,
  `Ubigeo` INTEGER ,
  `Departamento` INTEGER ,
  `Provincia` INTEGER ,
  `Distrito` INTEGER ,
  PRIMARY KEY (`idLocalidad`)
);

-- ---
-- Table 'Direccion'
-- 
-- ---

DROP TABLE IF EXISTS `Direccion`;
		
CREATE TABLE `Direccion` (
  `idDireccion` INTEGER  AUTO_INCREMENT ,
  `idTipoDeVia` INTEGER ,
  `NombreVia` VARCHAR(255) ,
  `idTipoDeLocalidad` INTEGER ,
  `NombreLocalidad` VARCHAR(255) ,
  PRIMARY KEY (`idDireccion`)
);

-- ---
-- Table 'TipoDeVia'
-- 
-- ---

DROP TABLE IF EXISTS `TipoDeVia`;
		
CREATE TABLE `TipoDeVia` (
  `idTipoDeVia` INTEGER  AUTO_INCREMENT ,
  `NombreDeVia` VARCHAR(255) ,
  PRIMARY KEY (`idTipoDeVia`)
);

-- ---
-- Table 'TipoDeLocalidad'
-- 
-- ---

DROP TABLE IF EXISTS `TipoDeLocalidad`;
		
CREATE TABLE `TipoDeLocalidad` (
  `idTipoDeLocalidad` INTEGER  AUTO_INCREMENT ,
  `NombreTipoDeLocalidad` VARCHAR(255) ,
  PRIMARY KEY (`idTipoDeLocalidad`)
);

-- ---
-- Table 'DatosProfesionales'
-- 
-- ---

DROP TABLE IF EXISTS `DatosProfesionales`;
		
CREATE TABLE `DatosProfesionales` (
  `idDatosProfesionales` INTEGER  AUTO_INCREMENT ,
  `Profesion` INTEGER ,
  `idCampoDeEstudio` INTEGER ,
  `MesesDeExperiencia` INTEGER ,
  `idCategoriaDeBrevete` INTEGER ,
  PRIMARY KEY (`idDatosProfesionales`)
);

-- ---
-- Table 'CampoDeEstudio'
-- 
-- ---

DROP TABLE IF EXISTS `CampoDeEstudio`;
		
CREATE TABLE `CampoDeEstudio` (
  `idCampoDeEstudio` INTEGER  AUTO_INCREMENT ,
  `NombreCategoriaDeBrevete` VARCHAR(255) ,
  PRIMARY KEY (`idCampoDeEstudio`)
);

-- ---
-- Table 'CategoriaDeBrevete'
-- 
-- ---

DROP TABLE IF EXISTS `CategoriaDeBrevete`;
		
CREATE TABLE `CategoriaDeBrevete` (
  `idCategoriaDeBrevete` INTEGER  AUTO_INCREMENT ,
  `NombreCategoriaDeBrevete` VARCHAR(255) ,
  PRIMARY KEY (`idCategoriaDeBrevete`)
);

-- ---
-- Table 'TipoDeSangre'
-- 
-- ---

DROP TABLE IF EXISTS `TipoDeSangre`;
		
CREATE TABLE `TipoDeSangre` (
  `idTipoDeSangre` INTEGER  AUTO_INCREMENT ,
  `new field` INTEGER ,
  `NombreTipoDeSangre` VARCHAR(255) ,
  PRIMARY KEY (`idTipoDeSangre`)
);

-- ---
-- Table 'Candidato'
-- 
-- ---

DROP TABLE IF EXISTS `Candidato`;
		
CREATE TABLE `Candidato` (
  `idCandidato` INTEGER  AUTO_INCREMENT ,
  `idPersona` INTEGER ,
  `PretencionSalarial` INTEGER ,
  `idCargoAOptar` INTEGER ,
  `MesesDeExperienciaPrevia` INTEGER ,
  `EtapaPrevia` INTEGER ,
  `LinkCurriculum` INTEGER ,
  `EtapaDeLlamada` INTEGER ,
  `EtapaDeEntrevista` INTEGER ,
  `EtapaDeContratacion` INTEGER ,
  PRIMARY KEY (`idCandidato`)
);

-- ---
-- Table 'LicenciaConGoceDeHaber'
-- 
-- ---

DROP TABLE IF EXISTS `LicenciaConGoceDeHaber`;
		
CREATE TABLE `LicenciaConGoceDeHaber` (
  `idLicenciaConGoceDeHaber` INTEGER  AUTO_INCREMENT ,
  `FechaDeInicioLicenciaConGoceDeHaber` INTEGER ,
  `FechaDeFinLicenciaConGoceDeHaber` INTEGER ,
  `DiasHabiles` INTEGER ,
  `LinkDelDocumento` INTEGER ,
  PRIMARY KEY (`idLicenciaConGoceDeHaber`)
);

-- ---
-- Table 'LicenciaSinGoceDeHaber'
-- 
-- ---

DROP TABLE IF EXISTS `LicenciaSinGoceDeHaber`;
		
CREATE TABLE `LicenciaSinGoceDeHaber` (
  `idLicenciaSinGoceDeHaber` INTEGER  AUTO_INCREMENT ,
  `FechaDeInicioLicenciaSinGoceDeHaber` INTEGER ,
  `FechaFinLicenciaSinGoceDeHaber` INTEGER ,
  `DiasHabilesAConsiderar` INTEGER ,
  `LinkDelDocumento` INTEGER ,
  PRIMARY KEY (`idLicenciaSinGoceDeHaber`)
);

-- ---
-- Table 'DescansoMedico'
-- 
-- ---

DROP TABLE IF EXISTS `DescansoMedico`;
		
CREATE TABLE `DescansoMedico` (
  `idDescansoMedico` INTEGER  AUTO_INCREMENT ,
  `FechaDeInicioDescansoMedico` INTEGER ,
  `FechaDeFinDescansoMedico` INTEGER ,
  `DiasHabilesAConsiderar` INTEGER ,
  PRIMARY KEY (`idDescansoMedico`)
);

-- ---
-- Table 'AdelantoOCreditos'
-- 
-- ---

DROP TABLE IF EXISTS `AdelantoOCreditos`;
		
CREATE TABLE `AdelantoOCreditos` (
  `idAdelantoOCreditos` INTEGER  AUTO_INCREMENT ,
  `CreditoHastaElMomento` INTEGER ,
  `MontoAAdelantoOCreditos` INTEGER ,
  `FechaDeSolicitud` INTEGER ,
  `FechaDePago` INTEGER ,
  PRIMARY KEY (`idAdelantoOCreditos`)
);

-- ---
-- Table 'Periodo'
-- 
-- ---

DROP TABLE IF EXISTS `Periodo`;
		
CREATE TABLE `Periodo` (
  `idPeriodo` INTEGER  AUTO_INCREMENT ,
  `NombrePeriodo` INTEGER ,
  `DiaDeInicioDelPeriodo` INTEGER ,
  `DiaDeFinDelPeriodo` INTEGER ,
  `CantidadDeDias` INTEGER ,
  PRIMARY KEY (`idPeriodo`)
);

-- ---
-- Table 'PagoTareo'
-- 
-- ---

DROP TABLE IF EXISTS `PagoTareo`;
		
CREATE TABLE `PagoTareo` (
  `idPagoTareo` INTEGER  AUTO_INCREMENT ,
  `idTareo` INTEGER ,
  `CantidadDePago` INTEGER ,
  `idPeriodo` INTEGER ,
  PRIMARY KEY (`idPagoTareo`)
);

-- ---
-- Table 'Liquidacion'
-- 
-- ---

DROP TABLE IF EXISTS `Liquidacion`;
		
CREATE TABLE `Liquidacion` (
  `idLiquidacion` INTEGER  AUTO_INCREMENT ,
  `idContrato` INTEGER ,
  `FechaDeInicio` INTEGER ,
  `FechaDeFin` INTEGER ,
  `MontoEstimado` INTEGER ,
  `BeneficiosNoPagados` INTEGER ,
  PRIMARY KEY (`idLiquidacion`)
);

-- ---
-- Table 'Gratificacion'
-- 
-- ---

DROP TABLE IF EXISTS `Gratificacion`;
		
CREATE TABLE `Gratificacion` (
  `idGratificacion` INTEGER  AUTO_INCREMENT ,
  `MesesConsiderados` INTEGER ,
  `SueldoConsiderado` INTEGER ,
  `TotalAConsiderar` INTEGER ,
  PRIMARY KEY (`idGratificacion`)
);

-- ---
-- Table 'SeguroComplementarioDeTrabajoDeRiesgo'
-- 
-- ---

DROP TABLE IF EXISTS `SeguroComplementarioDeTrabajoDeRiesgo`;
		
CREATE TABLE `SeguroComplementarioDeTrabajoDeRiesgo` (
  `idSeguroComplementarioDeTrabajoDeRiesgo` INTEGER  AUTO_INCREMENT ,
  `idEmpleado` INTEGER ,
  `idProyecto` INTEGER ,
  `FechaDeEmision` INTEGER ,
  `FechaDeFinalizacion` INTEGER ,
  PRIMARY KEY (`idSeguroComplementarioDeTrabajoDeRiesgo`)
);

-- ---
-- Table 'Proyecto'
-- 
-- ---

DROP TABLE IF EXISTS `Proyecto`;
		
CREATE TABLE `Proyecto` (
  `idProyecto` INTEGER  AUTO_INCREMENT ,
  `NombreProyecto` INTEGER ,
  `new field` INTEGER ,
  PRIMARY KEY (`idProyecto`)
);

-- ---
-- Table 'ExamenesMedicos'
-- 
-- ---

DROP TABLE IF EXISTS `ExamenesMedicos`;
		
CREATE TABLE `ExamenesMedicos` (
  `idExamenesMedicos` INTEGER  AUTO_INCREMENT ,
  `idTipoDeExamenMedico` INTEGER ,
  `FechaDeInicioVigencia` INTEGER ,
  `FechaDeFinVigencia` INTEGER ,
  `idEmpleado` INTEGER ,
  PRIMARY KEY (`idExamenesMedicos`)
);

-- ---
-- Table 'TipoDeExamenMedico'
-- 
-- ---

DROP TABLE IF EXISTS `TipoDeExamenMedico`;
		
CREATE TABLE `TipoDeExamenMedico` (
  `idTipoDeExamenMedico` INTEGER  AUTO_INCREMENT ,
  `NombreTipoDeExamenMedico` INTEGER ,
  PRIMARY KEY (`idTipoDeExamenMedico`)
);

-- ---
-- Table 'ProcedimientoDeHabilitacion'
-- 
-- ---

DROP TABLE IF EXISTS `ProcedimientoDeHabilitacion`;
		
CREATE TABLE `ProcedimientoDeHabilitacion` (
  `idProcedimientoDeHabilitacion` INTEGER  AUTO_INCREMENT ,
  `idProyecto` INTEGER ,
  `Nombre` INTEGER ,
  `idEtapaDeProcedimientoDeHabiliatación` VARCHAR(255) ,
  PRIMARY KEY (`idProcedimientoDeHabilitacion`)
);

-- ---
-- Table 'EtapaDeProcedimientoDeHabiliatación'
-- 
-- ---

DROP TABLE IF EXISTS `EtapaDeProcedimientoDeHabiliatación`;
		
CREATE TABLE `EtapaDeProcedimientoDeHabiliatación` (
  `idEtapaDeProcedimientoDeHabiliatación` INTEGER  AUTO_INCREMENT ,
  `NombreEtapaDeProcedimientoDeHabiliatación` VARCHAR(255) ,
  PRIMARY KEY (`idEtapaDeProcedimientoDeHabiliatación`)
);

-- ---
-- Table 'RegistroDeHabilitacion'
-- 
-- ---

DROP TABLE IF EXISTS `RegistroDeHabilitacion`;
		
CREATE TABLE `RegistroDeHabilitacion` (
  `idRegistroDeHabilitacion` INTEGER  AUTO_INCREMENT ,
  `idEmpleado` INTEGER ,
  `idEstadoDeHabilitacion` INTEGER ,
  `idProcedimientoDeHabilitacion` INTEGER ,
  PRIMARY KEY (`idRegistroDeHabilitacion`)
);

-- ---
-- Table 'EstadoDeHabilitacion'
-- 
-- ---

DROP TABLE IF EXISTS `EstadoDeHabilitacion`;
		
CREATE TABLE `EstadoDeHabilitacion` (
  `idEstadoDeHabilitacion` INTEGER  AUTO_INCREMENT ,
  `NombreEstadoDeHabilitacion` VARCHAR(255) ,
  PRIMARY KEY (`idEstadoDeHabilitacion`)
);

-- ---
-- Table 'CursosParaHabilitacion'
-- 
-- ---

DROP TABLE IF EXISTS `CursosParaHabilitacion`;
		
CREATE TABLE `CursosParaHabilitacion` (
  `idCursosParaHabilitacion` INTEGER  AUTO_INCREMENT ,
  `idProcedimientoDeHabilitacion` INTEGER ,
  `idCursoDeHabilitacion` INTEGER ,
  `idEstadoDeCurso` INTEGER ,
  `FechaDeInicioDeCertificacion` INTEGER ,
  `FechaDeFinDeCertificacion` INTEGER ,
  PRIMARY KEY (`idCursosParaHabilitacion`)
);

-- ---
-- Table 'CursoDeHabilitacion'
-- 
-- ---

DROP TABLE IF EXISTS `CursoDeHabilitacion`;
		
CREATE TABLE `CursoDeHabilitacion` (
  `idCursoDeHabilitacion` INTEGER  AUTO_INCREMENT ,
  `NombreCursoDeHabilitacion` INTEGER ,
  `LinkDePlataforma` INTEGER ,
  `idProyecto` INTEGER ,
  PRIMARY KEY (`idCursoDeHabilitacion`)
);

-- ---
-- Table 'EstadoDelCurso'
-- 
-- ---

DROP TABLE IF EXISTS `EstadoDelCurso`;
		
CREATE TABLE `EstadoDelCurso` (
  `idEstadoDelCurso` INTEGER  AUTO_INCREMENT ,
  `NombreEstadoDelCurso` INTEGER ,
  PRIMARY KEY (`idEstadoDelCurso`)
);

-- ---
-- Table 'AsignacionDePersonal'
-- 
-- ---

DROP TABLE IF EXISTS `AsignacionDePersonal`;
		
CREATE TABLE `AsignacionDePersonal` (
  `idRegistroDeHabilitacion` INTEGER  AUTO_INCREMENT ,
  `FechaDeInicioDeAsignación` INTEGER ,
  `FechaDeFinDeAsignacion` INTEGER ,
  PRIMARY KEY (`idRegistroDeHabilitacion`)
);

-- ---
-- Table 'Login'
-- 
-- ---

DROP TABLE IF EXISTS `Login`;
		
CREATE TABLE `Login` (
  `idLogin` INTEGER  AUTO_INCREMENT ,
  `User` INTEGER ,
  `Password` INTEGER ,
  `idEmpleado` INTEGER ,
  PRIMARY KEY (`idLogin`)
);

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE `Persona` ADD FOREIGN KEY (idLocalidadDeNacimiento) REFERENCES `Localidad` (`idLocalidad`);
ALTER TABLE `Persona` ADD FOREIGN KEY (idLocalidadActual) REFERENCES `Localidad` (`idLocalidad`);
ALTER TABLE `Persona` ADD FOREIGN KEY (idDireccion) REFERENCES `Direccion` (`idDireccion`);
ALTER TABLE `Persona` ADD FOREIGN KEY (idTipoDeSangre) REFERENCES `TipoDeSangre` (`idTipoDeSangre`);
ALTER TABLE `Tareo` ADD FOREIGN KEY (idCondicionDeTareo) REFERENCES `EstacionDeTrabajo` (`idEstacionDeTrabajo`);
ALTER TABLE `Tareo` ADD FOREIGN KEY (idEstacionDeTrabajo) REFERENCES `CondicionDeTareo` (`idCondicionDeTareo`);
ALTER TABLE `Tareo` ADD FOREIGN KEY (idLicenciaConGoceDeHAber) REFERENCES `LicenciaConGoceDeHaber` (`idLicenciaConGoceDeHaber`);
ALTER TABLE `Tareo` ADD FOREIGN KEY (idLicenciaSinGoceDeHaber) REFERENCES `LicenciaSinGoceDeHaber` (`idLicenciaSinGoceDeHaber`);
ALTER TABLE `Tareo` ADD FOREIGN KEY (idDescansoMedico) REFERENCES `DescansoMedico` (`idDescansoMedico`);
ALTER TABLE `Tareo` ADD FOREIGN KEY (idContrato) REFERENCES `Contrato` (`idContrato`);
ALTER TABLE `Empleado` ADD FOREIGN KEY (idPersona) REFERENCES `Persona` (`idPersona`);
ALTER TABLE `Empleado` ADD FOREIGN KEY (idCargo) REFERENCES `Cargo` (`idCargo`);
ALTER TABLE `Empleado` ADD FOREIGN KEY (idFondoDePension) REFERENCES `FondoDePension` (`idFondoDePension`);
ALTER TABLE `Empleado` ADD FOREIGN KEY (idDatosProfesionales) REFERENCES `DatosProfesionales` (`idDatosProfesionales`);
ALTER TABLE `Contrato` ADD FOREIGN KEY (idCondicionDeContrato) REFERENCES `CondicionDeContrato` (`idCondicionDeContrato`);
ALTER TABLE `Contrato` ADD FOREIGN KEY (idEmpleado) REFERENCES `Empleado` (`idEmpleado`);
ALTER TABLE `DatosContables` ADD FOREIGN KEY (idContrato) REFERENCES `Contrato` (`idContrato`);
ALTER TABLE `Planilla` ADD FOREIGN KEY (idPeriodo) REFERENCES `Periodo` (`idPeriodo`);
ALTER TABLE `Planilla` ADD FOREIGN KEY (idDatosContables) REFERENCES `DatosContables` (`idDatosContables`);
ALTER TABLE `Planilla` ADD FOREIGN KEY (idBonos) REFERENCES `idBonos` (`idBonos`);
ALTER TABLE `Planilla` ADD FOREIGN KEY (idDescuentos) REFERENCES `Descuentos` (`idDescuento`);
ALTER TABLE `Descuentos` ADD FOREIGN KEY (idAdelandoOCreditos) REFERENCES `AdelantoOCreditos` (`idAdelantoOCreditos`);
ALTER TABLE `idBonos` ADD FOREIGN KEY (idGratificacion) REFERENCES `Gratificacion` (`idGratificacion`);
ALTER TABLE `Direccion` ADD FOREIGN KEY (idTipoDeVia) REFERENCES `TipoDeVia` (`idTipoDeVia`);
ALTER TABLE `Direccion` ADD FOREIGN KEY (idTipoDeLocalidad) REFERENCES `TipoDeLocalidad` (`idTipoDeLocalidad`);
ALTER TABLE `DatosProfesionales` ADD FOREIGN KEY (idCampoDeEstudio) REFERENCES `CampoDeEstudio` (`idCampoDeEstudio`);
ALTER TABLE `DatosProfesionales` ADD FOREIGN KEY (idCategoriaDeBrevete) REFERENCES `CategoriaDeBrevete` (`idCategoriaDeBrevete`);
ALTER TABLE `Candidato` ADD FOREIGN KEY (idPersona) REFERENCES `Persona` (`idPersona`);
ALTER TABLE `Candidato` ADD FOREIGN KEY (idCargoAOptar) REFERENCES `Cargo` (`idCargo`);
ALTER TABLE `PagoTareo` ADD FOREIGN KEY (idTareo) REFERENCES `Tareo` (`idTareo`);
ALTER TABLE `PagoTareo` ADD FOREIGN KEY (idPeriodo) REFERENCES `Periodo` (`idPeriodo`);
ALTER TABLE `Liquidacion` ADD FOREIGN KEY (idContrato) REFERENCES `Contrato` (`idContrato`);
ALTER TABLE `SeguroComplementarioDeTrabajoDeRiesgo` ADD FOREIGN KEY (idEmpleado) REFERENCES `Empleado` (`idEmpleado`);
ALTER TABLE `SeguroComplementarioDeTrabajoDeRiesgo` ADD FOREIGN KEY (idProyecto) REFERENCES `Proyecto` (`idProyecto`);
ALTER TABLE `ExamenesMedicos` ADD FOREIGN KEY (idTipoDeExamenMedico) REFERENCES `TipoDeExamenMedico` (`idTipoDeExamenMedico`);
ALTER TABLE `ExamenesMedicos` ADD FOREIGN KEY (idEmpleado) REFERENCES `Empleado` (`idEmpleado`);
ALTER TABLE `ProcedimientoDeHabilitacion` ADD FOREIGN KEY (idProyecto) REFERENCES `Proyecto` (`idProyecto`);
ALTER TABLE `ProcedimientoDeHabilitacion` ADD FOREIGN KEY (idEtapaDeProcedimientoDeHabiliatación) REFERENCES `EtapaDeProcedimientoDeHabiliatación` (`idEtapaDeProcedimientoDeHabiliatación`);
ALTER TABLE `RegistroDeHabilitacion` ADD FOREIGN KEY (idEmpleado) REFERENCES `Empleado` (`idEmpleado`);
ALTER TABLE `RegistroDeHabilitacion` ADD FOREIGN KEY (idEstadoDeHabilitacion) REFERENCES `EstadoDeHabilitacion` (`idEstadoDeHabilitacion`);
ALTER TABLE `RegistroDeHabilitacion` ADD FOREIGN KEY (idProcedimientoDeHabilitacion) REFERENCES `ProcedimientoDeHabilitacion` (`idProcedimientoDeHabilitacion`);
ALTER TABLE `CursosParaHabilitacion` ADD FOREIGN KEY (idProcedimientoDeHabilitacion) REFERENCES `ProcedimientoDeHabilitacion` (`idProcedimientoDeHabilitacion`);
ALTER TABLE `CursosParaHabilitacion` ADD FOREIGN KEY (idCursoDeHabilitacion) REFERENCES `CursoDeHabilitacion` (`idCursoDeHabilitacion`);
ALTER TABLE `CursosParaHabilitacion` ADD FOREIGN KEY (idEstadoDeCurso) REFERENCES `EstadoDelCurso` (`idEstadoDelCurso`);
ALTER TABLE `CursoDeHabilitacion` ADD FOREIGN KEY (idProyecto) REFERENCES `Proyecto` (`idProyecto`);
ALTER TABLE `AsignacionDePersonal` ADD FOREIGN KEY (idRegistroDeHabilitacion) REFERENCES `RegistroDeHabilitacion` (`idRegistroDeHabilitacion`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `Persona` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Cargo` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `CondicionDeContrato` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `EstacionDeTrabajo` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Tareo` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `CondicionDeTareo` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Empleado` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Contrato` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `DatosContables` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `FondoDePension` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Planilla` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Descuentos` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `idBonos` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Localidad` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Direccion` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `TipoDeVia` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `TipoDeLocalidad` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `DatosProfesionales` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `CampoDeEstudio` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `CategoriaDeBrevete` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `TipoDeSangre` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Candidato` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `LicenciaConGoceDeHaber` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `LicenciaSinGoceDeHaber` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `DescansoMedico` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `AdelantoOCreditos` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Periodo` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `PagoTareo` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Liquidacion` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Gratificacion` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `SeguroComplementarioDeTrabajoDeRiesgo` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Proyecto` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `ExamenesMedicos` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `TipoDeExamenMedico` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `ProcedimientoDeHabilitacion` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `EtapaDeProcedimientoDeHabiliatación` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `RegistroDeHabilitacion` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `EstadoDeHabilitacion` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `CursosParaHabilitacion` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `CursoDeHabilitacion` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `EstadoDelCurso` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `AsignacionDePersonal` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Login` ENGINE=InnoD CHARSET=utf8 COLLATE=utf8_bin;