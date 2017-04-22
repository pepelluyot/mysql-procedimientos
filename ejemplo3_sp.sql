use BD06;
delimiter $$
drop procedure if exists ejemplo3 $$
create procedure ejemplo3()
begin
	declare v_caracter1 char(1);
    declare forma_pago enum('metálico', 'tarjeta', 'transferencia');
    
   --  set v_caracter1 = 'hola'; -- error tamaño
    set forma_pago = 1; -- metálico
    -- set forma_pago = 'cheque'; -- error no existe
    -- set forma_pago = 4; -- error no existe
    set forma_pago = 'TARJETA';
    
    
    
    select forma_pago;
    
end $$

delimiter ;
call ejemplo3;

