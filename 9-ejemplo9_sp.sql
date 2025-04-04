/*Crea un procedimiento (​ ejemplo9_sp.sql​ ) que compruebe si un usuario existe o no en la base de datos. Mostrar un mensaje en forma de select.*/
use BD06;


-- Paso 1: Crear la tabla con el password encriptado
DROP TABLE IF EXISTS usuarios;
CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(64) NOT NULL -- para SHA2 256
);
-- Paso 2: Insertar usuarios con SHA2
INSERT INTO usuarios (usuario, password)
VALUES ('pepe', SHA2('1234', 256)),
       ('ana', SHA2('hola123', 256));

-- paso 3:
drop procedure if exists ejemplo9_sp;
delimiter $$
CREATE PROCEDURE ejemplo9_sp(
    IN _usuario VARCHAR(50)
)
BEGIN
    DECLARE num INT DEFAULT 0;

    SELECT COUNT(*) INTO num
    FROM usuarios
    WHERE usuario = _usuario;

    IF num = 1 THEN
        SELECT '✅ Usuario existente' AS Mensaje;
    ELSE
        SELECT '❌ Usuario incorrecto' AS Mensaje;
    END IF;
END $$
delimiter ;

CALL ejemplo9_sp('pepe');     -- ✅
CALL ejemplo9_sp('ana');   -- ✅
CALL ejemplo9_sp('juan');   -- ❌
