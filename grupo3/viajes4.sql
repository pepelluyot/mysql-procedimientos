/*
Crear una función num_paradas_crucero_verificar que le pasemos 
la referencia de un crucero y devuelve en número de paradas. 
Hay que comprobar que todas las paradas del crucero están dadas 
de alta en la BD. Si no sigue una secuencia correlativa hay que devolver el valor -1.
*/
delimiter //
drop function if exists num_paradas_crucero_verificar //
create function num_paradas_crucero_verificar(_ref char(7))
returns INT
deterministic
begin

	declare num_paradas INT UNSIGNED;
    declare contador INT DEFAULT 1;
    select count(*) into num_paradas from recorrido where referencia = _ref;
 
 
	cuenta: WHILE contador <= num_paradas DO
		if not exists(select referencia from recorrido where referencia= _ref and num_parada = contador) then
			return -1;
		end if;
        set contador = contador + 1 ;
	END WHILE cuenta;

	return num_paradas;
end //

delimiter ;

select num_paradas_crucero_verificar('CC-885');

