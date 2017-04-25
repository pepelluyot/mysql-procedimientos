/* ejemplo de funciones */
drop function if exists ejemplo16; -- no podemos usar in out inout, sino return
delimiter //
create function ejemplo16 (_user varchar(15))
	returns year
begin
	declare _edad int;
	DECLARE EXIT HANDLER FOR NOT FOUND
		return NULL;
	
    set _edad = (select edad from datos_personales where usuario = _user);
    
    return (year(current_date()) - _edad );
end //
delimiter ;

select ejemplo16('juan') as 'año de nacimiento';