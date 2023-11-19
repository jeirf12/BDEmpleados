   -- Elimina un usuario llamado 'contratacion'
   DROP USER contratacion;

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