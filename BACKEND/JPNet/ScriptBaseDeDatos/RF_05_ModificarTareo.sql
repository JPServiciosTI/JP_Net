USE jpingenieria_jpnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS ActualizarTareo;
CREATE PROCEDURE ActualizarTareo(IN HoraDeIngreso_IN TIME, IN HoraDeInicioDeAlmuerzo_IN TIME, IN HoraDeFinDeAlmuerzo_IN TIME,IN HoraDeSalida_IN TIME,IN idEstacionDeTrabajo_IN INT ,IN idTareo_IN INT)
BEGIN
	UPDATE tareo SET 	HoraDeIngreso=HoraDeIngreso_IN, 
						HoraDeInicioDeAlmuerzo=HoraDeInicioDeAlmuerzo_IN,
                        HoraDeFinDeAlmuerzo=HoraDeFinDeAlmuerzo_IN,
                        HoraDeSalida=HoraDeSalida_IN,
                        idEstacionDeTrabajo=idEstacionDeTrabajo_IN 
						WHERE idTareo=idTareo_IN;
END//
 DELIMITER ;
 
 CALL ActualizarTareo('7:36:00','13:06:00','13:56:00','16:36:00',3,6);