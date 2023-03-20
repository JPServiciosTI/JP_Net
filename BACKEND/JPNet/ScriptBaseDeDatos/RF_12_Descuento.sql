USE jpingenieria_jpnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS RegistrarDescuentos;
CREATE PROCEDURE RegistrarDescuentos(
IN idPeriodo_IN INT, 
IN idContrato_IN INT,
IN INQuintaCategoria_IN  FLOAT,
IN Tardanzas_IN  FLOAT,
IN Faltas_IN  FLOAT,
IN DescuentoFondoDePensiones_IN  FLOAT)
BEGIN

		DELETE FROM descuentos  WHERE idContrato = idContrato_IN AND idPeriodo = idPeriodo_IN;

		INSERT INTO jpingenieria_jpnet2023.descuentos(
        idPeriodo,
        idContrato,
        ImpuestoDeQuintaCategoria,
        Tardanzas,
        Faltas,
        DescuentoFondoDePension) VALUES (
        idPeriodo_IN,
        idContrato_IN,
        INQuintaCategoria_IN,
        Tardanzas_IN,
        Faltas_IN,
        DescuentoFondoDePensiones_IN);
END//
DELIMITER ;

CALL RegistrarDescuentos(2,2,5.33,0,0,'296.00');
CALL ObtenerTardanzasPorDNI("72234614",'2023-01-16','2023-02-15');


USE jpingenieria_jpnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerDescuentos;
CREATE PROCEDURE ObtenerDescuentos(IN CONTRATOID_IN INT, IN IDPERIODO_IN INT )
BEGIN
	SELECT *  FROM jpingenieria_jpnet2023.descuentos DCS 
    LEFT JOIN jpingenieria_jpnet2023.adelantoocreditos AC ON DCS.idAdelantoOCredito = AC.idAdelantoOCreditos 
    LEFT JOIN jpingenieria_jpnet2023.cuentasporrendir CPR ON DCS.idCuentaPorRendir = CPR.idCuentasPorRendir    
    WHERE  DCS.idContrato = CONTRATOID_IN AND DCS.idPeriodo = IDPERIODO_IN ;
END//
DELIMITER ;

CALL ObtenerDescuentos(1,2);


