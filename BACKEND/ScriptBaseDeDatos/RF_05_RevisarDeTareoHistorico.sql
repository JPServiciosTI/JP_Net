USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS VerTareadoHistoricoTrabajadorActivo;
CREATE PROCEDURE VerTareadoHistoricoTrabajadorActivo(IN FECHA_IN DATE, IN FechaFIN DATE, IN idEmpleado_IN INT)
BEGIN
	DECLARE ID_Contrato INT;
    SET ID_Contrato = (SELECT idContrato FROM contrato  WHERE idEmpleado = idEmpleado_IN AND idCondicionDeContrato = 1);
	SELECT * FROM tareo TRE WHERE TRE.Fecha >= FECHA_IN AND FechaFIN >= TRE.Fecha;
END//
 DELIMITER ;
 CALL VerTareadoHistoricoTrabajadorActivo('2023-01-16','2023-02-15',1);
 
 
USE jpnet;
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
 