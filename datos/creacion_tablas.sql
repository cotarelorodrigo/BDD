DROP TABLE IF EXISTS rutas;
DROP TABLE IF EXISTS aeropuertos;
DROP TABLE IF EXISTS aerolineas;

CREATE TABLE aerolineas (
	codigo_IATA VARCHAR(2),
	nombre VARCHAR(50),
	empresa VARCHAR (50),
	pais VARCHAR(40),
	PRIMARY KEY (codigo_IATA)
);

COPY aerolineas
FROM '/home/franhermani/Escritorio/bdd-tp/datos/aerolineas.csv'
DELIMITER ',';

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
FROM '/home/franhermani/Escritorio/bdd-tp/datos/aeropuertos.csv'
DELIMITER ',';

CREATE TABLE rutas (
	codigo_aerolinea VARCHAR(2) REFERENCES aerolineas(codigo_IATA),
	codigo_origen VARCHAR(3) REFERENCES aeropuertos(codigo_IATA),
	codigo_destino VARCHAR(3) REFERENCES aeropuertos(codigo_IATA),
	PRIMARY KEY (codigo_aerolinea, codigo_origen, codigo_destino)
);

COPY rutas
FROM '/home/franhermani/Escritorio/bdd-tp/datos/rutas.csv'
DELIMITER ',';

