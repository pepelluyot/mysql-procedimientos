/*Crea una tabla sistema que almacene el número total de usuarios actuales y la fecha de la última actualización (último usuario, modificado o borrado).
Crear un disparador (​ ejemplo18_trig.sql​ ) sobre la tabla usuarios de forma que cuando se cree un usuario nuevo, actualice dicha tabla.*/
drop table if exists sistema;
create table sistema (
	num_usuarios INT UNSIGNED default 0,
    fecha timestamp
    );
    
drop trigger if exists ejemplo18_trig;

delimiter %%
create trigger ejemplo18_trig
	AFTER INSERT ON usuarios
    FOR EACH ROW
BEGIN
	declare numero int default 0 ;
	select count(*) into numero from usuarios;
	INSERT into sistema value ( numero, current_timestamp());
END %%
delimiter ;
