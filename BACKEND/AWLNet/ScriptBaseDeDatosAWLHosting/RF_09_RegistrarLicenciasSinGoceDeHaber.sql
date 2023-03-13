USE jpingenieria_awlnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS RegistrarLicenciasSinGoceDeHaber//
CREATE PROCEDURE RegistrarLicenciasSinGoceDeHaber(
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
		INSERT INTO jpingenieria_awlnet2023.licenciasingocedehaber(FechaDeInicioSinGoceDeHaber,   FechaDeFinSinGoceDeHaber, LinkDelDocumento ) 
        VALUES (FechaDeInicioSinGoceDeHaber_IN,        FechasDeFinSinGoceDeHaber_IN,        LinkDelDocumento_IN);
		SET ID_LICENCIACON = (SELECT idLicenciaSinGoceDeHaber FROM licenciasingocedehaber ORDER BY idLicenciaSinGoceDeHaber DESC LIMIT 1);
		UPDATE tareo TRA SET TRA.idCondicionDeTareo = 5,TRA.idLicenciaSinGoceDeHaber = ID_LICENCIACON WHERE  TRA.Fecha >=  FechaDeInicioSinGoceDeHaber_IN AND TRA.Fecha <=  FechasDeFinSinGoceDeHaber_IN AND TRA.idContrato = ID_Contrato;
		COMMIT;
END//
DELIMITER ;

CALL RegistrarLicenciasSinGoceDeHaber('2023-01-24','2023-01-27',"fghjsdfghjksdfghjksdftyuwertyuio34567890l",21);


USE jpingenieria_awlnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerLicenciasSinGocePorDNI//
CREATE PROCEDURE ObtenerLicenciasSinGocePorDNI( IN DNI_IN VARCHAR(10) ,IN FINICIO_IN DATE,IN FECHAFIN_IN DATE )
BEGIN
	DECLARE IDEmpleado INT;
    DECLARE IDContrato INT;
	SET IDEmpleado = (SELECT EMP.idEmpleado FROM empleado EMP INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN); 
	SET IDContrato = (SELECT CT.idContrato FROM jpingenieria_awlnet2023.contrato CT INNER JOIN jpingenieria_awlnet2023.empleado EMP ON CT.idEmpleado = EMP.idEmpleado INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN AND CT.idCondicionDeContrato =1);
	SELECT COUNT(TR.idTareo) AS CantidadDeLicenciasSinGoce  FROM tareo TR WHERE TR.idCondicionDeTareo = 5 AND TR.idContrato = IDContrato;
END//
DELIMITER ;
CALL ObtenerLicenciasSinGocePorDNI("71234180",'2023-01-16','2023-02-15');




