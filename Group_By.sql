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

-- Cantidad de personas de cada Pa�s con TELEFONO -- 

SELECT    PAISES.NOMBRE   PAIS,
          COUNT(TELEFONO) N_TELEFONO
FROM      PAISES,         PERSONAS P
WHERE     PAISES.ID_PAIS = P.ID_PAIS
GROUP BY  PAISES.NOMBRE
ORDER BY  1
;

----------------------------------------------------------------------

-- M�x y M�n de fechas de Nacimiento en la relaci�n Personas.

SELECT  
        MIN(FEC_NAC)  FEC_NAC_MIN,
        MAX(FEC_NAC)  FEC_NAC_MAX
FROM PERSONAS
;


-- M�x y M�n de Fechas de nacimiento para cada pa�s --

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
