delimiter //
drop procedure if exists generar_tabla_aux //

create procedure generar_tabla_aux()
begin
	drop table if exists aux_partido;
		
	create table aux_partido like partido;
    alter table aux_partido
    drop column resultado,
    add goles_local numeric (2,0) default NULL,
    add goles_visitante numeric (2,0) default NULL;
    

end //
delimiter ;

call generar_tabla_aux;