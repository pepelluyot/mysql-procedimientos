/*
Crear un procedimiento llamado cruceros_puerto_salida de forma 
que le pasemos como parámetro un el nombre de un puerto y muestre la referencia, 
compañía y el precio de todos los cruceros que partan de ese puerto 
(que partan de ese puerto quiere decir que en el recorrido, 
el número de parada de ese puerto es el primero)*/
delimiter //
drop procedure if exists cruceros_puerto_salida //
create procedure cruceros_puerto_salida(IN v_nombre_puerto varchar(35))
begin
	select referencia, compañia, precio
    from crucero JOIN recorrido USING (referencia)
		JOIN puerto ON recorrido.cod_puerto = puerto.codigo
	WHERE puerto.nombre = v_nombre_puerto
		AND num_parada = 1;
        
     
   /* DECLARE v_cod_puerto TINYINT;
	SET v_cod_puerto = (SELECT codigo FROM puerto WHERE nombre = _nombre_puerto);
	-- que un crucer parta de ese puerto significa que es su parada número 1
    
   -- hay que mostras ref, compañía y precio
   SELECT referencia, compañia, precio
   	 FROM crucero WHERE referencia IN (SELECT referencia
   								 FROM recorrido
   								 WHERE cod_puerto = v_cod_puerto
                                	AND num_parada = 1);
 */   
end //

delimiter ;

call cruceros_puerto_salida ('Barcelona');
call cruceros_puerto_salida ('Sevilla');