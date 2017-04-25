use BD06;
DROP PROCEDURE IF EXISTS ejemplo2;
DELIMITER $$
CREATE PROCEDURE ejemplo2()
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

call ejemplo2();