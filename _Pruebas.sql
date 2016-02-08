
SELECT 
SYSDATE "Fecha actual",
USER "Usuario"
FROM DUAL;

-- Modificaci�n de PASSWORD
ALTER 
USER PRUEBAS
IDENTIFIED 
BY sioux_pruebas;



--||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||   CREAR TABLAS  ||||||||||||
--||||||||||||||||||||||||||||||||||||||||||


CREATE TABLE --PAISES
PAISES
(
ID_PAIS     INTEGER     NOT NULL,
NOMBRE      VARCHAR(50) NOT NULL,

CONSTRAINT  PK_PAIS PRIMARY KEY (ID_PAIS),
CONSTRAINT  UK_NOMB_PAIS UNIQUE (NOMBRE)
)
TABLESPACE "USERS"
;


CREATE TABLE --PERSONAS
PERSONAS
(
ID_PERSONA  INTEGER     NOT NULL,
NOMBRE      VARCHAR(50) NOT NULL,
APELLIDO    VARCHAR(50) NOT NULL,
FEC_NAC     DATE        NOT NULL,
DOCUMENTO   NUMBER      NOT NULL,
TELEFONO    NUMBER,
CORREO      VARCHAR(50) NOT NULL,
ID_PAIS     NUMBER,

CONSTRAINT PK_PERSONA PRIMARY KEY (ID_PERSONA),
CONSTRAINT UK_DOCU_PERSONA UNIQUE (DOCUMENTO),
CONSTRAINT FK_PAIS_PERSONA FOREIGN KEY (ID_PAIS) REFERENCES PAISES
)

TABLESPACE "USERS"
;

ALTER TABLE PERSONAS MODIFY TELEFONO VARCHAR(50); --Se altera tipo de dato de columna TELEFONO


CREATE TABLE --ESTUDIANTES
ESTUDIANTES
(
ID_ESTUDIANTE           INTEGER   NOT NULL,
ID_PERSONA              INTEGER   NOT NULL,
FEC_PRIMER_MATRICULA    DATE,
CANT_CURSOS_FINALIZADOS INTEGER,
FEC_REGISTRO            DATE      NOT NULL,

CONSTRAINT PK_ESTUDIANTE        PRIMARY KEY (ID_ESTUDIANTE),
CONSTRAINT UK_PERS_ESTUDIANTE   UNIQUE  (ID_PERSONA),
CONSTRAINT FK_PERS_ESTUDIANTE   FOREIGN KEY (ID_PERSONA) REFERENCES PERSONAS
)
TABLESPACE "USERS"
;

CREATE TABLE --DOCENTES
DOCENTES
(
ID_DOCENTE    INTEGER   NOT NULL,
ID_PERSONA    INTEGER   NOT NULL,
FEC_INGRESO   DATE      NOT NULL,
FEC_EGRESO    DATE,
FEC_REGISTRO  DATE      NOT NULL,

CONSTRAINT PK_DOCENTE PRIMARY KEY (ID_DOCENTE),
CONSTRAINT UK_PERS_DOCENTE UNIQUE (ID_PERSONA),
CONSTRAINT FK_PERS_DOCENTE FOREIGN KEY (ID_PERSONA) REFERENCES PERSONAS
)
TABLESPACE "USERS"
;

CREATE TABLE --CURSOS
CURSOS
(
ID_CURSO    INTEGER     NOT NULL,
ID_DOCENTE  INTEGER     NOT NULL,
ID_MATERIA  INTEGER     NOT NULL,
FEC_INICIO  DATE        NOT NULL,
FEC_FIN     DATE        NOT NULL,
MODALIDAD   VARCHAR(50) NOT NULL,

CONSTRAINT PK_CURSO             PRIMARY KEY (ID_CURSO),
CONSTRAINT FK_DOCENTE_CURSO     FOREIGN KEY (ID_DOCENTE) REFERENCES DOCENTES,
CONSTRAINT UK_DOCENTE_CURSO     UNIQUE  (ID_DOCENTE),
CONSTRAINT FK_MATERIA_CURSO     FOREIGN KEY (ID_MATERIA) REFERENCES MATERIAS,
CONSTRAINT UK_MATERIA_CURSO     UNIQUE  (ID_MATERIA),
CONSTRAINT UK_FEC_INICIO_CURSO  UNIQUE (FEC_INICIO)
)
TABLESPACE "USERS"
;

CREATE TABLE --MATERIAS
MATERIAS
(
ID_MATERIA  INTEGER     NOT NULL,
NOMBRE      VARCHAR(50) NOT NULL,

CONSTRAINT PK_MATERIA         PRIMARY KEY (ID_MATERIA),
CONSTRAINT UK_NOMBRE_MATERIA  UNIQUE (NOMBRE)
)
TABLESPACE "USERS"
;

CREATE TABLE --MATR�CULAS
MATRICULAS
(
ID_MATRICULA  INTEGER   NOT NULL,
ID_CURSO      INTEGER   NOT NULL,
ID_ESTUDIANTE INTEGER   NOT NULL,
FEC_MATRICULA DATE      NOT NULL,
NOTA_FINAL    INTEGER,

CONSTRAINT PK_MATRICULA         PRIMARY KEY (ID_MATRICULA),
CONSTRAINT UK_CURSO_MATRICULA   UNIQUE (ID_CURSO),
CONSTRAINT FK_CURSO_MATRICULA   FOREIGN KEY (ID_CURSO) REFERENCES CURSOS,
CONSTRAINT UK_ESTUD_CURSO       UNIQUE (ID_ESTUDIANTE),
CONSTRAINT FK_ESTUD_CURSO       FOREIGN KEY (ID_ESTUDIANTE) REFERENCES ESTUDIANTES
)
TABLESPACE "USERS"
;


--|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
--||  AGREGAR (ADD), ELIMINAR (DROP), MODIFICAR (MODIFY), RENOMBRAR (RENAME) ||
--|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY';  --Cambiar formato de FECHA

/*
ALTER TABLE PERSONAS
ADD SEXO CHAR(1) NOT NULL;

ALTER TABLE PERSONAS
DROP COLUMN SEXO;

ALTER TABLE PERSONAS
MODIFY APELLIDO VARCHAR2(100);

ALTER TABLE PERSONAS
RENAME COLUMN FEC_NAC
TO
FEC_NACIMIENTO;
*/


--.....--...--..||||||||||||||||||||||
--.....--...--..|| Crear SECUENCIAS ||
--.....--...--..||||||||||||||||||||||

SELECT MAX(ID_PAIS)
FROM PAISES;

CREATE SEQUENCE SEQ_ID_PAIS
START WITH 19
INCREMENT BY 1;

SELECT MAX(ID_DOCENTE)+1
FROM DOCENTES;

CREATE SEQUENCE SEQ_ID_DOCENTE
START WITH 7
INCREMENT BY 1;

SELECT MAX(ID_ESTUDIANTE)
FROM ESTUDIANTES;

CREATE SEQUENCE SEQ_ID_ESTUDIANTE
START WITH 4
INCREMENT BY 1;

SELECT MAX(ID_MATERIA)+1
FROM MATERIAS;

CREATE SEQUENCE SEQ_ID_MATERIA
START WITH 9
INCREMENT BY 1;

SELECT MAX(ID_CURSO)+1
FROM CURSOS;

CREATE SEQUENCE SEQ_ID_CURSO
START WITH 4
INCREMENT BY 1;




----------------------------------------.....--...--..||||||||||||||||||||||||||||||||||||||
----------------------------------------.....--...--..|| PSEUDOCOLUMNAS (NEXTVAL y CURRVAL)|
SELECT SEQ_ID_PAIS.NEXTVAL, NOMBRE  --- .....--...--..||||||||||||||||||||||||||||||||||||||
FROM PAISES;                        ---
SELECT SEQ_ID_PAIS.CURRVAL;                       ---
---------------------------------------
DESCRIBE MATRICULAS;

SELECT FEC_REGISTRO FROM ESTUDIANTES;




--------------------------------------------.....--...--..||||||||||||||||||||||||||||||||||
--------------------------------------------.....--...--..||||||||||    INSERT    ||||||||||
--------------------------------------------.....--...--..||||||||||||||||||||||||||||||||||

-------------------------------
-- M�ximo ID de la Tabla Paises
-------------------------------
SELECT 
MAX (ID_PAIS)+1 "Pr�xima ID disponible"
FROM 
PAISES;

SELECT 
MAX(ID_PERSONA) "Id m�xima Tabla Personas"
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

INSERT INTO PAISES  --------------------------------------------.....--...--.. INSET PAIS CON NEXTVALL
(ID_PAIS, NOMBRE)
VALUES
(SEQ_ID_PAIS.NEXTVAL, 'INDONESIA');

INSERT INTO PAISES
VALUES
(SEQ_ID_PAIS.NEXTVAL, 'AFGANIST�N');

SELECT ID_PAIS IDE, NOMBRE PAIS
FROM PAISES
WHERE NOMBRE LIKE 'AFG%' 
OR
NOMBRE LIKE 'AR%';

SELECT NOMBRE PAIS, ID_PAIS IDE
FROM PAISES
WHERE ID_PAIS BETWEEN 10 AND 50
ORDER BY 2;

----------------------------------------------------------.....--...--..|||||||||||||||||||||
----------------------------------------------------------.....--...--..|| UPDATE -- UPPER ||
----------------------------------------------------------.....--...--..|||||||||||||||||||||

UPDATE PAISES SET NOMBRE = UPPER(NOMBRE); --Nombres de Pa�ses a may�sculas

UPDATE 
PAISES
SET NOMBRE = UPPER(NOMBRE)
WHERE ID_PAIS = 18;

UPDATE PERSONAS
SET APELLIDO = UPPER(APELLIDO);


--------------------
-- Insertar Personas
--------------------
INSERT INTO PERSONAS
VALUES
(1, 'MART�N', 'HERN�NDEZ', '29/04/1982',
4676543, 89898989, 'Martin@PC.COM', 12);

INSERT INTO PERSONAS
VALUES
(2, 'ROSMARY', 'BEL�N', '03/07/1984',
8976543, 564765746, 'Rosma@PC.COM', 12);

INSERT INTO PERSONAS
VALUES
(3, 'PAQUIRR�N', 'HERN�NDEZ', '15/12/2014',
123456, 43645272, 'YoPaco@ElSitio.COM', 12);

INSERT INTO PERSONAS
VALUES
(4, 'WILLIAM', 'VOLLMANN', '26/4/1962',
67898766, 78880000, 'Vollmann@us.COM', 17);

INSERT INTO PERSONAS
VALUES
(5, 'DAVID FOSTER', 'WALLACE', '19/4/1976', 
9994442233, 555789876, 'DFW@theinfinitejest.COM', 17);

INSERT INTO PERSONAS
VALUES
(6, 'NATASHA', 'ZARAKOVICH', '12/4/1981', 
78965, 91222565, 'ZaraKoVich@ru.COM', 16);

INSERT INTO PERSONAS
VALUES
(7, 'OLAJ', 'BRONSHTEINGAR', '02/7/1966', 
8965, 5666667888, 'Bronshte@germa.COM', 1);

INSERT INTO PERSONAS
SELECT MAX(ID_PERSONA)+1, 'PAULA', 'EISENBARGH', '19/9/1991', 
772222, 778899, 'PaulaEisen@POL.COM', 9
FROM PERSONAS;

INSERT INTO PERSONAS
SELECT MAX(ID_PERSONA)+1, 'FLORENCIA', 'MART�NEZ', '07/12/1989', 
786533333, 99221111, 'FlorenciaMartinez@argen.COM', 2
FROM PERSONAS;

INSERT INTO PERSONAS
SELECT MAX(ID_PERSONA)+1, 'THOMAS', 'PYNCHON', '08/05/1937', 
99999999, 9999, 'GravitysRainbow@v2.i2p', 17
FROM PERSONAS
;

INSERT INTO PERSONAS
SELECT MAX(ID_PERSONA)+1, 'JULIO', 'CORTAZAR', '26/08/1914', 88888888, 87678, 'cronopio@rayuela.i2p', 2
FROM 
PERSONAS;

INSERT INTO PERSONAS
SELECT MAX(ID_PERSONA)+1, 'THOMAS, PYNCHON, HOLA, PYTHON', 'PYNCHON', '08/05/1937', -------- VER VER VER VER VER VER VER VER
933333, 88, 'GravitysRainbow@v2.i2p', 17
FROM PERSONAS
;

INSERT INTO PERSONAS
(ID_PERSONA, NOMBRE, APELLIDO, FEC_NAC, DOCUMENTO, TELEFONO, CORREO, ID_PAIS)
SELECT *
FROM
(
SELECT MAX(ID_PERSONA)+1, 'JOSNIAK', 'KLOGFGRANK', '14/07/1945', 987898989, 5555555, 'KLOGFGRANK@rod.pl'
FROM PERSONAS
)
,
(
SELECT ID_PAIS FROM PAISES WHERE NOMBRE = 'POLONIA'
) PAIS
;

INSERT INTO PERSONAS
(ID_PERSONA, NOMBRE, APELLIDO, FEC_NAC, DOCUMENTO, TELEFONO, CORREO, ID_PAIS)
SELECT *
FROM
(
SELECT MAX(ID_PERSONA)+1, 'ALBERTO', 'LAISECA', '03/03/1943', 77777777, 333399999,'LAISEK@tecnocracia.ci2p'
FROM PERSONAS
)
,
(
SELECT ID_PAIS FROM PAISES WHERE NOMBRE = 'ARGENTINA'
) PAIS
;

INSERT INTO PERSONAS
(ID_PERSONA, NOMBRE, APELLIDO, FEC_NAC, DOCUMENTO, TELEFONO, CORREO, ID_PAIS)
SELECT *
FROM
(
SELECT MAX(ID_PERSONA)+1, 'JOUIN', 'LI TONG', '09/07/1980', 4545, 11111234, 'LITONG@tong.com'
FROM PERSONAS
)
,
(
SELECT ID_PAIS FROM PAISES WHERE NOMBRE = 'CHINA'
) PAIS
;

INSERT INTO PERSONAS
(ID_PERSONA, NOMBRE, APELLIDO, FEC_NAC, DOCUMENTO, TELEFONO, CORREO, ID_PAIS)
SELECT * FROM
(
SELECT MAX(ID_PERSONA)+1, 'NADIA', 'VLATSVORKY', '03/12/1989', 455545555, 678, 'nadia_vlatsvorky@russ.com'
FROM PERSONAS
)
,
(
SELECT ID_PAIS FROM PAISES WHERE NOMBRE = 'RUSIA'
)PAIS
;

SELECT MAX(ID_PERSONA)+1 FROM PERSONAS;

INSERT INTO PERSONAS
(ID_PERSONA, NOMBRE, APELLIDO, FEC_NAC, DOCUMENTO, CORREO)
VALUES
(16, 'CID', 'CAMPEADOR', '01/12/1934', 12332343, 'elcidcampeador@elcid.com')
;

INSERT INTO PERSONAS
(ID_PERSONA, NOMBRE, APELLIDO, FEC_NAC, DOCUMENTO, CORREO)
VALUES
(17, 'PIERRE', 'MONET', '01/12/1949', 662221112, 'PIERREmoney@pierre.com')
;

INSERT INTO PERSONAS
SELECT MAX(ID_PERSONA)+1, 'FREDERICH', 'MASTLKRICK', '21/04/1914', 74111199, 54, 'cronopio@rayuela.i2p', NULL
FROM PERSONAS;



SELECT ID_PAIS FROM PAISES WHERE NOMBRE = 'ARGENTINA';
SELECT * FROM PERSONAS WHERE ID_PAIS = 9;



--SELECT NOMBRE, ID_PERSONA "id" FROM PERSONAS WHERE ID_PAIS = 17;
--SELECT ID_PAIS FROM PAISES WHERE NOMBRE = 'ARGENTINA';


---------------------
-- Eliminar Registros
---------------------
DELETE -- Eliminar resgistros cuyo ID sea uno de (1,2,12,10,11)
FROM 
PERSONAS
WHERE ID_PAIS IN(1,2);

DELETE FROM PERSONAS;  -- Elimina todos los registros !!!

DELETE -- Eimina registros bajo condici�n.
FROM PAISES
WHERE ID_PAIS
IN (7,11);

SELECT * FROM PERSONAS
ORDER BY ID_PERSONA;



--------------------
-- Insetrar Docentes
--------------------
INSERT 
INTO DOCENTES
(ID_DOCENTE, ID_PERSONA, FEC_INGRESO, FEC_REGISTRO) --Se especifica solo los atributos que se ingresan.
VALUES (1, 1, '27/11/2015', '01/01/2015');          -- si se quiere insertar todos los datos no ser�a necesario.

INSERT 
INTO DOCENTES
(ID_DOCENTE, ID_PERSONA, FEC_INGRESO, FEC_REGISTRO)
VALUES (2, 5, '27/11/2015', '01/01/2015');

INSERT 
INTO DOCENTES
(ID_DOCENTE, ID_PERSONA, FEC_INGRESO, FEC_REGISTRO)
VALUES (3, 2, '27/11/2015', '01/01/2015');

INSERT
INTO DOCENTES
(ID_DOCENTE, ID_PERSONA, FEC_INGRESO, FEC_REGISTRO)
SELECT MAX(ID_DOCENTE)+1, 10, '01/02/2003', '09/09/2009'
FROM DOCENTES;

INSERT
INTO DOCENTES
(ID_DOCENTE, ID_PERSONA, FEC_INGRESO, FEC_REGISTRO)
SELECT MAX(ID_DOCENTE)+1, 3, '27/11/2015', '01/01/2015'
FROM DOCENTES;

INSERT
INTO DOCENTES
(ID_DOCENTE, ID_PERSONA, FEC_INGRESO, FEC_REGISTRO)
SELECT MAX(ID_DOCENTE)+1, 6, '27/11/2015', '09/03/1980'
FROM DOCENTES;


--__--__--__||||||||||||||||||||||||||
--__--__--__|| Insertar Estudiantes ||
--__--__--__||||||||||||||||||||||||||

INSERT INTO ESTUDIANTES
(ID_ESTUDIANTE, ID_PERSONA, FEC_REGISTRO)
VALUES
(1, 7, '20/11/2015');

INSERT INTO ESTUDIANTES
(ID_ESTUDIANTE, ID_PERSONA, FEC_REGISTRO)
VALUES
(2, 12, '20/11/2015');

INSERT INTO ESTUDIANTES
(ID_ESTUDIANTE, ID_PERSONA, FEC_REGISTRO)
VALUES
(3, 14, '20/11/2015');



--__--__--__||||||||||||||||||||||
--__--__--__|| Insertar Materias||
--__--__--__||||||||||||||||||||||

INSERT 
INTO
MATERIAS
(1, 'PROGRAMACION ORIENTADA A OBJETOS');

INSERT INTO MATERIAS
SELECT MAX(ID_MATERIA)+1, 'PROGRAMAI�N SQL'
FROM 
MATERIAS;

INSERT INTO MATERIAS
SELECT MAX(ID_MATERIA)+1, 'TESTING FUNCIONAL'
FROM 
MATERIAS;

INSERT INTO MATERIAS
SELECT MAX(ID_MATERIA)+1, 'LITERATURA POST-MODERNISTA'
FROM 
MATERIAS;

INSERT INTO MATERIAS
SELECT MAX(ID_MATERIA)+1, 'PROGRAMACI�N JAVA'
FROM 
MATERIAS;

INSERT INTO MATERIAS
SELECT MAX(ID_MATERIA)+1, 'HACKING �TICO'
FROM 
MATERIAS;

INSERT INTO MATERIAS
SELECT MAX(ID_MATERIA)+1, 'LENGUAJE ENSAMBLADOR'
FROM 
MATERIAS;

INSERT INTO MATERIAS
SELECT MAX(ID_MATERIA)+1, 'GUITARRA CL�SICA'
FROM MATERIAS
;

--__--__--__||||||||||||||||||||||||||
--__--__--__||   Insertar Cursos    ||
--__--__--__||||||||||||||||||||||||||


INSERT INTO CURSOS
(ID_CURSO, ID_DOCENTE, ID_MATERIA, FEC_INICIO, FEC_FIN, MODALIDAD)
VALUES
(1, 1, 4, '15/03/2016', '12/12/2015', 'PRESENCIAL');

DESCRIBE CURSOS;

INSERT INTO CURSOS
(ID_CURSO, ID_DOCENTE, ID_MATERIA, FEC_INICIO, FEC_FIN, MODALIDAD)
VALUES
(2, 2, 2, '16/03/2016', '13/12/2015', 'PRESENCIAL');

INSERT INTO CURSOS
(ID_CURSO, ID_DOCENTE, ID_MATERIA, FEC_INICIO, FEC_FIN, MODALIDAD)
VALUES
(3, 3, 3, '16/03/2017', '13/12/2016', 'PRESENCIAL');




-----------------------.....--...--..||||||||||||||||||||||||||
-----------------------.....--...--..|| Insertar Matriculas  ||
-----------------------.....--...--..||||||||||||||||||||||||||

INSERT INTO MATRICULAS
VALUES
(1,1,2, '01/01/2016', NULL);




-------------......--....--...--||||||||||||||||||||||||
-------------......--....--...--||      INNER JOIN    ||
-------------......--....--...--||||||||||||||||||||||||

SELECT PAISES.NOMBRE PAIS, PAISES.ID_PAIS "CODIGO",
PERSONAS.NOMBRE,
PERSONAS.APELLIDO,
PERSONAS.FEC_NAC "FECHA NACIMIENTO"
FROM PERSONAS
INNER JOIN PAISES
ON PAISES.ID_PAIS = PERSONAS.ID_PAIS
ORDER BY 1;

SELECT 
DOCENTES.FEC_INGRESO "INGRES�",
DOCENTES.FEC_REGISTRO "REGISTRO",
DOCENTES.FEC_EGRESO "EGRESA EN...",
PERSONAS.NOMBRE,
PERSONAS.APELLIDO,
PERSONAS.TELEFONO
FROM PERSONAS
INNER JOIN DOCENTES
ON DOCENTES.ID_PERSONA = PERSONAS.ID_PERSONA
ORDER BY 1;

SELECT
PAISES.ID_PAIS "CODIGO DE PAIS", PAISES.NOMBRE "PAIS",
PERSONAS.NOMBRE,
PERSONAS.APELLIDO,
PERSONAS.FEC_NAC,
PERSONAS.CORREO "MAIL"
FROM PERSONAS
INNER JOIN PAISES
ON PAISES.ID_PAIS = PERSONAS.ID_PAIS
ORDER BY 1;

SELECT 
PAISES.NOMBRE AS "PROCEDENCIA",
PERSONAS.NOMBRE,
PERSONAS.APELLIDO,
PERSONAS.CORREO "CONTACTO"
FROM PERSONAS
INNER JOIN PAISES
ON PAISES.ID_PAIS = PERSONAS.ID_PAIS
ORDER BY 1;

SELECT
DOCENTES.FEC_INGRESO "INGRES�", DOCENTES.FEC_REGISTRO "SE REGISTR�",
PERSONAS.NOMBRE,
PERSONAS.APELLIDO,
PERSONAS.FEC_NAC "FECHA NACIMIENTO"
FROM PERSONAS
INNER JOIN DOCENTES
ON DOCENTES.ID_PERSONA = PERSONAS.ID_PERSONA
ORDER BY 1
;

SELECT --Con muchas combinaciones
PERSONAS.NOMBRE,
PERSONAS.APELLIDO
FROM PERSONAS
INNER JOIN PAISES
ON PAISES.ID_PAIS = PERSONAS.ID_PAIS
WHERE PAISES.NOMBRE = 'URUGUAY'
OR
(
(PAISES.NOMBRE = 'RUSIA' AND PERSONAS.NOMBRE = 'NATASHA')
OR
(PAISES.NOMBRE = 'ESTADOS UNIDOS' AND PERSONAS.NOMBRE = 'THOMAS')
OR
(PAISES.NOMBRE = 'ESTADOS UNIDOS' OR PERSONAS.APELLIDO = 'WALLACE')
)
;

SELECT --Con muchas m�s combinaciones
PAISES.NOMBRE "PROCEDENCIA",
PERSONAS.APELLIDO,
PERSONAS.NOMBRE,
PERSONAS.CORREO
FROM PERSONAS
INNER JOIN PAISES
ON PAISES.ID_PAIS = PERSONAS.ID_PAIS
WHERE PAISES.NOMBRE = 'RUSIA'
OR
  (
  (PERSONAS.NOMBRE = 'THOMAS' AND PAISES.NOMBRE = 'ESTADOS UNIDOS')
    OR
  (PERSONAS.APELLIDO = 'HERN�NDEZ' AND PAISES.NOMBRE = 'URUGUAY')
  )
OR
  (
  (PAISES.ID_PAIS = 9 AND PERSONAS.NOMBRE = 'JOSNIAK')
    AND
  (PERSONAS.APELLIDO = 'KLOGFGRANK')
  )

ORDER BY 1
;

SELECT 
  PAISES.NOMBRE, 
  PAISES.ID_PAIS "COD. PAIS",
  PERSONAS.APELLIDO,
  PERSONAS.NOMBRE,
  PERSONAS.TELEFONO,
  PERSONAS.DOCUMENTO
FROM PERSONAS
  INNER JOIN PAISES
ON PAISES.ID_PAIS = PERSONAS.ID_PAIS
  WHERE PAISES.NOMBRE = 'URUGUAY'
OR
  PERSONAS.APELLIDO = 'HERN�NDEZ'
ORDER BY 3;


---------------------......--....--...--||||||||||||||||||||||||---.....----...--------||||||||||||||||||||||||||||||||||||||||||||
---------------------......--....--...--||      OUTER JOIN    ||---.....----...--------|||| NECESARIO USAR OUTER JOIN CUANDO FK||||
---------------------......--....--...--||||||||||||||||||||||||---.....----...--------|||| PUEDE SER NULL                     ||||
                                                                ---.....----...--------||||||||||||||||||||||||||||||||||||||||||||


SELECT
PERSONAS.NOMBRE,
PERSONAS.APELLIDO,
PAISES.NOMBRE PAIS
FROM PERSONAS
LEFT OUTER JOIN PAISES
ON PAISES.ID_PAIS = PERSONAS.ID_PAIS ------------- LEFT Devuelve todos los de la izquierda aunque no tengan registrad PAIS
ORDER BY 2;

SELECT
PERSONAS.NOMBRE,
PERSONAS.APELLIDO,
PERSONAS.FEC_NAC "FECHA NACIMIENTO",-------------- RIGHT Devuelve todos los de la derecha aunque no tengan Registrado Personas
PAISES.NOMBRE PAIS
FROM PERSONAS
RIGHT OUTER JOIN PAISES
ON PAISES.ID_PAIS = PERSONAS.ID_PAIS
ORDER BY 1;


SELECT
PAISES.ID_PAIS CODIGO,
PAISES.NOMBRE PAIS,
PERSONAS.NOMBRE,
PERSONAS.APELLIDO,
PERSONAS.FEC_NAC "NACIO EL"   -- FULL Devuelve todos: los paises que no tiene persona
FROM PERSONAS                 -- y las personas que no rienen pais.
FULL OUTER JOIN PAISES
ON PAISES.ID_PAIS = PERSONAS.ID_PAIS
ORDER BY 1;

SELECT
PERSONAS.NOMBRE,
PERSONAS.APELLIDO,
PERSONAS.CORREO,
PAISES.NOMBRE
FROM PERSONAS
FULL OUTER JOIN PAISES
ON PAISES.ID_PAIS = PERSONAS.ID_PAIS
ORDER BY 4;


SELECT
PERSONAS.NOMBRE,
PERSONAS.APELLIDO,
DOCENTES.ID_DOCENTE "DOCENTE Nro."
FROM PERSONAS
RIGHT OUTER JOIN DOCENTES
ON DOCENTES.ID_PERSONA = PERSONAS.ID_PERSONA
ORDER BY 3;

SELECT
PERSONAS.APELLIDO,
PERSONAS.NOMBRE,
ESTUDIANTES.ID_ESTUDIANTE "ESTUDIANTE Nro.",
ESTUDIANTES.FEC_REGISTRO "REGISTRADO EL"
FROM PERSONAS
RIGHT OUTER JOIN ESTUDIANTES
ON ESTUDIANTES.ID_PERSONA = PERSONAS.ID_PERSONA
ORDER BY 3;

SELECT
PERSONAS.NOMBRE,
PERSONAS.APELLIDO,
PAISES.NOMBRE PAIS,
DOCENTES.ID_DOCENTE "Nro. Doc",
CURSOS.ID_MATERIA
FROM DOCENTES
RIGHT OUTER JOIN CURSOS ON DOCENTES.ID_DOCENTE = CURSOS.ID_DOCENTE
RIGHT OUTER JOIN PERSONAS ON PERSONAS.ID_PERSONA = DOCENTES.ID_PERSONA
INNER JOIN PAISES ON PERSONAS.ID_PAIS = PAISES.ID_PAIS
;

SELECT
  CURSOS.ID_CURSO "ID. Curso",
  CURSOS.FEC_INICIO,
  CURSOS.FEC_FIN,
  CURSOS.MODALIDAD,
    PERSONAS.APELLIDO ||', '|| PERSONAS.NOMBRE "Nombre Completo",
    PERSONAS.CORREO "Mail",
      PAISES.NOMBRE Pais,
        MATERIAS.NOMBRE "Materia Dictada"
FROM DOCENTES
  INNER JOIN CURSOS ON CURSOS.ID_DOCENTE = DOCENTES.ID_DOCENTE
  INNER JOIN PERSONAS ON PERSONAS.ID_PERSONA = DOCENTES.ID_PERSONA
  INNER JOIN PAISES ON PERSONAS.ID_PAIS = PAISES.ID_PAIS
  INNER JOIN MATERIAS ON CURSOS.ID_MATERIA = MATERIAS.ID_MATERIA
  ORDER BY 2;


SELECT
  CURSOS.ID_CURSO "ID. Curso",
  CURSOS.FEC_INICIO,
  CURSOS.FEC_FIN,
  CURSOS.MODALIDAD,
    PERSONAS.APELLIDO ||', '|| PERSONAS.NOMBRE "Nombre Completo",
    PERSONAS.CORREO "Mail",
      PAISES.NOMBRE Pais,
        MATERIAS.NOMBRE "Materia Dictada"
FROM DOCENTES
  INNER JOIN CURSOS ON CURSOS.ID_DOCENTE = DOCENTES.ID_DOCENTE
  INNER JOIN PERSONAS ON PERSONAS.ID_PERSONA = DOCENTES.ID_PERSONA
  INNER JOIN PAISES ON PAISES.ID_PAIS = PERSONAS.ID_PAIS
  INNER JOIN MATERIAS ON MATERIAS.ID_MATERIA = CURSOS.ID_MATERIA
ORDER BY 8;

DESCRIBE MATRICULAS;



SELECT
PERSONAS.APELLIDO ||', '|| PERSONAS.NOMBRE "Nombre completo",
ESTUDIANTES.ID_ESTUDIANTE
FROM ESTUDIANTES
INNER JOIN PERSONAS
ON PERSONAS.ID_PERSONA = ESTUDIANTES.ID_PERSONA
order by 2
;


SELECT PERSONAS.APELLIDO||', '||PERSONAS.NOMBRE "Apellido, Nombre",
PAISES.NOMBRE,
ESTUDIANTES.ID_ESTUDIANTE
FROM PERSONAS
INNER JOIN ESTUDIANTES ON PERSONAS.ID_PERSONA = ESTUDIANTES.ID_PERSONA
INNER JOIN PAISES ON PERSONAS.ID_PAIS = PAISES.ID_PAIS;

SELECT
PERSONAS.APELLIDO||', '||PERSONAS.NOMBRE "Apellido, Nombre",
PAISES.NOMBRE,
ESTUDIANTES.ID_ESTUDIANTE
FROM ESTUDIANTES
INNER JOIN PERSONAS ON PERSONAS.ID_PERSONA = ESTUDIANTES.ID_PERSONA
INNER JOIN PAISES ON PERSONAS.ID_PAIS = PAISES.ID_PAIS;

DESCRIBE MATRICULAS;


------||||||||||||||||||||||||||||||||||||||||||||||
------||TODO LO RELACIONADO A LA TABLA MATR�CULAS|||
----- ||||||||||||||||||||||||||||||||||||||||||||||




SELECT
ESTUDIANTES.ID_ESTUDIANTE "Estudiante #",
MATERIAS.NOMBRE Materia,
MATERIAS.ID_MATERIA,
CURSOS.ID_CURSO "Curso #",
CURSOS.FEC_INICIO ||' - '|| CURSOS.FEC_FIN "Inicia-Termina",
MATRICULAS.FEC_MATRICULA "Fecha de Matr�cula",
MATRICULAS.NOTA_FINAL "Calificaci�n Final"
FROM MATRICULAS
INNER JOIN CURSOS ON CURSOS.ID_CURSO = MATRICULAS.ID_CURSO
INNER JOIN MATERIAS ON MATERIAS.ID_MATERIA = CURSOS.ID_MATERIA
INNER JOIN ESTUDIANTES ON MATRICULAS.ID_ESTUDIANTE = ESTUDIANTES.ID_ESTUDIANTE;


SELECT
ESTUDIANTES.ID_ESTUDIANTE,
PERSONAS.APELLIDO,
PERSONAS.NOMBRE,
PAISES.NOMBRE PAIS
FROM PERSONAS
INNER JOIN ESTUDIANTES
ON ESTUDIANTES.ID_PERSONA = PERSONAS.ID_PERSONA
INNER JOIN PAISES
ON PAISES.ID_PAIS = PERSONAS.ID_PAIS
ORDER BY 3;




SELECT
ID_ESTUDIANTE "Estudiante Nro.",
  PERSONAS.APELLIDO||', '||PERSONAS.NOMBRE "Apellido, Nombre",
    PAISES.NOMBRE
FROM PERSONAS
  INNER JOIN ESTUDIANTES
  ON PERSONAS.ID_PERSONA = ESTUDIANTES.ID_PERSONA
    INNER JOIN PAISES
    ON PAISES.ID_PAIS = PERSONAS.ID_PAIS;


-- Nombre, apellido, id y Pa�s del docente qe dicta 'Literatura post-modernista'

SELECT 
  DOCENTES.ID_DOCENTE                         "Docente #",
  PERSONAS.APELLIDO ||', '|| PERSONAS.NOMBRE  "Apellido, Nombre",
  PAISES.NOMBRE                               "Pa�s de origen",
  --MATERIAS.NOMBRE                             "Dicta la Materia",
  MATRICULAS.FEC_MATRICULA                    "Fecha de Matricula"
FROM CURSOS
  INNER JOIN DOCENTES ON DOCENTES.ID_DOCENTE  = CURSOS.ID_DOCENTE
  INNER JOIN PERSONAS ON DOCENTES.ID_PERSONA  = PERSONAS.ID_PERSONA
  INNER JOIN PAISES   ON PAISES.ID_PAIS       = PERSONAS.ID_PAIS
  INNER JOIN MATERIAS ON MATERIAS.ID_MATERIA  = CURSOS.ID_MATERIA
  INNER JOIN MATRICULAS ON CURSOS.ID_CURSO    = MATRICULAS.ID_CURSO
  WHERE MATERIAS.NOMBRE LIKE 'LITERATURA%'
ORDER BY 1;


SELECT COUNT (ID_PERSONA) "CANTIDAD DE REGISTROS" FROM PERSONAS;

SELECT NOMBRE, APELLIDO
FROM PERSONAS
WHERE ID_PERSONA NOT IN
(SELECT ESTUDIANTES.ID_PERSONA FROM ESTUDIANTES);

SELECT APELLIDO ||', '||NOMBRE "Estudiante", ID_PERSONA
FROM PERSONAS
WHERE ID_PERSONA IN
(SELECT ESTUDIANTES.ID_PERSONA FROM ESTUDIANTES);



SELECT
--PERSONAS.NOMBRE,
CURSOS.MODALIDAD,
DOCENTES.ID_DOCENTE "Nro. DOCENTE"
FROM MATERIAS
--INNER JOIN PERSONAS ON DOCENTES.ID_PERSONA = PERSONAS.ID_PERSONA
INNER JOIN CURSOS ON CURSOS.ID_MATERIA = MATERIAS.ID_MATERIA
INNER JOIN DOCENTES ON DOCENTES.ID_DOCENTE = CURSOS.ID_DOCENTE
ORDER BY 1;


SELECT NOMBRE, APELLIDO
FROM PERSONAS
WHERE FEC_NAC IN
(
   SELECT
   FEC_NAC FROM 
   PERSONAS WHERE FEC_NAC > '01/01/1960'
);


SELECT  table_name,
        index_name,
        uniqueness
FROM user_indexes
ORDER BY 1,2;



























--||||||||||||||||||||||||||||||||||||||||||||
--||    INSERTAR DATOS DESDE AQRCHIVO SQL   ||
--||||||||||||||||||||||||||||||||||||||||||||

-- @@c:\Users\Tincho\Desktop\UTEC\ProgramacionSQL\Semana2\Material\Instituto_BaseDatos.sql;


--||||||||||||||||||||||||||||||||||||||||||||||||||||||||
--||                      QUERYS                        ||
--||||||||||||||||||||||||||||||||||||||||||||||||||||||||


SELECT 
NOMBRE "Pa�s", ID_PAIS "Identificador" --Paises con ID impar
FROM PAISES
WHERE mod(ID_PAIS, 3) = 0
ORDER BY 2
;

SELECT 
NOMBRE "Pa�s", ID_PAIS "Identificador" --Paises con ID par
FROM PAISES
WHERE mod(ID_PAIS, 2) = 0
ORDER BY 2
;


SELECT NOMBRE "A", APELLIDO "B", CORREO
FROM 
PERSONAS;

SELECT NOMBRE, APELLIDO, CORREO
FROM PERSONAS
WHERE ID_PAIS = 12;

SELECT NOMBRE
FROM PAISES
WHERE ID_PAIS = 12;

SELECT NOMBRE "Pa�s", ID_PAIS "C�DIGO"
FROM PAISES
order by 1;

SELECT NOMBRE, APELLIDO, CORREO, TELEFONO
FROM PERSONAS
WHERE SYSDATE - FEC_NAC > 18;


SELECT NOMBRE, APELLIDO
FROM PERSONAS
WHERE ID_PERSONA = 2;


DELETE FROM PERSONAS WHERE ID_PERSONA = 12;

SELECT * 
FROM PERSONAS
WHERE 
NOMBRE IN('%HOLA%');

SELECT * 
FROM  PERSONAS 
WHERE NOMBRE = 'MART�N' 
OR    APELLIDO IN ('HERN�NDEZ', 'BEL�N')
OR    ID_PAIS  IN (1,2,10,17)
;

SELECT ID_PERSONA FROM PERSONAS WHERE NOMBRE = 'PAQUIRR�N';
SELECT MAX(ID_DOCENTE)+1 FROM DOCENTES;

SELECT * FROM PERSONAS
ORDER BY ID_PERSONA DESC; --Ordena de forma DESCENDENTE

COMMIT;


SELECT NOMBRE, APELLIDO, FEC_NAC
FROM PERSONAS
WHERE FEC_NAC BETWEEN '01/01/1920' AND '31/10/1984'
ORDER BY 3;

SELECT ID_CURSO IDE, MODALIDAD, FEC_INICIO
FROM CURSOS
WHERE FEC_INICIO BETWEEN '01/01/2015' AND '01/01/2017';



SELECT
MATERIAS.NOMBRE MATERIA,
CURSOS.ID_CURSO,
CURSOS.MODALIDAD,
CURSOS.FEC_INICIO "INICIA EN"
FROM CURSOS
INNER JOIN MATERIAS
ON MATERIAS.ID_MATERIA = CURSOS.ID_MATERIA
ORDER BY 1, 3;


SELECT
ESTUDIANTES.FEC_REGISTRO "REGISTRADO EL",
PERSONAS.NOMBRE,
PERSONAS.APELLIDO,
PERSONAS.CORREO
FROM PERSONAS
INNER JOIN ESTUDIANTES
ON ESTUDIANTES.ID_PERSONA = PERSONAS.ID_PERSONA
WHERE FEC_REGISTRO BETWEEN '01/01/2015' AND '01/01/2016'
ORDER BY FEC_REGISTRO;



SELECT
CURSOS.FEC_INICIO,
CURSOS.FEC_FIN,
CURSOS.MODALIDAD,
MATERIAS.NOMBRE MATERIA
FROM CURSOS
FULL OUTER JOIN MATERIAS
ON MATERIAS.ID_MATERIA = CURSOS.ID_MATERIA
ORDER BY 1, 2;

SELECT
CURSOS.FEC_INICIO,
CURSOS.FEC_FIN,
CURSOS.MODALIDAD,
MATERIAS.NOMBRE MATERIA
FROM CURSOS
RIGHT OUTER JOIN MATERIAS
ON MATERIAS.ID_MATERIA = CURSOS.ID_MATERIA
ORDER BY 4;




INSERT INTO CONTINENTES
(ID_CONTINENTE, NOMBRE, ECONOMIA)
SELECT
MAX(ID_CONTINENTE)+1, 'PRUEBA1', 56
FROM CONTINENTES
;

INSERT INTO CONTINENTES
(ID_CONTINENTE, NOMBRE, ECONOMIA)
VALUES
(SEQ_ID_CONTINENTE.NEXTVAL, 'PRUEBA2',78)
;

INSERT INTO CONTINENTES
(ID_CONTINENTE, NOMBRE, ECONOMIA)
SELECT
MAX(ID_CONTINENTE)+1, 'PRUEBAX', 8999
FROM CONTINENTES
;

INSERT INTO CONTINENTES
(ID_CONTINENTE, NOMBRE, ECONOMIA)
SELECT
MAX(ID_CONTINENTE)+1, 'CCCCCCCCCCCCCCCCCC', 8999
FROM CONTINENTES
;

DELETE FROM CONTINENTES
WHERE ECONOMIA = 8999;

DELETE FROM CONTINENTES
WHERE ECONOMIA IN (56, 78);


SELECT *
FROM CONTINENTES;
SELECT * FROM PERSONAS;

DELETE FROM PERSONAS
WHERE FEC_NAC < '01/01/1900';

SELECT * FROM PERSONAS
WHERE FEC_NAC < '01/01/1980';


DESCRIBE PERSONAS;

SELECT SEQ_ID_CONTINENTE.NEXTVAL FROM CONTINENTES;



SELECT * FROM USER_SEQUENCES;


