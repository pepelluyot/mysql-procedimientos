use torneofutbol;
drop procedure if exists cargar_datos_aux_partido;
delimiter $$
create procedure cargar_datos_aux_partido()
begin
/* creamos un procedimiento para volcar la tabla partidos en la tabla aux_partidos,
donde los goles aparecen en columnas distintas.
Si la tabla no existe, llamamos a un procedimiento creado anteriormente para crearla.
Insertamos los valores correctamente.
*/
	declare v_existe_tabla BOOLEAN default 0;
	-- vamos a controlar mediante un error cuando insertemos y la tabla no exista
    declare EXIT HANDLER for 1062
		select "la tabla estaba creada y los datos ya estaban volcados en la nueva tabla";
    DEClare eXIT HANDLER for sqlexception
	 	select "se ha producido un error";
    
    -- el problema es saber como pasar de '2-3' a 2 y 3, trabajamos con funciones string
    -- select left('2-3',1);
	SELECT count(*) into v_existe_tabla
	FROM information_schema.TABLES 
	WHERE table_schema = 'torneofutbol'
	and table_name='aux_partido';
    
    if v_existe_tabla = 0 then
		call crear_tabla_aux_partido(); -- creamos la nueva tabla
	else -- la tabla existe
		insert into aux_partido (nombreEquipoLocal, nombreEquipoVisitante, fecEncuentro, goles_local, goles_visitante)
		select nombreEquipoLocal,nombreEquipoVisitante,fecEncuentro, 
        left(resultado,1) as 'goles_local',
		right(resultado,1) as 'goles_visitante' 
        from partido;
    end if;
end$$
delimiter ;

call cargar_datos_aux_partido();

 /*  select left('2-3',1);
    select nombreEquipoLocal,nombreEquipoVisitante,fecEncuentro, left(resultado,1) as 'goles_local',
    right(resultado,1) as 'goles_visitante' from partido;
   
   begin;
    insert into aux_partido (nombreEquipoLocal, nombreEquipoVisitante, fecEncuentro, goles_local, goles_visitante)
    select nombreEquipoLocal,nombreEquipoVisitante,fecEncuentro, left(resultado,1) as 'goles_local',
    right(resultado,1) as 'goles_visitante' from partido; */

/*use information_schema;
SHOW TABLES;
SELECT count(*) 
FROM information_schema.TABLES 
WHERE table_schema = 'torneofutbol'
and table_name='aux_partido';*/