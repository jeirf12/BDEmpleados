UPDATE contratacion.empleado SET emp_nombre = 'Orlandx' WHERE emp_id = 7;  
SELECT * FROM contratacion.empleado  WHERE emp_id = 7;  
DELETE FROM contratacion.habilidades WHERE hab_id = 1;  
SELECT * FROM contratacion.habilidades  WHERE hab_id = 1;  

SELECT * FROM contratacion.salarios; 

INSERT INTO contratacion.habilidades VALUES (3, 'Habilidad Técnica2', 'Técnica2'); 
SELECT * FROM contratacion.habilidades WHERE hab_id = 3;  

ROLLBACK; 