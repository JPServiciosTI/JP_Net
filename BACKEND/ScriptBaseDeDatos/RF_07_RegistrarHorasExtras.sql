USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS VerTiempoExtra;
CREATE PROCEDURE VerTiempoExtra(IN FECHA_IN DATE, IN FechaFIN DATE, IN idEmpleado_IN INT)
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
CREATE PROCEDURE RegistrarHorasExtra(IN Link_IN TEXT , IN idEmpleado_IN INT,IN Day_IN DATE, IN ValorDe25_IN FLOAT, IN ValorDe35_IN FLOAT)
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
        INSERT INTO jpnet.horasextras(LinkDocumento,ValorDe25,ValorDe35) VALUES(Link_IN,ValorDe25_IN,ValorDe35_IN);
		SET ID_HoraExtra = (SELECT idHorasExtras FROM horasextras ORDER BY HoraDeRegistro DESC LIMIT 1);
		UPDATE tareo TRA SET TRA.idHorasExtras = ID_HoraExtra WHERE idTareo = ID_Tareo;
		COMMIT;

END//
DELIMITER ;

#CALL RegistrarHorasExtra("qertyuio" , 21 ,"2023-01-24",2,2);

#CALL RegistrarHorasExtra(11,'2023-01-23',2,1,'asdfghjkl');


USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS EliminarHorasExtras;
CREATE PROCEDURE EliminarHorasExtras(IN idHorasExtras_IN INT)
BEGIN
	DELETE FROM horasextras WHERE idHorasExtras = idHorasExtras_IN;
	UPDATE tareo TRA SET idHorasExtras = NULL WHERE idHorasExtras = idHorasExtras_IN;
END//
 DELIMITER ;



