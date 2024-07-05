-- CREATE DATABASE curso_sql_jm2;
-- DROP DATABASE curso_sql_jm2;
USE jm_curso_sql;

SHOW TABLES;

CREATE TABLE users(
	usuario_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    apellidos VARCHAR(30) NOT NULL,
    correo VARCHAR(50) UNIQUE,
    edad INT DEFAULT 0
);

INSERT INTO users (nombre, apellidos, correo, edad) VALUES
	('Santi', 'Gonzalez', 'sg@mail.com', 1),
    ('Marce', 'Nieto', 'mn@mail.com', 3),
    ('jon', 'Snow', 'js@got.com', 17),
	('ned', 'Stark', 'ns@got.com', 40),
	('Danny', 'Targaryen', 'dt@got.com', 18);
    
CREATE TABLE productos (
	producto_id  INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(50),
    precio DECIMAL(7, 2),
    cantidad INT UNSIGNED
);

INSERT INTO productos (nombre, descripcion, precio, cantidad) VALUES
	("Laptop", "Lenovo thinkpad", 29999.99, 5),
    ("Telefono", "Nothing phone", 11999.99, 15),
    ("Camara web", "Logitech C920", 1500, 12),
    ("Microfono", "Blue Yeti", 2500, 19),
    ("Audifonos", "Bose", 6500, 10);
    
SELECT * FROM users;
SELECT * FROM productos;

TRUNCATE TABLE users;
TRUNCATE TABLE productos;

-- Operaciones básicas
SELECT 6 + 5 AS Calculo_Sum;
SELECT 6 - 5 AS Calculo_Res;
SELECT 6 * 5 AS Calculo_Mul;
SELECT 6 / 5 AS Calculo_Div;
SELECT MOD(4,2); -- 0
SELECT MOD(73,5); -- 3

-- Funciones matemáticas
SELECT CEILING(7.1); -- 8
SELECT FLOOR(7.9); -- 7
SELECT ROUND(7.49999); -- 7
SELECT POWER(2, 6); -- 2 a la 6ta potencia 64
SELECT SQRT(81); -- 9

-- Columnas calculados
SELECT nombre, precio, cantidad, (precio * cantidad) AS Ganancia FROM productos;

-- Funciones de agrupamiento
SELECT MAX(precio) AS precio_maximo FROM productos; -- 29999.99
SELECT MIN(precio) AS precio_minimo FROM productos; -- 1500.00
SELECT SUM(cantidad) AS stock FROM productos; -- 61
SELECT AVG(precio) AS promedio_precios FROM productos; -- 10499.99600
SELECT COUNT(*) AS productos_total FROM productos; -- 5 (Cuenta cuantos hay y ponle un nombre a la cuenta)

SELECT nombre, precio, MAX(precio) AS precio_maximo FROM productos GROUP BY precio, nombre;

-- ---------------------------------------------------

CREATE TABLE caballeros (
	caballero_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(30),
	armadura VARCHAR(30),
	rango VARCHAR(30),
	signo VARCHAR(30),
	ejercito VARCHAR(30),
	pais VARCHAR(30)
);

SELECT * FROM caballeros;
-- TRUNCATE TABLE caballeros;
INSERT INTO caballeros VALUES
	(0, 'Seiya', 'Pegaso', 'Bronce', 'Sagitario', 'Atena', 'Japon'),
	(0, 'Shiryu', 'Dragon', 'Bronce', 'Libra', 'Atena', 'Japon'),
	(0, 'Hyoga', 'Cisne', 'Bronce', 'Acuario', 'Atena', 'Rusia'),
	(0, 'Ikki', 'Fenix', 'Bronce', 'Leo', 'Atena', 'Japon'),
	(0, 'Camus', 'Acuario', 'Oro', 'Acuario', 'Atena', 'Francia'),
	(0, 'Saga', 'Géminis', 'Oro', 'Géminis', 'Atena', 'Grecia'),
	(0, 'Kanon', 'Dragon Marino', 'Marino', 'Géminis', 'Poseidon', 'Grecia'),
	(0, 'Kagaho', 'Bennu', 'Espectro', 'Leo', 'Hades', 'Rusia');

-- GROUP BY
-- Muestra cuantos registros hay por cada grupo, por ejemplo signos
SELECT signo, COUNT(*) AS Total FROM caballeros GROUP BY signo;
SELECT rango, COUNT(*) AS Total_armaduras FROM caballeros GROUP BY rango;
-- Cuente la cantidad de armaduas por cada categoría de caballero

SELECT pais, COUNT(*) AS Total FROM caballeros GROUP BY pais;
SELECT ejercito, COUNT(*) AS Total FROM caballeros GROUP BY ejercito;

-- having: es el where de los group
SELECT rango, COUNT(*) AS Total_atena FROM caballeros WHERE ejercito = 'Atena'
GROUP BY rango;

SELECT rango, COUNT(*) AS caballeros_atena FROM caballeros WHERE ejercito = 'Atena' GROUP BY rango;
SELECT rango, COUNT(*) AS Total_atena FROM caballeros WHERE ejercito = 'Atena'
GROUP BY rango HAVING Total_atena <= 3;
-- HAVING es como un filtro
-- En las funciones de agrupamiento WHERE solo funciona con columnas existentes (No creadas dinámicamente como total_atena)
-- HAVING SI es para las columnas creadas dinámicamente como total_atena (Primero va el WHERE y luego el HAVING)

SELECT nombre, precio, MAX(precio) AS precio_maximo FROM productos GROUP BY precio, nombre HAVING precio >= 10000;

-- DISCTINT: borra los elementos repetidos
SELECT DISTINCT ejercito FROM caballeros;
SELECT DISTINCT rango FROM caballeros;
SELECT DISTINCT pais FROM caballeros;

-- ORDER BY Ordena por orden alfábetico o numerico
SELECT * FROM caballeros;
SELECT * FROM caballeros ORDER BY nombre; -- ordena ascendentemente por default
SELECT * FROM caballeros ORDER BY nombre ASC; -- ordena ascendentemente

SELECT * FROM caballeros ORDER BY nombre DESC; -- ordena descendentemente

SELECT * FROM caballeros ORDER BY nombre, armadura;

SELECT * FROM caballeros WHERE ejercito = 'Atena' ORDER BY nombre;

-- ORDER BY junto con GROUP BY
SELECT ejercito, COUNT(*) AS Total_Caballeros_Atena FROM caballeros WHERE ejercito = 'Atena';
SELECT ejercito, COUNT(*) AS Total_Caballeros FROM caballeros GROUP BY ejercito ORDER BY ejercito DESC;
-- Selecciona ejercito, cuenta cuantos registros tiene cada ejercito y llamalo 'Total_Caballeros' agrupalos por tipo de ejercito y ordenalos por nombre descendiente

-- BETWEEN
-- Es un filtro, que reemplaza el where con rangos
SELECT * FROM productos WHERE precio >= 5000 AND precio <= 15000;
-- Estas dos sentencias hacen los mismo
SELECT * FROM productos WHERE precio BETWEEN 5000 AND 15000;

SELECT * FROM productos WHERE nombre REGEXP '[a-z]';


-- Funciones de strings
SELECT ('Hola mundo');
SELECT UCASE('Hola mundo');
SELECT UPPER('Hola mundo');
SELECT LCASE('Hola mundo');
SELECT LOWER('Hola mundo');
SELECT LEFT('Hola mundo', 3); -- Hol
SELECT RIGHT('Hola mundo', 8); -- la mundo
SELECT LENGTH('Hola mundo');
SELECT REPEAT('Hola mundo ', 3);
SELECT REVERSE('Hola mundo'); -- odnum aloH
SELECT REPLACE('Hola mundo', 'o', 'x'); -- Hxla mundx
SELECT LTRIM('    Hola mundo     '); -- Sin espacio a la izquierda
SELECT RTRIM('    Hola mundo     '); -- Sin espacio a la derecha
SELECT TRIM('    Hola mundo     ');
SELECT CONCAT('Hola ',  'mundo'); -- Hola mundo
SELECT CONCAT_WS('-', 'Hola ',  'mundo');

SELECT UPPER(nombre) FROM productos;
SELECT CONCAT(nombre, ' - ', descripcion) AS referencia FROM productos; -- Laptop - Lenovo thinkpad

-- INDICES
SHOW INDEX FROM productos;



-- busqueda con indices
CREATE TABLE caballeros_index (
	caballero_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(30),
	armadura VARCHAR(30),
	rango VARCHAR(30),
	signo VARCHAR(30),
	ejercito VARCHAR(30),
	pais VARCHAR(30),
    FULLTEXT INDEX fi_search (armadura, rango, signo, ejercito, pais)
);

TRUNCATE TABLE caballeros_index;
SELECT * FROM caballeros_index;
INSERT INTO caballeros_index VALUES
	(0, 'Seiya', 'Pegaso', 'Bronce', 'Sagitario Oro', 'Atena', 'Japon'),
	(0, 'Shiryu', 'Dragon', 'Bronce', 'Libra', 'Atena', 'Japon'),
	(0, 'Hyoga', 'Cisne', 'Bronce', 'Acuario Oro', 'Atena', 'Rusia'),
	(0, 'Ikki', 'Fenix', 'Bronce', 'Leo', 'Atena', 'Japon'),
	(0, 'Camus', 'Acuario', 'Oro', 'Acuario', 'Atena', 'Francia'),
	(0, 'Saga', 'Géminis', 'Oro', 'Géminis', 'Atena', 'Grecia'),
	(0, 'Kanon', 'Dragon Marino', 'Marino', 'Géminis', 'Poseidon', 'Grecia'),
	(0, 'Kagaho', 'Bennu', 'Espectro', 'Leo', 'Hades', 'Rusia');

SHOW INDEX FROM caballeros_index;

SELECT * FROM caballeros_index WHERE MATCH (armadura, rango, signo, ejercito, pais)
AGAINST('Oro' IN BOOLEAN MODE);