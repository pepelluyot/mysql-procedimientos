/* EJEMPLO CON BLOQUES, ámbito de las variables
si definimos una variable dentro de un bloque, este la reconoce
pero no fuera de el.

Si declaramos una variable tanto fuera del bloque como dentro se
comportan como variables distintas.
*/
drop procedure if exists ejemplo2_18;
delimiter $$
create procedure ejemplo2_18()
begin
	declare _datos char(1) default 'A';
    
    mibloque: begin
		declare _nuevoTexto varchar(35) default 'esto es una prueba';
		declare _datos char(1) default 'B';	
        select _nuevoTexto, _datos;
    end mibloque;
    select _datos; -- muestra el valor inicial
	select _nuevoTexto; -- no existe y genera un error 1054
    
end $$
delimiter ;

call ejemplo2_18();