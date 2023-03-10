USE jpingenieria_awlnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS RegistrarVacaciones//
CREATE PROCEDURE RegistrarVacaciones(
IN FechaDeInicioDeVacaciones_IN DATE,
IN FechaDeFinDeVacaciones_IN DATE,
IN LinkDelDocumento_IN TEXT,
IN idEmpleado_IN INT)
BEGIN
	DECLARE ID_Contrato INT;
    DECLARE ID_VACACIONES INT;
    DECLARE ID_DIAS INT;
    DECLARE ID_DIAS_ITER INT;
    DECLARE FECHA_ITERADA DATE;
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
		INSERT INTO jpingenieria_awlnet2023.vacaciones(FechaDeInicioVacaciones,   FechaDeFinVacaciones, LinkDeDocumento ) 
        VALUES (FechaDeInicioDeVacaciones_IN,        FechaDeFinDeVacaciones_IN,        LinkDelDocumento_IN);
		SET ID_VACACIONES = (SELECT idVacaciones FROM vacaciones ORDER BY idVacaciones DESC LIMIT 1);
        SET ID_DIAS = (SELECT DATEDIFF (FechaDeFinDeVacaciones_IN,FechaDeInicioDeVacaciones_IN));
		SET ID_DIAS_ITER = 0;
        loop_label: LOOP
			IF ID_DIAS_ITER >= ID_DIAS THEN
				LEAVE loop_label;
			END IF;
			SET FECHA_ITERADA = DATE_ADD(FechaDeInicioDeVacaciones_IN, INTERVAL ID_DIAS_ITER DAY);
            INSERT INTO tareo(idContrato,Fecha,HoraDeIngreso , HoraDeInicioDeAlmuerzo , HoraDeFinDeAlmuerzo , HoraDeSalida, idCondicionDeTareo, idEstacionDeTrabajo, idVacaciones)
            VALUES (ID_Contrato,FECHA_ITERADA,"0:00","00:00","00:00","00:00",9,11,ID_VACACIONES);
			SET ID_DIAS_ITER = ID_DIAS_ITER + 1;
			ITERATE loop_label;
		END LOOP;
        COMMIT;
END//
DELIMITER ;
#CALL RegistrarVacaciones('2023-04-16','2023-05-01',"fghjsdfghjksdfghjksdftyuwertyuio34567890l",21);

USE jpingenieria_awlnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerVacaciones//
CREATE PROCEDURE ObtenerVacaciones( IN DNI_IN VARCHAR(10) ,IN FINICIO_IN DATE,IN FECHAFIN_IN DATE )
BEGIN
	DECLARE IDEmpleado INT;
    DECLARE IDContrato INT;
	SET IDEmpleado = (SELECT EMP.idEmpleado FROM empleado EMP INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN); 
	SET IDContrato = (SELECT CT.idContrato FROM jpingenieria_awlnet2023.contrato CT INNER JOIN jpingenieria_awlnet2023.empleado EMP ON CT.idEmpleado = EMP.idEmpleado INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN AND CT.idCondicionDeContrato =1);
	SELECT COUNT(TR.idTareo) AS DiasDeVacaciones  FROM tareo TR WHERE TR.idCondicionDeTareo = 9 AND TR.idContrato = IDContrato;
END//
DELIMITER ;
CALL ObtenerVacaciones("71234180",'2023-01-16','2024-02-15');
CALL ObtenerTareos("71234180",'2023-01-16','2024-02-15');
