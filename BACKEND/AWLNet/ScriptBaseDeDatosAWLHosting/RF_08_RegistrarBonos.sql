USE jpingenieria_awlnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS RegistrarBonos//
CREATE PROCEDURE RegistrarBonos(IN PagoHorasExtras_IN FLOAT,IN Reintegro_IN FLOAT,IN BonoDeclarado_IN FLOAT,IN BonoProduce_IN FLOAT,IN BonoNoche_IN FLOAT,IN BonoRotacion FLOAT, IN BonoAsignacionFamiliar FLOAT)
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
		INSERT INTO jpingenieria_awlnet2023.bonos(PagoHorasExtras,Reintegro, BonoDeclarado, BonoProduce, BonoConductor, BonoRotacion, BonoAsignacionFamiliar) VALUES (PagoHorasExtras_IN,Reintegro_IN,BonoDeclarado_IN,BonoProduce_IN,BonoNoche_IN,BonoRotacion,BonoAsignacionFamiliar);
        COMMIT;

END//
DELIMITER ;




#SELECT * FROM jpingenieria_awlnet2023.bonos;