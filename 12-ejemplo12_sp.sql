use BD06;
drop procedure if exists ejemplo12;

delimiter $$
create procedure ejemplo12()
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

call ejemplo12();