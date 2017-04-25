use torneofutbol;
drop function if exists obtener_puntuacion ;
-- drop procedure if exists obtener_puntuacion ;
delimiter $$
create function obtener_puntuacion (_equipo varchar(15))
 returns int
-- create procedure obtener_puntuacion (_equipo varchar(15), OUT mierror INT)
begin
	declare puntos DECIMAL(3,0) default 0; -- inicializamos los puntos
    declare _miequipo varchar(15) default NULL; /* almacenamos en esta variable NULL por defecto
    para saber si existe o no el equipo. en el caso de existir toma el valor del parámetro de entrada*/
-- declare exit HANDLER for SQLEXCEPTION
-- return -1;
	
    -- comprobamos si el equipo existe
    set _miequipo := (select nombre from equipo where nombre = _equipo);
    if _miequipo IS NULL then
		 return -1;
        -- set mierror = -1;
	-- calculamos los puntos obtenidos, partidos ganados x3 puntosgoles
    -- hacemos uso de la tabla auxiliar
    end if;
    
  /*  select goles_local, goles_visitante, if(goles_local > goles_visitante,3,
    if(goles_local = goles_visitante,1,0)) from aux_partido
    where nombreEquipoLocal = _equipo; -- or nombreEquipoVisitante=_equipo
	*/
	
	set puntos = (	select sum(if(goles_local > goles_visitante,3,
					if(goles_local = goles_visitante,1,0))) from aux_partido
		where nombreEquipoLocal = _equipo );
	set puntos = puntos + (	select sum(if(goles_local < goles_visitante,3,
					if(goles_local = goles_visitante,1,0))) from aux_partido
		where nombreEquipoVisitante = _equipo );
    return puntos;
end $$
delimiter ;


select obtener_puntuacion ("Roteña");
