/*Crea una función (​ ejemplo16_fun.sql​ ) de forma que pasandole un usuario nos devuelva su edad actual (debe comprobar su fecha de nacimiento en el caso de existir y calcular su edad actual).
*/
/* ejemplo de funciones */
drop function if exists ejemplo16_fun; -- no podemos usar in out inout, sino return
delimiter //
create function ejemplo16_fun (_user varchar(15))
	returns int
begin
	declare _edad int;
    declare _fecha_nacimiento date;
    
	DECLARE EXIT HANDLER FOR NOT FOUND
		return NULL;
	
    set _fecha_nacimiento = (select fecha_nacimiento from datos_personales where usuario = _user);
    set _edad = timestampdiff(year, _fecha_nacimiento, current_date());
    return (_edad );
end //
delimiter ;

select ejemplo16_fun('pepe') as 'año de nacimiento';
