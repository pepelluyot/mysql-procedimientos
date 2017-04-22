/* creamos una tabla usuarios e introducimos algunos datos, vamos a aprovechar la creación de un procedimiento 
para insertar datos */
use BD06;
/*DROP TABLE if exists usuarios;

CREATE TABLE usuarios (
	usuario varchar(15) primary key,
    passwd varchar(15) NOT NULL
);

INSERT INTO usuarios values
( 'pepe', '1234'), ( 'juan', '1234') , ('ana', '1111');

 ejemplos con parametros de entrada IN */
DELIMITER $$
DROP procedure if exists ejemplo6 $$
create procedure ejemplo6(IN v_usuario varchar(15), IN v_password varchar(15))
begin
/*
paso de
parámetros por valor, es decir, el procedimiento almacenado trabaja con una
“copia” del parámetro que recibe y por tanto no modifica nada el valor del
parámetro que se le pasa al programa almacenado
*/
	INSERT INTO usuarios values ( v_usuario, v_password);
    
    select * from usuarios;
    
    set v_usuario = 'pepe';
    
end $$
delimiter ;

-- call ejemplo6('manuela','11111');

set @nom='lolo', @clave='juan';

call ejemplo6(@nom,@clave);

select @nom;