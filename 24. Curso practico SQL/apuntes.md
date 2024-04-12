# SQL

## Álgebra relacional

Está basado en teoría de conjuntos, es la base de las operaciones de los conjuntos de datos o relaciones, a diferencia de las tablas tradicionales, en el álgebra relacional no puede haber rows repetidas

### Operadores unarios.
- Requiere una relación o tabla para funcionar. 
- Proyección (π): Equivale al comando Select. Saca un número de columnas o atributos sin necesidad de hacer una unión con una segunda tabla. π<Nombre, Apellido, Email>(Tabla_Alumno) ⠀ 
- Selección (σ): Equivale al comando Where. Consiste en el filtrado de de tuplas. σ<Suscripción=Expert>(Tabla_Alumno) ⠀
### Operadores binarios.
- Requiere más de una tabla para operar.
- Producto cartesiano (x): Toma todos los elementos de una tabla y los combina con los elementos de la segunda tabla. Docentes_Quinto_A x Alumnos_Quinto_A ⠀ 
- Unión (∪): Obtiene los elementos que existen en una de las tablas o en la otra de las tablas. Alumnos_Quinto_A x Alumnos_Quinto_B ⠀ 
- Diferencia (-): Obtiene los elementos que existe en una de las tablas pero que no corresponde a la otra tabla. Alumnos_planExpertPlus - Alumnos_planFree


## Operaciones

### Proyección $\pi$

```sql
SELECT field AS alias FROM tabla as t_alias
```
```sql
SELECT COUNT(id), SUM(quantity), AVG(age)
```
```sql
SELECT MIN(date), MAX(quantity)
```

#### FROM dblink

```sql
SELECT * FROM dblink('
dbname=db
port=5432
host=someserver
user=username
password=password
'SELECT * FROM schema.table'
')
```

#### Estructuras de control

```sql
SELECT IF(500<1000, "YES", "NO");
```
```sql
SELECT order_id, quantity,
CASE
    WHEN quantity < 30 THEN "Over 30"
    WHEN quantity = 30 THEN "Equal 30"
    ELSE "Under 30"
END AS quantity_text
```

#### Selección $\sigma$

```sql
SELECT * FROM tabla WHERE condicion;
```

```sql
SELECT * FROM tabla WHERE 
cantidad BETWEEN 10 AND 100;
```
```sql
SELECT * FROM tabla WHERE 
name LIKE "Is%"
```

#### Ordenamiento

```sql
SELECT * FROM tabla ORDER BY (column) ASC
```

#### Índices

No son recomendados si se hacen muchas escrituras en el índice, pero si unicamente se van a usar lecturas vale la pena tenerlos en cuenta.

#### Agregacíon

```sql
SELECT * FROM tabla GROUP BY (column);
```

### JOIN

```sql
SELECT * FROM tabla AS t JOIN tabla
ON tabla.pk = tabla.fk
```

![diagrama.jpeg](https://ingenieriadesoftware.es/wp-content/uploads/2018/07/sqljoin.jpeg)

## Práctica

- El primer registro
```sql
SELECT * FROM platzi.alumnos LIMIT 1;

SELECT * FROM platzi.alumnos FETCH FIRST 1 ROWS ONLY;

SELECT *
FROM
	(SELECT ROW_NUMBER() OVER() AS ROW_ID, *
		FROM PLATZI.ALUMNOS) AS ALUMNOS_WITH_ROWS
WHERE ROW_ID = 1;
```

- Segunda colegiatura más alta
```sql
SELECT DISTINCT(COLEGIATURA)
FROM PLATZI.ALUMNOS AS A1
WHERE 2 =
		(SELECT COUNT(DISTINCT COLEGIATURA)
			FROM PLATZI.ALUMNOS AS A2
		    WHERE A1.colegiatura <= A2. colegiatura);

SELECT DISTINCT(COLEGIATURA)
FROM PLATZI.ALUMNOS
ORDER BY COLEGIATURA DESC
LIMIT 1
OFFSET 1;
```
- Mitad de registros en adelante
```sql
SELECT ROW_NUMBER() OVER() AS ROW_ID, *
FROM PLATZI.ALUMNOS
OFFSET
	(SELECT COUNT(*) / 2
		FROM PLATZI.ALUMNOS)
```
- Grupo de opciones (listas)
```sql
SELECT *
FROM
	(SELECT ROW_NUMBER() OVER() AS ROW_ID, *
		FROM PLATZI.ALUMNOS) AS ALUMNOS_WITH_ROW_NUM
WHERE ROW_ID IN (1, 5, 6, 12);
```
- Extraer fechas
```sql
SELECT EXTRACT(YEAR
    FROM FECHA_INCORPORACION) AS ANIO
FROM PLATZI.ALUMNOS;

SELECT DATE_PART('YEAR', FECHA_INCORPORACION)
FROM PLATZI.ALUMNOS
```
- Filtrar por fecha
```sql
SELECT * FROM platzi.alumnos
WHERE (EXTRACT(YEAR FROM fecha_incorporacion) = 2018)
```
- Mostrar duplicadoss
```sql
SELECT (
	platzi.alumnos.nombre,
	platzi.alumnos.apellido,
	platzi.alumnos.email,
	platzi.alumnos.colegiatura,
	platzi.alumnos.fecha_incorporacion,
	platzi.alumnos.carrera_id,
	platzi.alumnos.tutor_id
)::text, COUNT(*)
FROM platzi.alumnos
GROUP BY platzi.alumnos.nombre,
	platzi.alumnos.apellido,
	platzi.alumnos.email,
	platzi.alumnos.colegiatura,
	platzi.alumnos.fecha_incorporacion,
	platzi.alumnos.carrera_id,
	platzi.alumnos.tutor_id
HAVING COUNT(*) > 1;


SELECT	*
FROM (
	SELECT id,
	ROW_NUMBER() OVER(
		PARTITION BY
			nombre,
			apellido,
			email,
			colegiatura,
			fecha_incorporacion,
			carrera_id,
			tutor_id
		ORDER BY id asc
	) AS row,
	*
	FROM platzi.alumnos
) duplicados
WHERE duplicados.row > 1;
```

- Rangos
```sql
SELECT * FROM platzi.alumnos
WHERE tutor_id IN (1, 2, 3, 4);

SELECT * FROM platzi.alumnos
WHERE tutor_id BETWEEN 1 AND 10;

SELECT * FROM platzi.alumnos
```
- Selfquery
```sql
SELECT CONCAT(t.nombre, ' ', t.apellido) AS TUTOR,
COUNT(*) AS alumnos_por_tutor
FROM platzi.alumnos as a
	INNER JOIN platzi.alumnos as t ON a.tutor_id = t.id
GROUP BY tutor
ORDER BY alumnos_por_tutor DESC
```
- Triangulando
```sql
SELECT lpad('sql', 15, '*');
```
- Generar rangos
```sql
SELECT * FROM generate_series(start, end, step);
```
- A
```sql

```