use torneofutbol;
drop trigger if exists log_update;
delimiter %%
create trigger log_update 
after update on jugador
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
    insert into logs_equipos 
		values ( current_timestamp(), 'actualizar', new.equipo_nombre, total_jugadores);
end%%


delimiter ;
