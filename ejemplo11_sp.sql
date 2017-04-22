use BD06;
drop procedure if exists ejemplo11;
delimiter $$
create procedure ejemplo11(_user varchar(15))
begin
	declare v_edad INT default 0;
    select edad into v_edad from datos_personales
    where usuario = _user;
    case v_edad
    when 0 then
		select 'usuario no existe';
	else
		select 'usuario existe';
	end case;
    -- otra forma 
    case
    when v_edad >= 18 then
		select 'mayor de edad';
	when v_edad between 1 and 17 then
		select 'menor de edad';
	end case;
end $$
delimiter ;

call ejemplo11('pepe');
call ejemplo11('juan');
call ejemplo11('rosa');

/* falta por ver :
LOOP, LEAVE, ITERATE
REPEAT ... UNTIL
WHILE...DO *
lo haremos en los siguientes ejemplos*/