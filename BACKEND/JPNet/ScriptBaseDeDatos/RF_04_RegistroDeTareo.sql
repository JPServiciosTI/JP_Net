USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS AgregarTareadoComun;
CREATE PROCEDURE AgregarTareadoComun(IN FECHA_IN DATE,IN HoraDeIngreso_IN TIME,IN HoraInicioAlmuerzo_IN TIME,IN HoraFinAlmuerzo_IN TIME,IN HoraSalida_IN TIME, IN idEmpleado_IN INT, IN EstacionDeTrabajo_IN INT)
BEGIN
	DECLARE ID_Contrato INT;
	SET ID_Contrato = (SELECT idContrato FROM contrato  WHERE idEmpleado = idEmpleado_IN AND idCondicionDeContrato = 1);
	INSERT INTO tareo(idContrato,Fecha,HoraDeIngreso, HoraDeInicioDeAlmuerzo,HoraDeFinDEAlmuerzo,HoraDeSalida,idEstacionDeTrabajo)
    VALUES(ID_Contrato,FECHA_IN,HoraDeIngreso_IN,HoraInicioAlmuerzo_IN,HoraFinAlmuerzo_IN,HoraSalida_IN,EstacionDeTrabajo_IN);
END//
 DELIMITER ;
 
USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS AgregarTareadoMina;
CREATE PROCEDURE AgregarTareadoMina(IN FECHA_IN DATE, IN ID_Operacion INT, IN idEmpleado_IN INT, IN CondicionDeTareo_IN INT)
BEGIN
	DECLARE ID_Contrato INT;
    SET ID_Contrato = (SELECT idContrato FROM contrato  WHERE idEmpleado = idEmpleado_IN AND idCondicionDeContrato = 1);
	
	INSERT INTO tareo(idContrato,Fecha,HoraDeIngreso, HoraDeInicioDeAlmuerzo,HoraDeFinDEAlmuerzo,HoraDeSalida,idCondicionDeTareo,idEstacionDeTrabajo)
    VALUES(ID_Contrato,FECHA_IN,'07:00:00','13:00:00','13:30:00','19:00:00',CondicionDeTareo_IN,ID_Operacion);
    
END//
 DELIMITER ;
 
