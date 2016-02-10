SELECT 
COUNT(*)
N_PERSONAS
FROM PERSONAS
;


SELECT    PAISES.NOMBRE   PAIS,
          COUNT(*)        N_PERSONAS
FROM      PAISES, PERSONAS P
WHERE     PAISES.ID_PAIS = P.ID_PAIS
GROUP BY  PAISES.NOMBRE
ORDER BY  1
;

----------------------------------------------------------------------

-- Cantidad de personas de cada País con TELEFONO -- 

SELECT    PAISES.NOMBRE   PAIS,
          COUNT(TELEFONO) N_TELEFONO
FROM      PAISES,         PERSONAS P
WHERE     PAISES.ID_PAIS = P.ID_PAIS
GROUP BY  PAISES.NOMBRE
ORDER BY  1
;

----------------------------------------------------------------------

-- Máx y Mín de fechas de Nacimiento en la relación Personas.

SELECT  
        MIN(FEC_NAC)  FEC_NAC_MIN,
        MAX(FEC_NAC)  FEC_NAC_MAX
FROM PERSONAS
;


-- Máx y Mín de Fechas de nacimiento para cada país --

SELECT    PAISES.NOMBRE PAIS,
          MIN(FEC_NAC)  FECHA_NAC_MINIMA,
          MAX(FEC_NAC)  FECHA_NAC_MAXIMA
FROM      PERSONAS P,   PAISES
WHERE     PAISES.ID_PAIS = P.ID_PAIS
GROUP BY  PAISES.NOMBRE
ORDER BY  1
;
----------------------------------------------------------------------

-- Cantidad de cursos por Modalidad --

SELECT  NOMBRE      NOMBDE_DE_CURSO,
        MODALIDAD,
        COUNT(*)    N_MODALIDAD
FROM    MATERIAS
        INNER JOIN  CURSOS
          ON        CURSOS.ID_MATERIA = MATERIAS.ID_MATERIA
GROUP BY            NOMBRE, MODALIDAD
ORDER BY            1,2
;

----------------------------------------------------------------------
