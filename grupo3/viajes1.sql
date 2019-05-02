/*
Crear una función llamada paradas_crucero que tome como parámetro la referencia 
de un crucero y devuelva el número total de paradas que tiene.
*/
delimiter //
drop function if exists paradas_crucero //
create function paradas_crucero(_ref char(7))
returns INT UNSIGNED
deterministic
begin
	declare num_paradas INT UNSIGNED;
    select count(*) into num_paradas from recorrido where referencia = _ref;
	return num_paradas;
end //

delimiter ;

select paradas_crucero('CC-112'); -- 0
select paradas_crucero('CC-885'); -- 6
select paradas_crucero('ZZZZZ'); -- 0 inventado

select referencia, paradas_crucero(referencia) 'num_paradas' from crucero;