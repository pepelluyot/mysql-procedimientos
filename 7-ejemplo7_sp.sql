/*Crear un procedimiento (​ ejemplo7_sp.sql​ ) con una variable de de salida (paso de parámetros por variable) y comprueba que por defecto su valor es Nulo. Modifica su valor y muestralo tanto dentro del procedimiento como fuera de él.*/
use BD06;

/* ejemplos con parametros de salida OUT */
DELIMITER $$
DROP procedure if exists ejemplo7_sp $$
create procedure ejemplo7_sp(OUT numero INT)
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
call ejemplo7_sp(@cantidad);

select @cantidad;

call ejemplo7_sp(2); -- error pues no es una variable el argumento*/
