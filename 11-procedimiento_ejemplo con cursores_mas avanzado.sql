use BD06_1819;
show tables like 'datos%';

select count(*) from information_schema.tables where table_name="datos_personales"
and table_Schema='BD06_1819';

select exists(select table_name from information_schema.tables where table_name="datos_personales"
and table_Schema='BD06_1819');

set @existe = exists(select table_name from information_schema.tables where table_name="datos_personales"
and table_Schema='BD06_1819');


drop procedure if exists datospersonales;
delimiter $$
create procedure datospersonales()
proc: begin
	declare v_fecha DATE;
    declare v_fin, v_existe_tabla boolean default 0;
    declare v_usuario varchar(10);
	declare v_cursor cursor for 
        select usuario  from usuarios;
	-- control de errores
	declare continue handler for not found
		set v_fin=1;
        
	-- drop table if exists datos_personales;
	-- comprobamos si existe la tabla:
	set v_existe_tabla = exists(select table_name from information_schema.tables where table_name="datos_personales"
	and table_Schema='BD06_1819');
	if v_existe_tabla then
		select "salimos del procedimiento";
		leave proc;
	end if;
		
	create table datos_personales (
			usuario varchar(10) NOT NULL PRIMARY KEY,
			fecha_nacimiento date NULL,
			ultimo_login timestamp NULL,
			num_accesos INT NULL default 0,
			foreign key (usuario) references  usuarios (usuario) ON DELETE CASCADE
		);
	
    open v_cursor;
		mibucle: LOOP
        
        fetch v_cursor into v_usuario;
        if v_fin=1 then
			LEAVE mibucle;
        end if;
		
        SET v_fecha = '2000-01-01' - INTERVAL FLOOR(RAND() * 9000) DAY;
		insert into datos_personales (usuario, fecha_nacimiento, ultimo_login, num_accesos)
			values (v_usuario, v_fecha, NULL, 0);

        END LOOP mibucle;
    close v_cursor;

end proc $$
delimiter ;
call datospersonales();
select rand();

select * from datos_personales;


drop procedure if exists historico_sp;
delimiter $$
create procedure historico_sp(_user varchar(15))
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

call historico_sp('pepe');
call historico_sp('juan');
call historico_sp('rosa');

/*
Crea un procedimiento (​ ejemplo11_sp.sql​ ) 
Hacer uso de case...when.. para comprobar 
si un usuario pasado por parámetros existe o no y si es mayor de edad o no.
*/
delimiter %%
drop procedure if exists info_usuario %%
create procedure info_usuario ( IN _usuario varchar(15))
begin
	declare v_usuario_existe boolean default 0;
    declare v_fecha_nacimiento date default NULL;
    declare v_edad int default NULL;
    
    
	set v_usuario_existe = (select count(*) from usuarios where usuario = _usuario);
   -- select count(*) into v_usuario_existe from usuarios where usuario = _usuario;
     
    case v_usuario_existe
    when FALSE then
		select 'el usuario no existe en la base de datos' as 'MENSAJE';
    else
    	-- select 'el usuario EXISTE en la base de datos' as 'MENSAJE';
		select fecha_nacimiento into v_fecha_nacimiento from datos_personales where usuario = _usuario;
        -- preguntamos si la fecha de nacimiento tiene información o una fecha válida
        if v_fecha_nacimiento is null then
			select 'el usuario EXISTE pero no tiene una fecha de nacimiento asociada' as 'MENSAJE';
		else
			set v_edad = timestampdiff(YEAR, v_fecha_nacimiento, current_date());
            
            case 
            when v_edad>=18 then
				select 'el usuario EXISTE y es MAYOR de edad' as 'MENSAJE';
			else
				select 'el usuario EXISTE y es MENOR de edad' as 'MENSAJE';
			end case;
            
        end if;
    end case;
end %%
delimiter ;

call info_usuario('pepess');


