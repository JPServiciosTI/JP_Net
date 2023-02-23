USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS VerHorasExtras;
CREATE PROCEDURE VerHorasExtras(IN FECHA_IN DATE, IN FechaFIN DATE, IN idEmpleado_IN INT)
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
END//
 DELIMITER ;
 
 CALL VerHorasExtras('2023-01-16','2023-02-15',1);
 
SELECT idHorasExtras FROM horasextras ORDER BY HoraDeRegistro ASC LIMIT 1;
   
USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS RegistrarHorasExtra;
CREATE PROCEDURE RegistrarHorasExtra(IN Link_IN TEXT , IN idTareo_IN INT)
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
		INSERT INTO jpnet.horasextras(LinkDocumento) VALUES(Link_IN);
		SET ID_HoraExtra = (SELECT idHorasExtras FROM horasextras ORDER BY HoraDeRegistro ASC LIMIT 1);
		UPDATE tareo TRA SET idHorasExtras = ID_HoraExtra WHERE idTareo = idTareo_IN;
		COMMIT;

END//
DELIMITER ;


USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS EliminarHorasExtras;
CREATE PROCEDURE EliminarHorasExtras(IN idHorasExtras_IN INT)
BEGIN
	DELETE FROM horasextras WHERE idHorasExtras = idHorasExtras_IN;
	UPDATE tareo TRA SET idHorasExtras = NULL WHERE idHorasExtras = idHorasExtras_IN;
END//
 DELIMITER ;



