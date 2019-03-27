delimiter //
drop procedure if exists rellenar_tabla_aux //

create procedure rellenar_tabla_aux()
begin
	/*
    1- comprobar si la tabla existe- SI NO --> llamamos al procedimiento que la crea 
    2- volcamos los datos de la tabla partido en la tabla auxiliar.
    */
    declare continue HANDLER for 1146
		call generar_tabla_aux();
	declare exit HANDLER for SQLEXCEPTION
		select 'Error al insertar los datos';
       
	INSERT INTO aux_partido (`nombreEquipoLocal`,
		`nombreEquipoVisitante`,
		`fecEncuentro`,
		`goles_local`,
		`goles_visitante`)
    select `nombreEquipoLocal`,
		`nombreEquipoVisitante`,
		`fecEncuentro`,
	    left(resultado,locate('-',resultado)-1),
        right(resultado,length(resultado)-locate('-',resultado))
        from partido;
end //
delimiter ;

call rellenar_tabla_aux();

