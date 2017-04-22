use BD06;
delimiter $$
drop procedure if exists ejemplo4 $$
create procedure ejemplo4()
begin
	declare v_entero_1, v_entero_2, v_entero_3 INT default 0;
    declare fecha1, fecha2 date default current_date;
    set fecha1 = '2008/10/30';
    set fecha2 = fecha1 + 1, fecha1 = '2006-10-02';
    
    
    
    
    select v_entero_1, fecha1, fecha2;
    
end $$

delimiter ;
call ejemplo4;

