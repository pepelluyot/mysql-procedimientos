/*Crear una función (​ ejemplo15_fun.sql​ ) de manera que reciba una cantidad de euros y devuelva el valor expresado en pesetas. Llamar a dicha función en el interior de una select*/
/* ejemplo de funciones */
drop function if exists ejemplo15_fun;
delimiter //
create function ejemplo15 (_euros DECIMAL(10,2)) 
RETURNS decimal(20,3)
begin
	-- cuerpo de la funcion 
	declare _pesetas DECIMAL (20,3) ;
    set _pesetas = _euros * 166.386;
    return _pesetas;
end //
delimiter ;

select nombre, ejemplo15_fun(precio) 'pesetas' from articulos
order by nombre;

set @valor = ejemplo15_fun(123);
select @valor;


