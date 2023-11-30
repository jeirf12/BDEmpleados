/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     10/22/2023 3:36:22 PM                        */
/*==============================================================*/


alter table CONTRATO
   drop constraint FK_CONTRATO_CONTRATO__MODALIDA;

alter table CONTRATO
   drop constraint FK_CONTRATO_CONTRATO__MONEDA;

alter table CONTRATO
   drop constraint FK_CONTRATO_CONTRATO__TIPO_CON;

alter table CONTRATO
   drop constraint FK_CONTRATO_PERSONA_C_EMPLEADO;

alter table CONTRATO_SEGURIDADSOCIAL
   drop constraint FK_CONTRATO_CONTRATO__CONTRATO;

alter table CONTRATO_SEGURIDADSOCIAL
   drop constraint FK_CONTRATO_CSS_SEGUR_SEGURIDA;

alter table EMPLEADO
   drop constraint FK_EMPLEADO_TIPO_IDEN_TIPO_IDE;

alter table HABILIDADES_PERFILCARGO
   drop constraint FK_HABILIDA_HABILIDAD_PERFILCA;

alter table HABILIDADES_PERFILCARGO
   drop constraint FK_HABILIDA_HABILIDAD_HABILIDA;

alter table NOVEDADES
   drop constraint FK_NOVEDADE_CONTRATO__CONTRATO;

alter table POSICION
   drop constraint FK_POSICION_AREA_POSI_AREA;

alter table POSICION
   drop constraint FK_POSICION_A_CARGO_POSICION;

alter table POSICION
   drop constraint FK_POSICION_PERFIL_CA_PERFILCA;

alter table POSICION
   drop constraint FK_POSICION_SEDE_POSI_SEDE;

alter table POSICION_CONTRATO
   drop constraint FK_POSICION_POSICIONC_CONTRATO;

alter table POSICION_CONTRATO
   drop constraint FK_POSICION_POSICION__POSICION;

alter table SALARIOS
   drop constraint FK_SALARIOS_CONTRATO__CONTRATO;

drop table AREA cascade constraints;

drop index CONTRATO_MODALIDAD_FK;

drop index CONTRATO_TIPO_FK;

drop index CONTRATO_MONEDA_FK;

drop index PERSONA_CONTRATO_FK;

drop table CONTRATO cascade constraints;

drop index CSS_SEGURIDADSOCIAL_FK;

drop index CONTRATO_CSS_FK;

drop table CONTRATO_SEGURIDADSOCIAL cascade constraints;

drop index TIPO_IDEN_EMPLEADO_FK;

drop table EMPLEADO cascade constraints;

drop table HABILIDADES cascade constraints;

drop index HABILIDADES_PERFILCARGO2_FK;

drop index HABILIDADES_PERFILCARGO_FK;

drop table HABILIDADES_PERFILCARGO cascade constraints;

drop table MODALIDAD_CONTRATO cascade constraints;

drop table MONEDA cascade constraints;

drop index CONTRATO_NOVEDAD_FK;

drop table NOVEDADES cascade constraints;

drop table PERFILCARGO cascade constraints;

drop index AREA_POSICION_FK;

drop index A_CARGO_FK;

drop index PERFIL_CARGO_POSICION_FK;

drop index SEDE_POSICION_FK;

drop table POSICION cascade constraints;

drop index POSICION_POSICIONCONTRATO_FK;

drop index POSICIONCONTRATO_CONTRATO_FK;

drop table POSICION_CONTRATO cascade constraints;

drop index CONTRATO_SALARIO_FK;

drop table SALARIOS cascade constraints;

drop table SEDE cascade constraints;

drop table SEGURIDADSOCIAL cascade constraints;

drop table TIPO_CONTRATO cascade constraints;

drop table TIPO_IDENTIFICACION cascade constraints;

/*==============================================================*/
/* Table: AREA                                                  */
/*==============================================================*/
create table AREA 
(
   AREA_ID              INTEGER              not null,
   AREA_NOMBRE          VARCHAR2(100)        not null,
   constraint PK_AREA primary key (AREA_ID)
);

/*==============================================================*/
/* Table: CONTRATO                                              */
/*==============================================================*/
create table CONTRATO 
(
   CON_ID               INTEGER              not null,
   TIPCON_ID            INTEGER              not null,
   EMP_ID               INTEGER              not null,
   MODCON_ID            INTEGER              not null,
   MON_ID               VARCHAR2(3)          not null,
   CON_FOLIO            VARCHAR2(100)        not null,
   CON_FECHA_INICIO     DATE                 not null,
   CON_FECHA_FIN        DATE,
   constraint PK_CONTRATO primary key (CON_ID), 
   constraint UN_CON_FOLIO unique(CON_FOLIO)
) TABLESPACE contratacion_rh
   STORAGE (INITIAL 50M NEXT 10M MAXEXTENTS UNLIMITED);

/*==============================================================*/
/* Index: PERSONA_CONTRATO_FK                                   */
/*==============================================================*/
create index PERSONA_CONTRATO_FK on CONTRATO (
   EMP_ID ASC
);

/*==============================================================*/
/* Index: CONTRATO_MONEDA_FK                                    */
/*==============================================================*/
create index CONTRATO_MONEDA_FK on CONTRATO (
   MON_ID ASC
);

/*==============================================================*/
/* Index: CONTRATO_TIPO_FK                                      */
/*==============================================================*/
create index CONTRATO_TIPO_FK on CONTRATO (
   TIPCON_ID ASC
);

/*==============================================================*/
/* Index: CONTRATO_MODALIDAD_FK                                 */
/*==============================================================*/
create index CONTRATO_MODALIDAD_FK on CONTRATO (
   MODCON_ID ASC
);

/*==============================================================*/
/* Table: CONTRATO_SEGURIDADSOCIAL                              */
/*==============================================================*/
create table CONTRATO_SEGURIDADSOCIAL 
(
   CON_ID               INTEGER              not null,
   SEGSOC_ID            INTEGER              not null,
   CONSEG_FECHA_INICIO  DATE                 not null,
   CONSEG_CODIGO_DOCUMENTO VARCHAR2(200)        not null,
   CONSEG_FECHA_FINALIZACION DATE,
   constraint PK_CONTRATO_SEGURIDADSOCIAL primary key (CON_ID, SEGSOC_ID, CONSEG_FECHA_INICIO),
   constraint UN_COD_DOCUMENTO unique(CONSEG_CODIGO_DOCUMENTO) 
) TABLESPACE contratacion_rh
   STORAGE (INITIAL 100M NEXT 50M MAXEXTENTS UNLIMITED);

/*==============================================================*/
/* Index: CONTRATO_CSS_FK                                       */
/*==============================================================*/
create index CONTRATO_CSS_FK on CONTRATO_SEGURIDADSOCIAL (
   CON_ID ASC
);

/*==============================================================*/
/* Index: CSS_SEGURIDADSOCIAL_FK                                */
/*==============================================================*/
create index CSS_SEGURIDADSOCIAL_FK on CONTRATO_SEGURIDADSOCIAL (
   SEGSOC_ID ASC
);

/*==============================================================*/
/* Table: EMPLEADO                                              */
/*==============================================================*/
create table EMPLEADO 
(
   EMP_ID               INTEGER              not null,
   TIPIDE_ID            INTEGER              not null,
   EMP_CODIGO_IDENTIFICACION VARCHAR2(20)         not null,
   EMP_NOMBRE           VARCHAR2(250)        not null,
   EMP_APELLIDO         VARCHAR2(250)        not null,
   EMP_FECHA_NACIMIENTO DATE                 not null,
   EMP_GENERO           VARCHAR2(50)         not null
      constraint CKC_EMP_GENERO_EMPLEADO check (EMP_GENERO in ('MASCULINO','FEMENINO','INDEFINIDO')),
   constraint PK_EMPLEADO primary key (EMP_ID), 
   constraint un_emp_cod_iden UNIQUE (EMP_CODIGO_IDENTIFICACION)
)TABLESPACE contratacion_rh
   STORAGE (INITIAL 50M NEXT 10M MAXEXTENTS UNLIMITED);

/*==============================================================*/
/* Index: TIPO_IDEN_EMPLEADO_FK                                 */
/*==============================================================*/
create index TIPO_IDEN_EMPLEADO_FK on EMPLEADO (
   TIPIDE_ID ASC
);

/*==============================================================*/
/* Table: HABILIDADES                                           */
/*==============================================================*/
create table HABILIDADES 
(
   HAB_ID               INTEGER              not null,
   HAB_DESCRIPCION      CLOB                 not null,
   HAB_NOMBRE           VARCHAR2(250)        not null,
   constraint PK_HABILIDADES primary key (HAB_ID)
);

/*==============================================================*/
/* Table: HABILIDADES_PERFILCARGO                               */
/*==============================================================*/
create table HABILIDADES_PERFILCARGO 
(
   PERCAR_ID            INTEGER              not null,
   HAB_ID               INTEGER              not null,
   constraint PK_HABILIDADES_PERFILCARGO primary key (PERCAR_ID, HAB_ID)
);

/*==============================================================*/
/* Index: HABILIDADES_PERFILCARGO_FK                            */
/*==============================================================*/
create index HABILIDADES_PERFILCARGO_FK on HABILIDADES_PERFILCARGO (
   PERCAR_ID ASC
);

/*==============================================================*/
/* Index: HABILIDADES_PERFILCARGO2_FK                           */
/*==============================================================*/
create index HABILIDADES_PERFILCARGO2_FK on HABILIDADES_PERFILCARGO (
   HAB_ID ASC
);

/*==============================================================*/
/* Table: MODALIDAD_CONTRATO                                    */
/*==============================================================*/
create table MODALIDAD_CONTRATO 
(
   MODCON_ID            INTEGER              not null,
   MODCON_NOMBRE        VARCHAR2(100)        not null,
   constraint PK_MODALIDAD_CONTRATO primary key (MODCON_ID)
);

/*==============================================================*/
/* Table: MONEDA                                                */
/*==============================================================*/
create table MONEDA 
(
   MON_ID               VARCHAR2(3)          not null,
   MON_NOMBRE           VARCHAR2(100)        not null,
   constraint PK_MONEDA primary key (MON_ID)
);

/*==============================================================*/
/* Table: NOVEDADES                                             */
/*==============================================================*/
create table NOVEDADES 
(
   CON_ID               INTEGER              not null,
   NOV_CODIGO_DOCUMENTO VARCHAR2(200)        not null,
   NOV_FECHA_INICIO     DATE                 not null,
   NOV_FECHA_FIN        DATE,
   NOV_MEDIDA_MANEJO    INTEGER              not null,
   NOV_DESCRIPCION_MANEJO CLOB               not null,
   NOV_DESCRIPCION      CLOB                 not null,
   NOV_TIPO             INTEGER              not null,
   constraint PK_NOVEDADES primary key (CON_ID, NOV_CODIGO_DOCUMENTO)
)TABLESPACE contratacion_rh
   STORAGE (INITIAL 30M NEXT 10M MAXEXTENTS UNLIMITED);

/*==============================================================*/
/* Index: CONTRATO_NOVEDAD_FK                                   */
/*==============================================================*/
create index CONTRATO_NOVEDAD_FK on NOVEDADES (
   CON_ID ASC
);

/*==============================================================*/
/* Table: PERFILCARGO                                           */
/*==============================================================*/
create table PERFILCARGO 
(
   PERCAR_ID            INTEGER              not null,
   PERCAR_CARGO         VARCHAR2(250)        not null,
   PERCAR_DESCRIPCION   CLOB                 not null,
   constraint PK_PERFILCARGO primary key (PERCAR_ID)
);

/*==============================================================*/
/* Table: POSICION                                              */
/*==============================================================*/
create table POSICION 
(
   POS_ID               INTEGER              not null,
   JEFE_ID              INTEGER,
   SED_ID               INTEGER              not null,
   PERCAR_ID            INTEGER              not null,
   AREA_ID              INTEGER,
   POS_CATEGORIA        INTEGER              not null,
   POS_LIMITE_PLAZAS    INTEGER              not null,
   constraint PK_POSICION primary key (POS_ID)
);

/*==============================================================*/
/* Index: SEDE_POSICION_FK                                      */
/*==============================================================*/
create index SEDE_POSICION_FK on POSICION (
   SED_ID ASC
);

/*==============================================================*/
/* Index: PERFIL_CARGO_POSICION_FK                              */
/*==============================================================*/
create index PERFIL_CARGO_POSICION_FK on POSICION (
   PERCAR_ID ASC
);

/*==============================================================*/
/* Index: A_CARGO_FK                                            */
/*==============================================================*/
create index A_CARGO_FK on POSICION (
   JEFE_ID ASC
);

/*==============================================================*/
/* Index: AREA_POSICION_FK                                      */
/*==============================================================*/
create index AREA_POSICION_FK on POSICION (
   AREA_ID ASC
);

/*==============================================================*/
/* Table: POSICION_CONTRATO                                     */
/*==============================================================*/
create table POSICION_CONTRATO 
(
   CON_ID               INTEGER              not null,
   POS_ID               INTEGER              not null,
   POSCON_FECHA_INICIO  DATE                 not null,
   POSCON_FECHA_FIN     DATE,
   POSCON_CARACTERISTICA VARCHAR2(50) check (POSCON_CARACTERISTICA in ('PRINCIPAL','SECUNDARIO')) not null,
   constraint PK_POSICION_CONTRATO primary key (CON_ID, POS_ID, POSCON_FECHA_INICIO)
)TABLESPACE contratacion_rh
   STORAGE (INITIAL 30M NEXT 10M MAXEXTENTS UNLIMITED);

/*==============================================================*/
/* Index: POSICIONCONTRATO_CONTRATO_FK                          */
/*==============================================================*/
create index POSICIONCONTRATO_CONTRATO_FK on POSICION_CONTRATO (
   CON_ID ASC
);

/*==============================================================*/
/* Index: POSICION_POSICIONCONTRATO_FK                          */
/*==============================================================*/
create index POSICION_POSICIONCONTRATO_FK on POSICION_CONTRATO (
   POS_ID ASC
);

/*==============================================================*/
/* Table: SALARIOS                                              */
/*==============================================================*/
create table SALARIOS 
(
   CON_ID               INTEGER              not null,
   SAL_FECHA_INICIO     DATE                 not null,
   SAL_FECHA_FINALIZADO DATE,
   SAL_VALOR            VARCHAR2(250)        not null,
   constraint PK_SALARIOS primary key (CON_ID, SAL_FECHA_INICIO)
)TABLESPACE contratacion_rh
   STORAGE (INITIAL 50M NEXT 10M MAXEXTENTS UNLIMITED);

/*==============================================================*/
/* Index: CONTRATO_SALARIO_FK                                   */
/*==============================================================*/
create index CONTRATO_SALARIO_FK on SALARIOS (
   CON_ID ASC
);

/*==============================================================*/
/* Table: SEDE                                                  */
/*==============================================================*/
create table SEDE 
(
   SED_ID               INTEGER              not null,
   SED_NIT              VARCHAR2(250)        not null,
   SED_NOMBRE           VARCHAR2(250)        not null,
   constraint PK_SEDE primary key (SED_ID)
);

/*==============================================================*/
/* Table: SEGURIDADSOCIAL                                       */
/*==============================================================*/
create table SEGURIDADSOCIAL 
(
   SEGSOC_ID            INTEGER              not null,
   SEGSOC_NOMBRE        VARCHAR2(250)        not null,
   SEGSOC_DESCRIPCION   CLOB                 not null,
   SEGSOC_TIPO          INTEGER        not null,
   constraint PK_SEGURIDADSOCIAL primary key (SEGSOC_ID)
);

/*==============================================================*/
/* Table: TIPO_CONTRATO                                         */
/*==============================================================*/
create table TIPO_CONTRATO 
(
   TIPCON_ID            INTEGER              not null,
   TIPCON_NOMBRE        VARCHAR2(100)        not null,
   constraint PK_TIPO_CONTRATO primary key (TIPCON_ID)
);

/*==============================================================*/
/* Table: TIPO_IDENTIFICACION                                   */
/*==============================================================*/
create table TIPO_IDENTIFICACION 
(
   TIPIDE_ID            INTEGER              not null,
   TIPIDE_NOMBRE        VARCHAR2(50)         not null,
   TIPIDE_ACRONIMO      VARCHAR2(5),
   constraint PK_TIPO_IDENTIFICACION primary key (TIPIDE_ID)
);

alter table CONTRATO
   add constraint FK_CONTRATO_CONTRATO__MODALIDA foreign key (MODCON_ID)
      references MODALIDAD_CONTRATO (MODCON_ID);

alter table CONTRATO
   add constraint FK_CONTRATO_CONTRATO__MONEDA foreign key (MON_ID)
      references MONEDA (MON_ID);

alter table CONTRATO
   add constraint FK_CONTRATO_CONTRATO__TIPO_CON foreign key (TIPCON_ID)
      references TIPO_CONTRATO (TIPCON_ID);

alter table CONTRATO
   add constraint FK_CONTRATO_PERSONA_C_EMPLEADO foreign key (EMP_ID)
      references EMPLEADO (EMP_ID);

alter table CONTRATO_SEGURIDADSOCIAL
   add constraint FK_CONTRATO_CONTRATO__CONTRATO foreign key (CON_ID)
      references CONTRATO (CON_ID);

alter table CONTRATO_SEGURIDADSOCIAL
   add constraint FK_CONTRATO_CSS_SEGUR_SEGURIDA foreign key (SEGSOC_ID)
      references SEGURIDADSOCIAL (SEGSOC_ID);

alter table EMPLEADO
   add constraint FK_EMPLEADO_TIPO_IDEN_TIPO_IDE foreign key (TIPIDE_ID)
      references TIPO_IDENTIFICACION (TIPIDE_ID);

alter table HABILIDADES_PERFILCARGO
   add constraint FK_HABILIDA_HABILIDAD_PERFILCA foreign key (PERCAR_ID)
      references PERFILCARGO (PERCAR_ID);

alter table HABILIDADES_PERFILCARGO
   add constraint FK_HABILIDA_HABILIDAD_HABILIDA foreign key (HAB_ID)
      references HABILIDADES (HAB_ID);

alter table NOVEDADES
   add constraint FK_NOVEDADE_CONTRATO__CONTRATO foreign key (CON_ID)
      references CONTRATO (CON_ID);

alter table POSICION
   add constraint FK_POSICION_AREA_POSI_AREA foreign key (AREA_ID)
      references AREA (AREA_ID);

alter table POSICION
   add constraint FK_POSICION_A_CARGO_POSICION foreign key (JEFE_ID)
      references POSICION (POS_ID);

alter table POSICION
   add constraint FK_POSICION_PERFIL_CA_PERFILCA foreign key (PERCAR_ID)
      references PERFILCARGO (PERCAR_ID);

alter table POSICION
   add constraint FK_POSICION_SEDE_POSI_SEDE foreign key (SED_ID)
      references SEDE (SED_ID);

alter table POSICION_CONTRATO
   add constraint FK_POSICION_POSICIONC_CONTRATO foreign key (CON_ID)
      references CONTRATO (CON_ID);

alter table POSICION_CONTRATO
   add constraint FK_POSICION_POSICION__POSICION foreign key (POS_ID)
      references POSICION (POS_ID);

alter table SALARIOS
   add constraint FK_SALARIOS_CONTRATO__CONTRATO foreign key (CON_ID)
      references CONTRATO (CON_ID);

ALTER TABLE MONEDA
   ADD CONSTRAINT ck_mon_acronimo
   CHECK (REGEXP_LIKE(MON_ID, '^[A-Z]+$'));

ALTER TABLE NOVEDADES
      ADD CONSTRAINT ck_tipo_novedad
      CHECK (NOV_TIPO IN (1, 2, 3, 4));

ALTER TABLE NOVEDADES
      ADD CONSTRAINT ck_tipo_manejo_novedad
      CHECK (NOV_MEDIDA_MANEJO IN (1, 2, 3, 4, 5, 6, 7, 8, 9));  

ALTER TABLE POSICION
      ADD CONSTRAINT ck_posicion_categoria
      CHECK (Pos_categoria IN (1, 2, 3, 4, 5, 6, 7));

ALTER TABLE SEGURIDADSOCIAL
      ADD CONSTRAINT ck_segsoc_tipo
      CHECK (Segsoc_tipo IN (1, 2, 3, 4, 5, 6));


--------------------------------------------------------
-- Archivo creado  - viernes-noviembre-24-2023   
--------------------------------------------------------
REM INSERTING into CONTRATACION.HABILIDADES
SET DEFINE OFF;
Insert into CONTRATACION.HABILIDADES (HAB_ID,HAB_NOMBRE,HAB_DESCRIPCION) values ('1','Comunicación', 'Desc Comunicación');
Insert into CONTRATACION.HABILIDADES (HAB_ID,HAB_NOMBRE,HAB_DESCRIPCION) values ('2','Técnica', 'Desc Técnica');

REM INSERTING into CONTRATACION.AREA
SET DEFINE OFF;
Insert into CONTRATACION.AREA (AREA_ID,AREA_NOMBRE) values ('1','Departamento de Ventas');
Insert into CONTRATACION.AREA (AREA_ID,AREA_NOMBRE) values ('2','Departamento de Recursos Humanos');
Insert into CONTRATACION.AREA (AREA_ID,AREA_NOMBRE) values ('3','Departamento de Finanzas');
Insert into CONTRATACION.AREA (AREA_ID,AREA_NOMBRE) values ('4','Departamento de Tecnología de la Información');
Insert into CONTRATACION.AREA (AREA_ID,AREA_NOMBRE) values ('5','Departamento de Marketing');
Insert into CONTRATACION.AREA (AREA_ID,AREA_NOMBRE) values ('6','Departamento de Logística');
Insert into CONTRATACION.AREA (AREA_ID,AREA_NOMBRE) values ('7','Departamento de Investigación y Desarrollo');
REM INSERTING into CONTRATACION.SEDE
SET DEFINE OFF;
Insert into CONTRATACION.SEDE (SED_ID,SED_NIT,SED_NOMBRE) values ('1','123456789','sede 1');
Insert into CONTRATACION.SEDE (SED_ID,SED_NIT,SED_NOMBRE) values ('2','987654321','sede 2');
Insert into CONTRATACION.SEDE (SED_ID,SED_NIT,SED_NOMBRE) values ('3','554445688','Sede 3');
REM INSERTING into CONTRATACION.SEGURIDADSOCIAL
SET DEFINE OFF;
Insert into CONTRATACION.SEGURIDADSOCIAL (SEGSOC_ID,SEGSOC_NOMBRE,SEGSOC_TIPO, SEGSOC_DESCRIPCION) values ('1','Empresa de Salud','1', 'Empresa de Salud');
Insert into CONTRATACION.SEGURIDADSOCIAL (SEGSOC_ID,SEGSOC_NOMBRE,SEGSOC_TIPO, SEGSOC_DESCRIPCION) values ('2','Empresa de Pensión','2', 'Empresa de Pensión');
REM INSERTING into CONTRATACION.TIPO_CONTRATO
SET DEFINE OFF;
Insert into CONTRATACION.TIPO_CONTRATO (TIPCON_ID,TIPCON_NOMBRE) values ('1','Tiempo Completo');
Insert into CONTRATACION.TIPO_CONTRATO (TIPCON_ID,TIPCON_NOMBRE) values ('2','Medio Tiempo');
REM INSERTING into CONTRATACION.TIPO_IDENTIFICACION
SET DEFINE OFF;
Insert into CONTRATACION.TIPO_IDENTIFICACION (TIPIDE_ID,TIPIDE_NOMBRE,TIPIDE_ACRONIMO) values ('1','Cédula de Ciudadanía','CC');
Insert into CONTRATACION.TIPO_IDENTIFICACION (TIPIDE_ID,TIPIDE_NOMBRE,TIPIDE_ACRONIMO) values ('2','Tarjeta de Identidad','TI');
REM INSERTING into CONTRATACION.MODALIDAD_CONTRATO
SET DEFINE OFF;
Insert into CONTRATACION.MODALIDAD_CONTRATO (MODCON_ID,MODCON_NOMBRE) values ('1','Contrato a Término Indefinido');
Insert into CONTRATACION.MODALIDAD_CONTRATO (MODCON_ID,MODCON_NOMBRE) values ('2','Contrato a Término Fijo');
REM INSERTING into CONTRATACION.MONEDA
SET DEFINE OFF;
Insert into CONTRATACION.MONEDA (MON_ID,MON_NOMBRE) values ('USD','Dólar Americano');
Insert into CONTRATACION.MONEDA (MON_ID,MON_NOMBRE) values ('EUR','Euro');
REM INSERTING into CONTRATACION.EMPLEADO
SET DEFINE OFF;
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('7','1','BYT78VJW1UY','Orlando','Marsh',to_date('28/11/65','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('8','1','BVL25UNG4HM','Xenos','Moody',to_date('14/08/91','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('9','2','TFO75IQP8UU','Samson','Zamora',to_date('25/02/76','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('10','2','YEZ85UVS8QZ','Lawrence','Nash',to_date('01/05/97','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('11','2','PRQ56LFG6UU','Erica','Harper',to_date('05/02/99','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('12','1','VYF86CRS1AL','Moana','Becker',to_date('03/03/99','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('13','2','OKQ47TXU5ED','Orli','Gillespie',to_date('08/03/61','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('14','1','WOE65GIH1GL','Colleen','Lawrence',to_date('01/04/79','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('15','2','ZTH66NXI3OX','Clinton','Hayes',to_date('29/09/94','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('16','1','FRG51FBA6NT','Noble','Buckner',to_date('27/07/97','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('17','1','DQX56UVN2HV','Zena','Barber',to_date('26/06/94','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('18','2','CJT69QXR8WF','Griffin','Fisher',to_date('10/11/73','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('19','1','NLT86DFB7WP','Vaughan','Moses',to_date('23/01/79','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('20','1','ZEM32VNQ6LJ','Colton','Lott',to_date('14/09/68','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('21','2','MKR25EJW5BU','Christian','Slater',to_date('19/10/64','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('22','1','PSL11KMU4JA','Kirestin','Rivas',to_date('29/03/73','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('23','2','LFP77OHB6XB','Acton','James',to_date('25/10/00','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('24','2','KDM08LKL2II','Clarke','Burgess',to_date('15/08/80','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('25','2','EJK48EFB9JQ','Marvin','Spence',to_date('27/02/63','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('26','1','VSD48CLN4QU','Lars','Nash',to_date('13/05/72','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('27','1','BFY37CCJ8EZ','Illana','Marks',to_date('21/01/98','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('28','1','KDV62KZX4FM','Shafira','Schwartz',to_date('16/09/72','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('29','2','BPW16BVY5TN','Orson','Cline',to_date('12/05/90','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('30','1','DBM56PTZ0GN','Mira','Heath',to_date('14/08/66','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('31','1','CRJ33XCS8OM','Murphy','Hughes',to_date('08/12/74','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('32','1','DLO50VWW1ZJ','Cameran','Morton',to_date('13/07/73','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('33','2','CHN20ZUW3IJ','Imogene','Olsen',to_date('28/09/95','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('34','1','YEH86DBO4XG','Beverly','Hines',to_date('08/04/62','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('35','1','BHW27KER1EV','Carter','William',to_date('11/05/90','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('36','1','CUT24QIL0UW','Channing','Clements',to_date('12/05/96','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('37','1','EXC33WJJ5GB','Athena','Fox',to_date('28/01/82','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('38','2','QRH62IXJ4MB','Levi','James',to_date('06/01/97','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('39','1','CIC39BQW1RY','Jermaine','Sweet',to_date('22/11/00','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('40','1','EGS35FMS2LX','Quin','Wilson',to_date('13/01/72','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('41','2','ZIX31YAA5VN','Ella','Pate',to_date('13/09/99','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('42','2','CDU62EQX2OG','Reed','Bell',to_date('25/09/62','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('43','2','ORE06QBC2MH','Duncan','Newton',to_date('21/03/72','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('44','1','QFS14KFD1MJ','Howard','Harmon',to_date('18/12/87','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('45','2','JWT36GKD1KB','Dennis','Craig',to_date('14/03/72','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('46','1','BXT74EIX1HO','Rajah','Bates',to_date('09/08/62','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('47','1','YOR21NTK4UR','Kirestin','Barker',to_date('02/12/71','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('48','1','DRT59QMH8TL','Miriam','Sanchez',to_date('12/04/75','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('49','1','PSV90EXQ8YU','Cassidy','Meyers',to_date('21/03/64','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('50','1','WUW94SKD3SG','Sylvester','Dudley',to_date('07/02/84','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('51','2','NLG55SUP8WT','Graham','Carney',to_date('17/11/69','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('52','1','KUK27WML6NV','Yoshio','Pace',to_date('26/08/89','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('53','1','BDF78XMS5KK','Kadeem','Fisher',to_date('02/11/94','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('54','2','HJO84RPV6CV','Karleigh','Mcclain',to_date('21/05/88','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('55','2','YCR02HPL6WS','Chloe','Cooper',to_date('02/01/72','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('56','1','YMU51FSW8NO','Zelda','Valentine',to_date('31/12/70','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('57','2','YJJ66QIH1FE','Brielle','Pratt',to_date('16/10/77','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('58','1','RUZ06AFU4EW','Phillip','Mcclure',to_date('24/10/74','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('59','2','AKH42EJG6LO','Leonard','Ramsey',to_date('15/07/96','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('60','2','JGN13CAD3PT','Devin','Frederick',to_date('10/04/77','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('61','2','GHR46KIB5KL','Jakeem','Hamilton',to_date('24/02/92','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('62','2','ZKG71COA8OX','Mohammad','Allison',to_date('22/01/80','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('63','2','QQQ42NDP6GH','Upton','Kim',to_date('26/01/80','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('64','1','MMB49COH3EU','Jolene','Franklin',to_date('09/09/93','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('65','1','WAD88VLP3DC','Laurel','Booth',to_date('17/12/77','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('66','2','NUT34IYU5XI','Bo','Stewart',to_date('14/07/85','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('67','2','MQU01JQA2WK','Aristotle','Mullins',to_date('11/07/79','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('68','1','VHU50LJS6NC','Jasper','Warren',to_date('26/04/99','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('69','1','EYU60LGK8MJ','Neil','Dean',to_date('10/10/64','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('70','2','PTS82DPD4LE','Amena','Church',to_date('01/06/86','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('71','2','MID26TIN5LB','Idona','Ross',to_date('17/02/68','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('72','1','KUE40TFV0BR','Nathan','Ellison',to_date('26/11/76','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('73','2','LCN65XFX1PS','Camden','Foster',to_date('16/12/87','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('74','1','OYW63UNB4CR','Buffy','Haley',to_date('24/06/93','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('75','2','SYT74EQY8RY','Lois','Howe',to_date('19/04/77','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('76','1','TWB81DBL6IJ','Uriel','Love',to_date('01/02/80','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('77','2','EIR48XLD7CT','Rae','Lancaster',to_date('24/10/63','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('78','2','MDD18CTD5DI','Mechelle','Wolf',to_date('25/08/84','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('79','2','WXS57CUE5AN','Jasmine','Kelly',to_date('28/09/94','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('80','2','BLS03FHO8PY','Oprah','Herman',to_date('02/07/93','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('81','1','XXV04XYY3YU','Regina','Hurley',to_date('31/08/80','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('82','2','SVM59CBL5BG','Nerea','Hall',to_date('02/05/67','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('83','1','VKL11DEH1WS','Quail','Byrd',to_date('11/01/76','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('84','1','LSN81GNS2FO','Audrey','Fuentes',to_date('27/04/70','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('85','2','EYC52CYO8CU','Ivana','Church',to_date('20/04/90','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('86','2','TGD48BPW6CC','Moana','Byrd',to_date('29/09/81','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('87','2','FQM84FGU8SR','Donna','Cox',to_date('28/12/99','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('88','2','JXT25LVH4YM','Rajah','Brady',to_date('23/06/68','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('89','2','QGP14FDN8GY','Nero','Cannon',to_date('18/06/75','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('90','1','HKT83OVH6WS','Bradley','Wyatt',to_date('19/09/87','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('91','1','DFB25XMJ3QD','Fleur','Watson',to_date('27/02/68','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('92','2','RZT51WXK1DX','Kelly','Luna',to_date('05/12/92','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('93','2','CNB17LYG4GG','Upton','Edwards',to_date('07/05/97','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('94','2','CCF81TQQ6RD','Briar','Levy',to_date('16/02/83','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('95','2','VJL39OBV7HG','Dalton','Stephens',to_date('28/10/67','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('96','1','TBD12FVO7TY','Jemima','Irwin',to_date('16/12/98','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('97','1','TFU63JGN7KU','Travis','Gray',to_date('13/01/89','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('98','1','CYD55UXX5CT','Russell','Flores',to_date('31/12/82','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('99','2','UOU32BTS6KX','Rafael','Sims',to_date('19/05/77','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('100','1','WXC22OKL7FF','Tate','Mclean',to_date('24/11/95','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('101','1','YES17NPD0RK','Rhea','Middleton',to_date('06/12/68','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('102','2','LQY23VSK3JM','Cameron','Gross',to_date('27/06/89','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('103','1','PON07JNA9EY','Gabriel','Perez',to_date('02/04/68','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('104','1','PYW94FNM8JY','Fiona','Buckner',to_date('08/06/98','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('105','1','IDC19MVM8OL','Calista','Gill',to_date('09/11/79','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('106','1','DDO63FTG6XL','Acton','Rivas',to_date('28/12/93','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('1','1','123456789','Juan','Pérez',to_date('01/01/90','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('2','2','987654321','María','Gómez',to_date('15/05/85','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('3','1','111111111','Luis','Martínez',to_date('20/06/88','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('4','2','222222222','Ana','Sánchez',to_date('15/03/95','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('5','1','555555555','Pedro','Rodríguez',to_date('10/10/87','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('6','2','666666666','Laura','López',to_date('25/12/92','DD/MM/RR'),'FEMENINO');
REM INSERTING into CONTRATACION.PERFILCARGO
SET DEFINE OFF;
Insert into CONTRATACION.PERFILCARGO (PERCAR_ID,PERCAR_CARGO,PERCAR_DESCRIPCION) values ('1','Gerente de Ventas', 'Gerente de Ventas');
Insert into CONTRATACION.PERFILCARGO (PERCAR_ID,PERCAR_CARGO,PERCAR_DESCRIPCION) values ('2','Analista de Recursos Humanos', 'Analista de Recursos Humanos');
Insert into CONTRATACION.PERFILCARGO (PERCAR_ID,PERCAR_CARGO,PERCAR_DESCRIPCION) values ('3','Desarrollador Web', 'Desarrollador Web');
Insert into CONTRATACION.PERFILCARGO (PERCAR_ID,PERCAR_CARGO,PERCAR_DESCRIPCION) values ('4','Analista de Datos', 'Analista de Datos');
Insert into CONTRATACION.PERFILCARGO (PERCAR_ID,PERCAR_CARGO,PERCAR_DESCRIPCION) values ('5','Especialista en Marketing Digital', 'Especialista en Marketing Digital');
Insert into CONTRATACION.PERFILCARGO (PERCAR_ID,PERCAR_CARGO,PERCAR_DESCRIPCION) values ('6','Ingeniero de Sistemas', 'Ingeniero de Sistemas');
Insert into CONTRATACION.PERFILCARGO (PERCAR_ID,PERCAR_CARGO,PERCAR_DESCRIPCION) values ('7','Asistente Administrativo', 'Asistente Administrativo');
Insert into CONTRATACION.PERFILCARGO (PERCAR_ID,PERCAR_CARGO,PERCAR_DESCRIPCION) values ('8','Consultor de Tecnología', 'Consultor de Tecnología');
Insert into CONTRATACION.PERFILCARGO (PERCAR_ID,PERCAR_CARGO,PERCAR_DESCRIPCION) values ('9','Coordinador de Proyectos', 'Coordinador de Proyectos');
Insert into CONTRATACION.PERFILCARGO (PERCAR_ID,PERCAR_CARGO,PERCAR_DESCRIPCION) values ('10','Diseñador Gráfico', 'Diseñador Gráfico');
Insert into CONTRATACION.PERFILCARGO (PERCAR_ID,PERCAR_CARGO,PERCAR_DESCRIPCION) values ('11','Especialista en Finanzas', 'Especialista en Finanzas');
Insert into CONTRATACION.PERFILCARGO (PERCAR_ID,PERCAR_CARGO,PERCAR_DESCRIPCION) values ('12','Coordinador de Marketing', 'Coordinador de Marketing');
REM INSERTING into CONTRATACION.HABILIDADES_PERFILCARGO
SET DEFINE OFF;
REM INSERTING into CONTRATACION.POSICION
SET DEFINE OFF;
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('1',null,'1','1','1','1','10');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('2','1','2','2','2','2','5');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('3','2','1','3','1','3','8');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('4','3','2','4','2','4','5');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('5','4','2','5','1','5','7');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('6','5','1','6','2','6','4');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('7','5','3','7','1','3','3');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('8','1','2','12','2','1','9');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('9','6','2','2','2','5','7');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('10','5','2','2','4','2','7');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('11','2','2','1','4','2','2');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('12','3','2','2','5','7','9');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('13','2','3','6','5','7','3');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('14','3','1','1','3','6','6');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('15','4','1','8','5','1','3');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('16','6','1','8','2','4','9');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('17','4','2','6','6','4','2');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('18','1','2','7','3','4','7');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('19','2','1','8','5','5','8');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('20','3','2','5','5','5','6');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('21','6','1','9','6','4','8');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('22','4','1','5','2','4','2');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('23','2','2','10','3','1','3');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('24','3','2','11','5','3','8');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('25','3','2','7','3','7','3');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('26','3','1','3','4','7','2');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('27','1','3','4','6','2','10');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('28','4','2','11','5','7','7');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('29','2','1','7','7','2','7');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('30','5','3','9','5','5','7');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('31','4','2','2','1','2','2');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('32','2','3','6','1','2','6');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('33','1','2','10','5','5','2');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('34','5','3','7','2','6','10');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('35','2','2','5','5','6','4');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('36','6','3','2','2','1','1');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('37','5','2','5','5','1','6');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('38','4','1','8','3','5','7');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('39','4','3','6','5','5','3');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('40','3','2','11','6','4','3');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('41','4','2','9','4','7','7');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('42','2','3','6','4','3','3');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('43','5','3','8','2','7','4');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('44','5','3','8','2','6','9');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('45','5','2','6','2','4','4');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('46','6','2','8','4','7','10');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('47','4','1','7','5','4','9');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('48','2','2','1','3','3','6');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('49','3','1','6','3','5','5');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('50','5','1','9','6','2','7');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('51','3','3','3','5','5','9');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('52','3','2','12','5','5','5');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('53','5','2','10','5','5','10');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('54','6','2','2','2','1','4');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('55','4','1','10','3','1','2');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('56','6','3','8','5','2','2');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('57','2','1','9','2','4','3');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('58','5','1','11','4','5','8');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('59','4','3','9','3','1','3');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('60','3','3','7','6','4','2');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('61','1','2','6','1','4','9');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('62','4','2','8','7','2','8');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('63','4','2','4','3','4','9');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('64','3','3','1','2','5','2');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('65','2','3','9','4','4','8');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('66','6','2','11','5','6','9');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('67','6','2','7','6','1','10');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('68','4','2','2','3','5','6');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('69','5','2','2','6','5','5');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('70','4','2','7','3','3','10');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('71','5','2','6','6','3','2');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('72','3','3','1','5','5','3');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('73','5','2','10','1','7','3');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('74','2','1','7','3','3','8');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('75','5','1','8','3','7','8');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('76','6','2','2','2','4','4');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('77','5','2','11','3','5','4');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('78','4','2','3','4','6','4');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('79','6','3','2','6','3','6');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('80','3','3','3','7','3','3');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('81','2','2','1','6','1','10');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('82','4','2','9','5','6','3');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('83','2','3','9','1','6','5');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('84','1','3','11','5','7','4');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('85','4','2','10','7','2','1');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('86','3','2','8','2','2','9');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('87','6','2','1','2','5','3');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('88','5','2','12','5','4','7');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('89','6','1','8','5','3','3');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('90','1','2','2','3','5','2');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('91','4','2','7','1','3','4');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('92','6','2','3','7','2','6');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('93','3','2','3','5','2','7');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('94','1','2','3','7','2','6');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('95','2','2','3','4','5','9');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('96','2','2','8','3','1','9');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('97','1','3','7','2','2','3');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('98','4','2','11','5','5','1');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('99','3','2','3','4','2','8');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('100','3','3','1','7','6','3');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('101','5','1','10','5','5','1');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('102','6','2','8','4','1','9');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('103','5','2','7','1','6','3');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('104','5','3','3','7','3','2');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('105','4','1','2','6','6','4');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('106','4','2','4','2','2','3');

REM INSERTING into CONTRATACION.CONTRATO
SET DEFINE OFF;
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('1','1','1','1','USD','CONTR123',to_date('01/01/22','DD/MM/RR'),to_date('01/01/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('2','2','2','2','EUR','CONTR456',to_date('01/02/22','DD/MM/RR'),to_date('01/02/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('3','1','3','1','USD','CONTR789',to_date('01/03/22','DD/MM/RR'),to_date('01/03/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('4','2','4','2','EUR','CONTR101',to_date('01/04/22','DD/MM/RR'),to_date('01/04/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('5','1','5','1','USD','CONTR111',to_date('01/05/22','DD/MM/RR'),to_date('01/05/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('6','2','6','2','EUR','CONTR222',to_date('01/06/22','DD/MM/RR'),to_date('01/06/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('7','2','7','2','EUR','JTO41HOS9EI6LW9FG22',to_date('28/12/06','DD/MM/RR'),to_date('06/02/16','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('8','2','8','1','EUR','WVF25RPD4UF8MM6BM86',to_date('25/08/06','DD/MM/RR'),to_date('13/05/18','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('9','1','9','1','USD','SDX31PBX7OC9FG7LA70',to_date('15/01/06','DD/MM/RR'),to_date('06/07/22','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('10','1','10','2','USD','VMN86NHC7QV2OF2IN11',to_date('24/10/06','DD/MM/RR'),to_date('27/06/21','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('11','1','11','2','EUR','YZV74TJJ0IW3QT6MI47',to_date('03/07/07','DD/MM/RR'),to_date('21/06/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('12','2','12','2','EUR','LLZ83FIH7JB6XT6DE31',to_date('30/12/07','DD/MM/RR'),to_date('22/11/17','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('13','2','13','1','USD','VYK75XTW0DB6DV7NK81',to_date('26/05/06','DD/MM/RR'),to_date('28/08/15','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('14','2','14','2','USD','LJQ23QNQ4LH8HT2YE47',to_date('11/07/08','DD/MM/RR'),to_date('15/05/10','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('15','2','15','2','EUR','CNH24PRQ6HO1TD3QH06',to_date('11/04/08','DD/MM/RR'),to_date('14/02/15','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('16','2','16','1','EUR','HQG21UII8KF6XC1SJ16',to_date('19/02/05','DD/MM/RR'),to_date('06/07/15','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('17','2','17','1','USD','RRF12IJR3TF3UG3PU31',to_date('02/03/06','DD/MM/RR'),to_date('22/06/24','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('18','1','18','2','USD','OIH24KOW6XF8RS5JR76',to_date('07/08/07','DD/MM/RR'),to_date('29/07/16','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('19','1','19','2','EUR','BDO88GGL5TY8ZA2EG32',to_date('19/12/05','DD/MM/RR'),to_date('02/11/18','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('20','2','20','2','EUR','UNS15GQE8TM4VX4KA82',to_date('24/05/05','DD/MM/RR'),to_date('22/04/06','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('21','1','21','1','USD','OFD46AXB8LW1CX5NR11',to_date('11/12/07','DD/MM/RR'),to_date('29/07/08','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('22','1','22','1','USD','FCJ61GUN8CN6BH7SZ74',to_date('08/12/06','DD/MM/RR'),to_date('06/05/07','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('23','2','23','1','EUR','ROR54JKH1SZ2VD1RH68',to_date('11/01/08','DD/MM/RR'),to_date('26/05/21','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('24','2','24','2','EUR','EDF29HTQ5RD2VK4EB51',to_date('18/08/06','DD/MM/RR'),to_date('03/06/14','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('25','1','25','1','USD','PQT12SVJ1RM5ON8UU32',to_date('26/01/06','DD/MM/RR'),to_date('17/04/22','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('26','2','26','2','USD','WEG68SBL2KL7IH2LI27',to_date('26/12/07','DD/MM/RR'),to_date('27/07/16','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('27','2','27','1','EUR','JQJ47IQI2OW8MU2CE75',to_date('08/07/05','DD/MM/RR'),to_date('07/11/15','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('28','2','28','1','EUR','EEM13HYJ2BS4YW1KH63',to_date('12/06/07','DD/MM/RR'),to_date('22/12/21','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('29','2','29','1','USD','UQQ32SUK1PE5IW3GS96',to_date('18/04/05','DD/MM/RR'),to_date('31/10/22','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('30','1','30','1','USD','VUU40MON7GV7OS2UX52',to_date('15/10/06','DD/MM/RR'),to_date('30/06/21','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('31','1','31','1','EUR','PFO85LPK5ZS1FB2BN10',to_date('02/02/07','DD/MM/RR'),to_date('01/01/18','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('32','1','32','1','EUR','JMJ58XUW1XE7QD4YM26',to_date('30/08/07','DD/MM/RR'),to_date('05/09/12','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('33','1','33','2','USD','API76WLT4OC6CP6HC07',to_date('19/06/06','DD/MM/RR'),to_date('21/11/13','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('34','2','34','2','USD','WIH35TPB4QS4MK5HK55',to_date('19/01/05','DD/MM/RR'),to_date('02/05/09','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('35','1','35','2','EUR','PWM67KZO1YX8DK6YG82',to_date('08/07/08','DD/MM/RR'),to_date('03/06/19','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('36','1','36','2','EUR','QYJ18YVN4HL5VL1UM25',to_date('21/08/08','DD/MM/RR'),to_date('17/11/09','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('37','1','37','1','USD','KCY37JXK5TP0KW7NV64',to_date('05/10/07','DD/MM/RR'),to_date('09/01/08','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('38','1','38','1','USD','OOB11SFY3NK4BM5QT79',to_date('21/10/07','DD/MM/RR'),to_date('31/10/13','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('39','2','39','2','EUR','VDW43IIH4HN4IN2BW83',to_date('06/02/05','DD/MM/RR'),to_date('26/03/18','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('40','1','40','2','EUR','WJW57AUE9EE1WL8SF32',to_date('31/12/04','DD/MM/RR'),to_date('14/06/15','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('41','1','41','1','USD','ZEX51BCF7LX5SD5VW83',to_date('30/03/05','DD/MM/RR'),to_date('12/12/12','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('42','2','42','2','USD','XFP92ZCK2EC0SV3KG84',to_date('15/08/07','DD/MM/RR'),to_date('08/10/19','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('43','1','43','2','EUR','JZJ18OVC6UR2EU7QG82',to_date('05/06/07','DD/MM/RR'),to_date('05/01/14','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('44','1','44','1','EUR','UFJ15QKN7JX3ED7CJ46',to_date('26/05/08','DD/MM/RR'),to_date('11/02/17','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('45','1','45','2','USD','WIR10NSK0ME8TP4KS55',to_date('06/12/05','DD/MM/RR'),to_date('25/10/17','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('46','2','46','2','USD','XEV59OTT2ZN4PQ1KV95',to_date('16/08/05','DD/MM/RR'),to_date('02/01/21','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('47','1','47','1','EUR','GPY78LYW1UN2WI3RV47',to_date('28/12/05','DD/MM/RR'),to_date('28/02/21','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('48','1','48','2','EUR','VWN53ZBQ1FW4BS4VO26',to_date('10/06/07','DD/MM/RR'),to_date('05/07/06','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('49','2','49','2','USD','LQB75DEW7OV8VS8NM17',to_date('27/03/05','DD/MM/RR'),to_date('24/12/16','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('50','1','50','1','USD','ONM64BGL1NN3YG6ET64',to_date('02/09/08','DD/MM/RR'),to_date('04/10/19','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('51','1','51','2','EUR','UCY88XYN7ZW2PX2YH21',to_date('11/01/05','DD/MM/RR'),to_date('02/06/24','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('52','1','52','1','EUR','TGX60ISR3AJ9QQ3MM42',to_date('15/04/08','DD/MM/RR'),to_date('31/03/18','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('53','2','53','2','USD','HQN85GPS6LF5KQ8BF86',to_date('02/10/07','DD/MM/RR'),to_date('30/10/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('54','1','54','2','USD','NMA95XHC0BH2DQ6KG37',to_date('20/02/07','DD/MM/RR'),to_date('08/06/18','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('55','1','55','1','EUR','JRA68VJG3BU6GA3UF69',to_date('05/11/08','DD/MM/RR'),to_date('27/02/18','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('56','1','56','1','EUR','KJL24PRT9BP1EN5XC95',to_date('03/07/07','DD/MM/RR'),to_date('19/03/19','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('57','2','57','1','USD','VYY37EOV7UX1OO1EF52',to_date('26/04/08','DD/MM/RR'),to_date('19/09/13','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('58','2','58','1','USD','OUB26LVI8VV7CB0FM88',to_date('01/07/06','DD/MM/RR'),to_date('13/11/13','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('59','1','59','1','EUR','AIU06JCA2WG4GS8XK23',to_date('18/05/07','DD/MM/RR'),to_date('29/10/07','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('60','2','60','1','EUR','ZXS73HND4QL1BL5ML38',to_date('23/07/06','DD/MM/RR'),to_date('14/11/16','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('61','2','61','1','USD','RYJ87MED7TA7SX1CK32',to_date('02/10/07','DD/MM/RR'),to_date('07/01/13','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('62','2','62','1','USD','QOU75QUJ5XW3ZL7SI18',to_date('28/08/07','DD/MM/RR'),to_date('28/07/07','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('63','1','63','2','EUR','ZFE84BJH2ER2HF0OH62',to_date('03/04/06','DD/MM/RR'),to_date('06/04/21','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('64','2','64','1','EUR','YJB73NXF1CO2WN2EY58',to_date('07/09/07','DD/MM/RR'),to_date('15/08/11','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('65','1','65','2','USD','NLI53FFF7UX3GX8ZX96',to_date('10/05/08','DD/MM/RR'),to_date('02/04/22','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('66','2','66','1','USD','WVX84HYC8KB8EI5OJ76',to_date('22/02/05','DD/MM/RR'),to_date('16/10/16','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('67','1','67','1','EUR','DYR48XVF3EF3XY7LT91',to_date('25/06/07','DD/MM/RR'),to_date('18/09/20','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('68','1','68','1','EUR','BOE42ETM4EI9IN3RE31',to_date('06/05/07','DD/MM/RR'),to_date('01/08/17','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('69','2','69','2','USD','BSY25IMH6BP8UK1IA56',to_date('06/06/08','DD/MM/RR'),to_date('18/08/09','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('70','1','70','1','USD','YJN14JKI2MF7TN9SB14',to_date('14/04/07','DD/MM/RR'),to_date('18/03/12','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('71','1','71','2','EUR','UDT67HNU7CP3TF0FN56',to_date('12/12/07','DD/MM/RR'),to_date('23/07/19','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('72','2','72','2','EUR','OBH76PDV5DN0KX1FG18',to_date('13/08/07','DD/MM/RR'),to_date('07/03/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('73','1','73','2','USD','WFW29EPN5LW6SX8WU73',to_date('12/06/07','DD/MM/RR'),to_date('12/01/12','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('74','2','74','2','USD','ECW42IUO4CA1XY4ZR49',to_date('17/12/06','DD/MM/RR'),to_date('16/12/10','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('75','2','75','1','EUR','YMD98OXP9GW6SE5OF26',to_date('28/09/07','DD/MM/RR'),to_date('24/07/15','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('76','2','76','2','EUR','ING80QMH8KQ1PM1NO01',to_date('14/08/06','DD/MM/RR'),to_date('31/05/13','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('77','1','77','2','USD','FOC34IXF1UH4LA7VU31',to_date('25/03/05','DD/MM/RR'),to_date('05/01/11','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('78','2','78','2','USD','BQX71KMG3JA4DN4HZ59',to_date('05/11/06','DD/MM/RR'),to_date('02/12/20','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('79','1','79','2','EUR','LYT25YPK2YF4VG7DO98',to_date('12/12/04','DD/MM/RR'),to_date('12/06/10','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('80','1','80','1','EUR','HAO68JPW3CI8OO7OS57',to_date('11/12/05','DD/MM/RR'),to_date('17/04/16','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('81','1','81','1','USD','BRB28SVO6UM5RT9FA38',to_date('27/08/07','DD/MM/RR'),to_date('08/11/16','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('82','2','82','1','USD','LWX57JHH9TU5RA3VC42',to_date('03/05/08','DD/MM/RR'),to_date('01/01/20','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('83','2','83','2','EUR','HPH51QYV3JQ5IM5OE94',to_date('15/05/05','DD/MM/RR'),to_date('23/11/18','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('84','2','84','2','EUR','QKY75VQH1YS1BF8VM47',to_date('15/05/08','DD/MM/RR'),to_date('26/05/13','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('85','1','85','1','USD','NZY63SLR4TI4IL7QM48',to_date('09/11/05','DD/MM/RR'),to_date('16/05/12','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('86','2','86','2','USD','LFU75OTS5YX7DU6EQ02',to_date('07/03/05','DD/MM/RR'),to_date('23/06/18','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('87','2','87','2','EUR','RVD82EUH1DW8JH6LE41',to_date('26/07/06','DD/MM/RR'),to_date('22/07/15','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('88','1','88','2','EUR','INH10RJT6UW2AW8DU39',to_date('12/10/06','DD/MM/RR'),to_date('03/04/17','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('89','2','89','1','USD','KQT44DWU6GJ8AB7EB31',to_date('30/11/07','DD/MM/RR'),to_date('30/08/24','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('90','2','90','1','USD','NGH35LEZ8XJ3TI8OK97',to_date('25/02/08','DD/MM/RR'),to_date('02/12/22','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('91','2','91','2','EUR','DOH22HWJ7DU1GW5MW49',to_date('25/03/06','DD/MM/RR'),to_date('17/03/19','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('92','1','92','2','EUR','REO46TXC9JA1SR5TT87',to_date('02/09/05','DD/MM/RR'),to_date('14/11/20','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('93','1','93','2','USD','XBD50HJG0YK4FY5AD96',to_date('17/03/06','DD/MM/RR'),to_date('17/07/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('94','2','94','2','USD','MXV24OHB4OW0LE4GU75',to_date('20/02/05','DD/MM/RR'),to_date('11/06/09','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('95','1','95','1','EUR','QGF41DFF3QI8HS6SE48',to_date('26/09/08','DD/MM/RR'),to_date('21/07/22','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('96','2','96','2','EUR','VWJ10TOX3XC0YH7WF61',to_date('10/10/05','DD/MM/RR'),to_date('07/09/06','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('97','1','97','2','USD','NPK58RTO9DF3DG2KO74',to_date('05/01/08','DD/MM/RR'),to_date('19/07/07','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('98','1','98','1','USD','OTF03CWF0GT4OM9CL02',to_date('24/07/07','DD/MM/RR'),to_date('25/07/14','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('99','1','99','2','EUR','HNS88QID1BR4BY1YD52',to_date('29/05/06','DD/MM/RR'),to_date('18/10/16','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('100','1','100','1','EUR','LMT68ZEE1HP6PF4IH20',to_date('08/10/07','DD/MM/RR'),to_date('03/02/20','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('101','2','101','2','USD','PCD42UGT7XT2HK9RR52',to_date('03/03/05','DD/MM/RR'),to_date('02/11/24','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('102','2','102','1','USD','IID16DOA7PD6LG8ZQ45',to_date('17/11/05','DD/MM/RR'),to_date('23/12/16','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('103','1','103','2','EUR','EZY29CZM9WO2BO9CS77',to_date('06/04/07','DD/MM/RR'),to_date('25/04/10','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('104','2','104','2','EUR','TFS96FPN1HN9PW4LN25',to_date('25/10/08','DD/MM/RR'),to_date('04/09/09','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('105','2','105','1','USD','THE43EET8DH5SD8TR24',to_date('10/08/05','DD/MM/RR'),to_date('08/05/11','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('106','1','106','2','USD','OIU66RMI6FX6NJ2QP25',to_date('03/01/08','DD/MM/RR'),to_date('10/11/10','DD/MM/RR'));
REM INSERTING into CONTRATACION.CONTRATO_SEGURIDADSOCIAL
SET DEFINE OFF;
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('7','2',to_date('03/03/02','DD/MM/RR'),'PUS10CNU1LQL06LTG3JQ',to_date('17/01/07','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('8','2',to_date('31/05/02','DD/MM/RR'),'CGQ40CVO4LWX46SQD2NJ',to_date('13/07/06','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('9','2',to_date('08/08/04','DD/MM/RR'),'IWJ86JUO6ENF42PIP8DQ',to_date('26/06/06','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('10','2',to_date('04/05/01','DD/MM/RR'),'DVL83IEO8XPD08ELC4WO',to_date('22/07/13','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('11','2',to_date('27/02/03','DD/MM/RR'),'KOG13PVW9DQT82TXA7JR',to_date('26/10/19','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('12','2',to_date('18/08/04','DD/MM/RR'),'VYL72XKR6KQP63TMS2MY',to_date('03/06/11','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('13','2',to_date('13/10/04','DD/MM/RR'),'OEV29LUU2DDK66BVU0GU',to_date('28/05/15','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('14','2',to_date('25/11/01','DD/MM/RR'),'ANV81VKU5FYG56YGU7YC',to_date('11/06/20','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('15','2',to_date('23/10/03','DD/MM/RR'),'NFU12IKU8XVQ89CPG5VQ',to_date('24/03/06','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('16','2',to_date('28/07/01','DD/MM/RR'),'NOY57RTA4GLS56WPQ8RE',to_date('24/04/15','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('17','2',to_date('30/12/00','DD/MM/RR'),'DMP13IJV2QKJ11UES6GH',to_date('01/05/14','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('18','2',to_date('27/02/01','DD/MM/RR'),'HAX22YDB7ZUE26WNZ2TX',to_date('30/04/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('19','2',to_date('31/07/01','DD/MM/RR'),'RNZ56IVB8IAI51XPA8AW',to_date('15/01/18','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('20','2',to_date('29/12/03','DD/MM/RR'),'BDN34WFC1UVY76HMG4SG',to_date('14/05/18','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('21','2',to_date('14/02/03','DD/MM/RR'),'PSF58VHM6HAO61XAO4FT',to_date('07/04/19','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('22','2',to_date('29/01/02','DD/MM/RR'),'GDV15SGR2PYO18GFD9YT',to_date('20/11/24','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('23','2',to_date('28/02/03','DD/MM/RR'),'RVJ46NYS8HSH86THD8HW',to_date('24/02/15','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('24','2',to_date('30/09/01','DD/MM/RR'),'NXF73CYY3ODD76RKC6VH',to_date('31/01/08','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('25','2',to_date('18/12/03','DD/MM/RR'),'KUU52GJM5QAH26BXL6BG',to_date('10/11/10','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('26','2',to_date('04/01/04','DD/MM/RR'),'EUM88YSH8ZDZ26PKL7RV',to_date('22/09/20','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('27','2',to_date('18/02/01','DD/MM/RR'),'PXI87QLB1NCO77XXJ8GH',to_date('15/04/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('28','2',to_date('02/06/04','DD/MM/RR'),'HLQ42ERE1CWE78WUP4BI',to_date('02/02/12','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('29','2',to_date('04/04/04','DD/MM/RR'),'GYV38UXF5UVU92EZA8RK',to_date('06/05/06','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('30','2',to_date('06/06/04','DD/MM/RR'),'GVI13HYD6VQS31FGT6DH',to_date('28/10/18','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('31','2',to_date('10/07/01','DD/MM/RR'),'DNH65PSS1CAE41NJZ4DM',to_date('26/11/09','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('32','2',to_date('04/11/04','DD/MM/RR'),'JCG91WFW2DCK87NNG7AH',to_date('02/11/16','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('33','2',to_date('27/08/03','DD/MM/RR'),'PWU89DKI5WWU57FZJ7NR',to_date('04/12/15','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('34','2',to_date('08/03/02','DD/MM/RR'),'PER45KOY6KJW48SPV8DT',to_date('18/05/10','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('35','2',to_date('09/09/04','DD/MM/RR'),'TFR24SCD6DXY58KSL5SS',to_date('24/06/11','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('36','2',to_date('09/11/02','DD/MM/RR'),'JWM10EUZ1NXV21VAU2SR',to_date('08/08/21','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('37','2',to_date('24/07/03','DD/MM/RR'),'PWP85OZC7RML76IQO6SG',to_date('16/11/07','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('38','2',to_date('05/12/01','DD/MM/RR'),'BLQ05BTQ4LVU30BGX7DU',to_date('02/05/21','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('39','2',to_date('20/04/01','DD/MM/RR'),'NGK42XNO8GAS22SUH1JG',to_date('01/10/08','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('40','2',to_date('12/07/02','DD/MM/RR'),'UEO37WSE6DRW08RFV3FB',to_date('25/08/07','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('41','2',to_date('25/01/03','DD/MM/RR'),'IXG19JKN4PXG99VNN0QC',to_date('12/09/12','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('42','2',to_date('16/01/01','DD/MM/RR'),'VFS37UOP5VNT66FHA6MM',to_date('27/12/18','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('43','2',to_date('14/02/02','DD/MM/RR'),'XQL06MOH8LVE11WQU3PH',to_date('21/01/10','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('44','2',to_date('04/06/02','DD/MM/RR'),'SDN47EVO2TPW95THX6VZ',to_date('03/03/19','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('45','2',to_date('16/09/02','DD/MM/RR'),'BCC22QIF7RAE15XNK9CM',to_date('08/12/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('46','2',to_date('24/02/03','DD/MM/RR'),'GAL23ESO2COX70BRJ4DZ',to_date('24/08/14','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('47','2',to_date('07/10/01','DD/MM/RR'),'WNA32VBQ1SDL11ILP4KY',to_date('08/02/06','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('48','2',to_date('11/04/01','DD/MM/RR'),'CTR14JTQ1BPX43QAY6HM',to_date('31/01/07','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('49','2',to_date('25/05/03','DD/MM/RR'),'BVK41BPW3VFT69LHW6EK',to_date('04/01/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('50','2',to_date('20/07/03','DD/MM/RR'),'FCD06VYB4IVP58BAH2DD',to_date('20/09/18','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('51','2',to_date('13/01/04','DD/MM/RR'),'HRN40FHT6SWU59CUW2RX',to_date('06/04/22','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('52','2',to_date('10/05/04','DD/MM/RR'),'VHJ02HUH8DWV43RKT5LX',to_date('27/10/13','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('53','2',to_date('01/04/02','DD/MM/RR'),'UYI23JMM4GVV87WQP8IJ',to_date('27/03/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('54','2',to_date('13/08/04','DD/MM/RR'),'GJI68SGE3NWY09ZJS3KJ',to_date('07/10/21','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('55','2',to_date('19/09/03','DD/MM/RR'),'PSI28WFE3ULX39GIY1DT',to_date('21/03/19','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('56','2',to_date('22/07/04','DD/MM/RR'),'YKM57JJV8TKW14WRS6MC',to_date('05/07/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('57','2',to_date('11/05/03','DD/MM/RR'),'MHX47KNI1YPA55IQO1TS',to_date('14/10/15','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('58','2',to_date('09/03/04','DD/MM/RR'),'XHB43KRV3JCJ52YFK9JF',to_date('26/05/12','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('59','2',to_date('22/08/01','DD/MM/RR'),'NXK61RPM7IHC38GOX6EB',to_date('16/06/07','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('60','2',to_date('01/09/02','DD/MM/RR'),'OON86OKL2JLP81EFP0MD',to_date('11/12/22','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('61','2',to_date('03/09/01','DD/MM/RR'),'BEC32JQW7PNL32TRF5FL',to_date('01/01/14','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('62','2',to_date('12/01/04','DD/MM/RR'),'EFS58FUC0NQF36RDJ1QS',to_date('22/01/17','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('63','2',to_date('01/02/03','DD/MM/RR'),'UPS17RVP5RMT55GNI6DL',to_date('29/12/06','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('64','2',to_date('18/03/01','DD/MM/RR'),'PTV62SRN5VSV46CIO5FS',to_date('16/07/24','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('65','2',to_date('21/10/01','DD/MM/RR'),'DIJ24IWC7ZGH66HOF5JJ',to_date('18/09/09','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('66','2',to_date('30/11/00','DD/MM/RR'),'NSV25OMY9LEC57XPL5DC',to_date('20/08/08','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('67','2',to_date('17/04/03','DD/MM/RR'),'SYY16SJK1XTT22WES4VF',to_date('17/12/21','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('68','2',to_date('09/05/03','DD/MM/RR'),'WJJ68WEW0UTH61EQQ2EI',to_date('24/09/08','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('69','2',to_date('18/07/03','DD/MM/RR'),'PXK73NZX0EGJ43WAH1FG',to_date('12/09/21','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('70','2',to_date('15/04/04','DD/MM/RR'),'CBU81EVX0CQB23TRP9TF',to_date('23/04/07','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('71','2',to_date('10/02/03','DD/MM/RR'),'HMV68RIQ4URH02JOB0BO',to_date('09/06/17','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('72','2',to_date('10/09/02','DD/MM/RR'),'LPY33MOY4TAY47GQR7KL',to_date('31/05/12','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('73','2',to_date('22/07/03','DD/MM/RR'),'SLR77POB8RQF53IGW2WY',to_date('21/07/15','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('74','2',to_date('01/11/02','DD/MM/RR'),'TUE10VWV5JQM62HND7DT',to_date('15/05/24','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('75','2',to_date('27/09/04','DD/MM/RR'),'SPV59TKM8PGH84FXN2KD',to_date('13/02/06','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('76','2',to_date('22/09/03','DD/MM/RR'),'UUP07KSS5XDL45BCM4NM',to_date('19/07/14','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('77','2',to_date('13/02/01','DD/MM/RR'),'WTT32OIE1HPW24UWI7WM',to_date('12/09/18','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('78','2',to_date('07/01/01','DD/MM/RR'),'ROY12QYG3SGZ70LJK9XV',to_date('09/10/16','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('79','2',to_date('10/06/03','DD/MM/RR'),'GKP37PFH8HCW55DZC2EA',to_date('17/12/20','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('80','2',to_date('09/04/02','DD/MM/RR'),'OJG19XIT2NZD87ORM7IN',to_date('13/04/16','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('81','2',to_date('22/05/03','DD/MM/RR'),'PGT46SXL8XRT31YBZ0FE',to_date('31/03/19','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('82','2',to_date('01/07/02','DD/MM/RR'),'TDS46MDS0SPW64RHJ5RI',to_date('04/06/10','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('83','2',to_date('23/10/03','DD/MM/RR'),'VKW52QFS5JYY81KOM5ZI',to_date('26/02/24','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('84','2',to_date('19/07/04','DD/MM/RR'),'TBU58TRH5TPW58WFW4FD',to_date('25/05/20','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('85','2',to_date('01/09/02','DD/MM/RR'),'ZLR43WSD7CQQ53OBZ8SQ',to_date('02/12/07','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('86','2',to_date('03/11/01','DD/MM/RR'),'IXA44CPY5HMI36DMC5FW',to_date('14/08/06','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('87','2',to_date('22/08/02','DD/MM/RR'),'XFU91MLR6WBS76EGS8ZU',to_date('27/03/14','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('88','2',to_date('05/02/03','DD/MM/RR'),'JSY12ALI5IHU56OZF4UD',to_date('08/01/17','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('89','2',to_date('25/08/02','DD/MM/RR'),'GRS74PRL3ZMD51CDX5YL',to_date('14/01/19','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('90','2',to_date('25/02/01','DD/MM/RR'),'YQS17HAB6VVV81JRB2JM',to_date('24/04/13','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('91','2',to_date('07/03/02','DD/MM/RR'),'JJG74TGF2ETC24VLV2YK',to_date('03/07/06','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('92','2',to_date('07/04/03','DD/MM/RR'),'MCD88SRH7UBE28TUG9EL',to_date('14/02/06','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('93','2',to_date('03/06/01','DD/MM/RR'),'UFQ73QCM3TGF32OPV2XO',to_date('16/11/16','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('94','2',to_date('19/01/02','DD/MM/RR'),'HHP30PXP4BED15ZEQ7FR',to_date('03/10/22','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('95','2',to_date('23/04/02','DD/MM/RR'),'JVI16RRY5PGX57HMM5GS',to_date('18/05/09','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('96','2',to_date('04/07/02','DD/MM/RR'),'FOY73QWW2WWS51XCQ1GV',to_date('30/03/12','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('97','2',to_date('05/11/02','DD/MM/RR'),'QWB08WAU8ECB48TQI5MH',to_date('17/10/15','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('98','2',to_date('16/03/04','DD/MM/RR'),'ZHT88FUX1KEG54QIS1HY',to_date('13/12/06','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('99','2',to_date('01/05/01','DD/MM/RR'),'YXJ65OHX5ZDC09UJT3XD',to_date('17/11/14','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('100','2',to_date('16/01/04','DD/MM/RR'),'XMD28XWI3VQF77CXI8RP',to_date('26/07/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('101','2',to_date('17/03/02','DD/MM/RR'),'EMW45TTG8QTY60JJE1XH',to_date('10/03/14','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('102','2',to_date('14/10/02','DD/MM/RR'),'XJR38KPC3JHB66ICP6WJ',to_date('31/03/09','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('103','2',to_date('16/01/03','DD/MM/RR'),'COW87OYO3NWK62EMN9GB',to_date('03/11/11','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('104','2',to_date('04/05/04','DD/MM/RR'),'NBD38HMA0GKI30TEO5IR',to_date('20/10/08','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('105','2',to_date('20/05/02','DD/MM/RR'),'KPI13FJP3XKF66GBD9MR',to_date('19/02/24','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('106','2',to_date('19/02/03','DD/MM/RR'),'CPN64GFG8PVY16TXT1FZ',to_date('19/03/06','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('7','1',to_date('09/03/04','DD/MM/RR'),'EQD46CQO4FEJ19AWJ9NJ',to_date('15/07/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('8','1',to_date('27/03/03','DD/MM/RR'),'TPT24LJN7DUU82MNC0LL',to_date('29/09/11','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('9','1',to_date('28/01/01','DD/MM/RR'),'LMN37GRS2LBM34TKU6MG',to_date('19/06/13','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('10','1',to_date('31/01/01','DD/MM/RR'),'GTR11CYT8QNW82UBB0BP',to_date('16/09/15','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('11','1',to_date('31/05/02','DD/MM/RR'),'UPP02IMW5TIG37BYM1OG',to_date('06/11/14','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('12','1',to_date('11/09/01','DD/MM/RR'),'VIP65TOG9LJM54HXU7NY',to_date('19/08/13','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('13','1',to_date('13/12/02','DD/MM/RR'),'QRD21QVH6UFZ41OOT2FO',to_date('27/10/19','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('14','1',to_date('28/07/03','DD/MM/RR'),'DBT93MEX1EPE05NQM4RO',to_date('13/11/07','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('15','1',to_date('09/02/04','DD/MM/RR'),'DSJ75RVV3ZIE68FDK8XC',to_date('18/11/14','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('16','1',to_date('17/04/01','DD/MM/RR'),'YIT05ZCN8IPD85EIQ2TT',to_date('17/12/06','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('17','1',to_date('01/04/02','DD/MM/RR'),'YDT06VON6FVF33UVY2KP',to_date('17/06/11','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('18','1',to_date('04/05/03','DD/MM/RR'),'KEO32PSR8SWT36OYP7CL',to_date('25/10/06','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('19','1',to_date('13/07/03','DD/MM/RR'),'MGG44DHL9UQT58RTG1MV',to_date('10/07/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('20','1',to_date('05/10/01','DD/MM/RR'),'IDD32OCQ3THB83OXB0CF',to_date('19/12/07','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('21','1',to_date('14/04/01','DD/MM/RR'),'RQX36BSL7PFE76VEB2DT',to_date('02/06/18','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('22','1',to_date('23/04/03','DD/MM/RR'),'ICT51EXF6MGY88JGX3GC',to_date('09/05/11','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('23','1',to_date('26/05/04','DD/MM/RR'),'CZN21WKW0GRL74WMN4AC',to_date('23/11/20','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('24','1',to_date('05/03/02','DD/MM/RR'),'NPO80OXK8SNQ57JHI7DP',to_date('09/09/12','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('25','1',to_date('13/12/02','DD/MM/RR'),'FIZ53FQM1WGI48POD5YW',to_date('27/11/13','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('26','1',to_date('13/08/01','DD/MM/RR'),'ISB73UKL3AKE34LDM1BK',to_date('29/03/07','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('27','1',to_date('09/04/04','DD/MM/RR'),'HSV25FMH1OMW41QLZ5NX',to_date('10/09/06','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('28','1',to_date('08/07/02','DD/MM/RR'),'TQM19GON6IWH44EGB1FL',to_date('21/12/17','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('29','1',to_date('04/08/01','DD/MM/RR'),'MIT54DKB1YKL33QAG0HQ',to_date('19/07/17','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('30','1',to_date('07/02/01','DD/MM/RR'),'EGP38RKW4NBP66YER5YQ',to_date('22/04/17','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('31','1',to_date('13/02/03','DD/MM/RR'),'DKQ28FIB6MXK50IZV8PM',to_date('16/05/12','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('32','1',to_date('14/03/01','DD/MM/RR'),'FVD26UUV7PWG34OGL6HS',to_date('26/01/12','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('33','1',to_date('11/03/04','DD/MM/RR'),'VZX36BJG8HJN03EUG4WJ',to_date('25/01/17','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('34','1',to_date('25/04/02','DD/MM/RR'),'EMX59EFL2CKB25CEB5SE',to_date('07/07/09','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('35','1',to_date('19/02/01','DD/MM/RR'),'ZVM45PHI4RKN66IBD7ZY',to_date('11/06/19','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('36','1',to_date('13/04/04','DD/MM/RR'),'FUX22NOB6RLL95QUF4LO',to_date('10/05/15','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('37','1',to_date('14/11/04','DD/MM/RR'),'MTY45CSE1GET15ZBW2VI',to_date('14/02/12','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('38','1',to_date('29/03/04','DD/MM/RR'),'HNV42WQQ5WRN52WBH7BA',to_date('28/06/16','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('39','1',to_date('20/02/04','DD/MM/RR'),'HBN88PSY7UFN71TPV1DY',to_date('31/01/15','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('40','1',to_date('13/12/00','DD/MM/RR'),'TSF68PYG5NJG48THF6QB',to_date('09/10/20','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('41','1',to_date('21/11/02','DD/MM/RR'),'XKK18IPI4FNK33TGP7LH',to_date('28/04/12','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('42','1',to_date('18/12/02','DD/MM/RR'),'DQT52SSW3PBH96ZSC3VJ',to_date('03/08/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('43','1',to_date('10/10/02','DD/MM/RR'),'GQA73PVF8WCY32LGN3TT',to_date('09/09/10','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('44','1',to_date('27/07/03','DD/MM/RR'),'BZG78YHF7XMP83WKW7KU',to_date('02/03/08','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('45','1',to_date('12/08/03','DD/MM/RR'),'PCF36COR2IPH77SRB6IM',to_date('18/12/12','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('46','1',to_date('08/12/00','DD/MM/RR'),'CCY35EZM4AQZ82TOD2FH',to_date('23/07/15','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('47','1',to_date('05/09/02','DD/MM/RR'),'MWS45ZVE2VIO35XEY6XE',to_date('22/01/15','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('48','1',to_date('20/12/00','DD/MM/RR'),'KXW62LJB2SXQ77NTS2SN',to_date('06/12/13','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('49','1',to_date('20/02/01','DD/MM/RR'),'EKU44PDG0DPK38LWV5LX',to_date('07/10/08','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('50','1',to_date('29/11/01','DD/MM/RR'),'FNC52VXL6XRX35PCB0KA',to_date('08/05/10','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('51','1',to_date('25/02/03','DD/MM/RR'),'SNO14YWU3TWO52NLT3PQ',to_date('06/06/15','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('52','1',to_date('21/01/03','DD/MM/RR'),'QHK89IZC4SNI48DFY6QV',to_date('04/10/24','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('53','1',to_date('09/11/04','DD/MM/RR'),'HQH99QAL3LZY84TKY5JJ',to_date('10/08/12','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('54','1',to_date('28/10/04','DD/MM/RR'),'BMV60DIK5OGR78BQE2MY',to_date('05/06/11','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('55','1',to_date('10/06/03','DD/MM/RR'),'LYL80URF7UOR23MLJ1FD',to_date('02/08/07','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('56','1',to_date('21/08/03','DD/MM/RR'),'TZJ20JSC1NJZ58HTX3OR',to_date('17/08/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('57','1',to_date('19/03/02','DD/MM/RR'),'RZY32NNS8QEM50MTZ7XT',to_date('09/03/18','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('1','1',to_date('01/01/22','DD/MM/RR'),'SEG123',to_date('01/01/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('2','2',to_date('01/02/22','DD/MM/RR'),'SEG456',to_date('01/02/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('3','1',to_date('01/03/22','DD/MM/RR'),'SEG789',to_date('01/03/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('4','1',to_date('01/04/22','DD/MM/RR'),'SEG101',to_date('01/04/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('3','2',to_date('01/03/22','DD/MM/RR'),'SEG790',to_date('01/03/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('4','2',to_date('01/04/22','DD/MM/RR'),'SEG105',to_date('01/04/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('5','1',to_date('01/05/22','DD/MM/RR'),'SEG111',to_date('01/05/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('6','2',to_date('01/06/22','DD/MM/RR'),'SEG222',to_date('01/06/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('58','1',to_date('06/07/04','DD/MM/RR'),'JPL80UUP4CHR33NJW9ME',to_date('27/10/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('59','1',to_date('11/11/03','DD/MM/RR'),'ACT68OJH4IMQ71UWF8AE',to_date('30/09/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('60','1',to_date('05/05/04','DD/MM/RR'),'MCF85XLW5QQJ08CBS6TC',to_date('26/10/20','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('61','1',to_date('30/11/01','DD/MM/RR'),'GFQ91DQD4NSK06TJI1EG',to_date('23/09/20','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('62','1',to_date('03/04/02','DD/MM/RR'),'CQO25YDZ1LNE69EIS2CB',to_date('17/01/10','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('63','1',to_date('25/12/02','DD/MM/RR'),'DOE21NTS4VNA68EDG5HU',to_date('28/06/11','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('64','1',to_date('13/11/04','DD/MM/RR'),'QNS18DSX1NVS85TXD4JA',to_date('18/03/24','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('65','1',to_date('25/04/02','DD/MM/RR'),'MSC47RSR9AXV28KLF8IU',to_date('27/09/11','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('66','1',to_date('16/02/03','DD/MM/RR'),'HRU57FZX9MQP12OGS5DB',to_date('22/01/22','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('67','1',to_date('07/07/01','DD/MM/RR'),'NMU66PEB3AZF75TUI7LY',to_date('31/07/07','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('68','1',to_date('16/04/03','DD/MM/RR'),'UAD80ZWH2RMR83JHW3KV',to_date('09/06/13','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('69','1',to_date('15/06/04','DD/MM/RR'),'VLT92YYS5LWJ03DLB5JX',to_date('02/07/10','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('70','1',to_date('02/08/02','DD/MM/RR'),'KVC61HYV2MJY64SUH4EY',to_date('07/12/09','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('71','1',to_date('15/09/01','DD/MM/RR'),'OEY45PCR2CYP68FIQ4US',to_date('16/08/24','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('72','1',to_date('02/01/04','DD/MM/RR'),'BZM75KKZ3PMI98SWW0EV',to_date('16/11/14','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('73','1',to_date('28/10/03','DD/MM/RR'),'LJE43VOQ7ZBT95HNT5KK',to_date('29/11/14','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('74','1',to_date('20/02/03','DD/MM/RR'),'GNZ05IYQ3PEU21SQP4EM',to_date('18/05/22','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('75','1',to_date('13/11/04','DD/MM/RR'),'FZB40UNE2TWC16WIJ1RO',to_date('10/10/24','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('76','1',to_date('23/06/04','DD/MM/RR'),'BEK68HCK6XVM17WUE1JR',to_date('22/06/14','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('77','1',to_date('06/06/03','DD/MM/RR'),'EXD42VHU5YYT32YNO2UF',to_date('08/05/06','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('78','1',to_date('15/06/04','DD/MM/RR'),'ICM16TDU8LMS83NVI6SF',to_date('23/04/13','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('79','1',to_date('16/04/01','DD/MM/RR'),'QDU33QPE4LWM21IWE3XN',to_date('12/01/11','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('80','1',to_date('26/04/02','DD/MM/RR'),'HYS83JEJ5BSR83VHF5JG',to_date('04/09/06','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('81','1',to_date('24/10/02','DD/MM/RR'),'WNP85BSX3QQU45XSD1WG',to_date('07/06/11','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('82','1',to_date('21/11/01','DD/MM/RR'),'QYT98BEQ3JOU78PXD2JX',to_date('08/11/13','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('83','1',to_date('30/05/02','DD/MM/RR'),'RGL67FUT5OQC25HRP7ZQ',to_date('24/09/09','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('84','1',to_date('26/02/01','DD/MM/RR'),'KBK94XQD7SQT67FFK9MW',to_date('22/02/16','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('85','1',to_date('11/03/03','DD/MM/RR'),'UOY36CSJ7QOS54WVR6TX',to_date('05/04/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('86','1',to_date('28/11/01','DD/MM/RR'),'LCU22MOQ8NDJ85PNI6SB',to_date('17/11/13','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('87','1',to_date('20/07/03','DD/MM/RR'),'QIS69WTU5LGI02QXJ1XF',to_date('09/09/07','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('88','1',to_date('17/12/02','DD/MM/RR'),'WHH62FOP7FMI37IFI3JG',to_date('19/12/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('89','1',to_date('15/06/03','DD/MM/RR'),'OFK79QQI7EZR83DNL9JB',to_date('23/10/12','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('90','1',to_date('24/11/00','DD/MM/RR'),'XVT45SRD3UNW87OJJ9YH',to_date('12/09/12','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('91','1',to_date('30/05/01','DD/MM/RR'),'NLT25MOV8DQP55XPL8EK',to_date('21/01/13','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('92','1',to_date('24/10/03','DD/MM/RR'),'EVH33XEK4OVB65XSW8QV',to_date('02/03/18','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('93','1',to_date('06/04/03','DD/MM/RR'),'WVJ58DOI8WHD15RUF3SI',to_date('11/06/12','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('94','1',to_date('21/02/03','DD/MM/RR'),'NSZ36CVJ6PNG17BPI2JW',to_date('21/09/16','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('95','1',to_date('09/06/02','DD/MM/RR'),'ZZG01XII9DLD54FCY1IF',to_date('02/11/21','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('96','1',to_date('04/02/01','DD/MM/RR'),'MJW36KMM3YIM11BVJ1BX',to_date('31/10/09','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('97','1',to_date('24/10/04','DD/MM/RR'),'URP66ENY5KYW97SXU3QD',to_date('27/07/09','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('98','1',to_date('20/08/02','DD/MM/RR'),'DER57ZSR4SYR97IXE4UX',to_date('14/07/08','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('99','1',to_date('15/02/02','DD/MM/RR'),'YXC91NVB1KRF02XJY7HK',to_date('11/06/08','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('100','1',to_date('06/03/01','DD/MM/RR'),'MWR26FDI2PVW64KPP9KC',to_date('12/08/21','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('101','1',to_date('28/07/03','DD/MM/RR'),'HGX62MLL2MGZ36RUN3AZ',to_date('02/06/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('102','1',to_date('30/11/01','DD/MM/RR'),'OJN50HDE0ZXG77PWQ6UM',to_date('02/06/13','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('103','1',to_date('15/01/02','DD/MM/RR'),'WLV07TWV8ZRO27QZU0VV',to_date('06/04/14','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('104','1',to_date('29/05/04','DD/MM/RR'),'IJW66THC8DZN83CHC6JR',to_date('11/01/20','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('105','1',to_date('22/09/04','DD/MM/RR'),'BMB51LNC9FRC59SGZ4TM',to_date('02/10/21','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('106','1',to_date('15/05/01','DD/MM/RR'),'KCE60EUY0OXX11UKC5SF',to_date('25/07/16','DD/MM/RR'));


REM INSERTING into CONTRATACION.NOVEDADES
SET DEFINE OFF;
Insert into CONTRATACION.NOVEDADES (CON_ID,NOV_CODIGO_DOCUMENTO,NOV_FECHA_INICIO,NOV_FECHA_FIN,NOV_MEDIDA_MANEJO,NOV_TIPO,NOV_DESCRIPCION, NOV_DESCRIPCION_MANEJO) values ('1','NOV123',to_date('01/01/22','DD/MM/RR'),to_date('01/01/23','DD/MM/RR'),'1','1','Novedad1','Manejo1');
Insert into CONTRATACION.NOVEDADES (CON_ID,NOV_CODIGO_DOCUMENTO,NOV_FECHA_INICIO,NOV_FECHA_FIN,NOV_MEDIDA_MANEJO,NOV_TIPO,NOV_DESCRIPCION, NOV_DESCRIPCION_MANEJO) values ('2','NOV456',to_date('01/02/22','DD/MM/RR'),to_date('01/02/23','DD/MM/RR'),'2','2','Novedad2','Manejo2');
REM INSERTING into CONTRATACION.POSICION_CONTRATO
SET DEFINE OFF;
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('7','7',to_date('17/06/04','DD/MM/RR'),to_date('25/11/08','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('8','8',to_date('20/03/03','DD/MM/RR'),to_date('07/04/17','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('9','9',to_date('03/05/04','DD/MM/RR'),to_date('11/07/18','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('10','10',to_date('22/03/04','DD/MM/RR'),to_date('19/02/18','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('11','11',to_date('25/10/03','DD/MM/RR'),to_date('24/03/11','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('12','12',to_date('17/08/01','DD/MM/RR'),to_date('30/01/23','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('13','13',to_date('18/03/03','DD/MM/RR'),to_date('22/02/22','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('14','14',to_date('26/08/04','DD/MM/RR'),to_date('04/05/12','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('15','15',to_date('19/12/00','DD/MM/RR'),to_date('09/08/15','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('16','16',to_date('26/07/02','DD/MM/RR'),to_date('10/08/11','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('17','17',to_date('09/06/02','DD/MM/RR'),to_date('02/02/21','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('18','18',to_date('13/07/02','DD/MM/RR'),to_date('22/08/18','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('19','19',to_date('21/10/01','DD/MM/RR'),to_date('21/10/21','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('20','20',to_date('03/01/04','DD/MM/RR'),to_date('11/08/07','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('21','21',to_date('18/09/02','DD/MM/RR'),to_date('12/04/21','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('22','22',to_date('10/08/03','DD/MM/RR'),to_date('08/05/08','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('23','23',to_date('18/07/01','DD/MM/RR'),to_date('22/10/20','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('24','24',to_date('13/03/02','DD/MM/RR'),to_date('06/06/21','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('25','25',to_date('02/03/02','DD/MM/RR'),to_date('11/02/20','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('26','26',to_date('17/11/03','DD/MM/RR'),to_date('10/04/18','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('27','27',to_date('12/06/04','DD/MM/RR'),to_date('15/07/20','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('28','28',to_date('17/09/04','DD/MM/RR'),to_date('13/06/11','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('29','29',to_date('16/06/03','DD/MM/RR'),to_date('31/10/19','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('30','30',to_date('01/03/03','DD/MM/RR'),to_date('22/12/12','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('31','31',to_date('20/07/02','DD/MM/RR'),to_date('04/05/20','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('32','32',to_date('28/05/01','DD/MM/RR'),to_date('08/02/21','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('33','33',to_date('03/02/01','DD/MM/RR'),to_date('15/06/21','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('34','34',to_date('20/04/04','DD/MM/RR'),to_date('17/09/18','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('35','35',to_date('19/05/03','DD/MM/RR'),to_date('19/11/20','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('36','36',to_date('26/06/04','DD/MM/RR'),to_date('13/09/22','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('37','37',to_date('11/04/01','DD/MM/RR'),to_date('30/06/06','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('38','38',to_date('26/05/04','DD/MM/RR'),to_date('06/12/12','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('39','39',to_date('16/11/03','DD/MM/RR'),to_date('18/05/10','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('40','40',to_date('10/08/03','DD/MM/RR'),to_date('26/04/21','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('41','41',to_date('20/12/01','DD/MM/RR'),to_date('28/01/18','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('42','42',to_date('27/01/03','DD/MM/RR'),to_date('24/05/24','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('43','43',to_date('04/06/01','DD/MM/RR'),to_date('19/01/15','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('44','44',to_date('16/12/03','DD/MM/RR'),to_date('10/09/21','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('45','45',to_date('14/05/01','DD/MM/RR'),to_date('09/04/10','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('46','46',to_date('22/12/03','DD/MM/RR'),to_date('24/11/07','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('47','47',to_date('10/02/03','DD/MM/RR'),to_date('10/05/16','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('48','48',to_date('23/01/03','DD/MM/RR'),to_date('24/09/22','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('49','49',to_date('09/02/02','DD/MM/RR'),to_date('24/11/06','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('50','50',to_date('13/12/02','DD/MM/RR'),to_date('06/08/20','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('51','51',to_date('08/01/01','DD/MM/RR'),to_date('15/06/10','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('52','52',to_date('06/05/02','DD/MM/RR'),to_date('01/07/07','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('53','53',to_date('03/09/01','DD/MM/RR'),to_date('15/09/06','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('54','54',to_date('04/01/02','DD/MM/RR'),to_date('29/11/18','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('55','55',to_date('26/04/01','DD/MM/RR'),to_date('25/10/13','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('56','56',to_date('13/04/02','DD/MM/RR'),to_date('07/08/08','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('57','57',to_date('08/04/01','DD/MM/RR'),to_date('26/03/17','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('58','58',to_date('30/08/02','DD/MM/RR'),to_date('20/12/08','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('59','59',to_date('30/03/02','DD/MM/RR'),to_date('14/09/16','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('60','60',to_date('01/07/03','DD/MM/RR'),to_date('01/08/10','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('61','61',to_date('23/01/01','DD/MM/RR'),to_date('30/06/12','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('62','62',to_date('23/06/03','DD/MM/RR'),to_date('13/12/07','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('63','63',to_date('01/11/04','DD/MM/RR'),to_date('26/05/15','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('64','64',to_date('27/08/04','DD/MM/RR'),to_date('19/01/16','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('65','65',to_date('30/11/02','DD/MM/RR'),to_date('05/01/13','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('66','66',to_date('08/01/04','DD/MM/RR'),to_date('14/07/19','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('67','67',to_date('11/05/01','DD/MM/RR'),to_date('23/04/18','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('68','68',to_date('15/08/03','DD/MM/RR'),to_date('11/06/09','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('69','69',to_date('29/11/01','DD/MM/RR'),to_date('18/03/10','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('70','70',to_date('07/08/02','DD/MM/RR'),to_date('15/11/13','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('71','71',to_date('06/11/02','DD/MM/RR'),to_date('15/02/24','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('72','72',to_date('22/03/02','DD/MM/RR'),to_date('09/08/14','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('73','73',to_date('27/06/03','DD/MM/RR'),to_date('18/03/07','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('74','74',to_date('11/05/01','DD/MM/RR'),to_date('08/08/20','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('75','75',to_date('13/06/04','DD/MM/RR'),to_date('21/02/24','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('76','76',to_date('21/05/03','DD/MM/RR'),to_date('20/09/13','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('77','77',to_date('02/08/04','DD/MM/RR'),to_date('01/04/15','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('78','78',to_date('04/04/01','DD/MM/RR'),to_date('17/02/21','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('79','79',to_date('09/12/03','DD/MM/RR'),to_date('11/06/21','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('80','80',to_date('05/02/01','DD/MM/RR'),to_date('13/04/10','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('81','81',to_date('01/04/03','DD/MM/RR'),to_date('07/10/14','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('82','82',to_date('05/04/02','DD/MM/RR'),to_date('13/03/08','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('83','83',to_date('30/12/03','DD/MM/RR'),to_date('20/05/18','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('84','84',to_date('25/09/03','DD/MM/RR'),to_date('07/08/21','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('85','85',to_date('17/11/02','DD/MM/RR'),to_date('01/03/08','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('86','86',to_date('02/07/02','DD/MM/RR'),to_date('19/06/17','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('87','87',to_date('10/10/03','DD/MM/RR'),to_date('24/01/24','DD/MM/RR'),'SECUNDARIO');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('88','88',to_date('19/11/04','DD/MM/RR'),to_date('20/03/10','DD/MM/RR'),'SECUNDARIO');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('89','89',to_date('11/09/03','DD/MM/RR'),to_date('30/01/19','DD/MM/RR'),'SECUNDARIO');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('90','90',to_date('03/01/02','DD/MM/RR'),to_date('24/04/19','DD/MM/RR'),'SECUNDARIO');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('91','91',to_date('23/09/02','DD/MM/RR'),to_date('09/07/24','DD/MM/RR'),'SECUNDARIO');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('92','92',to_date('02/04/03','DD/MM/RR'),to_date('05/05/13','DD/MM/RR'),'SECUNDARIO');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('93','93',to_date('24/04/02','DD/MM/RR'),to_date('01/03/17','DD/MM/RR'),'SECUNDARIO');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('94','94',to_date('07/02/01','DD/MM/RR'),to_date('18/01/06','DD/MM/RR'),'SECUNDARIO');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('95','95',to_date('19/02/04','DD/MM/RR'),to_date('06/11/22','DD/MM/RR'),'SECUNDARIO');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('96','96',to_date('28/11/02','DD/MM/RR'),to_date('05/03/24','DD/MM/RR'),'SECUNDARIO');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('97','97',to_date('14/09/03','DD/MM/RR'),to_date('18/02/12','DD/MM/RR'),'SECUNDARIO');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('98','98',to_date('22/10/01','DD/MM/RR'),to_date('31/01/15','DD/MM/RR'),'SECUNDARIO');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('99','99',to_date('02/04/02','DD/MM/RR'),to_date('22/11/15','DD/MM/RR'),'SECUNDARIO');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('100','100',to_date('20/09/02','DD/MM/RR'),to_date('01/10/24','DD/MM/RR'),'SECUNDARIO');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('101','101',to_date('16/04/03','DD/MM/RR'),to_date('25/03/12','DD/MM/RR'),'SECUNDARIO');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('102','102',to_date('02/06/03','DD/MM/RR'),to_date('06/06/20','DD/MM/RR'),'SECUNDARIO');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('103','103',to_date('11/01/01','DD/MM/RR'),to_date('27/12/16','DD/MM/RR'),'SECUNDARIO');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('104','104',to_date('26/01/03','DD/MM/RR'),to_date('01/03/08','DD/MM/RR'),'SECUNDARIO');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('105','105',to_date('09/08/03','DD/MM/RR'),to_date('12/04/15','DD/MM/RR'),'SECUNDARIO');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('106','106',to_date('12/04/04','DD/MM/RR'),to_date('25/02/12','DD/MM/RR'),'SECUNDARIO');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('1','1',to_date('01/01/22','DD/MM/RR'),to_date('01/01/23','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('2','2',to_date('01/02/22','DD/MM/RR'),to_date('01/02/23','DD/MM/RR'),'SECUNDARIO');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('3','3',to_date('01/03/22','DD/MM/RR'),to_date('01/03/23','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('4','4',to_date('01/04/22','DD/MM/RR'),to_date('01/04/23','DD/MM/RR'),'SECUNDARIO');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('5','5',to_date('01/05/22','DD/MM/RR'),to_date('01/05/23','DD/MM/RR'),'PRINCIPAL');
Insert into CONTRATACION.POSICION_CONTRATO (CON_ID,POS_ID,POSCON_FECHA_INICIO,POSCON_FECHA_FIN,POSCON_CARACTERISTICA) values ('6','6',to_date('01/06/22','DD/MM/RR'),to_date('01/06/23','DD/MM/RR'),'SECUNDARIO');
REM INSERTING into CONTRATACION.SALARIOS
SET DEFINE OFF;
Insert into CONTRATACION.SALARIOS (CON_ID,SAL_FECHA_INICIO,SAL_FECHA_FINALIZADO,SAL_VALOR) values ('1',to_date('01/01/22','DD/MM/RR'),null,'50000');
Insert into CONTRATACION.SALARIOS (CON_ID,SAL_FECHA_INICIO,SAL_FECHA_FINALIZADO,SAL_VALOR) values ('2',to_date('01/02/22','DD/MM/RR'),null,'60000');
Insert into CONTRATACION.SALARIOS (CON_ID,SAL_FECHA_INICIO,SAL_FECHA_FINALIZADO,SAL_VALOR) values ('3',to_date('01/03/22','DD/MM/RR'),null,'55000');
Insert into CONTRATACION.SALARIOS (CON_ID,SAL_FECHA_INICIO,SAL_FECHA_FINALIZADO,SAL_VALOR) values ('4',to_date('01/04/22','DD/MM/RR'),null,'65000');
Insert into CONTRATACION.SALARIOS (CON_ID,SAL_FECHA_INICIO,SAL_FECHA_FINALIZADO,SAL_VALOR) values ('5',to_date('01/05/22','DD/MM/RR'),null,'70000');
Insert into CONTRATACION.SALARIOS (CON_ID,SAL_FECHA_INICIO,SAL_FECHA_FINALIZADO,SAL_VALOR) values ('6',to_date('01/06/22','DD/MM/RR'),null,'80000');

