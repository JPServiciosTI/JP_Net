USE jpingenieria_jpnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS VerTareadoHistoricoTrabajadorActivo;
CREATE PROCEDURE VerTareadoHistoricoTrabajadorActivo(IN FECHA_IN DATE, IN FechaFIN DATE, IN idEmpleado_IN INT)
BEGIN
	DECLARE ID_Contrato INT;
    SET ID_Contrato = (SELECT idContrato FROM contrato  WHERE idEmpleado = idEmpleado_IN AND idCondicionDeContrato = 1);
	SELECT idTareo ,date_format(Fecha, "%d-%m-%Y") as Fecha,HoraDeIngreso, HoraDeInicioDeAlmuerzo, HoraDeFinDeAlmuerzo, HoraDeSalida FROM tareo TRE WHERE TRE.Fecha >= FECHA_IN AND FechaFIN >= TRE.Fecha;
END//
DELIMITER ;
CALL VerTareadoHistoricoTrabajadorActivo('2023-01-16','2023-02-15',1);

USE jpingenieria_jpnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS VerTareadoHistoricoTrabajadorCesado;
CREATE PROCEDURE VerTareadoHistoricoTrabajadorCesado(IN FECHA_IN DATE, IN FechaFIN DATE, IN idEmpleado_IN INT)
BEGIN
	DECLARE ID_Contrato INT;
    SET ID_Contrato = (SELECT idContrato FROM contrato  WHERE idEmpleado = idEmpleado_IN AND idCondicionDeContrato > 1);
	SELECT * FROM tareo TRE WHERE TRE.idContrato = ID_Contrato AND TRE.Fecha >= FECHA_IN AND FechaFIN >= TRE.Fecha ORDER BY TRE.Fecha ASC;
END//
DELIMITER ; 
CALL VerTareadoHistoricoTrabajadorCesado('2023-01-16','2023-02-15',1);
UPDATE tareo SET HoraDeIngreso='7:30:00', HoraDeInicioDeAlmuerzo='13:06:00',HoraDeFinDEAlmuerzo='13:36:00',HoraDeSalida='16:36:00',idEstacionDeTrabajo=1 WHERE idTareo=2;



USE jpingenieria_jpnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS VerTareadoHistoricoTrabajadorCalculadoEnMinutos;
CREATE PROCEDURE VerTareadoHistoricoTrabajadorCalculadoEnMinutos(IN FECHA_IN DATE, IN FechaFIN DATE, IN idEmpleado_IN INT)
BEGIN
	DECLARE ID_Contrato INT;
    SET ID_Contrato = (SELECT idContrato FROM contrato  WHERE idEmpleado = idEmpleado_IN AND idCondicionDeContrato = 1);
	SELECT TRE.idTareo ,TRE.Fecha, idContrato,TIMESTAMPDIFF(MINUTE,TRE.HoraDeIngreso,TRE.HoraDeSalida)-TIMESTAMPDIFF(MINUTE,TRE.HoraDeInicioDeAlmuerzo,TRE.HoraDeFinDeAlmuerzo) AS "TiempoCalculado" FROM tareo TRE WHERE TRE.Fecha >= FECHA_IN AND FechaFIN >= TRE.Fecha AND TRE.idContrato = ID_Contrato;
END//
DELIMITER ;

CALL VerTareadoHistoricoTrabajadorCalculadoEnMinutos('2023-01-16','2023-02-15',1);