set @mivariable = 'lo que sea'; -- variable definida por el usuario

use BD06;
select 'ejemplo' into @mivariable;
 -- select @mivariable as id, nombre from tabla;
 -- select id into @mivariable, nombre from tabla;

select @mivariable;



DELIMITER $$

DROP procedure if exists ejemplo5 $$
create procedure ejemplo5()
begin
	set @mivariable = @mivariable * 2;
    select @mivariable;
end $$
delimiter ;


call ejemplo5();

set @mivariable = 2;
select @mivariable;