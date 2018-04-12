use BD06;
DELIMITER //
DROP PROCEDURE IF EXISTS ejemplo1//
CREATE PROCEDURE ejemplo1()
BEGIN
 select "esto es un ejemplo de procedimiento" as 'mensaje';
END //
-- call ejemplo1();
