/*Crear un procedimiento (​ ejemplo14_sp.sql​ ) que pasándole un número, inserte en la tabla de artículos el artículo con clave el número p, controlar los errores de clave duplicada y error al insertar null como clave.*/

/* manejo de errores */
/* ejemplo con CONTINUE EXIT */
CREATE TABLE `BD06grupoB`.`articulos` (
  `idArticulo` INT NOT NULL,
  `articulo` VARCHAR(45) NOT NULL,
  `precio` DECIMAL(6,2) NULL DEFAULT 0,
  PRIMARY KEY (`idArticulo`));


drop procedure if exists ejemplo14_sp;
delimiter $$
create procedure ejemplo14_sp(IN _num int)
begin
		insert into articulos values(_num, concat('articulo',_num),100);
end $$
delimiter ;
call ejemplo14_sp(2);

/* lo controlamos con errores */
drop procedure if exists ejemplo14_sp2;
delimiter $$
create procedure ejemplo14_sp2(IN _num int)
MODIFIES SQL DATA
begin
	DECLARE CONTINUE HANDLER FOR 1062
		SELECT CONCAT("el artículo ", _num, " ya existe en la base de datos") as 'aviso error';
        
		insert into articulos values(_num, concat('articulo',_num),100);
end $$
delimiter ;
call ejemplo14_sp2(2);
call ejemplo14_sp2(NULL);

drop procedure if exists ejemplo14_sp3;
delimiter $$
create procedure ejemplo14_sp3(IN _num int)
MODIFIES SQL DATA
begin
	DECLARE CONTINUE HANDLER FOR 1062
		SELECT CONCAT("el artículo ", _num, " ya existe en la base de datos") as 'aviso error';
	DECLARE CONTINUE HANDLER FOR 1048
		SELECT CONCAT("el número del artículo no puede ser nulo") as 'aviso error';
        
		insert into articulos values(_num, concat('articulo',_num),100);
end $$
delimiter ;
call ejemplo14_sp3(NULL);

-- podriamos haber puesto 
/*DECLARE CONTINUE o EXIT HANDLER FOR SQLEXCEPTION 
BEGIN
	rollback;
	select 'ocurrio un error';
END;*/ 
