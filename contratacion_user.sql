   -- Elimina un usuario llamado 'contratacion'
   DROP USER contratacion CASCADE;

   -- Elimina los usuarios del sistema 'contratacion'
   DROP USER Contralor1 CASCADE;
   DROP USER PasanteTH1 CASCADE;

   -- Elimina los roles del sistema 'contratacion'
   DROP ROLE Contralor; 
   DROP ROLE Talento_humano; 

   -- Elimina la tablespace llamada 'contratacion_rh' incluyendo su contenido y archivos de datos
   DROP TABLESPACE contratacion_rh INCLUDING CONTENTS AND DATAFILES;

   -- Crea una nueva tablespace llamada 'contratacion_rh'
   CREATE TABLESPACE contratacion_rh
   DATAFILE 'contratacion_rh.dbf' SIZE 100M
   AUTOEXTEND ON
   NEXT 10M MAXSIZE UNLIMITED
   EXTENT MANAGEMENT LOCAL;

   -- Crea un nuevo usuario llamado 'contratacion' con contraseña 'oracle'
   CREATE USER contratacion IDENTIFIED BY oracle;

   -- Establece la tablespace por defecto para el usuario 'contratacion' como 'contratacion_rh'
   ALTER USER contratacion DEFAULT TABLESPACE contratacion_rh;

   -- Concede permiso al usuario 'contratacion' para crear sesiones en la base de datos
   GRANT CREATE SESSION TO contratacion;

   -- Concede permisos al usuario 'contratacion' para crear tablas y vistas
   GRANT CREATE TABLE, CREATE VIEW TO contratacion;

   -- Establece una cuota ilimitada en la tablespace 'contratacion_rh' para el usuario 'contratacion'
   ALTER USER contratacion QUOTA UNLIMITED ON contratacion_rh;

   CREATE ROLE Contralor; 
   CREATE ROLE Talento_humano; 

   -- Crea un nuevo usuario llamado 'Contralor1' con contraseña 'oracle'
   CREATE USER Contralor1 IDENTIFIED BY oracle;
   GRANT CREATE SESSION TO Contralor1;
   GRANT Contralor TO Contralor1;  


   -- Crea un nuevo usuario llamado 'PasanteTH1' con contraseña 'oracle'
   CREATE USER PasanteTH1 IDENTIFIED BY oracle;
   GRANT CREATE SESSION TO PasanteTH1;
   GRANT Talento_humano TO PasanteTH1;  
