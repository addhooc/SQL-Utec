DELETE -- Eliminar resgistros cuyo ID sea uno de (1,2,12,10,11)
FROM 
PERSONAS
WHERE ID_PAIS IN(1,2);

DELETE FROM PERSONAS;  -- Elimina todos los registros

DELETE -- Eimina registros bajo condición.
FROM PAISES
WHERE ID_PAIS
IN (7,11);

SELECT * FROM PERSONAS
ORDER BY ID_PERSONA;