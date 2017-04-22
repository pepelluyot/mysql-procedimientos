use BD06;

/* ejemplos con parametros de salida OUT */
DELIMITER $$
DROP procedure if exists ejemplo7 $$
create procedure ejemplo7(OUT numero INT)
begin
/*
paso de parámetros por variable, es decir, las
modificaciones del parámetro dentro del programa almacenado modifican
directamente el parámetro pasado como argumento. Hasta que no se le asigne un
valor determinado dentro del programa, su valor dentro de él será nulo.
*/
	declare ejemplo int default 123;
    
	set ejemplo = numero;
    
	select ejemplo, numero; -- es nulo en ambas variables
    select count(*) into numero from usuarios; -- almacenamos el número de filas en numero y lo devolvemos
    
    
end $$
delimiter ;
set @cantidad = 100;
call ejemplo7(@cantidad);

select @cantidad;

call ejemplo7(2); -- error pues no es una variable el argumento*/