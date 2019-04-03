/*
Haciendo uso de la función anterior, crear un procedimiento llamado actualizar_calificacion 
que cree una nueva tabla si no existe llamada clasificación, de forma que actualice la clasificación 
de todos los equipos de la base de datos, indicando el orden de calificación
*/
use torneofutbol;
drop procedure if exists  actualizar_calificacion;
delimiter $$
create procedure actualizar_calificacion()
begin
	drop table if exists calificacion;
    create table calificacion (
		posicion INT auto_increment primary key,
        equipo varchar(15),
        puntos decimal(3,0) default 0)
    ;
    insert into calificacion
    select 0, nombre, obtener_puntuacion(nombre) from equipo
    order by 3 desc;
    
end$$
-- otra forma
drop procedure if exists  actualizar_calificacion$$

create procedure actualizar_calificacion()
begin
	declare continue handler for 1146
	BEGIN
		create table calificacion (
			posicion INT auto_increment primary key,
			equipo varchar(15),
			puntos decimal(3,0) default 0,
--            goles_favor decimal(3,0) default 0,
  --          goles_contra decimal(3,0) default 0,
            PJ decimal (2,0) default 0,
            PG decimal (2,0) default 0,
            PE decimal (2,0) default 0,
            PP decimal (2,0) default 0)
		;
	END;
    truncate calificacion;
    
    insert into calificacion (	posicion,
			equipo ,
			puntos ,
     --       goles_favor ,
     --       goles_contra,
            PJ,
            PG,
            PE,
            PP
		)
    select 0, nombre, obtener_puntuacion(nombre), obtener_partidos('PJ',nombre),
    obtener_partidos('PG',nombre), obtener_partidos('PE',nombre), obtener_partidos('PP',nombre)from equipo
    order by 3 desc;    
end$$

drop function if exists obtener_partidos $$
create function obtener_partidos(tipo enum('PJ','PG','PE','PP'),_equipo char(15))
returns decimal (3,0)
READs sql data
begin
	declare resultado decimal(3,0) default 0;
	case tipo
		when 'PJ' then 
			select count(*) into resultado from aux_partido where 
            (nombreEquipoLocal=_equipo or nombreEquipoVisitante=_equipo )
					and goles_local is not null and goles_visitante is not null;        
        when 'PG' then 
			select count(*) into resultado from aux_partido 
					where (nombreEquipoLocal=_equipo and goles_local > goles_visitante) or
                    (nombreEquipoVisitante=_equipo and goles_local < goles_visitante);        
        when 'PE' then 
			select count(*) into resultado from aux_partido 
					where (nombreEquipoLocal=_equipo and goles_local = goles_visitante) or
                    (nombreEquipoVisitante=_equipo and goles_local = goles_visitante);        
        when 'PP' then 
			select count(*) into resultado from aux_partido 
					where (nombreEquipoLocal=_equipo and goles_local < goles_visitante) or
                    (nombreEquipoVisitante=_equipo and goles_local > goles_visitante);        
        
	end case;
    return resultado;
end $$

delimiter ;

select obtener_partidos('PP','Mosquitos');
call actualizar_calificacion();

/*

(select sum(ifnull(goles_local,0)) from aux_partido where nombreEquipoLocal = 'Antrax') +
(select sum(ifnull(goles_visitante,0)) from aux_partido where nombreEquipoVisitante = 'Antrax');*/
