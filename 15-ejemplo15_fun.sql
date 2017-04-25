/* ejemplo de funciones */
drop function if exists ejemplo15;
delimiter //
create function ejemplo15 (_euros numeric(10,2))
	returns numeric(10,2)
begin
	return (_euros * 166.386);
end //
delimiter ;

select nombre, ejemplo15(precio) 'pesetas' from articulos
order by nombre;

set @valor = ejemplo15(123);
select @valor;