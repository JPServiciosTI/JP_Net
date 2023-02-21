#### CREAR DIRECCION
USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS CrearDireccion;
CREATE PROCEDURE CrearDireccion(IN idTipoDeVia_IN INT,IN NombreDeVia_IN VARCHAR(45),IN idTipoDeLocalidad_IN INT,IN NombreLocalidad_IN VARCHAR(45))
BEGIN
	 INSERT INTO direccion (idTipoDeVia,NombreDeVia,idTipoDeLocalidad,NombreLocalidad) VALUES (idTipoDeVia_IN ,NombreDeVia_IN, idTipoDeLocalidad_IN, NombreLocalidad_IN);
END//
 DELIMITER ;
# CALL CrearDireccion(1,"IrlandaSS",3,"La ColinaSS"); 


#### PARA OBTENER EL ID DE UNA PERSONA ESPECIFICA 
USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerDireccion;
CREATE PROCEDURE ObtenerDireccion(IN idDireccion_IN INT)
BEGIN
	 SELECT * FROM jpnet.direccion DI INNER JOIN jpnet.tipodelocalidad TLO ON DI.idTipoDeLocalidad=TLO.idTipoDeLocalidad INNER JOIN jpnet.tipodevia TLV ON DI.idTipoDeVia=TLV.idTipoDeVia WHERE DI.idDireccion = idDireccion_IN;
END//
 DELIMITER ;
#CALL ObtenerDireccion(1);



#### PARA OBTENER LA ULTIMA DIRECCION COMPLETA
USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerUltimaDireccion;
CREATE PROCEDURE ObtenerUltimaDireccion()
BEGIN
	SELECT * FROM jpnet.direccion DI INNER JOIN jpnet.tipodelocalidad TLO ON DI.idTipoDeLocalidad=TLO.idTipoDeLocalidad INNER JOIN jpnet.tipodevia TLV ON DI.idTipoDeVia=TLV.idTipoDeVia  ORDER BY idDireccion DESC LIMIT 1 ;
END//
 DELIMITER ; 
#CALL ObtenerUltimaDireccion();


 
#### PARA OBTENER EL ID DE LA LOCALIDAD SEGUN EL UBIGEO
USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerLocalidad;
CREATE PROCEDURE ObtenerLocalidad(IN ubigeo_IN VARCHAR(6))
BEGIN
	 SELECT idLocalidad FROM localidad LC WHERE LC.Ubigeo = ubigeo_IN;
END//
 DELIMITER ;
#CALL ObtenerLocalidad("040101");
 
 
#### CREAR UN PERFIL DE PERSONA 
USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS CrearPersona;
CREATE PROCEDURE CrearPersona(IN NOMBRE_IN VARCHAR(45),IN APELLIDO_PATERNO_IN VARCHAR(45),IN APELLIDO_MATERNO_IN VARCHAR(45),IN DNI_IN VARCHAR(10),IN TELEFONO_IN VARCHAR(12),
IN TELEFONOFIJO_IN VARCHAR(10),IN EMAIL_IN VARCHAR(100),IN CONTACTODEEMERGENCIA_IN VARCHAR(100),IN NUMERODEEMERGENCIA_IN VARCHAR(12),IN ID_LOCALIDAD_NACIMIENTO_IN INT,
IN ID_LOCALIDAD_ACTUAL_IN INT,IN ID_DIRECCION_IN INT,IN FECHA_DE_NACIMIENTO_IN DATE,IN ID_TIPO_DE_SANGRE_IN INT,IN ALERGIAS_IN VARCHAR(100)
)
BEGIN
INSERT INTO persona(
     Nombres,     ApellidoPaterno,     ApellidoMaterno,     DNI,     Telefono,     TelefonoFijo,     Email,     ContactoDeEmergencia,     NumeroDeEmergencia,     idLocalidadDeNacimiento,     idLocalidadActual,
     idDireccion,     FechaDeNacimiento,     idTipoDeSangre,     Alergias     ) VALUES (
	NOMBRE_IN,    APELLIDO_PATERNO_IN,    APELLIDO_MATERNO_IN,	DNI_IN,	TELEFONO_IN,	TELEFONOFIJO_IN,	EMAIL_IN,	CONTACTODEEMERGENCIA_IN,	NUMERODEEMERGENCIA_IN ,	ID_LOCALIDAD_NACIMIENTO_IN ,
	ID_LOCALIDAD_ACTUAL_IN ,	ID_DIRECCION_IN ,	FECHA_DE_NACIMIENTO_IN ,	ID_TIPO_DE_SANGRE_IN ,	ALERGIAS_IN);
END//
 DELIMITER ;
#CALL CrearPersona(    "PIERO",	"VIZCARRA",	"VARGAS",	"74624957",	"977336451",    "99999",	"pevv2016@gmail.com",	"Maribel",	"946387095",	'335' ,	'335' ,	'1' ,	'2003-04-04',	1,	"Ninguna");

 
#### PARA OBTENER EL ID DE UNA PERSONA ESPECIFICA 
USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerPersona;
CREATE PROCEDURE ObtenerPersona(IN DNI_IN INT)
BEGIN
	 SELECT idPersona FROM persona PER WHERE PER.DNI = DNI_IN;
END//
 DELIMITER ;
#CALL ObtenerPersona("74624957");
 

 
 
#### CREAR UN NUEVO CANDIDATO CON LOS PROCEDIMIENTOS ANTERIORES
USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS CrearCandidatoNuevo;
CREATE PROCEDURE CrearCandidatoNuevo(IN NOMBRE_IN VARCHAR(45),IN APELLIDO_PATERNO_IN VARCHAR(45),IN APELLIDO_MATERNO_IN VARCHAR(45),IN DNI_IN VARCHAR(10),IN TELEFONO_IN VARCHAR(12),IN EMAIL_IN VARCHAR(100),IN SALARIO_IN FLOAT,IN CARGO_IN INT, IN NMESES INT , IN LINK_CV_IN VARCHAR(500))
BEGIN
	DECLARE idPERS INT;
	SET idPERS = (SELECT idPersona FROM persona PER WHERE PER.DNI = DNI_IN);
    IF idPERS > 0 THEN
		INSERT INTO candidato(idPersona,PretencionSalaria,idCargoAOptar,MesesDeExperiencia,linkCurriculum,EtapaPrevia,EtapaDeLlamada,EtapaDeEntrevista,EtapaDeContratacion) VALUES (idPERS,SALARIO_IN,CARGO_IN,NMESES,LINK_CV_IN,0,0,0,0);
	ELSE
		CALL CrearPersona(	NOMBRE_IN,    APELLIDO_PATERNO_IN,    APELLIDO_MATERNO_IN,	DNI_IN,	TELEFONO_IN,	"",	EMAIL_IN,	"",	"" ,	1 ,	1 ,	1 ,	"2000-01-01" ,	1 ,	"");
		SET idPERS = (SELECT idPersona FROM persona PER WHERE PER.DNI = DNI_IN);
		INSERT INTO candidato(idPersona,PretencionSalaria,idCargoAOptar,MesesDeExperiencia,linkCurriculum,EtapaPrevia,EtapaDeLlamada,EtapaDeEntrevista,EtapaDeContratacion) VALUES (idPERS,SALARIO_IN,CARGO_IN,NMESES,LINK_CV_IN,0,0,0,0);	 
	END IF;
END//
 DELIMITER ;
#CALL CrearCandidatoNuevo(    "PIERO",	"VIZCARRA",	"VARGAS",	"74624957",	"977336451", "pevv2016@gmail.com",1500,6,9,"https://drive.google.com/file/d/1Ajm2azF7JIAMn4rDpmreFXXZB5QrJHOQ/view?usp=sharing");


#### CREAR UN NUEVO CANDIDATO CON LOS PROCEDIMIENTOS ANTERIORES
USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerCandidatos;
CREATE PROCEDURE ObtenerCandidatos(IN REG_INICIO INT, IN CANTIDAD_IN INT)
BEGIN
	SELECT * FROM jpnet.candidato CN INNER JOIN jpnet.persona PO on CN.idPersona = PO.idPersona WHERE CN.idCandidato >= REG_INICIO LIMIT CANTIDAD_IN;
END//
 DELIMITER ;
 

CALL ObtenerCandidatos(0,5);

USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS EliminarCandidato;
CREATE PROCEDURE EliminarCandidato(IN REG_IN INT)
BEGIN
	DELETE FROM jpnet.candidato CN WHERE CN.idCandidato = REG_IN;
END//
 DELIMITER ;
 
 
 USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS ActualizarCandidato;
CREATE PROCEDURE ActualizarCandidato(IN IDCandidato_IN INT,IN EtapaPrevia_IN INT,IN EtapaDeLlamada_IN INT,IN EtapaEntrevista_IN INT,IN EtapaDeContratacion_IN INT)
BEGIN
	UPDATE jpnet.candidato CAND SET 
    CAND.EtapaPrevia = EtapaPrevia_IN,
    CAND.EtapaDeLlamada = EtapaDeLlamada_IN,
    CAND.EtapaDeEntrevista = EtapaEntrevista_IN,
    CAND.EtapaDeContratacion = EtapaDeContratacion_IN 
    WHERE CAND.idCandidato = IDCandidato_IN; 
END//
 DELIMITER ;