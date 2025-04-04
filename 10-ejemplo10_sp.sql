/*Crea un procedimiento (​ ejemplo10_sp.sql​ ) con dos parámetros de entrada (usuario y contraseña) y uno de salida (mensaje) Hacer uso de IF, ELSE para comprobar si un usuario pasado por parámetros existe en la base de datos con esa contraseña.
Devolvemos en la variable de saida estos tres posibles valores: usuario no existe, password incorrecto o usuario correcto*/
use BD06;
-- eliminamos el procedimiento si existe
drop procedure if exists ejemplo10_sp;
delimiter $$
create procedure ejemplo10_sp(_user varchar(15), _passwd varchar(50), out _mensaje varchar(20))
begin
	-- comprobamos si el usuario existe con esa contraseña.
    -- devolvemos en la variable estos tres posibles valores
    -- usuario no existe
    -- password incorrecto
    -- usuario correcto
    declare num int default 0;
    
    select count(*) into num from usuarios where usuario = _user and passwd= SHA2(_password, 256);
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

call ejemplo10_sp('pepe','1234',@mensaje);
select @mensaje;

call ejemplo10_sp('pepe','1111',@mensaje);
select @mensaje;

call ejemplo10_sp('pppp','1111',@mensaje);
select @mensaje;
