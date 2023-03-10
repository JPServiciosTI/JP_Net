USE jpingenieria_awlnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS RegistrarLicenciasSinGoceDeHaber//
CREATE PROCEDURE RegistrarLicenciasSinGoceDeHaber(
IN FechaDeInicioSinGoceDeHaber_IN DATE,
IN FechasDeFinSinGoceDeHaber_IN DATE,
IN DiasHabilesAConsiderar_IN INT,
IN LinkDelDocumento_IN TEXT,
IN idEmpleado INT)
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
		INSERT INTO jpnet.licenciasingocedehaber(FechaDeInicioSinGoceDeHaber,
        FechasDeFinSinGoceDeHaber,
        DiasHabilesAConsiderar,
        LinkDelDocumento
        ) 
        VALUES (FechaDeInicioSinGoceDeHaber_IN,
        FechasDeFinSinGoceDeHaber_IN,
        DiasHabilesAConsiderar_IN,
        LinkDelDocumento_IN);
		SET ID_LICENCIACON = (SELECT idLicenciaSinGoceDeHaber FROM licenciasingocedehaber ORDER BY idLicenciaSinGoceDeHaber DESC LIMIT 1);
        UPDATE tareo TRA SET idCondicionDeTareo = 5, idLicenciaSinGoceDeHaber = ID_LICENCIACON  WHERE FechaDeInicioSinGoceDeHaber_IN  < TRA.Fecha AND TRA.Fecha > FechasDeFinSinGoceDeHaber_IN AND TRA.idContrato = ID_Contrato;
		COMMIT;

END//
DELIMITER ;




