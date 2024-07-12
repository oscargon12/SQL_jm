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
    
    
-- Solución profe