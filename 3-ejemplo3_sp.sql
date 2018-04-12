/*
Crea un procedimiento (​ ejemplo3_sp.sql​ ) donde se declaren dos variables internas, una de tipo char y otra de tipo enum.
Dentro del procedimiento, modificar el valor de la variables y mostrar el resultado. Provocar diferentes errores al asignar valores no permitidos a las variables
*/ use BD06;
delimiter $$
drop procedure if exists ejemplo3_sp $$
create procedure ejemplo3_sp()
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
call ejemplo3_sp;

