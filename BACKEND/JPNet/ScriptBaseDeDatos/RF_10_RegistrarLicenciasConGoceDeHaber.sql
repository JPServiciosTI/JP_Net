USE jpingenieria_jpnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS RegistrarLicenciasConGoceDeHaber;
CREATE PROCEDURE RegistrarLicenciasConGoceDeHaber(
IN FechaDeInicioConGoceDeHaber_IN DATE,
IN FechasDeFinConGoceDeHaber_IN DATE,
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
		INSERT INTO licenciacongocedehaber(FechaDeInicioConGoceDeHaber,
        FechaDeFinConGoceDeHaber,
        LinkDelDocumento
        ) 
        VALUES (FechaDeInicioConGoceDeHaber_IN,
        FechasDeFinConGoceDeHaber_IN,
        LinkDelDocumento_IN);
		SET ID_LICENCIACON = (SELECT idLicenciaConGoceDeHaber FROM licenciacongocedehaber ORDER BY idLicenciaConGoceDeHaber DESC LIMIT 1);
		UPDATE tareo TRA SET idCondicionDeTareo = 6,idLicenciaConGoceDeHaber = ID_LICENCIACON WHERE FechaDeInicioConGoceDeHaber_IN  < TRA.Fecha AND TRA.Fecha > FechasDeFinConGoceDeHaber_IN AND TRA.idContrato = ID_Contrato;
		COMMIT;
END//
DELIMITER ;
SELECT idContrato FROM contrato  WHERE idEmpleado = 19 AND idCondicionDeContrato = 1;
INSERT INTO jpingenieria_jpnet2023.licenciacongocedehaber(FechaDeInicioConGoceDeHaber,  FechaDeFinConGoceDeHaber, LinkDelDocumento ) VALUES ("2023-01-28","2023-01-30","AdjntoPruebas");

		INSERT INTO licenciacongocedehaber(FechaDeInicioConGoceDeHaber,
        FechaDeFinConGoceDeHaber,
        LinkDelDocumento
        ) 
        VALUES ("2023-01-28","2023-01-30","AdjntoPruebas");
SELECT idLicenciaConGoceDeHaber FROM licenciacongocedehaber ORDER BY idLicenciaConGoceDeHaber DESC LIMIT 1;
UPDATE tareo TRA SET idCondicionDeTareo = 6,idLicenciaConGoceDeHaber = 25 WHERE "2023-01-28"  <= TRA.Fecha AND TRA.Fecha <= "2023-01-30" AND TRA.idContrato = 19;

CALL RegistrarLicenciasConGoceDeHaber("2023-01-28","2023-01-30","AdjntoPruebas",19);
