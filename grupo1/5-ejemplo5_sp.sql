/*Asignar cualquier valor a una variable definida por el usuario de distintas formas (mediante una select y mediante la clausula SET)
Crear un procedimiento (​ ejemplo5_sp.sql​ ) que modifique dicha variable, muestre el valor de dicha variable tanto dentro del procedimiento, como fuera de él.
*/

set @mivariable = 'lo que sea'; -- variable definida por el usuario

use BD06;
select 'ejemplo' into @mivariable;
 -- select @mivariable as id, nombre from tabla;
 -- select id into @mivariable, nombre from tabla;

select @mivariable;
DELIMITER $$

DROP procedure if exists ejemplo5_sp $$
create procedure ejemplo5_sp()
begin
	set @mivariable = @mivariable * 2;
    select @mivariable;
end $$
delimiter ;

call ejemplo5_sp();
set @mivariable = 2;
select @mivariable;
