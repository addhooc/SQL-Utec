--|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
--||  AGREGAR (ADD), ELIMINAR (DROP), MODIFICAR (MODIFY), RENOMBRAR (RENAME) ||
--|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||


ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY';  --Cambiar formato de FECHA


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
