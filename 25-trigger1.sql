use torneofutbol;
drop trigger if exists log_insert;
delimiter %%
create trigger log_insert 
after insert on jugador
for each row
begin
	declare v_error INT default 0;
	declare total_jugadores decimal(3,0);
    
   -- declare continue handler for sqlexception 
	-- set v_error=1;
    -- calculamos el número de jugadores del equipo.
    
    select count(*) into total_jugadores
		from jugador where equipo_nombre = new.equipo_nombre;
	-- lo insertamos en la tabla logs_equipos. SI la tabla no existiera daría un error, que lo controlamos
    
    -- deberíamos comprobar si el registro existe para actualizarlo, si no existe lo insertamod, pero
    -- por hacerlo más fácil siempre lo vamos a insertar
    insert into logs_equipos 
		values ( current_timestamp(), 'insertar', new.equipo_nombre, total_jugadores);
	
end%%


delimiter ;
