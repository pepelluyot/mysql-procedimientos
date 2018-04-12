/*
Crea un procedimiento (​ ejemplo2_sp.sql​ ) donde se declaren tres variables internas, una de tipo entero con valor de 1, otra de tipo varchar(10) con valor nulo por defecto y otra de tipo decimal con 4 dígitos y dos decimales.
Dentro del procedimiento, modificar el valor de la variable entera, la variable de tipo texto, realizar alguna operación matemáticas con las variables y mostrar los resultados en una select.
*/
use BD06;
DROP PROCEDURE IF EXISTS ejemplo2_sp;
DELIMITER $$
CREATE PROCEDURE ejemplo2_sp()
BEGIN
	/*declaración de variables internas*/
	DECLARE var_a INT default 1;
    DECLARE var_texto varchar(10) default NULL;
    DECLARE var_num NUMERIC(4,2) default 12.98;
    /*modificación del valor de una variable*/
    SET var_a = var_a + 1;
    set var_texto = "prueba";
    
    /*mostramos resultados en forma de select*/
	select var_a, var_texto, var_num;
    select (var_a + 2 ) * var_num;
END$$
DELIMITER ;

call ejemplo2_sp();
