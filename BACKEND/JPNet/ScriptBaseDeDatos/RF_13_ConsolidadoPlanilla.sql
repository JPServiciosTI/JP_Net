USE jpingenieria_consolidadodeplanillajpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS RegistrarConsolidado;
CREATE PROCEDURE RegistrarConsolidado(
IN Periodo_IN varchar(45) ,
IN DNI_IN varchar(45) ,
IN ApellidoPaterno_IN varchar(45) ,
IN ApellidoMaterno_IN varchar(45) ,
IN Nombres_IN varchar(45) ,
IN RemuneracionBasica_IN varchar(45) ,
IN PRY_IN varchar(45) ,
IN MCP_IN varchar(45) ,
IN MCB_IN varchar(45) ,
IN AQP_IN varchar(45) ,
IN Total_IN varchar(45) ,
IN SueldoBruto_IN varchar(45) ,
IN Dias_DCGH_IN varchar(45) ,
IN Monto_DCGH_IN varchar(45) ,
IN Dias_Vacaciones_IN varchar(45) ,
IN Monto_Vacaciones_IN varchar(45) ,
IN Dias_FeriadosTrabajados_IN varchar(45) ,
IN Monto_FeriadosTrabajadaos_IN varchar(45) ,
IN Dias_Descansos_IN varchar(45) ,
IN Monto_Descansos_IN varchar(45) ,
IN AsignacionFamiliar_IN varchar(45) ,
IN Vacaciones_Compensacion_IN varchar(45) ,
IN Monto_Compensacion_IN varchar(45) ,
IN HoraExtras_25_IN varchar(45) ,
IN HoraExtra_35_IN varchar(45) ,
IN MontoHorasExtras_IN varchar(45) ,
IN RemuneracionAsegurable_IN varchar(45) ,
IN AFPHabitad_IN varchar(45) ,
IN AFPIntegra_IN varchar(45) ,
IN AFPPrima_IN varchar(45) ,
IN AFPProfuturo_IN varchar(45) ,
IN ONP_IN varchar(45) ,
IN ImpuestoDeQuinta_IN varchar(45) ,
IN DevolucionQuinta_IN varchar(45) ,
IN Adelantos_IN varchar(45) ,
IN Prestamos_IN varchar(45) ,
IN DescuentosCuentasARendir_IN varchar(45) ,
IN DescuentosRecursosHumanos_IN varchar(45) ,
IN PensionAlimenticia_IN varchar(45) ,
IN TotalNeto_IN varchar(45) ,
IN EsSalud_IN varchar(45) 
)
BEGIN
	DECLARE idConsolidado INT;
    SET idConsolidado = (SELECT idplanilla FROM planillaconsolidadada WHERE DNI = DNI_IN  AND Periodo = Periodo_IN);
    IF idConsolidado > 0 THEN 
		DELETE FROM planillaconsolidadada WHERE idplanilla = idConsolidado;
	END IF;
	INSERT INTO jpingenieria_consolidadodeplanillajpnet.planillaconsolidadada(
				Periodo ,DNI , ApellidoPaterno ,ApellidoMaterno, Nombres ,RemuneracionBasica ,
				PRY ,MCP ,MCB ,AQP ,Total , SueldoBruto ,Dias_DCGH , Monto_DCGH ,
				Dias_Vacaciones,Monto_Vacaciones ,Dias_FeriadosTrabajados ,Monto_FeriadosTrabajadaos , 
				Dias_Descansos,Monto_Descansos,AsignacionFamiliar ,Vacaciones_Compensacion ,
				Monto_Compensacion ,HoraExtras_25 ,HoraExtra_35 ,MontoHorasExtras ,
				RemuneracionAsegurable,
				AFPHabitad ,AFPIntegra ,AFPPrima ,AFPProfuturo,ONP,
				ImpuestoDeQuinta ,DevolucionQuinta,Adelantos ,Prestamos ,DescuentosCuentasARendir ,DescuentosRecursosHumanos ,
				PensionAlimenticia ,TotalNeto ,EsSalud)
                values(
				Periodo_IN ,DNI_IN ,ApellidoPaterno_IN ,ApellidoMaterno_IN ,Nombres_IN ,RemuneracionBasica_IN ,
				PRY_IN ,MCP_IN ,MCB_IN ,AQP_IN ,Total_IN ,SueldoBruto_IN ,Dias_DCGH_IN ,Monto_DCGH_IN ,
				Dias_Vacaciones_IN ,Monto_Vacaciones_IN ,Dias_FeriadosTrabajados_IN ,Monto_FeriadosTrabajadaos_IN ,
				Dias_Descansos_IN ,Monto_Descansos_IN ,AsignacionFamiliar_IN ,Vacaciones_Compensacion_IN ,
				Monto_Compensacion_IN ,HoraExtras_25_IN ,HoraExtra_35_IN ,MontoHorasExtras_IN ,
				RemuneracionAsegurable_IN ,
				AFPHabitad_IN ,AFPIntegra_IN ,AFPPrima_IN ,AFPProfuturo_IN ,ONP_IN ,
				ImpuestoDeQuinta_IN ,DevolucionQuinta_IN ,Adelantos_IN ,Prestamos_IN ,DescuentosCuentasARendir_IN ,DescuentosRecursosHumanos_IN ,
				PensionAlimenticia_IN ,TotalNeto_IN ,EsSalud_IN    );
END//
DELIMITER ;


	INSERT INTO jpingenieria_consolidadodeplanillajpnet.planillaconsolidadada(
Periodo ,DNI , ApellidoPaterno ,ApellidoMaterno, Nombres ,RemuneracionBasica ,
PRY ,MCP ,MCB ,AQP ,Total , SueldoBruto ,Dias_DCGH , Monto_DCGH ,
Dias_Vacaciones,Monto_Vacaciones ,Dias_FeriadosTrabajados ,Monto_FeriadosTrabajadaos , 
Dias_Descansos,Monto_Descansos,AsignacionFamiliar ,Vacaciones_Compensacion ,
Monto_Compensacion ,HoraExtras_25 ,HoraExtra_35 ,MontoHorasExtras ,
RemuneracionAsegurable,
AFPHabitad ,AFPIntegra ,AFPPrima ,AFPProfuturo,ONP,
ImpuestoDeQuinta ,DevolucionQuinta,Adelantos ,Prestamos ,DescuentosCuentasARendir ,DescuentosRecursosHumanos ,
PensionAlimenticia ,TotalNeto ,EsSalud
    )values(
"2","70471667","PINTO","CHECYA","BRANDO LUGGER","1500.00",
"0","0","0","31","31","1500","0","0",
"0","0","0","0",
"0","0","0","0",
"0","0","0","0",
"1500",
"0","177.6","0","0","0",
"0","0","0","0","0","0",
"0","1322.4","135"
  );
  
USE jpingenieria_consolidadodeplanillajpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS VerConsolidadoTotalConsolidadoPorPeriodo;
CREATE PROCEDURE VerConsolidadoTotalConsolidadoPorPeriodo(IN PERIODO_IN INT)
BEGIN
	SELECT * FROM planillaconsolidadada WHERE Periodo=PERIODO_IN;
END//
DELIMITER ;
  
  CALL VerConsolidadoTotalConsolidadoPorPeriodo(2);


USE jpingenieria_consolidadodeplanillajpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS VerConsolidadoPorTrabajadorConsolidadoPorPeriodo;
CREATE PROCEDURE VerConsolidadoPorTrabajadorConsolidadoPorPeriodo(IN PERIODO_IN INT, IN DNI_IN VARCHAR(10))
BEGIN
	SELECT * FROM planillaconsolidadada WHERE Periodo=PERIODO_IN AND DNI=DNI_IN;
END//
DELIMITER ;

CALL VerConsolidadoPorTrabajadorConsolidadoPorPeriodo(2,"74624957");