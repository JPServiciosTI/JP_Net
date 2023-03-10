USE jpingenieria_awlnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS RegistrarLicenciasConGoceDeHaber//
CREATE PROCEDURE RegistrarLicenciasConGoceDeHaber(
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
		INSERT INTO jpingenieria_awlnet2023.licenciacongocedehaber(FechaDeInicioConGoceDeHaber,   FechaDeFinSinGoceDeHaber, LinkDelDocumento ) 
        VALUES (FechaDeInicioConGoceDeHaber_IN,        FechasDeFinConGoceDeHaber_IN,        LinkDelDocumento_IN);
		SET ID_LICENCIACON = (SELECT idLicenciaConGoceDeHaber FROM licenciacongocedehaber ORDER BY idLicenciaConGoceDeHaber DESC LIMIT 1);
		UPDATE tareo TRA SET TRA.idCondicionDeTareo = 6,TRA.idLicenciaConGoceDeHaber = ID_LICENCIACON WHERE  TRA.Fecha >=  FechaDeInicioConGoceDeHaber_IN AND TRA.Fecha <=  FechasDeFinConGoceDeHaber_IN AND TRA.idContrato = ID_Contrato;
		COMMIT;
END//
DELIMITER ;
#CALL RegistrarLicenciasConGoceDeHaber('2023-01-19','2023-01-23',"fghjsdfghjksdfghjksdftyuwertyuio34567890l",21);

CALL ObtenerTareos("71234180",'2023-01-16','2023-02-15');



USE jpingenieria_awlnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerLicenciasConGocePorDNI//
CREATE PROCEDURE ObtenerLicenciasConGocePorDNI( IN DNI_IN VARCHAR(10) ,IN FINICIO_IN DATE,IN FECHAFIN_IN DATE )
BEGIN
	DECLARE IDEmpleado INT;
    DECLARE IDContrato INT;
	SET IDEmpleado = (SELECT EMP.idEmpleado FROM empleado EMP INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN); 
	SET IDContrato = (SELECT CT.idContrato FROM jpingenieria_awlnet2023.contrato CT INNER JOIN jpingenieria_awlnet2023.empleado EMP ON CT.idEmpleado = EMP.idEmpleado INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN AND CT.idCondicionDeContrato =1);
	SELECT COUNT(TR.idTareo) AS CantidadDeLicenciasConGoce  FROM tareo TR WHERE TR.idCondicionDeTareo = 6 AND TR.idContrato = IDContrato;
END//
DELIMITER ;
CALL ObtenerLicenciasConGocePorDNI("71234180",'2023-01-16','2023-02-15');
