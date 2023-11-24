LOAD DATA
INFILE 'contrato.csv'
APPEND INTO TABLE contrato
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    CON_ID INTEGER EXTERNAL,
    TIPCON_ID INTEGER EXTERNAL,
    EMP_ID INTEGER EXTERNAL,
    MODCON_ID INTEGER EXTERNAL,
    MON_ID CHAR,
    CON_FOLIO CHAR,
    CON_FECHA_INICIO DATE "MM/DD/YYYY",
    CON_FECHA_FIN DATE "MM/DD/YYYY"
)