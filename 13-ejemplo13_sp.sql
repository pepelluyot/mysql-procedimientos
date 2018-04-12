/* hacer un procedimiento de forma que cuando un usuario se autentifique,
actualice la tabla datos_personales (aumente el numero de acceso y almacene la fecha)
. MOstrar los datos de la tabla datos personales para ese usuario*/
use BD06;
drop procedure if exists ejemplo13;
delimiter $$
create procedure ejemplo13(_user varchar(15), _passwd varchar(15))
begin
	-- comprobamos si el usuario existe con esa contraseña.
    -- devolvemos en la variable estos tres posibles valores
    -- usuario no existe
    -- password incorrecto
    -- usuario correcto
    declare num int ;
    
    select num_accesos into num from usuarios, datos_personales 
    where usuarios.usuario = _user and passwd= _passwd
    and usuarios.usuario = datos_personales.usuario;
    
	-- select num; 
    -- si devuelve NULL es que no hay datos (no se ha autenticado, pues por defecto
    -- al crear un usuario le metemos 0.
    
    If num >= 0 then -- actualizamos los datos
		update datos_personales
		set num_accesos = num_accesos + 1, ultimo_login = current_timestamp()
		where usuario = _user;
	end if;
	
    select * from datos_personales
    where usuario = _user;
end $$
delimiter ;

call ejemplo13('pepe','1234');
call ejemplo13('pepe','2234');

-- otra forma
use BD06grupoB;
drop procedure if exists actualizar_datos_usuario;
delimiter $$
create procedure actualizar_datos_usuario(_user varchar(15))
begin
	-- comprobamos si el usuario existe.
    if (select count(*) from usuarios where usuario = _user)>0 then
    -- si existe
		-- compronbamos si existe ne la tabla datos.personales
        if (select count(*) from datos_personales where usuario = _user)>0 then
			-- si existe en esa tabla actualizamos los datos
            UPDATE datos_personales 
				set ultimo_login = current_timestamp(),
					num_accesos = ifnull(num_accesos,0) + 1
				where usuario = _user;
            -- si no , insertamos un nuevo registro.
            else
				INSERT INTO datos_personales (usuario, num_accesos, ultimo_login)
                values (_user, 1, current_timestamp());
		end if;
	end if;
end $$
delimiter ;

call actualizar_datos_usuario('manuela');


