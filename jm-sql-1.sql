SHOW DATABASES;
CREATE DATABASE IF NOT EXISTS jm_curso_sql;
CREATE USER 'oscar.gonzalez'@'localhost' IDENTIFIED BY 'qwerty';
GRANT ALL PRIVILEGES ON jm_curso_sql TO 'oscar.gonzalez'@'localhost';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'oscar.gonzalez'@'localhost';
REVOKE ALL, GRANT OPTION FROM 'oscar.gonzalez'@'localhost';
DROP USER 'oscar.gonzalez'@'localhost';

USE jm_curso_sql;
SHOW TABLES;
CREATE TABLE usuarios(
	nombre VARCHAR(50),
    correo VARCHAR(40)
);

ALTER TABLE usuarios ADD COLUMN cumpleaños VARCHAR(50);   -- adiciona una columna a una tabla existente
SELECT * FROM usuarios;

ALTER TABLE usuarios MODIFY cumpleaños DATE;
ALTER TABLE usuarios RENAME COLUMN cumpleaños TO Nacimiento;
ALTER TABLE usuarios DROP COLUMN Nacimiento;
DROP TABLE IF EXISTS usuarios;

CREATE TABLE usuarios(
	usuario_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    apellidos VARCHAR(30) NOT NULL,
    correo VARCHAR(50) UNIQUE,
    direccion VARCHAR(100) DEFAULT "Sin direccion",
    edad INT DEFAULT 0
);

DESCRIBE usuarios; -- Muestra las propiedades de la tabla

INSERT INTO usuarios
VALUES (0, 'Oscar', 'Gonzalez', 'osc@mail.com', 'Cll 72' , 0 );

-- Es mejor insertar así
INSERT INTO usuarios (nombre, apellidos, edad)
VALUES ('Santi', 'Gonzalez', 1);

-- Multiples inserciones
INSERT INTO usuarios (nombre, apellidos, correo, edad) VALUES
('jon', 'Snow', 'js@got.com', 17),
('ned', 'Stark', 'ns@got.com', 40),
('Danny', 'Targaryen', 'dt@got.com', 18); -- finalizo con ;

SELECT nombre, edad, usuario_id FROM usuarios;

SELECT COUNT(*) AS Total_Usuarios FROM usuarios; -- conteo de registros, AS es un alias

-- Condicional WHERE
SELECT * FROM usuarios WHERE nombre = 'jon';

-- Multiples registros
SELECT * FROM usuarios WHERE nombre IN ('jon', 'ned');
	
-- coincidencias like
SELECT * FROM usuarios WHERE apellidos LIKE 'G%'; -- apellidos que inicien con 'G'
SELECT * FROM usuarios WHERE correo LIKE '%got.com';  -- correos que terminen en 'got.com'
SELECT * FROM usuarios WHERE apellidos LIKE '%tar%'; -- apellidos que contengan los caracteres 'tar'

-- coincidencias not like
SELECT * FROM usuarios WHERE apellidos NOT LIKE 'G%'; -- apellidos que NO inicien con 'G'
SELECT * FROM usuarios WHERE correo NOT LIKE '%got.com';  -- correos que NO terminen en 'got.com'
SELECT * FROM usuarios WHERE apellidos NOT LIKE '%tar%'; -- apellidos que NO contengan los caracteres 'tar'

-- Operadores relacionales
SELECT * FROM usuarios WHERE edad != 17;
SELECT * FROM usuarios WHERE edad <> 17;

SELECT * FROM usuarios WHERE edad = 17;

SELECT * FROM usuarios WHERE edad > 17;

SELECT * FROM usuarios WHERE edad < 17;

SELECT * FROM usuarios WHERE edad <= 17;

-- Operadores lógicos
SELECT * FROM usuarios WHERE NOT direccion = 'Sin direccion';
SELECT * FROM usuarios WHERE direccion = 'Sin direccion' AND edad > 30;

SELECT * FROM usuarios WHERE direccion != 'Sin direccion' OR edad > 30;

-- UDATE
UPDATE usuarios SET direccion = 'Clle 123', correo = 'se@mail.com'
WHERE usuario_id = 2;

-- TRUNCATE
TRUNCATE TABLE usuarios; -- resetea la tabla y deja los ids en cero



