drop procedure if exists ejemplo14_sp;
delimiter //
create procedure ejemplo14_sp(_num INT UNSIGNED)
begin
	declare v_numero INT UNSIGNED;
    set v_numero =_num;
	bucle: LOOP
		if v_numero = 0 then
			leave bucle;
        end if;
		select v_numero;
        set v_numero = v_numero - 1;
    
    end LOOP bucle;
end//
delimiter ;

call ejemplo14_sp(5);