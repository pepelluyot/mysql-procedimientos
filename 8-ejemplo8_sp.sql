/*Crea un procedimiento (​ ejemplo8_sp.sql​ ) con una variable de entrada-salida. El procedimiento debe cambiar el valor de la vriable. Realizar una prueba mostrando el valor de la variable antes y despúes de llamar al procedimiento.*/
use BD06;
/* ejemplos con parametros de entrada y salida INOUT */
DELIMITER $$
DROP procedure if exists ejemplo8_sp $$
create procedure ejemplo8_sp(INOUT datos varchar(10))
begin
	declare v_texto varchar(5) default 'aeiou';
    set v_texto = datos; -- si el dato pasado tiene una longitud mayor de 5 da error
    select v_texto;
    set datos = 'cambiado';
end $$
delimiter ;
set @v_texto = 'holahola';
call ejemplo8_sp(@v_texto);  -- error truncado
set @v_texto = 'hola';
call ejemplo8_sp(@v_texto); -- cambia el valor de la variable
select @v_texto;

call ejemplo8_sp('hola'); -- error pues no es una variable el argumento
