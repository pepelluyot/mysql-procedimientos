delimiter %%
drop procedure if exists crear_tabla_logs_equipos%%
/*
Crear un procedimiento llamado crear_tabla_logs_equipos que cree una tabla temporal nueva
 si no existe llamada logs_equipos, con los campos, fecha actual de tipo timestamp, 
 orden (que puede ser insertar, eliminar o actualizar), nombre del equipo y total de jugadores.
*/
create procedure crear_tabla_logs_equipos(OUT _error INT)
begin
	declare exit handler for sqlException
		set _error= -1;
        
	create temporary table if not exists logs_equipos (
		fecha timestamp,
        orden enum ('insertar', 'actualizar', 'eliminar'),
        equipo char(15),
        total_jugadores decimal(3,0)
    );
    set _error = 0;
end%%

delimiter ;

CALL crear_tabla_logs_equipos(@errores);
