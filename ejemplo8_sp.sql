use BD06;
/* ejemplos con parametros de entrada y salida INOUT */
DELIMITER $$
DROP procedure if exists ejemplo8 $$
create procedure ejemplo8(INOUT datos varchar(10))
begin
	declare v_texto varchar(5) default 'aeiou';
    set v_texto = datos; -- si el dato pasado tiene una longitud mayor de 5 da error
    select v_texto;
    set datos = 'cambiado';
end $$
delimiter ;
set @v_texto = 'holahola';
call ejemplo8(@v_texto);  -- error truncado
set @v_texto = 'hola';
call ejemplo8(@v_texto); -- cambia el valor de la variable
select @v_texto;

call ejemplo8('hola'); -- error pues no es una variable el argumento
