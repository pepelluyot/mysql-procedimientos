/* EJEMPLO CON BLOQUES, ámbito de las variables
si definimos una variable dentro de un bloque, este la reconoce
pero no fuera de el
*/
drop procedure if exists ejemplo2_18;
delimiter $$
create procedure ejemplo2_18()
begin
	
    
    mibloque: begin
		declare _nuevoTexto varchar(5) default 'esto es una prueba';
		
        select _nuevoTexto;
    end mibloque;
    select _nuevoTexto; -- no existe
end $$
delimiter ;

call ejemplo2_18();