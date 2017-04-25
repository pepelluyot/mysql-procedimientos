use BD06;
drop procedure if exists ejemplo10;
delimiter $$
create procedure ejemplo10(_user varchar(15), _passwd varchar(15), out _mensaje varchar(20))
begin
	-- comprobamos si el usuario existe con esa contraseña.
    -- devolvemos en la variable estos tres posibles valores
    -- usuario no existe
    -- password incorrecto
    -- usuario correcto
    declare num int default 0;
    
    select count(*) into num from usuarios where usuario = _user and passwd= _passwd;
    if num = 0 then
		select count(*) into num from usuarios where usuario = _user;
		if num = 0 then
			set _mensaje = 'usuario no existe';
		else
			set _mensaje = 'password incorrecto';
		end if;
	else
		set _mensaje = 'usuario correcto';
	end if;
	
end $$
delimiter ;

call ejemplo10('pepe','1234',@mensaje);
select @mensaje;

call ejemplo10('pepe','1111',@mensaje);
select @mensaje;

call ejemplo10('pppp','1111',@mensaje);
select @mensaje;