-- Selecciona todas las restricciones (Constraints) del usuario.
-- INSTITUTO utilizando alias mediante el comando AS, y ordenado.
-- de manera ascendente (a --> z) en las columnas TABLA y RESTRICCION.

SELECT
Table_Name AS TABLA,
Constraint_Name AS RESTRICCION,
Constraint_Type AS TIPO,
Search_Condition AS CONDICION_CHEQUEO,
R_Constraint_Name AS RELACION_PK
FROM user_constraints
ORDER BY TABLA, RESTRICCION
;




-- Se renombra la Primary Key perteneciente a la Tabla MATERIAS.
-- cambiando el nombre que Orace asigna (SYS_C004096) por el nombre PK_Materia.

ALTER TABLE       MATERIAS
RENAME CONSTRAINT SYS_C004096
TO                PK_MATERIA
;




-- Se altera la Tabla PERSONAS para adicionar la columna SEXO
-- con tipo de dato CHAR(1). El "1" se refiere a un carácter.

ALTER 
TABLE PERSONAS
ADD (SEXO CHAR(1))
;


-- Se altera la Tabla PERSONAS para adicionar una restricción de control (CHECK)
-- para que cumpla con una asignación de valores 'F' o 'M', para el único carácter
-- aceptado de la columna SEXO.

ALTER TABLE PERSONAS
ADD CONSTRAINT CHK_PERS_SEXO
CHECK(
      SEXO IN('F','M')
      )
;





-- Se altera la Tabla CURSOS para adicionar una restricción de chequeo (CHECK)
-- para que cumpla la condición de que FEC_FIN sea mayor que FEC_INICIO.

ALTER TABLE CURSOS
ADD CONSTRAINT CHK_CURS_FECHAS
CHECK(
      FEC_FIN > FEC_INICIO
      )
;




-- Se crea un índice (INDEX) para la Tabla PERSONA
-- por las columnas APELLIDO y NOMBRE.

CREATE 
INDEX IND_PERS_APELL_NOMB
ON PERSONAS(APELLIDO, NOMBRE)
;





-- Muestra todos los índices de usuario mediante user_indexes
-- ordenado en forma ascendente (a --> z) por las columnas TABLA e INDICE.

SELECT
        table_name AS TABLA,
        index_name AS INDICE,
        uniqueness AS UNICO
FROM    user_indexes
ORDER   BY TABLA, INDICE
;






-- Selecciona el nombre de la materia que comienza
-- con el texto PROGRAMA. Para ello su usa el comodín % luego del texto de inicio.

SELECT 
NOMBRE AS MATERIA
FROM MATERIAS
WHERE NOMBRE LIKE 'PROGRAMA%'
;





-- Selecciona el nombre de la Materia que contenga el texto PROGRAMA.
-- En este cso no nos interesa que la palabra se encuentre solo al comienzo
-- por ello usamos el comodín antes y después del texto.

SELECT 
NOMBRE AS MATERIA
FROM MATERIAS
WHERE NOMBRE LIKE '%PROGRAMA%'
;





-- Lista todas las personas con el cálculo de su edad.
-- Las palabras comienzan con su primera letra en mayúscula y separadas por una coma ",".
-- Se utilizan alias para encabezar las columnas.
-- Se ordena de manera ascendente (a --> z) en la columna PERSONA.

SELECT
      INITCAP   (   APELLIDO || ',' || NOMBRE) AS PERSONA,
      FEC_NAC,
      TRUNC     (   (SYSDATE - FEC_NAC) / 365) AS EDAD
FROM PERSONAS
ORDER BY PERSONA
;
