/* 
Crea un procedimiento (​ ejemplo12_sp.sql​ ) que borre si existe la tabla artículos. Si no existe debe crearla e insertar 10 artículos haciendo uso de un buce WHILE...DO*/
use BD06;
drop procedure if exists ejemplo12_sp;

delimiter $$
create procedure ejemplo12_sp()
begin
	declare i tinyint unsigned default 1;
	-- creamos una tabla nueva e insertamos algunos articulos
	drop table if exists articulos;
	create table articulos (
		id_articulo INT not null primary key,
		nombre varchar (15) not null,
		precio int NULL
	);
    -- usamos WHILE para ver como funciona
    WHILE (i<10) DO
		insert into articulos values (i, concat('articulo', i), 100 * i);
        set i = i + 1;
    end while;
end $$
delimiter ;

call ejemplo12_sp();
