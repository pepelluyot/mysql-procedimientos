/*Crea un procedimiento (​ ejemplo9_sp.sql​ ) que compruebe si un usuario existe o no en la base de datos. Mostrar un mensaje en forma de select.*/
use BD06;
drop procedure if exists ejemplo9_sp;
delimiter $$
create procedure ejemplo9_sp(IN _usuario varchar(10))
begin
	declare num INT default 0;
	-- comprobamos si existe el usuario
    select count(*) into num from usuarios where usuario = _usuario;
    IF num = 1 THEN -- usuario existe
		select 'usuario existe' as 'Mensaje';
    ELSE -- usuario no existe 
		select 'usuario NO existe' as 'Mensaje';
	END IF;
end $$
delimiter ;

call ejemplo9_sp('pepe');
call ejemplo9_sp('rosalía');
