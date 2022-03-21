CREATE TABLE categoria (
    id_categoria     INTEGER NOT NULL PRIMARY KEY,
    nombre_categoria VARCHAR(150) NOT NULL
);

CREATE TABLE producto (
    id_producto            INTEGER NOT NULL PRIMARY KEY,
    nombre_producto        VARCHAR(150) NOT NULL,
    precio                 FLOAT NOT NULL,
    id_categoria           INTEGER NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria)
);

CREATE TABLE pais (
    id_pais     INTEGER NOT NULL PRIMARY KEY,
    nombre_pais VARCHAR(150) NOT NULL
);

CREATE TABLE cliente (
    id_cliente      INTEGER NOT NULL PRIMARY KEY,
    nombre          VARCHAR(150) NOT NULL,
    apellido        VARCHAR(150) NOT NULL,
    direccion       VARCHAR(250) NOT NULL,
    telefono        VARCHAR(15) NOT NULL,
    tarjeta_credito VARCHAR(50) NOT NULL,
    edad            INTEGER NOT NULL,
    salario         INTEGER NOT NULL,
    genero          VARCHAR(2) NOT NULL,
    id_pais         INTEGER NOT NULL,
    FOREIGN KEY (id_pais) REFERENCES pais (id_pais)
);

CREATE TABLE vendedor (
    id_vendedor     INTEGER NOT NULL PRIMARY KEY,
    nombre_vendedor VARCHAR(150) NOT NULL,
    id_pais         INTEGER NOT NULL
);

CREATE TABLE orden (
    id_orden             INTEGER NOT NULL,
    linea_orden          INTEGER NOT NULL,
    fecha_orden          DATE NOT NULL,
    id_cliente           INTEGER NOT NULL,
    id_vendedor          INTEGER NOT NULL,
    id_producto          INTEGER NOT NULL,
    cantidad             INTEGER NOT NULL,
    CONSTRAINT PK_Orden  PRIMARY KEY (id_orden, linea_orden),
    FOREIGN KEY (id_producto) REFERENCES producto (id_producto),
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES vendedor (id_vendedor)
);

#Drop de las tablas
drop table orden;
drop table producto;
drop table categoria;
drop table cliente;
drop table vendedor;
drop table pais;