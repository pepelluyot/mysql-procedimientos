delimiter %%
drop procedure if exists crear_tabla_logs_equipos%%
create procedure crear_tabla_logs_equipos(OUT _error INT)
begin
	declare exit handler for sqlException
		set _error= -1;
        
	create table if not exists logs_equipos (
		fecha timestamp,
        orden enum ('insertar', 'actualizar', 'eliminar'),
        equipo char(15),
        total_jugadores decimal(3,0)
    );
    set _error = 0;
end%%

delimiter ;

CALL crear_tabla_logs_equipos(@errores);