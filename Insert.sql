INSERT 
INTO DOCENTES
(ID_DOCENTE, ID_PERSONA, FEC_INGRESO, FEC_REGISTRO) --Se especifica solo los atributos que se ingresan.
VALUES (1, 1, '27/11/2015', '01/01/2015');          -- si se quiere insertar todos los datos no sería necesario.

----------------------------------------------------------------------------------------------------------------

SELECT MAX(ID_PERSONA)+1 FROM PERSONAS;

INSERT INTO PERSONAS
(ID_PERSONA, NOMBRE, APELLIDO, FEC_NAC, DOCUMENTO, CORREO)
VALUES
(16, 'CID', 'CAMPEADOR', '01/12/1934', 12332343, 'elcidcampeador@elcid.com')
;

INSERT INTO PERSONAS
VALUES
(5, 'DAVID FOSTER', 'WALLACE', '19/4/1976', 
9994442233, 555789876, 'DFW@theinfinitejest.COM', 17);

INSERT INTO PERSONAS
SELECT MAX(ID_PERSONA)+1, 'PAULA', 'EISENBARGH', '19/9/1991', 
772222, 778899, 'PaulaEisen@POL.COM', 9
FROM PERSONAS;

----------------------------------------------------------------------------------------------------------------


-- Buscando en id máximo en la tabla Personas y el id Pais cuyo Nombre es Polonia

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