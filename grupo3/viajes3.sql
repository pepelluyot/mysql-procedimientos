/*
crear un procedimiento num_cruceros_puerto que le pasemos
 el nombre de un puerto y devuelva el número de cruceros diferentes que pasan por ese puerto,
 y en el caso de no existir devuelve el valor -1.
*/
delimiter //
drop procedure if exists num_cruceros_puerto //
create procedure num_cruceros_puerto(IN v_nombre_puerto varchar(35), OUT num_cruceros INT)
begin
	DECLARE v_cod_puerto TINYINT;
	SET v_cod_puerto = (SELECT codigo FROM puerto WHERE nombre = v_nombre_puerto);
	
    -- if v_cod_puerto IS NOT NULL then
    if isnull(v_cod_puerto) then
		set num_cruceros=-1;
	else 
		set num_cruceros= (select count(*) from recorrido where cod_puerto = v_cod_puerto);
    end if;
    
end //

delimiter ;

call num_cruceros_puerto('MaltaX',@num_cruceros);
select @num_cruceros;
