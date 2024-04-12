CREATE TABLE Pasajero (
  id INT PRIMARY KEY,
  nombre VARCHAR(255),
  apellido VARCHAR(255),
  edad INT
);

CREATE TABLE Trayecto (
  id INT PRIMARY KEY,
  origen VARCHAR(255),
  destino VARCHAR(255),
  duracion INT
);

CREATE TABLE Estacion (
  id INT PRIMARY KEY,
  nombre VARCHAR(255),
  ubicacion VARCHAR(255),
  capacidad INT
);

CREATE TABLE Tren (
  id INT PRIMARY KEY,
  modelo VARCHAR(255),
  capacidad INT,
  velocidadMaxima INT
);

CREATE TABLE Viaje (
  id INT PRIMARY KEY,
  fechaSalida DATE,
  horaSalida TIME,
  trayecto_id INT,
  estacionOrigen_id INT,
  estacionDestino_id INT,
  tren_id INT,
  FOREIGN KEY (trayecto_id) REFERENCES Trayecto(id),
  FOREIGN KEY (estacionOrigen_id) REFERENCES Estacion(id),
  FOREIGN KEY (estacionDestino_id) REFERENCES Estacion(id),
  FOREIGN KEY (tren_id) REFERENCES Tren(id)
);

CREATE TABLE IF NOT EXISTS public.bitacora_viaje
(
    id integer NOT NULL DEFAULT nextval('bitacora_viaje_id_seq'::regclass),
    id_viaje integer NOT NULL,
    fecha date NOT NULL,
    CONSTRAINT bitacora_viaje_pkey PRIMARY KEY (id_viaje, fecha)
) PARTITION BY RANGE (fecha);

ALTER TABLE IF EXISTS public.bitacora_viaje
    OWNER to postgres;

CREATE TABLE bitacora_viaje_201001 PARTITION OF bitacora_viaje 
FOR VALUES FROM ('2010-01-01') TO ('2019-01-31');