/*
Crear un trigger llamado insertar_puerto que cuando se inserte
 un puerto compruebe si existe el nombre y país del puerto insertado. 
 En tal caso no realizar la inserción.

*/
delimiter //
drop procedure if exists prueba_cursor //
create procedure prueba_cursor(v_precio decimal(6,2))
begin
		
		declare v_ref char(7);
        declare v_com varchar(35);
        declare v_prec decimal(6,2);
        declare mi_cont INT default 1;
        declare salir BOOLEAN default 0;
        
        declare mi_cursor cursor for
			select referencia, compañia, precio from crucero where precio <= v_precio;
		declare continue handler for not found
			set salir=1;
            
		OPEN mi_cursor;
        
		mi_loop: LOOP
            fetch mi_cursor into v_ref, v_com, v_prec;
            
            if salir=1 then
				leave mi_loop;
			end if;
            
            select mi_cont, v_ref, v_com, v_prec;
            set mi_cont = mi_cont +1;
            
		END LOOP mi_loop;
        select "fuera del loop";
        CLOSE mi_cursor;
end //

delimiter ;

 call prueba_cursor(1000);


