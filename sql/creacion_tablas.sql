DROP TABLE IF EXISTS rutas;
DROP TABLE IF EXISTS aeropuertos;
DROP TABLE IF EXISTS aerolineas;
DROP TABLE IF EXISTS origen_destino;


-- Tabla aerolineas
CREATE TABLE aerolineas (
	codigo_IATA VARCHAR(2),
	nombre VARCHAR(50),
	empresa VARCHAR (50),
	pais VARCHAR(40),
	PRIMARY KEY (codigo_IATA)
);

COPY aerolineas
FROM '/home/franhermani/Escritorio/bdd-tp_vuelos/datos/aerolineas.csv'
DELIMITER ',';


-- Tabla aeropuertos
CREATE TABLE aeropuertos (
	codigo_IATA VARCHAR(3),
	nombre VARCHAR(80),
	ciudad VARCHAR (50),
	pais VARCHAR(40),
	latitud numeric(8,5),
	longitud numeric(8,5),
	altitud INTEGER,
	zona_horaria NUMERIC(4,2),
	TZ VARCHAR(40),
	PRIMARY KEY (codigo_IATA)
);

COPY aeropuertos
FROM '/home/franhermani/Escritorio/bdd-tp_vuelos/datos/aeropuertos.csv'
DELIMITER ',';


-- Tabla rutas
CREATE TABLE rutas (
	codigo_aerolinea VARCHAR(2) REFERENCES aerolineas(codigo_IATA),
	codigo_origen VARCHAR(3) REFERENCES aeropuertos(codigo_IATA),
	codigo_destino VARCHAR(3) REFERENCES aeropuertos(codigo_IATA),
	PRIMARY KEY (codigo_aerolinea, codigo_origen, codigo_destino)
);

COPY rutas
FROM '/home/franhermani/Escritorio/bdd-tp_vuelos/datos/rutas.csv'
DELIMITER ',';


-- Tabla origen_destino --> generada en analysis.ipynb
CREATE TABLE origen_destino (
	origen VARCHAR(50),
	destino	VARCHAR(50)
);

COPY origen_destino
FROM '/home/franhermani/Escritorio/bdd-tp_vuelos/notebooks/csv/origen_destino.csv'
DELIMITER ';';


-- Tabla iata_codes --> para utilizar en skyscanner_scrapper.ipynb
COPY (
(SELECT DISTINCT codigo_iata, origen AS ciudad
FROM aeropuertos
INNER JOIN origen_destino ON aeropuertos.ciudad = origen_destino.origen)
UNION
(SELECT DISTINCT codigo_iata, destino AS ciudad
FROM aeropuertos
INNER JOIN origen_destino ON aeropuertos.ciudad = origen_destino.destino)
)
TO '/tmp/iata_codes.csv'
DELIMITER ';'
CSV HEADER;
