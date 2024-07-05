USE jm_curso_sql;
SHOW TABLES;
DROP TABLE caballeros;
TRUNCATE TABLE caballeros;

-- iNDICES
CREATE TABLE caballeros (
	caballero_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(30),
	armadura VARCHAR(30) UNIQUE,
	rango VARCHAR(30),
	signo VARCHAR(30),
	ejercito VARCHAR(30),
	pais VARCHAR(30),
    INDEX i_rango (rango), -- columnas tipo indice
    INDEX i_signo (signo)
    -- Como esos dos campos son indices las consultas serán más rápidas
);

SHOW INDEX FROM caballeros;

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

SELECT * FROM caballeros;
SELECT * FROM caballeros WHERE signo = 'Leo'; -- Consulta más rápida gracias a los indices

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

SELECT * FROM caballeros_index WHERE MATCH (armadura, rango, signo, ejercito, pais) -- va a buscar coincidencias en todas esas columnas
AGAINST('Oro' IN BOOLEAN MODE);