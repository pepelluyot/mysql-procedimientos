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
delimiter ;

call actualizar_calificacion();