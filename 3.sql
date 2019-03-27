use torneofutbol;
delimiter $$

drop function if exists obtener_puntos $$
create function obtener_puntos(v_nombre_equipo varchar(50))
returns numeric (2,0)
begin
	declare _puntos numeric (2,0) default 0;
    
    set _puntos = (select sum(if(goles_local>goles_visitante,3,if(goles_local=goles_visitante,1,0)))
	from aux_partido
	where nombreEquipoLocal = v_nombre_equipo
	and (goles_local is not null or goles_visitante is not null));
	
    set _puntos = _puntos + (select sum(if(goles_local<goles_visitante,3,if(goles_local=goles_visitante,1,0)))
	from aux_partido
	where nombreEquipoVisitante= v_nombre_equipo
	and (goles_local is not null or goles_visitante is not null));
    return _puntos;
end$$
delimiter ;

select nombre, obtener_puntos(nombre) from equipo;