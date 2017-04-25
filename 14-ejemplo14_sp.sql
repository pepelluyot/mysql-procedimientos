/* manejo de errores */
/* ejemplo con CONTINUE EXIT */

use BD06;
drop procedure if exists ejemplo14;
delimiter $$
create procedure ejemplo14(IN _num int)
MODIFIES SQL DATA
begin
		insert into articulos values(_num, concat('articulo',_num),100);
end $$
delimiter ;
call ejemplo14(2);

/* lo controlamos con errores */
drop procedure if exists ejemplo14;
delimiter $$
create procedure ejemplo14(IN _num int)
MODIFIES SQL DATA
begin
	DECLARE CONTINUE HANDLER FOR 1062
		SELECT CONCAT("el artículo ", _num, " ya existe en la base de datos") as 'aviso error';
        
		insert into articulos values(_num, concat('articulo',_num),100);
end $$
delimiter ;
call ejemplo14(2);
call ejemplo14(NULL);

drop procedure if exists ejemplo14;
delimiter $$
create procedure ejemplo14(IN _num int)
MODIFIES SQL DATA
begin
	DECLARE CONTINUE HANDLER FOR 1062
		SELECT CONCAT("el artículo ", _num, " ya existe en la base de datos") as 'aviso error';
	DECLARE CONTINUE HANDLER FOR 1048
		SELECT CONCAT("el número del artículo no puede ser nulo") as 'aviso error';
        
		insert into articulos values(_num, concat('articulo',_num),100);
end $$
delimiter ;
call ejemplo14(NULL);

-- podriamos haber puesto 
/*DECLARE CONTINUE o EXIT HANDLER FOR SQLEXCEPTION 
BEGIN
	rollback;
	select 'ocurrio un error';
END;*/ 