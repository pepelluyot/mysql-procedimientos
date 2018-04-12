/*
Crea una nueva tabla datos_personales con los campos: usuario, fecha_nacimiento, ultimo_login, num_accesos, (donde usuario es clave foránea de la tabla creada anteriormente).
Insertar algunos datos de ejemplos.
Crea un procedimiento (​ ejemplo11_sp.sql​ ) Hacer uso de case...when.. para comprobar si un usuario pasado por parámetros existe o no y si es mayor de edad o no.
*/
/*
Crea una nueva tabla datos_personales con los campos: usuario, fecha_nacimiento, ultimo_login, num_accesos, (donde usuario es clave foránea de la tabla creada anteriormente).
Insertar algunos datos de ejemplos.
Crea un procedimiento (​ ejemplo11_sp.sql​ ) Hacer uso de case...when.. para comprobar si un usuario pasado por parámetros existe o no y si es mayor de edad o no.
*/

drop table if exists datos_personales;
create table datos_personales (
	usuario varchar(10) NOT NULL PRIMARY KEY,
    fecha_nacimiento date NULL,
    ultimo_login timestamp NULL,
    num_accesos INT NULL default 0,
    foreign key (usuario) references  usuarios (usuario) ON DELETE CASCADE

);

insert into datos_personales
select usuario, '2000-01-01', NULL, 0 from usuarios;

select * from datos_personales;

-- vamos a cambiar algunas fechas de nacimiento a mano para hacer la prueba con el procedimiento que vamos a crear
UPDATE `datos_personales` SET `fecha_nacimiento`='2001-06-08' WHERE `usuario`='juan';
UPDATE `datos_personales` SET `fecha_nacimiento`='1984-10-25' WHERE `usuario`='manuel';
UPDATE `datos_personales` SET `fecha_nacimiento`='1985-05-15' WHERE `usuario`='lolo';

select * from datos_personales;

drop procedure if exists ejemplo11_sp;
delimiter $$
create procedure ejemplo11_sp(_user varchar(15))
begin
	declare v_edad INT default 0;
    declare v_fecNac date default NULL;
    
    case (select count(*) from usuarios where usuario = _user)
    when 0 then
		select 'usuario no existe';
	else
		select 'usuario existe';
        -- si el usuario existe comprobamos su fecha de nacimiento
		select fecha_nacimiento into v_fecNac from datos_personales where usuario = _user;
        set v_edad = TIMESTAMPDIFF(YEAR,v_fecNac ,current_date());
        case
		when v_edad is NULL then
        	select 'el usuario no tiene una edad determinada';
        when v_edad >= 18 then
			select 'mayor de edad';
		when v_edad between 1 and 17 then
			select 'menor de edad';
		end case;	
	end case;
    
end $$
delimiter ;

call ejemplo11_sp('pepe');
call ejemplo11_sp('juan');
call ejemplo11_sp('rosa');

