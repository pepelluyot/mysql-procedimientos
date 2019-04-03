/*
Crear un procedimiento llamado crear_tabla_aux_partido de forma que copie 
la tabla partido con el nombre de aux_partido, 
elimine la columna resultado y añada dos columnas nuevas, goles_local y goles_visitante.
*/

use torneofutbol;
delimiter $$
drop procedure if exists crear_tabla_aux_partido $$
create procedure crear_tabla_aux_partido()
begin
	drop table if exists aux_partido;
    create table aux_partido like partido;
    
    alter table aux_partido
    add column (goles_local decimal(2,0) default 0, goles_visitante decimal(2,0) default 0);
    
    alter table aux_partido
    drop column resultado;
    
-- NOTA: hemos creado la tabla sin añadir claves ajenas, en el siguiente ejemplo Sí creamos las claves ajenas.

end$$

-- otra forma

drop procedure if exists crear_tabla_aux_partido $$
create procedure crear_tabla_aux_partido()
begin
	declare exit handler for 1050 -- controlamos el error mostrando un warning por consola.
    SIGNAL SQLSTATE '01000' SET MESSAGE_TEXT = 'La tabla "aux_partido" ya estaba creada en la BD';
		-- select "la tabla ya existe";
	-- drop table if exists aux_partido;
    create table aux_partido (
		nombreEquipoLocal char(15), 
        nombreEquipoVisitante char(15), 
        fecEncuentro DATE, 
        goles_local decimal(2,0) default 0,
        goles_visitante decimal(2,0) default 0,
        PRIMARY KEY (nombreEquipoLocal, nombreEquipoVisitante),
        Foreign key (nombreEquipoLocal) references equipo (nombre),
        Foreign key (nombreEquipoVisitante) references equipo (nombre)
 	);
    
end$$

delimiter ;

call crear_tabla_aux_partido();

show warnings;
