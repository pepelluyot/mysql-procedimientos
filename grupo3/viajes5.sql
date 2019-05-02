/*
Crear un trigger llamado insertar_puerto que cuando se inserte
 un puerto compruebe si existe el nombre y país del puerto insertado. 
 En tal caso no realizar la inserción.

*/
delimiter //
drop trigger if exists insertar_puerto //
create trigger insertar_puerto BEFORE INSERT  ON puerto
FOR EACH ROW
begin
	declare num INT;
    set num = (select count(*) from puerto where nombre= new.nombre and pais = new.pais) ;
    
    if num=0 then
	 SIGNAL SQLSTATE '45000' set message_text = 'Existe un puerto con esos datos';
    end if;
    
	
end //

delimiter ;



