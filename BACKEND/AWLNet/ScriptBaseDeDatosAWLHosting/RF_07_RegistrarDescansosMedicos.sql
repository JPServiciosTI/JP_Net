USE jpingenieria_awlnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS RegistrarDescansoMedico//
CREATE PROCEDURE RegistrarDescansoMedico(IN Link_IN TEXT , IN idEmpleado_IN INT,IN Day_INICIO_IN DATE,IN Day_FIN_IN DATE)
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
        INSERT INTO jpingenieria_awlnet2023.descansomedico(LinkDocumento,FechaDeInicioDescansoMedico,FechaDeFinDescansoMedico) VALUES(Link_IN,Day_INICIO_IN,Day_FIN_IN);
		SET ID_DescansoMedico = (SELECT idDescansoMedico FROM descansomedico ORDER BY idDescansoMedico DESC LIMIT 1);
		UPDATE tareo TRA SET TRA.idDescansoMedico = ID_DescansoMedico, TRA.idCondicionDeTareo = 4 WHERE TRA.idContrato = ID_Contrato AND TRA.Fecha >=  Day_INICIO_IN AND TRA.Fecha <=  Day_FIN_IN ;
		COMMIT;
END//
DELIMITER ;
CALL RegistrarDescansoMedico("fghjkl",21,'2023-01-16','2023-01-18');

SELECT idContrato FROM contrato  WHERE idEmpleado = 21 AND idCondicionDeContrato = 1;
SELECT TRA.idTareo  FROM tareo TRA WHERE TRA.idContrato = 21 AND TRA.Fecha =  '2023-02-08';

USE jpingenieria_awlnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerDescansosMedicosPorDNI//
CREATE PROCEDURE ObtenerDescansosMedicosPorDNI( IN DNI_IN VARCHAR(10) ,IN FINICIO_IN DATE,IN FECHAFIN_IN DATE )
BEGIN
	DECLARE IDEmpleado INT;
    DECLARE IDContrato INT;
	SET IDEmpleado = (SELECT EMP.idEmpleado FROM empleado EMP INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN); 
	SET IDContrato = (SELECT CT.idContrato FROM jpingenieria_awlnet2023.contrato CT INNER JOIN jpingenieria_awlnet2023.empleado EMP ON CT.idEmpleado = EMP.idEmpleado INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN AND CT.idCondicionDeContrato =1);
	SELECT COUNT(TR.idTareo) AS CantidadDeLicenciasSinGoce  FROM tareo TR WHERE TR.idCondicionDeTareo = 4 AND TR.idContrato = IDContrato;
END//
DELIMITER ;
CALL ObtenerDescansosMedicosPorDNI("71234180",'2023-01-16','2023-02-15');

CALL ObtenerTareos("71234180",'2023-01-16','2023-02-15');

