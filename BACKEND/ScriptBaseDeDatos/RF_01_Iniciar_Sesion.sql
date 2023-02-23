USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerUsuarios;
CREATE PROCEDURE ObtenerUsuarios()
BEGIN
	SELECT * FROM jpnet.login;
END//
 DELIMITER ;
 
 CALL ObtenerUsuarios();

USE jpnet;
DROP PROCEDURE IF EXISTS CrearUsuario;
DELIMITER //
CREATE PROCEDURE CrearUsuario(IN Email_IN VARCHAR(100),IN PassWord_IN VARCHAR(100), IN PersonaID_IN INT)
BEGIN
	INSERT INTO login(email,password,PersonaId) values (Email_IN,PassWord_IN,PersonaID_IN);
END //
 DELIMITER ;
 
 #CALL CrearUsuario("jpingenieria@gmail.com","HolaMundo",1);
 
 
 
 USE jpnet;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerUsuario;
CREATE PROCEDURE ObtenerUsuario(IN Email_IN VARCHAR(100))
BEGIN
	 SELECT * FROM login WHERE Email = Email_IN;
END//
 DELIMITER ;
 
 CALL ObtenerUsuario("pevv");