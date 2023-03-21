USE jpingenieria_jpnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerUsuarios;
CREATE PROCEDURE ObtenerUsuarios()
BEGIN
	SELECT * FROM jpingenieria_jpnet2023.login;
END//
 DELIMITER ;
 
 CALL ObtenerUsuarios();

USE jpingenieria_jpnet2023;
DROP PROCEDURE IF EXISTS CrearUsuario;
DELIMITER //
CREATE PROCEDURE CrearUsuario(IN Email_IN VARCHAR(100),IN PassWord_IN VARCHAR(100), IN PersonaID_IN INT)
BEGIN
	INSERT INTO login(email,password,PersonaId) values (Email_IN,PassWord_IN,PersonaID_IN);
END //
 DELIMITER ;
 
 #CALL CrearUsuario("jpingenieria@gmail.com","HolaMundo",1);
 
 
 
 USE jpingenieria_jpnet2023;
DELIMITER //
DROP PROCEDURE IF EXISTS ObtenerUsuario;
CREATE PROCEDURE ObtenerUsuario(IN Email_IN VARCHAR(100))
BEGIN
	 SELECT * FROM login WHERE Email = Email_IN;
END//
 DELIMITER ;
 
 CALL ObtenerUsuario("pevv");