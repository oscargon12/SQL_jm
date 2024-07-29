-- Intro a los JOINS

-- Permiten combinar columnas de tablas distintas
-- INNER join: solo las columnas que tengan en comun dos tablas
-- LEFT join: solo las de la izquiera completa, más las que coincidan de la derecha
-- RIGHT join: solo las de la derecha completa, más las que coincidan de la izquierda

-- Primero creo as tablas que van a ser referenciadas
CREATE TABLE armaduras (
	armadura_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    armadura VARCHAR(30) NOT NULL
);

CREATE TABLE signos (
	signo_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    signo VARCHAR(30) NOT NULL
);

CREATE TABLE rangos (
	rango_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    rango VARCHAR(30) NOT NULL
);

CREATE TABLE ejercitos (
	ejercito_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ejercito VARCHAR(30) NOT NULL
);

CREATE TABLE paises (
	pais_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    pais VARCHAR(30) NOT NULL
);

-- Luego creo la tabla que va a llamar a las demás
CREATE TABLE caballeros (
	caballero_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(30),
	armadura INT UNSIGNED, -- todos los que vengan de tablas son enteros
	rango INT UNSIGNED,
	signo INT UNSIGNED,
	ejercito INT UNSIGNED,
	pais INT UNSIGNED,
    -- llaves foraneas referenciadas
    FOREIGN KEY(armadura) REFERENCES armaduras(armadura_id),
    -- nombre columna referencia de la tabla Armaduras en la columna(armadura_id)
    FOREIGN KEY(signo) REFERENCES signos(signo_id),
    FOREIGN KEY(rango) REFERENCES rangos(rango_id),
    FOREIGN KEY(ejercito) REFERENCES ejercitos(ejercito_id),
    FOREIGN KEY(pais) REFERENCES paises(pais_id)
);

SHOW TABLES;    

INSERT INTO rangos VALUES
	(1, 'Oro'),
    (2, 'Plata'),
    (3, 'Bronce'),
    (4, 'Marino'),
    (5, 'Espectro');

INSERT INTO paises VALUES
	(6, 'Francia'),
    (7, 'Inglaterra');
    
    
INSERT INTO caballeros VALUES
	(1, 'Seiya', 1, 3, 9, 1, 1),
    (2, 'Shiryu', 2, 3, 7, 1, 1),
    (3, 'Hyoga', 3, 3, 11, 1, 4),
    (4, 'Ikki', 4, 3, 5, 1, 1),
    (5, 'Camus', 5, 1, 11, 1, 6),
    (6, 'Saga', 6, 1, 3, 1, 2),
    (7, 'Kanon', 7, 4, 3, 2, 2),
    (8, 'Kagaho', 8, 5, 5, 4, 4);
    

SELECT * FROM caballeros AS c	-- c es el alias de caballeros
	LEFT JOIN signos AS s		-- Tabla izquierda caballeros y un item de la de signos con alias s
    ON c.signo = s.signo_id;	-- donde caballeros.signo (ejem: 1) == signos.signo_id (ejem: 1)
    
-- SELECT * FROM caballeros AS c
	-- LEFT JOIN signos AS s
    -- ON c.signo = s.signo_id
-- UNION

-- Reemplazar iDs por valores
SELECT c.caballero_id, c.nombre, a.armadura, r.rango, s.signo, e.ejercito, p.pais
	FROM caballeros AS c
    INNER JOIN armaduras AS a	ON c.armadura = a.armadura_id
	INNER JOIN rangos AS r		ON c.rango = r.rango_id
    INNER JOIN signos AS s		ON c.signo = s.signo_id
    INNER JOIN ejercitos AS e	ON c.ejercito = e.ejercito_id
    INNER JOIN paises AS p		ON c.pais = p.pais_id;
    
    
-- Subconsultas
SELECT signo,
(SELECT COUNT(*) FROM caballeros c WHERE c.signo = s.signo_id)
AS Total_caballeros
FROM signos s;


-- Vistas
-- Son tablas virtuales que se arman con otras listas existentes
CREATE VIEW vista_caballeros AS 
	SELECT c.caballero_id, c.nombre, a.armadura, r.rango, s.signo, e.ejercito, p.pais
		FROM caballeros AS c
		INNER JOIN armaduras AS a	ON c.armadura = a.armadura_id
		INNER JOIN rangos AS r		ON c.rango = r.rango_id
		INNER JOIN signos AS s		ON c.signo = s.signo_id
		INNER JOIN ejercitos AS e	ON c.ejercito = e.ejercito_id
		INNER JOIN paises AS p		ON c.pais = p.pais_id;
        
SELECT * FROM vista_caballeros;

-- ----------------------------------------------------------------------------------------------

-- RESTRICCIONES Cascade
/*
4 tipos de restricciones para DELETE y UPDATE
	- CASCADE
	- SET NULL
    - SET DEFAULT
    - RESTRICT
La formula ganadora es: ON DELETE RESTRICT ON UPDATE CASCADE
*/
CREATE TABLE lenguajes (
	lenguaje_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Lenguaje VARCHAR(30) NOT NULL
);

INSERT INTO Lenguajes (lenguaje) VALUES
("JavaScript"),
("PHP"),
("Python"),
("Ruby"),
("JAVA");

CREATE TABLE frameworks (
	framework_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    framework VARCHAR(30) NOT NULL,
	lenguaje INT UNSIGNED,
    -- llave foranea lenguaje hace referencia a la columna de mi tabla lenguaje_id
	FOREIGN KEY (Lenguaje) REFERENCES lenguajes (lenguaje_id)
    -- Y establece las restricciones
    ON DELETE RESTRICT ON UPDATE CASCADE -- No dejar borar, pero si actualiza en cascada afectando a las referencias 👌
    -- también se puede establecer como null, pero lo mejor en DELETE es RESTRICT
    -- ON DELETE SET NULL ON UPDATE CASCADE
);

INSERT INTO frameworks (framework, lenguaje) VALUES
("React", 1),
("Angular", 1),
("Vue", 1),
("Svelte", 1),
("Laravel", 2),
("Symfony", 2),
("Flask", 3),
("Django", 3),
("On Rails", 4);

SELECT * FROM lenguajes;
SELECT * FROM frameworks;

SELECT f.framework_id, f.framework, l.lenguaje FROM frameworks AS F
	INNER JOIN lenguajes AS l	ON f.lenguaje = l.lenguaje_id;
    
DELETE FROM lenguajes WHERE lenguaje_id = 3;
-- podría ejecutar esto porque ellenguaje 3 (python) tiene dependencias de llave foránea
-- los lenguajes relacionales guardan la integridad de los datos

DROP TABLE lenguajes;
-- Tampoco podría borrar una tabla con dependencias

-- ----------------------------------------------------------------------------------------------

-- TRANSACCIONES
-- Permiten correr un grupo de sentencias y hacer rollback a la base de datos si alguna sentencia del grupo falla

START TRANSACTION;	-- Inicia la transacción
	-- Sentencias dentro de la transacción
	UPDATE frameworks SET framework = "Vue.js" WHERE framework_id = 3;
    DELETE FROM frameworks;
    INSERT INTO frameworks VALUES (0, "Spring", 5);
	-- fin de sentencias
ROLLBACK;	-- Descarta los cambios de la transacción
COMMIT;		-- Acepta los cambios de la transacción	

-- ----------------------------------------------------------------------------------------------

-- CLAUSULA LIMIT
-- Permite limitar la cantidad de registros que se consulta en un SELECT
SELECT * FROM frameworks;
SELECT * FROM frameworks LIMIT 2, 2; -- Esto muestra desde el 3 registro, dos registros
SELECT * FROM frameworks LIMIT 3, 3; -- Esto muestra desde el 4 registro, tres registros

-- ----------------------------------------------------------------------------------------------

-- ENCRIPTACIÓN
-- FUNCIONES encriptan caracteres en un hash
SELECT MD5('Mi_pa55word');
SELECT SHA1('Mi_pa55word');
SELECT SHA2('Mi_pa55word', 256); -- esta recibe un 2do parametro de bits

SELECT AES_ENCRYPT('Mi_pa55word', 'llave_secreta'); -- esta recibe un 2do parametro palabra secreta
SELECT AES_DECRYPT(nombre_campo, 'llave_secreta'); -- esta recibe un 2do parametro, columna donde se desencripta

-- práctica
CREATE TABLE pagos_recurrentes (
	cuenta VARCHAR(8) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
	tarjeta BLOB
);

SELECT * FROM pagos_recurrentes;

SELECT CAST(AES_DECRYPT(tarjeta, '12345678') AS CHAR) AS tdc, nombre
	FROM pagos_recurrentes;
-- Desencripta tarjeta con la llave '12345678', como CHAR con el combre de columna tdc

SELECT CAST(AES_DECRYPT(tarjeta, 'super_llave') AS CHAR) AS tdc, nombre
	FROM pagos_recurrentes;
    
INSERT INTO pagos_recurrentes VALUES
	('12345678', 'Jon Snow', AES_ENCRYPT('1234567890123456788', '12345678')),
    ('12345677', 'Daenerys', AES_ENCRYPT('1234567890123456777', '12345678')),
    ('12345676', 'Tyrion Lanister', AES_ENCRYPT('1234567890123456776', 'super_llave')),
    ('12345675', 'Ned Stark', AES_ENCRYPT('1234567890123456774', 'super_llave'));