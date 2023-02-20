# CREAR UN ID EN LA TABLA DE EMPLEADOS PARA GENERAR UN CONTRATO
USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS CrearEmpleado;
CREATE PROCEDURE CrearEmpleado(IN NOMBRE_IN VARCHAR(45),IN APELLIDO_PATERNO_IN VARCHAR(45),IN APELLIDO_MATERNO_IN VARCHAR(45),IN DNI_IN VARCHAR(10),IN TELEFONO_IN VARCHAR(12),
IN TELEFONOFIJO_IN VARCHAR(10),IN EMAIL_IN VARCHAR(100),IN CONTACTODEEMERGENCIA_IN VARCHAR(100),IN NUMERODEEMERGENCIA_IN VARCHAR(12),IN ID_LOCALIDAD_NACIMIENTO_IN INT,
IN ID_LOCALIDAD_ACTUAL_IN INT,IN ID_DIRECCION_IN INT,IN FECHA_DE_NACIMIENTO_IN DATE,IN ID_TIPO_DE_SANGRE_IN INT,IN ALERGIAS_IN VARCHAR(100),IN ID_CARGO_IN INT, IN FONDO_PENSIONES_IN INT)
BEGIN
	DECLARE idPERS INT;
	SET idPERS = (SELECT idPersona FROM persona PER WHERE PER.DNI = DNI_IN);
    IF idPERS > 0 THEN
		INSERT INTO empleado(idPersona,idCargo,idFondoDePension) VALUES (idPERS,ID_CARGO_IN,FONDO_PENSIONES_IN);
	ELSE
		CALL CrearPersona(NOMBRE_IN,    APELLIDO_PATERNO_IN,    APELLIDO_MATERNO_IN,	DNI_IN,	TELEFONO_IN,	TELEFONOFIJO_IN,	EMAIL_IN,	CONTACTODEEMERGENCIA_IN,	NUMERODEEMERGENCIA_IN ,	ID_LOCALIDAD_NACIMIENTO_IN ,	ID_LOCALIDAD_ACTUAL_IN ,	ID_DIRECCION_IN ,	FECHA_DE_NACIMIENTO_IN ,	ID_TIPO_DE_SANGRE_IN ,	ALERGIAS_IN);
		SET idPERS = (SELECT idPersona FROM persona PER WHERE PER.DNI = DNI_IN);
		INSERT INTO empleado(idPersona,idCargo,idFondoDePension) VALUES (idPERS,ID_CARGO_IN,FONDO_PENSIONES_IN);	 
	END IF;
END//
 DELIMITER ;
#CALL CrearEmpleado(    "PIERO",	"VIZCARRA",	"VARGAS",	"74624957",	"977336451",    "99999",	"pevv2016@gmail.com",	"Maribel",	"946387095",	'335' ,	'335' ,	'1' ,	'2003-04-04',	1,	"Ninguna",8,2);


# ACTUALIZAR EMPLEADOS
USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS ActualizarEmpleado;
CREATE PROCEDURE ActualizarEmpleado(IN NOMBRE_IN VARCHAR(45),IN APELLIDO_PATERNO_IN VARCHAR(45),IN APELLIDO_MATERNO_IN VARCHAR(45),IN DNI_IN VARCHAR(10),IN TELEFONO_IN VARCHAR(12),
IN TELEFONOFIJO_IN VARCHAR(10),IN EMAIL_IN VARCHAR(100),IN CONTACTODEEMERGENCIA_IN VARCHAR(100),IN NUMERODEEMERGENCIA_IN VARCHAR(12),IN ID_LOCALIDAD_NACIMIENTO_IN INT,
IN ID_LOCALIDAD_ACTUAL_IN INT,IN ID_DIRECCION_IN INT,IN FECHA_DE_NACIMIENTO_IN DATE,IN ID_TIPO_DE_SANGRE_IN INT,IN ALERGIAS_IN VARCHAR(100))
BEGIN
	DECLARE idPERS INT;
	SET idPERS = (SELECT PER.idPersona FROM jpnet.persona PER WHERE PER.DNI = DNI_IN);
	UPDATE jpnet.persona PER SET 
    PER.Nombres = NOMBRE_IN,
    PER.ApellidoPaterno = APELLIDO_PATERNO_IN,
    PER.ApellidoMaterno = APELLIDO_MATERNO_IN,
    PER.Telefono =TELEFONO_IN,    PER.TelefonoFijo = TELEFONOFIJO_IN,
    PER.Email =EMAIL_IN ,    PER.ContactoDeEmergencia = CONTACTODEEMERGENCIA_IN,
    PER.NumeroDeEmergencia = NUMERODEEMERGENCIA_IN,    PER.idLocalidadDeNacimiento = ID_LOCALIDAD_NACIMIENTO_IN,
    PER.idLocalidadActual = ID_LOCALIDAD_ACTUAL_IN,
    PER.idDireccion = ID_DIRECCION_IN,
    PER.FechaDeNacimiento = FECHA_DE_NACIMIENTO_IN,
    PER.idTipoDeSangre = ID_TIPO_DE_SANGRE_IN,
    PER.Alergias = ALERGIAS_IN
    WHERE PER.idPersona = idPERS;
END//
DELIMITER ;
#CALL ActualizarEmpleado(    "PIERO",	"VIZCARRA",	"VARGAS",	"74624957",	"977336451",    "99999",	"pevv2016@gmail.com",	"Maribel",	"946387095",	'335' ,	'335' ,	'1' ,	'2003-04-04',	1,	"Ninguna");


# CREAR UN ID EN LA TABLA DE CONTRATO
USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS CrearContratoVigente;
CREATE PROCEDURE CrearContratoVigente(IN DNI_IN VARCHAR(10), IN FINICIO_IN DATE,IN FECHAFIN_IN DATE, IN SUELDO_BASE_IN FLOAT,IN CISPP_IN VARCHAR(25),IN NHijos_IN INT )
BEGIN
	DECLARE IDEmpleado INT;
    DECLARE IDContrato INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN # Si se produce una SQLEXCEPTION, se retrocede la transacción con ROLLBACK
			SELECT 'SQLEXCEPTION!, transacción abortada' AS Resultado;
			ROLLBACK;
		END//
	START TRANSACTION;
		SET IDEmpleado = (SELECT EMP.idEmpleado FROM empleado EMP INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN); 
		INSERT INTO contrato(idCondicionDeContrato,idEmpleado,FechaDeInicioDeContrato,FechaDeFinDeContrato) VALUES (1,IDEmpleado,FINICIO_IN,FECHAFIN_IN);
		SET IDContrato = (SELECT CT.idContrato FROM jpnet.contrato CT INNER JOIN jpnet.empleado EMP ON CT.idEmpleado = EMP.idEmpleado INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN AND CT.idCondicionDeContrato =1);
		INSERT INTO datoscontables(SueldoBase,CISPP,NHijos,idContrato) VALUES (SUELDO_BASE_IN,CISPP_IN,NHijos_IN,IDContrato);
		COMMIT;
END//
DELIMITER ;


START TRANSACTION;
SAVEPOINT sp1;
	CALL CrearContratoVigente("74624957","2023-01-16","2023-04-16",1500,"000",0);
ROLLBACK TO sp1;
CALL CrearContratoVigente("74624957","2023-01-16","2023-04-16",1500,"000",0);
#SELECT EMP.idEmpleado FROM empleado EMP INNER JOIN persona PRS ON EMP.idPersona = PRS.idPersona WHERE PRS.DNI = DNI_IN





 