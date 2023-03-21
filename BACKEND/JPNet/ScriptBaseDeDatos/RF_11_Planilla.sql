USE jpingenieria_jpnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerDatosPeriodo;
CREATE PROCEDURE ObtenerDatosPeriodo()
BEGIN
	SELECT * FROM jpingenieria_jpnet2023.periodo;
END//
 DELIMITER ;


USE jpingenieria_jpnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerEmpleadosParaPlanilla;
CREATE PROCEDURE ObtenerEmpleadosParaPlanilla(IN REG_INICIO INT, IN CANTIDAD_IN INT)
BEGIN
	SELECT * FROM empleado CN INNER JOIN  persona PO ON CN.idPersona = PO.idPersona INNER JOIN cargo CG ON CG.idCargo = CN.idCargo   INNER JOIN contrato CT ON CT.idEmpleado = CN.idEmpleado INNER JOIN datoscontables DC ON DC.idContrato = CT.idContrato WHERE CN.idEmpleado >= REG_INICIO AND CT.idCondicionDeContrato = 1 LIMIT CANTIDAD_IN;
END//
 DELIMITER ;
 CALL ObtenerEmpleadosParaPlanilla(0,100);
 
 USE jpingenieria_jpnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerDatosPersona;
CREATE PROCEDURE VerTareadoHistoricoTrabajadorActivo(IN FECHA_IN DATE, IN FechaFIN DATE, IN idEmpleado_IN INT)
BEGIN
	DECLARE ID_Contrato INT;
    SET ID_Contrato = (SELECT idContrato FROM contrato  WHERE idEmpleado = idEmpleado_IN AND idCondicionDeContrato = 1);
	SELECT idTareo ,date_format(Fecha, "%d-%m-%Y") as Fecha,HoraDeIngreso, HoraDeInicioDeAlmuerzo, HoraDeFinDeAlmuerzo, HoraDeSalida FROM tareo TRE WHERE TRE.Fecha >= FECHA_IN AND FechaFIN >= TRE.Fecha;
END//
DELIMITER ;

USE jpingenieria_jpnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerPersonaParaCalculoDePlanilla;
CREATE PROCEDURE ObtenerPersonaParaCalculoDePlanilla(IN idEmpleado_IN INT)
BEGIN
	DECLARE ID_Contrato INT;
    SET ID_Contrato = (SELECT idContrato FROM contrato  WHERE idEmpleado = idEmpleado_IN AND idCondicionDeContrato = 1);
	SELECT * FROM contrato CT INNER JOIN datoscontables ON ;
END//
 DELIMITER ;
 
 USE jpingenieria_jpnet2023;
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


USE jpingenieria_jpnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS CalcularRemuneracionBruta;
CREATE PROCEDURE CalcularRemuneracionBruta(IN DNI_IN VARCHAR(10), IN FINICIO_IN DATE,IN FECHAFIN_IN DATE )
BEGIN
	DECLARE IDEmpleado INT;
    DECLARE IDContrato INT;
	SET IDEmpleado = (SELECT EMP.idEmpleado FROM jpingenieria_jpnet2023.empleado EMP INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN); 
	SET IDContrato = (SELECT CT.idContrato FROM jpingenieria_jpnet2023.contrato CT INNER JOIN jpingenieria_jpnet2023.empleado EMP ON CT.idEmpleado = EMP.idEmpleado INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN AND CT.idCondicionDeContrato =1);
	SELECT PG.idPeriodo,ROUND(SUM(PG.CantidadDePago), 2)AS SueldoBruto, ROUND(SUM(PG.CantidadDePago), 2)*0.09 AS EsSalud FROM jpingenieria_jpnet2023.pagotareo PG INNER JOIN jpingenieria_jpnet2023.tareo TAR ON PG.idTareo = TAR.idTareo WHERE TAR.Fecha >= FINICIO_IN AND FECHAFIN_IN >= TAR.Fecha AND TAR.idContrato = IDContrato AND (TAR.idCondicionDeTareo = 1 OR TAR.idCondicionDeTareo = 2) AND (TAR.idEstacionDeTrabajo = 1 OR TAR.idEstacionDeTrabajo = 2) GROUP BY PG.idPeriodo;
END//
DELIMITER ;

SELECT ROUND(SUM(PG.CantidadDePago), 2)AS SueldoBruto, ROUND(SUM(PG.CantidadDePago), 2)*0.09 AS EsSalud FROM jpingenieria_jpnet2023.pagotareo PG INNER JOIN jpingenieria_jpnet2023.tareo TAR ON PG.idTareo = TAR.idTareo WHERE TAR.Fecha >= '2023-01-16' AND '2023-02-15' >= TAR.Fecha AND TAR.idContrato = 17;

CALL CalcularRemuneracionBruta("72234614",'2023-01-16','2023-02-15');

USE jpingenieria_jpnet2023;
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


USE jpingenieria_jpnet2023;
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


       
USE jpingenieria_jpnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerPlanilla;
CREATE PROCEDURE ObtenerPlanilla( IN FINICIO_IN DATE,IN FECHAFIN_IN DATE )
BEGIN
	SELECT CT.idContrato ,CT.FechaDeInicioDeContrato,CT.FechaDeFinDeContrato,CT.idEmpleado,PRS.Nombres,PRS.ApellidoPaterno,PRS.ApellidoMaterno,DCT.SueldoBase,PRS.DNI,DCT.NHijos,DCT.SueldoBase,DCT.idDatosContables,DCT.NHijos,FDP.idFondoDePension, FDP.NombreEntidad,FDP.PorcentajeDeDescuento  FROM contrato CT INNER JOIN empleado EMP ON CT.idEmpleado = EMP.idEmpleado INNER JOIN datoscontables DCT ON CT.idContrato = DCT.idContrato INNER JOIN fondodepension FDP ON EMP.idFondoDePension = FDP.idFondoDePension INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona  WHERE CT.FechaDeInicioDeContrato <= FINICIO_IN AND FECHAFIN_IN <= CT.FechaDeFinDeContrato AND CT.idCondicionDeContrato =1;
END//
DELIMITER ;
CALL ObtenerPlanilla('2023-01-16','2023-02-15');

USE jpingenieria_jpnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerTardanzasPorDNI;
CREATE PROCEDURE ObtenerTardanzasPorDNI( IN DNI_IN VARCHAR(10) ,IN FINICIO_IN DATE,IN FECHAFIN_IN DATE )
BEGIN
	DECLARE IDEmpleado INT;
    DECLARE IDContrato INT;
	SET IDEmpleado = (SELECT EMP.idEmpleado FROM empleado EMP INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN); 
	SET IDContrato = (SELECT CT.idContrato FROM jpingenieria_jpnet2023.contrato CT INNER JOIN jpingenieria_jpnet2023.empleado EMP ON CT.idEmpleado = EMP.idEmpleado INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN AND CT.idCondicionDeContrato =1);
	SELECT COUNT(TR.idTareo) AS Tardanzas  FROM tareo TR WHERE TR.idCondicionDeTareo = 2 AND TR.idContrato = IDContrato;
END//
DELIMITER ;
CALL ObtenerTardanzasPorDNI("71234180",'2023-01-16','2023-02-15');


USE jpingenieria_jpnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerFaltasPorDNI;
CREATE PROCEDURE ObtenerFaltasPorDNI( IN DNI_IN VARCHAR(10) ,IN FINICIO_IN DATE,IN FECHAFIN_IN DATE )
BEGIN
	DECLARE IDEmpleado INT;
    DECLARE IDContrato INT;
	SET IDEmpleado = (SELECT EMP.idEmpleado FROM empleado EMP INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN); 
	SET IDContrato = (SELECT CT.idContrato FROM jpingenieria_jpnet2023.contrato CT INNER JOIN jpingenieria_jpnet2023.empleado EMP ON CT.idEmpleado = EMP.idEmpleado INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN AND CT.idCondicionDeContrato =1);
	SELECT COUNT(TR.idTareo) AS Faltas  FROM tareo TR WHERE TR.idCondicionDeTareo = 3 AND TR.idContrato = IDContrato;
END//
DELIMITER ;
CALL ObtenerFaltasPorDNI("71234180",'2023-01-16','2023-02-15');

USE jpingenieria_jpnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerTareoPlanillaDelPeriodo;
CREATE PROCEDURE ObtenerTareoPlanillaDelPeriodo(IN Periodo_IN INT )
BEGIN
	SELECT idPagoTareo FROM jpingenieria_jpnet2023.pagotareo WHERE idPeriodo = Periodo_IN LIMIT 1;
END//
DELIMITER ;
CALL ObtenerTareoPlanillaDelPeriodo(2);

USE jpingenieria_jpnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS ReiniciarPlanillaDelPeriodo;
CREATE PROCEDURE ReiniciarPlanillaDelPeriodo(IN Periodo_IN INT )
BEGIN
	DELETE FROM jpingenieria_jpnet2023.pagotareo WHERE idPeriodo = Periodo_IN;
END//
DELIMITER ;
CALL ReiniciarPlanillaDelPeriodo(2);

CALL CalcularRemuneracionBruta(22,"2023-01-16","2023-02-15");
#Dias pendientes de pago	
#Descanso Médico		
#DCGH		
#VACACIONES		
#FERIADOS TRABAJADOS		
#DESCANSOS TRABAJADOS		
#Asig. Fam	Bonos y Otros Conceptos	
#COMPENSACION VACACIONAL		
#HORAS EXTRAS		
#MMG 	MCP	MCB	AQP	PRY

USE jpingenieria_jpnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerConsolidadoDeDatosDelTareo;
CREATE PROCEDURE ObtenerConsolidadoDeDatosDelTareo(IN idContrato_IN INT, IN FechaDeInicio_IN DATE, IN FechaDeFin_IN DATE)
BEGIN
	DECLARE MMG_C FLOAT;
    DECLARE MCP_C FLOAT;
    DECLARE MCB_C FLOAT;
    DECLARE AQP_C FLOAT;
    DECLARE PRY_C FLOAT;
	DECLARE DESCANSOMedico_C INT;
    DECLARE DCGH_C INT;
    DECLARE FERIADO_TRABAJOS_C INT;
    DECLARE DESCANSOS_TRABAJADOS_C INT;
    DECLARE Hora35_C FLOAT;
    DECLARE Hora25_C FLOAT;
    DECLARE DESCANSOS_C FLOAT;
    DECLARE VACACIONES_C FLOAT;
	SET MMG_C = (SELECT count(idTareo) FROM tareo TRA  WHERE  idContrato = idContrato_IN AND TRA.idEstacionDeTrabajo = 4 AND (TRA.idCondicionDeTareo = 1 OR TRA.idCondicionDeTareo = 10)  AND FechaDeInicio_IN<=TRA.Fecha AND TRA.Fecha <= FechaDeFin_IN);
	SET MCP_C = (SELECT count(idTareo) FROM tareo TRA  WHERE  idContrato = idContrato_IN AND TRA.idEstacionDeTrabajo = 6 AND (TRA.idCondicionDeTareo = 1 OR TRA.idCondicionDeTareo = 10)  AND FechaDeInicio_IN<=TRA.Fecha AND TRA.Fecha <= FechaDeFin_IN);
	SET MCB_C = (SELECT count(idTareo) FROM tareo TRA  WHERE  idContrato = idContrato_IN AND TRA.idEstacionDeTrabajo = 7 AND (TRA.idCondicionDeTareo = 1 OR TRA.idCondicionDeTareo = 10)  AND FechaDeInicio_IN<=TRA.Fecha AND TRA.Fecha <= FechaDeFin_IN);
	SET AQP_C = (SELECT count(idTareo) FROM tareo TRA  WHERE  idContrato = idContrato_IN AND (TRA.idEstacionDeTrabajo = 1 OR TRA.idEstacionDeTrabajo = 2 ) AND (TRA.idCondicionDeTareo = 1 OR TRA.idCondicionDeTareo = 2)  AND FechaDeInicio_IN<=TRA.Fecha AND TRA.Fecha <= FechaDeFin_IN);
	SET PRY_C = (SELECT count(idTareo) FROM tareo TRA  WHERE  idContrato = idContrato_IN AND (TRA.idEstacionDeTrabajo = 8 OR TRA.idEstacionDeTrabajo = 9 OR TRA.idEstacionDeTrabajo = 3) AND (TRA.idCondicionDeTareo = 1 OR TRA.idCondicionDeTareo = 2)  AND FechaDeInicio_IN<=TRA.Fecha AND TRA.Fecha <= FechaDeFin_IN);
	SET DESCANSOMedico_C = (SELECT count(idTareo) FROM tareo TRA WHERE  TRA.idCondicionDeTareo = 4 AND TRA.idContrato = idContrato_IN AND FechaDeInicio_IN<=TRA.Fecha AND TRA.Fecha <= FechaDeFin_IN);
    SET DESCANSOS_C = (SELECT count(idTareo) FROM tareo TRA WHERE  TRA.idCondicionDeTareo = 7 AND TRA.idContrato = idContrato_IN AND FechaDeInicio_IN<=TRA.Fecha AND TRA.Fecha <= FechaDeFin_IN);
    SET FERIADO_TRABAJOS_C = (SELECT count(idTareo) FROM tareo TRA WHERE  TRA.idCondicionDeTareo = 8 AND TRA.idContrato = idContrato_IN AND FechaDeInicio_IN<=TRA.Fecha AND TRA.Fecha <= FechaDeFin_IN);
    SET VACACIONES_C = (SELECT count(idTareo) FROM tareo TRA WHERE  TRA.idCondicionDeTareo = 9 AND TRA.idContrato = idContrato_IN AND FechaDeInicio_IN<=TRA.Fecha AND TRA.Fecha <= FechaDeFin_IN);
	SET DCGH_C = (SELECT count(idTareo) FROM tareo TRA WHERE  TRA.idCondicionDeTareo = 6 AND TRA.idContrato = idContrato_IN AND FechaDeInicio_IN<=TRA.Fecha AND TRA.Fecha <= FechaDeFin_IN);
	SET Hora25_C = (SELECT SUM(HES.ValorDe25) FROM tareo TRA INNER JOIN horasextras HES ON TRA.idHorasExtras = HES.idHorasExtras AND TRA.idContrato = idContrato_IN AND FechaDeInicio_IN<=TRA.Fecha AND TRA.Fecha <= FechaDeFin_IN);
    SET Hora35_C = (SELECT SUM(HES.ValorDe35) FROM tareo TRA INNER JOIN horasextras HES ON TRA.idHorasExtras = HES.idHorasExtras AND TRA.idContrato = idContrato_IN AND FechaDeInicio_IN<=TRA.Fecha AND TRA.Fecha <= FechaDeFin_IN);
    SELECT MMG_C AS "MMG", MCP_C AS "MCP", MCB_C AS "MCB",AQP_C AS "AQP",PRY_C AS "PRY", DCGH_C AS "DCGH", DESCANSOMedico_C AS "MEDICO", DESCANSOS_C AS "DESCANSOSPROGRAMADOS", FERIADO_TRABAJOS_C AS "FERIADOSTRABAJADOS", VACACIONES_C AS "VACACIONES", Hora25_C AS "H25",Hora35_C AS "H35";
END//
DELIMITER ;
CALL ObtenerConsolidadoDeDatosDelTareo(11,"2023-01-16","2023-02-15");



SELECT SUM(HES.ValorDe25) FROM tareo TRA INNER JOIN horasextras HES ON TRA.idHorasExtras = HES.idHorasExtras AND TRA.idContrato = idContrato_IN AND FechaDeInicio_IN<=TRA.Fecha AND TRA.Fecha <= FechaDeFin_IN;