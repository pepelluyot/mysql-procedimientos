use torneofutbol;
delimiter $$

drop procedure if exists crear_tabla_aux_partido2 $$
create procedure crear_tabla_aux_partido2()
begin

    drop table if exists aux_partido;
    create table aux_partido as
    select nombreEquipoLocal, nombreEquipoVisitante, fecEncuentro, 
    left(resultado, locate ('-',resultado)-1)  as 'goles_local',
	right(resultado,length(resultado) - locate ('-',resultado)) as 'goles_visitante'
    from partido;
    
    
end$$
delimiter ;

call crear_tabla_aux_partido2();
