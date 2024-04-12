# PostgreSQL

Es un motor de bases de datos que permite estructurar la información, es Open Source, usa como elemento principal Ojeto-Relacional, es muy reconocido por POstGIS que es un servicio de localizacion y por PL que es para programar. Cumple ACID (Atomicity, Consistency, Insolation, Durability)

¿Por qué PostgreSQL?

- Tipos de datos
- Integridad de datos
- Concurrencia, rendimiento
- Fiabilidad, recuperación antre desastres
- Seguridad
- Extensibilidad
- Internalización, búsqueda de texto
- Sitema de geolocalización

## Comandos 

**Comandos de navegación y consulta de información**

\c Saltar entre bases de datos

\l Listar base de datos disponibles

\dt Listar las tablas de la base de datos

\d <nombre_tabla> Describir una tabla

\dn Listar los esquemas de la base de datos actual

\df Listar las funciones disponibles de la base de datos actual

\dv Listar las vistas de la base de datos actual

\du Listar los usuarios y sus roles de la base de datos actual

**Comandos de inspección y ejecución**

\g Volver a ejecutar el comando ejecutando justo antes

\s Ver el historial de comandos ejecutados

\s <nombre_archivo> Si se quiere guardar la lista de comandos ejecutados en un archivo de texto plano

\i <nombre_archivo> Ejecutar los comandos desde un archivo

\e Permite abrir un editor de texto plano, escribir comandos y ejecutar en lote. \e abre el editor de texto, escribir allí todos los comandos, luego guardar los cambios y cerrar, al cerrar se ejecutarán todos los comandos guardados.

\ef Equivalente al comando anterior pero permite editar también funciones en PostgreSQL

**Comandos para debug y optimización**

\timing Activar / Desactivar el contador de tiempo por consulta
Comandos para cerrar la consola

\q Cerrar la consola
Ejecutando consultas en la base de datos usando la consola

## Roles
Se pueden crear y eliminar, puede asignar atributos, puede manipular tablas, etc. A cada rol se le puede dar una serie de permisos para indicar que puede y que no puede hacer
 
```SQL
-- Ver las funciones del comando CREATE ROLE (help)
\h CREATE ROLE;

-- Creamos un ROLE (consultas -&gt; lectura, insertar, actualizar)
CREATE ROLE usuario_consulta;

-- Mostrar todos los usuarios junto a sus atributos
\dg

-- Agregamos atributos al usuario o role
ALTER ROLE  usuario_consulta WITH LOGIN; -- Acceder a la base de datos
ALTER ROLE  usuario_consulta WITH SUPERUSER;
ALTER ROLE  usuario_consulta WITH PASSWORD'1234';

-- Elimanos el usuario o role
DROP ROLE usuario_consulta;

-- La mejor forma de crear un usuario o role por pgadmin
CREATE ROLE usuario_consulta WITH
  LOGIN
  NOSUPERUSER
  NOCREATEDB
  NOCREATEROLE
  INHERIT
  NOREPLICATION
  CONNECTION LIMIT -1
  PASSWORD'1234';
```

## Funciones principales

### ON CONFLICT DO
Esta instruccion nos permite especificar que debemos hacer en caso de un conflicto.

Ejemplo: Imaginamos que realizamos una consulta donde el id ya ha sido utilizado. Podemos especificar que en ese caso, actualize los datos.


```sql
INSERT INTO pasajero (id, nombre, direccion_residencia, fecha_nacimiento)
	values (1, '', '','2010-01-01')
	ON CONFLICT (id) DO 
	UPDATE SET 
	nombre = '', direccion_residencia='', fecha_nacimiento='2010-01-01';
```
### RETURNING
Returning nos devuelve una consulta select de los campos sobre los que ha tenido efecto la instruccion.

Ejemplo: Queremos saber cual es el id que le fue asignado a un dato insertado.


```sql
INSERT INTO tren (modelo, capacidad)
	 VALUES('modelo x', 100)
	 RETURNING id;
/*
Opcionalmente tambien puedes solicitar todos los campos o alguno de ellos
*/

INSERT INTO tren (modelo, capacidad)
	 VALUES('modelo x', 100)
	 RETURNING id;

INSERT INTO tren (modelo, capacidad)
	 VALUES('modelo x', 100)
	 RETURNING id, capacidad;
```
### Like / Ilike
Las funciones like y ilike sirven para crear consultas a base de expresiones regulares.

Like considera mayusculas y minusculas, mientras que ilike solo considera las letras.

Ejemplo: Busquemos a los pasajeros con nombre que terminen con la letra o


```sql
-- Usando LIKE
SELECT * FROM PASAJERO
WHERE pasajero.nombre LIKE '%O'
-- No devulve nada, porque ningun nombre terminara con una letra mayuscula


-- Usando ILIKE
SELECT * FROM PASAJERO
WHERE pasajero.nombre LIKE '%O'
-- Devolvera los nombres que terminen con o, independiente si es mayuscula o minuscula.
```
### IS / IS NOT
Permite hacer comprobacion de valores especiales como null

Ejemplo: Consultemos a todos los usuarios que tengan como direccion_residencia NULL


```sql
-- IS
SELECT * FROM PASAJERO
WHERE pasajero.nombre IS null;
Ahora a los que si tengan la direccion_recidencia con algun valor


-- IS NOT
SELECT * FROM PASAJERO
WHERE pasajero.nombre IS NOT null;
```
## Funciones avanzadas

COALESCE: te permite comparar 2 valores y retornar el que no es nulo. Pero la función acepta un número ilimitado de argumentos. Cuando son más de 2 argumentos devuelve el primero no NULL (en sentido de izquierda a derecha). Si todos los argumentos son NULL, devuelve NULL. Se utiliza para evitar devolver valores nulos. Esto es útil cuando el valor devuelto tiene que ser usado dentro de una función. Para que esta función no tenga un argumento nulo. https://www.postgresqltutorial.com/postgresql-coalesce/
NULLIF: te permite comparar 2 valores y retorna NULL si son iguales. Si no son iguales retorna el argumento de la izquierda. Esta función se puede usar como denominador de una división con el argumento de la izquierda igual a cero. La división siempre se dividirá por el argumento de la izquierda salvo cuando sea cero. Para ese caso NULLIF devuelve NULL, haciendo que el resultado de la división sea NULL y no indefinido. https://www.postgresqltutorial.com/postgresql-nullif/
GREATEST: te permite comparar un arreglo de valores y te retorna el mayor
LEAST: idem anterior pero para este caso retorna el menor
BLOQUES ANÓNIMOS: al igual que el desarrollo de software te permite ingresar condicionales pero dentro de una consulta de base de datos. Se agrega más información a una misma tabla sin agregar ningún tipo de consulta

## Vistas

Una vista es util cuando se usa mucho una misma consulta

### Volátil
Siempre que se haga la consulta en la vista, la BD hace la ejecución de la consulta en la BD, por lo que siempre se va a tener información reciente.

### Materializada: Persistente

 Hace la consulta una sola vez, y la información queda almacenada en memoria, la siguiente vez que se consulte, trae el dato almacenado, eso es bueno y malo a la vez, bueno porque la velocidad con la que se entrega la información es rápida, malo porque la información no es actualizada. Es ideal utilizar este tipo de vista en procesos que utilice días anteriores, porque el día de ayer, ya pasó y no hay razón para actualizarlo

```sql
REFRESH MATERIALIZED VIEW <nombre vista>;
```

## PL/SQL

```sql
[ <<label>> ]
[ DECLARE
    declarations ]
BEGIN
    statements
END [ label ];

-- Ejemplo

DO $$
	DECLARE
		rec record := NULL;
		contador integer := 0;
	BEGIN
		FOR rec IN SELECT * FROM pasajero LOOP
			RAISE NOTICE 'Un pasajero se llama %', rec.nombre;
			contador := contador + 1;
		END LOOP;
		RAISE NOTICE 'Hay % filas', contador;
	END
$$
```

```sql
CREATE OR REPLACE FUNCTION importantePL()
    RETURNS void
AS $$
	DECLARE
		rec record := NULL;
		contador integer := 0;
	BEGIN
		FOR rec IN SELECT * FROM pasajero LOOP
			RAISE NOTICE 'Un pasajero se llama %', rec.nombre;
			contador := contador + 1;
		END LOOP;
		RAISE NOTICE 'Hay % filas', contador;
	END
$$
LANGUAGE PLPGSQL;
```

```sql
--FUNCION QUE RETORNA UNA TABLA
--Mostrar tabla con plpgsql
--https://stackoverflow.com/questions/18084936/pl-pgsql-functions-how-to-return-a-normal-table-with-multiple-columns-using-an
DROP FUNCTION consulta_t_pasajero(p_pasajero_id integer);

CREATE OR REPLACE FUNCTION consulta_t_pasajero(p_pasajero_id integer) 
RETURNS TABLE(id integer, nombre character varying, direccion_residencia character varying, fecha_nacimiento date) 
LANGUAGE plpgsql
AS $BODY$
    BEGIN
		IF p_pasajero_id IS NULL THEN 
		 RETURN QUERY 
			SELECT pasajero.id, pasajero.nombre, pasajero.direccion_residencia, pasajero.fecha_nacimiento
			FROM public.pasajero;
		END IF;
		RETURN QUERY 
			SELECT pasajero.id, pasajero.nombre, pasajero.direccion_residencia, pasajero.fecha_nacimiento
			FROM public.pasajero
			WHERE pasajero.id = p_pasajero_id;
    END;
$BODY$

--Retorno en forma de fila
SELECT consulta_t_pasajero(NULL); 
SELECT consulta_t_pasajero(50);
--Retorno en forma de tabla
SELECT * FROM consulta_t_pasajero(NULL);
SELECT * FROM consulta_t_pasajero(50);
```

## Triggers
Son disparadores que se lanzan cuando pasa alguna de estas acciones

- Insert
- Update
- Delete
  
Y pueden hacerse:
- AFTER despues de
- BEFORE antes de
- INSTEAD OF en vez de

```sql
CREATE OR REPLACE FUNCTION public.impl()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
	DECLARE
		rec record := NULL;
		contador integer := 0;
	BEGIN
		FOR rec IN SELECT * FROM pasajero LOOP
			RAISE NOTICE 'Un pasajero se llama %', rec.nombre;
			contador := contador + 1;
		END LOOP;
		INSERT INTO conteo_pasajeros(total, tiempo) VALUES (contador, now());
		RETURN NEW; -- El cambio puede proceder
	END
$BODY$;

ALTER FUNCTION public.impl()
    OWNER TO postgres;
```

OLD y NEW son variables que se utilizan en los triggers de PostgreSQL para representar los datos de la fila que se está insertando, actualizando o eliminando.

OLD representa los datos de la fila antes de que se produzca la acción desencadenante.
NEW representa los datos de la fila después de que se produzca la acción desencadenante.
OLD y NEW se utilizan para que el desarrollador del trigger pueda acceder a los datos de la fila que se está modificando. Esto permite al desarrollador realizar comprobaciones de integridad de datos, aplicar lógica de negocio o realizar otras operaciones que requieran el conocimiento de los datos de la fila.

Por ejemplo, si se crea un trigger para comprobar que el nombre de un usuario no esté ya en uso, el desarrollador podría utilizar la variable OLD para acceder al nombre del usuario que se está actualizando. Si el nombre del usuario ya está en uso, el desarrollador podría cancelar la acción desencadenante.

```sql
CREATE TABLE mitrigger
AFTER INSERT
ON pasajero
FOR EACH ROW
EXECUTE PROCEDURE impl();
```

## Conectarse a bases externas

```sql
--CREATE EXTENSION dblink;

SELECT *
FROM DBLINK ('dbname=Remota
			 port=5432
			 host=127.0.0.1
			 user=postgres
			 password=root',
			 'SELECT id, fecha FROM vip') AS DATOS_REMOTOS(ID integer, FECHA date);
```

## Transacciones

Las transacciones, tienen la capacidad para empaquetar varios pasos en una sola operación “todo o nada”.y si ocurre alguna falla que impida que se complete la transacción, entonces ninguno de los pasos se ejecuta y no se afecta la base de datos en absoluto.

SQL Transacción - Estructura La transacciones tienen la siguiente estructura postgres. Postgres en las operaciones normales usa de manera implícita el rollback el rollback.

```sql
BEGIN
<consultas>
COMMIT | ROLLBACK
```

## Mantenimiento

Mantenimiento

Se refiere a quitar todas las filas, columnas e items del disco duro que no están funcionando.

Se puede realizar a la db o a una tabla en especifica.

**VACUUM**:
- FULL: Se realizara un mantenimiento full, y se realiza una consulta durante el proceso la tabla se congelara y no permitirá ninguna otra modificación.
- FREEZE: Se congelara durante el proceso y no permitirá ninguna otra modificación.
- ANALYZE: Realiza una revision pero no ejecuta cambios.

**ANALYZE**: No permite realizar cambios, únicamente realiza la revisión y te muestra el estado de la tabla o db.
**REINDEX**: Aplica para indices. En el momento que los indices sean demasiado extensos.
**CLUSTER**: Organiza la información en el disco duro.
Recomendación: No realizar mantenimiento a la db a menos que se presente problemas de indexación o eliminado.

### [Replicas](https://platzi.com/tutoriales/1480-postgresql/24446-replicas-en-postgresql-usando-aws-amazon-web-services/)

[Extensiones](https://www.postgresql.org/docs/11/contrib.html)