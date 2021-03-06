-- FECHA y MESES --


-- Ultimo d�a del Mes --
SELECT 
SYSDATE HOY_ES,
  LAST_DAY(SYSDATE) ULTIMO_DIA_MES
FROM DUAL
;

-- Invento m�o :) --
SELECT 
SYSDATE -(365*2) AYER_FUE, -- Menos 2 a�os :)
  LAST_DAY(SYSDATE) ULTIMO_DIA
FROM DUAL
;

-- 1 --> LUNES; 2 --> Martes, 3 --> MIERCOLES, etc.
-- LUNES', 'MARTES', 'MIERCOLES'

-- Fechas del Lunes y Martes siguientes a SYSDATE --
SELECT
  SYSDATE   HOY,
  NEXT_DAY(SYSDATE, 1) LUNES_SIGUIENTE,         -- 1 --> LUNES
  NEXT_DAY(SYSDATE, 'MARTES') MARTES_SIGUIENTE  -- 'MARTES'
FROM DUAL
;

-- Suma o resta MESES a la fecha SYSDATE --

SELECT
  ADD_MONTHS(SYSDATE, 150) DENTRO_DE_150_MESES,
  ADD_MONTHS(SYSDATE, -600) HACE_600_MESES
FROM DUAL
;

-- Cantidad de meses que faltan a partir de SYSDATE --
SELECT
SYSDATE HOY_ES,
  TRUNC(MONTHS_BETWEEN('03/08/2016', SYSDATE),2) MESES_AL_8agosto2016
FROM DUAL
;
  
-- FECHAS Y HORAS --

ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI:SS'
;
ALTER SESSION SET NLS_DATE_FORMAT = 'DAY DD MONTH YYYY HH24:MI:SS';

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYYMMDD';

SELECT SYSDATE FROM DUAL
;

---------------------------------------------------------------------------

SELECT
  TO_CHAR(SYSDATE)              F1,
  TO_CHAR(SYSDATE, 'YYYYMMDD')  F2
FROM DUAL
;

SELECT
  TO_CHAR('1234','9999D9')    N1,
  TO_CHAR('1234','9G999D99')  N2
FROM DUAL
;

ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY';

SELECT
  TO_DATE('20151030','YYYYMMDD')  F1,
  TO_DATE('102010','MMYYYY')      F2
FROM DUAL
;

SELECT TO_NUMBER('-100,5') + 500N
FROM DUAL
;