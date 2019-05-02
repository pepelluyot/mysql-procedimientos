/*
Crea un procedimiento (​ ejemplo1_sp.sql​ ) simple que muestre por pantalla el texto "esto
es un ejemplo de procedimiento" (donde la cabecera de la columna sea “mensaje”).
*/
use BD06;
DELIMITER //
DROP PROCEDURE IF EXISTS ejemplo1_sp//
CREATE PROCEDURE ejemplo1_sp()
BEGIN
 select "esto es un ejemplo de procedimiento" as 'mensaje';
END //
-- call ejemplo1_sp();
