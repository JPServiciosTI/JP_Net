USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerPlanilla;
CREATE PROCEDURE ObtenerPlanilla(IN REG_INICIO INT, IN CANTIDAD_IN INT)
BEGIN
	SELECT * FROM jpnet.empleado CN INNER JOIN  jpnet.persona PO ON CN.idPersona = PO.idPersona  INNER JOIN jpnet.contrato CT ON CT.idEmpleado = CN.idEmpleado WHERE CN.idEmpleado >= REG_INICIO AND CT.idCondicionDeContrato = 1 LIMIT CANTIDAD_IN;
END//
 DELIMITER ;
 


USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerDatosPeriodo;
CREATE PROCEDURE ObtenerDatosPeriodo()
BEGIN
	SELECT * FROM jpnet.periodo;
END//
 DELIMITER ;


USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerEmpleadosParaPlanilla;
CREATE PROCEDURE ObtenerEmpleadosParaPlanilla(IN REG_INICIO INT, IN CANTIDAD_IN INT)
BEGIN
	SELECT * FROM jpnet.empleado CN INNER JOIN  jpnet.persona PO ON CN.idPersona = PO.idPersona INNER JOIN jpnet.cargo CG ON CG.idCargo = CN.idCargo   INNER JOIN jpnet.contrato CT ON CT.idEmpleado = CN.idEmpleado INNER JOIN jpnet.datoscontables DC ON DC.idContrato = CT.idContrato WHERE CN.idEmpleado >= REG_INICIO AND CT.idCondicionDeContrato = 1 LIMIT CANTIDAD_IN;
END//
 DELIMITER ;
 CALL ObtenerEmpleadosParaPlanilla(0,100);
 
 
 USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS CrearPagoDelTareo;
CREATE PROCEDURE CrearPagoDelTareo(IN IDTAREO_IN INT,  IN CANTIDAD_PAGO_IN FLOAT, IDPERIODO_IN INT)
BEGIN
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
		INSERT INTO pagotareo(idTareo,CantidadDePago,idPeriodo) VALUES (IDTAREO_IN,CANTIDAD_PAGO_IN,IDPERIODO_IN);
		COMMIT;

END//
DELIMITER ;
CALL CrearPagoDelTareo(38,48.38709677419355,2);
INSERT INTO pagotareo(idTareo,CantidadDePago,idPeriodo) VALUES (38,48.38709677419355,2);


USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS CalcularRemuneracionBruta;
CREATE PROCEDURE CalcularRemuneracionBruta(IN DNI_IN VARCHAR(10), IN FINICIO_IN DATE,IN FECHAFIN_IN DATE )
BEGIN
	DECLARE IDEmpleado INT;
    DECLARE IDContrato INT;
	SET IDEmpleado = (SELECT EMP.idEmpleado FROM empleado EMP INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN); 
	SET IDContrato = (SELECT CT.idContrato FROM jpnet.contrato CT INNER JOIN jpnet.empleado EMP ON CT.idEmpleado = EMP.idEmpleado INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN AND CT.idCondicionDeContrato =1);
	SELECT ROUND(SUM(PG.CantidadDePago), 2)AS SueldoBruto, ROUND(SUM(PG.CantidadDePago), 2)*0.09 AS EsSalud FROM jpnet.pagotareo PG INNER JOIN jpnet.tareo TAR ON PG.idTareo = TAR.idTareo WHERE TAR.Fecha >= FINICIO_IN AND FECHAFIN_IN >= TAR.Fecha AND TAR.idContrato = IDContrato;
END//
DELIMITER ;


CALL CalcularRemuneracionBruta("73349166",'2023-01-16','2023-02-15');

USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerTareos;
CREATE PROCEDURE ObtenerTareos(IN DNI_IN VARCHAR(10), IN FINICIO_IN DATE,IN FECHAFIN_IN DATE )
BEGIN
	DECLARE IDEmpleado INT;
    DECLARE IDContrato INT;
	SET IDEmpleado = (SELECT EMP.idEmpleado FROM empleado EMP INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN); 
	SET IDContrato = (SELECT CT.idContrato FROM jpnet.contrato CT INNER JOIN jpnet.empleado EMP ON CT.idEmpleado = EMP.idEmpleado INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN AND CT.idCondicionDeContrato =1);
	SELECT *  FROM jpnet.pagotareo PG INNER JOIN jpnet.tareo TAR ON PG.idTareo = TAR.idTareo WHERE TAR.Fecha >= FINICIO_IN AND FECHAFIN_IN >= TAR.Fecha AND TAR.idContrato = IDContrato;
END//
DELIMITER ;

CALL ObtenerTareos("74958535",'2023-01-16','2023-02-15');


USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerPlanillaEmpleados;
CREATE PROCEDURE ObtenerPlanillaEmpleados( IN FINICIO_IN DATE,IN FECHAFIN_IN DATE )
BEGIN
	SELECT CT.idContrato,CT.FechaDeInicioDeContrato,CT.FechaDeFinDeContrato,CT.idEmpleado,PRS.Nombres,PRS.ApellidoPaterno,PRS.ApellidoMaterno,PRS.DNI FROM jpnet.contrato CT INNER JOIN jpnet.empleado EMP ON CT.idEmpleado = EMP.idEmpleado INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE CT.FechaDeInicioDeContrato >= FINICIO_IN AND FECHAFIN_IN <= CT.FechaDeFinDeContrato AND CT.idCondicionDeContrato =1;
END//
DELIMITER ;
CALL ObtenerPlanillaEmpleados('2023-01-16','2023-02-15');

SELECT * FROM jpnet.contrato CT INNER JOIN jpnet.empleado EMP ON CT.idEmpleado = EMP.idEmpleado INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE CT.FechaDeInicioDeContrato >= FINICIO_IN AND FECHAFIN_IN >= CT.FechaDeFinDeContrato AND CT.idCondicionDeContrato =1;
SET IDDatosContables = (SELECT DC.idDatosContables FROM jpnet.datoscontables DC WHERE DC.idContrato = IDContrato);


       
USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerPlanilla;
CREATE PROCEDURE ObtenerPlanilla( IN FINICIO_IN DATE,IN FECHAFIN_IN DATE )
BEGIN
	SELECT CT.idContrato ,CT.FechaDeInicioDeContrato,CT.FechaDeFinDeContrato,CT.idEmpleado,PRS.Nombres,PRS.ApellidoPaterno,PRS.ApellidoMaterno,DCT.SueldoBase,PRS.DNI,DCT.NHijos,DCT.SueldoBase,DCT.idDatosContables,DCT.NHijos, FDP.NombreEntidad,FDP.PorcentajeDeDescuento  FROM jpnet.contrato CT INNER JOIN jpnet.empleado EMP ON CT.idEmpleado = EMP.idEmpleado INNER JOIN datoscontables DCT ON CT.idContrato = DCT.idContrato INNER JOIN fondodepension FDP ON EMP.idFondoDePension = FDP.idFondoDePension INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona  WHERE CT.FechaDeInicioDeContrato >= FINICIO_IN AND FECHAFIN_IN <= CT.FechaDeFinDeContrato AND CT.idCondicionDeContrato =1;
END//
DELIMITER ;
CALL ObtenerPlanilla('2023-01-16','2023-02-15');

USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerTardanzasPorDNI;
CREATE PROCEDURE ObtenerTardanzasPorDNI( IN DNI_IN VARCHAR(10) ,IN FINICIO_IN DATE,IN FECHAFIN_IN DATE )
BEGIN
	DECLARE IDEmpleado INT;
    DECLARE IDContrato INT;
	SET IDEmpleado = (SELECT EMP.idEmpleado FROM empleado EMP INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN); 
	SET IDContrato = (SELECT CT.idContrato FROM jpnet.contrato CT INNER JOIN jpnet.empleado EMP ON CT.idEmpleado = EMP.idEmpleado INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN AND CT.idCondicionDeContrato =1);
	SELECT COUNT(TR.idTareo) AS Faltas  FROM tareo TR WHERE TR.idCondicionDeTareo = 3 AND TR.idContrato = IDContrato;
END//
DELIMITER ;
CALL ObtenerTardanzasPorDNI("71234180",'2023-01-16','2023-02-15');