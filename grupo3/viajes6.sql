/* 6- Crear un procedimiento en el que le pasemos un cantidad de euros (precio) y un país,
el procedimiento debe mostrar los cruceros que cuestan ese precio o menos
de ese país (que partan de un puerto de ese país).
Si no existiesen cruceros de ese país (que partan de u puerto de ese país),
mostrar los precios de todos los cruceros (menores o iguales del precio indicado)....uff
*/
delimiter $$
DROP PROCEDURE IF EXISTS listado_cruceros  $$
CREATE PROCEDURE listado_cruceros(_precio DECIMAL(6,2), v_pais VARCHAR(25))
BEGIN
    declare num_cruceros INT default 0;
    
    /*SELECT referencia, precio  FROM crucero WHERE precio <= _precio
	AND referencia IN (
	SELECT referencia FROM recorrido, puerto WHERE num_parada = 1 AND
 	pais = v_pais AND cod_puerto = codigo)
 	;*/
 	-- deberíamos comprobar que si no devuelve ningún valor, no debemos filtrar por país
 	-- contamos si hay cruceros que partan de ese país
 	select count(referencia) into num_cruceros  from puerto  INNER JOIN recorrido on puerto.codigo=recorrido.cod_puerto where
    num_parada = 1 and pais=v_pais ;
	if num_cruceros>0 then
   	 SELECT referencia, precio  FROM crucero WHERE precio <= _precio
   	 AND referencia IN (
   	 SELECT referencia  FROM recorrido, puerto WHERE num_parada = 1 AND
   	  pais = v_pais AND cod_puerto = codigo)
   	  ;
    
	else
   	 select referencia 'referencia (crucero no parte del país)', precio
     from crucero WHERE precio <= _precio;
	end if;
	 
END $$
delimiter ;
CALL listado_cruceros(1000,'España');
