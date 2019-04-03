/* creamos una nueva tabla*/
drop table if exists usuarios;
CREATE TABLE `usuarios` (
  `idPersona` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL COMMENT '	',
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NOT NULL,
  `usuario` CHAR(10) NULL DEFAULT NULL,
  `dni` CHAR(9) NOT NULL,
  `passwd` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idPersona`));
  
  
  
  /* creamos un trigger para cuando insertemos un nuevo usuario*/
  drop trigger if exists validar_usuario;
  drop function if exists comprobar_dni;
  drop function if exists eliminar_acentos;
  delimiter &&
  
  
  /* generamos una función que compruebe si un dni es correcto */
  create function comprobar_dni(_dni char(9))
  returns Boolean 
  begin
	-- verificamos que los 8 primeros dígitos son números y el último una letraz
    declare _resultado Boolean default FALSE;
    set _resultado = (select _dni regexp '^[0-9]{8}[A-Z]');
    return _resultado;
  end &&
  
  /* generamos una función para que nos elimine las tildes de una cadena */
  create function eliminar_acentos(_texto varchar(100))
  returns varchar(100)
  begin
    declare v_texto varchar(100) default NULL;
    set v_texto = replace(_texto,'á','a');
    set v_texto = replace(v_texto,'é','e');
    set v_texto = replace(v_texto,'í','i');
    set v_texto = replace(v_texto,'ó','o');
    set v_texto = replace(v_texto,'ú','u');
    set v_texto = replace(v_texto,'ñ','n');
    
    return v_texto ;
  end &&
  
  create trigger validar_usuario
  before insert on usuarios 
  for each row
  begin
    declare v_mensaje varchar(50) default NULL;
    declare v_usuario char(100) default NULL;
    /* comprobamos el dni*/
	if comprobar_dni(new.dni)=FALSE then
	-- salimos, generamos una excepción
		set v_mensaje = "El formato del dni es incorrecto";
        signal sqlstate '45000' set message_text = v_mensaje;-- lanzar exepción
	end if;
    
    /* generamos el nombre de usuario */
    set v_usuario = lcase(concat(left(new.nombre,1), left(new.apellido1,3), left(new.apellido2,3), substring(new.dni, 6,3)));
     set v_usuario = eliminar_acentos(v_usuario);
    set new.usuario = v_usuario;
    
    /* ponemos por defecto el password a 'changeme'*/
    set new.passwd = md5('changeme');
    
  end &&
  delimiter ;
  
  
