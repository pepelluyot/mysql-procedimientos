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
    
end$$

delimiter ;

call crear_tabla_aux_partido2();