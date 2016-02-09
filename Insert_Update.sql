--------------------------------------------.....--...--..||||||||||||||||||||||||||||||||||
--------------------------------------------.....--...--..||||||||||    INSERT    ||||||||||
--------------------------------------------.....--...--..||||||||||||||||||||||||||||||||||

-------------------------------
-- Máximo ID de la Tabla Paises
-------------------------------

SELECT 
MAX (ID_PAIS)+1 "Próxima ID disponible"
FROM 
PAISES;

SELECT 
MAX(ID_PERSONA) "Id máxima Tabla Personas"
FROM 
PERSONAS;



---------------------------------------------------------.....--...--..|||||||||||||||||||||
---------------------------------------------------------.....--...--..|| Insertar Paises ||
---------------------------------------------------------.....--...--..|||||||||||||||||||||

INSERT 
INTO PAISES
VALUES 
(14, 'ITALIA');

INSERT 
INTO PAISES
VALUES
(15, 'CHINA');

INSERT
INTO PAISES
VALUES
(16, 'RUSIA');

INSERT
INTO PAISES
VALUES
(17, 'ESTADOS UNIDOS');

INSERT INTO PAISES
SELECT MAX(ID_PAIS)+1, 'francia'
FROM PAISES;

DESCRIBE PAISES;

INSERT INTO PAISES  --------------------------------------------.....--...--.. INSERT PAIS CON NEXTVALL
(ID_PAIS, NOMBRE)
VALUES
(SEQ_ID_PAIS.NEXTVAL, 'INDONESIA');

INSERT INTO PAISES
VALUES
(SEQ_ID_PAIS.NEXTVAL, 'AFGANISTÁN');

SELECT ID_PAIS IDE, NOMBRE PAIS
FROM PAISES
WHERE NOMBRE LIKE 'AFG%' 
OR
NOMBRE LIKE 'AR%';

SELECT NOMBRE PAIS, ID_PAIS IDE
FROM PAISES
WHERE ID_PAIS BETWEEN 10 AND 50
ORDER BY 2;