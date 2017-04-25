use BD06;
/*
drop table if exists datos_personales;
create table datos_personales (
	usuario varchar(10) NOT NULL PRIMARY KEY,
    edad int NULL DEFAULT 0,
    ultimo_login timestamp NULL,
    num_accesos INT NULL default 0,
    foreign key (usuario) references  usuarios (usuario) ON DELETE CASCADE

);

insert into datos_personales
select usuario, 15, NULL, 0 from usuarios;

select * from datos_personales;

-- vamos a cambiar algunas edades a mano para hacer la prueba con el procedimiento que vamos a crear
UPDATE `BD06`.`datos_personales` SET `edad`='18' WHERE `usuario`='juan';
UPDATE `BD06`.`datos_personales` SET `edad`='21' WHERE `usuario`='manuel';
UPDATE `BD06`.`datos_personales` SET `edad`='27' WHERE `usuario`='lolo';

select * from datos_personales;
*/
drop procedure if exists ejemplo9;
delimiter $$
create procedure ejemplo9(IN _usuario varchar(10))
begin
	declare num INT default 0;
	-- comprobamos si existe el usuario
    select count(*) into num from usuarios where usuario = _usuario;
    IF num = 1 THEN -- usuario existe
		select 'usuario existe' as 'Mensaje';
    ELSE -- usuario no existe 
		select 'usuario NO existe' as 'Mensaje';
	END IF;
end $$
delimiter ;

call ejemplo9('pepe');
call ejemplo9('rosalía');
