-- STORED PROCEDURES
-- Conjunto de instrucciones SQL que se almacenan enla base de datos, como si fueran funcioes
-- como una función se puede llamar varias veces y usa parámetros de entrada o de salida
-- Encapsulan y reducen lógica

USE jm_curso_sql;
SHOW TABLES;

CREATE TABLE suscripciones (
	suscripcion_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    suscripcion VARCHAR(30) NOT NULL,
	costo DECIMAL(5,2) NOT NULL
); -- catalogo

INSERT INTO suscripciones VALUES
	(0, 'Bronce', 199.99),
    (0, 'Plata', 299.99),
    (0, 'Oro', 399.99);
    
CREATE TABLE clientes (
	cliente_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    correo VARCHAR(50) UNIQUE
);

CREATE TABLE tarjetas (
	tarjeta_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    cliente INT UNSIGNED,
    tarjeta BLOB,
    FOREIGN KEY(Cliente)
		REFERENCES clientes(cliente_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE servicios(
	servicio_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    cliente INT UNSIGNED,
    tarjeta INT UNSIGNED,
    suscripcion INT UNSIGNED,
    FOREIGN KEY (cliente)
		REFERENCES clientes(cliente_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
	FOREIGN KEY (tarjeta)
		REFERENCES tarjetas(tarjeta_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
	FOREIGN KEY (suscripcion)
		REFERENCES suscripciones(suscripcion_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

SELECT * FROM suscripciones;
SELECT * FROM clientes;
SELECT * FROM tarjetas;
SELECT * FROM servicios;

-- ------------------------------------------------------------------------

-- Ejemplo de SP
DELIMITER $$ -- Se definen delimitadores (separados por un espacio)

CREATE PROCEDURE sp_obtener_suscripciones()
	BEGIN
    -- todos los scripts
    SELECT * FROM suscripciones;
    
    END $$
DELIMITER ; -- Se cierra el delimitador (también separando el ; por un espacio)

-- Para correr el SP en MySQL debo copiar solo el SP y correrlo en un nuevo script con el 2do ícono de rayo

-- LLAMAR SP
CALL sp_obtener_suscripciones();

-- MOSTRAR SPs
SHOW PROCEDURE STATUS WHERE db = 'jm_curso_sql';

-- ELIMINAR SP
DROP PROCEDURE sp_obtener_suscripciones

-- ------------------------------------------------------------------------

-- Ejemplo de SP
DELIMITER $$

CREATE PROCEDURE sp_asignar_servicio(
	-- dentro de los paréntesis van los prámetros
	IN i_suscripcion INT UNSIGNED,
	IN i_nombre VARCHAR(30),
	IN i_correo VARCHAR(50),
	IN i_TARJETA VARCHAR(16),
	OUT o_respuesta VARCHAR(50)
)
	BEGIN
    -- Acá van los scripts con transactions: osea que si algo sale mal puedo hacer rollback, de lo contrario commit
    -- las variables se definen antes de transactions
    
    
    START TRANSACTION
    
    END $$
DELIMITER ;