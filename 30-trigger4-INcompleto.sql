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
  
/* generamos una función para que nos elimine las tildes de una cadena */


