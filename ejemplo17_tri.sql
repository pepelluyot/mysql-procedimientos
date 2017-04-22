use BD06;
drop table if exists sistema;
create table sistema (
	num_usuarios INT UNSIGNED default 0,
    fecha timestamp
    );
    
drop trigger if exists ejemplo17;

delimiter %%
create trigger ejemplo17
	AFTER INSERT ON usuarios
    FOR EACH ROW
BEGIN
	declare numero int default 0 ;
	select count(*) into numero from usuarios;
	INSERT into sistema value ( numero, current_timestamp());
END %%
delimiter ;