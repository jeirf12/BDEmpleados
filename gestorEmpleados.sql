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
)TABLESPACE contratacion_rh
   STORAGE (INITIAL 10M NEXT 5M MAXEXTENTS UNLIMITED);

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
)TABLESPACE contratacion_rh
   STORAGE (INITIAL 10M NEXT 5M MAXEXTENTS UNLIMITED);

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
   STORAGE (INITIAL 10M NEXT 5M MAXEXTENTS UNLIMITED);

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
   STORAGE (INITIAL 5M NEXT 5M MAXEXTENTS UNLIMITED);

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
   STORAGE (INITIAL 10M NEXT 5M MAXEXTENTS UNLIMITED);

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
   STORAGE (INITIAL 10M NEXT 5M MAXEXTENTS UNLIMITED);

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


REM INSERTING into CONTRATACION.AREA
SET DEFINE OFF;
Insert into CONTRATACION.AREA (AREA_ID,AREA_NOMBRE) values ('1','Departamento de Ventas');
Insert into CONTRATACION.AREA (AREA_ID,AREA_NOMBRE) values ('2','Departamento de Recursos Humanos');
REM INSERTING into CONTRATACION.HABILIDADES
SET DEFINE OFF;
Insert into CONTRATACION.HABILIDADES (HAB_ID,HAB_NOMBRE, HAB_DESCRIPCION) values ('1','Comunicación', 'Comunicación social');
Insert into CONTRATACION.HABILIDADES (HAB_ID,HAB_NOMBRE, HAB_DESCRIPCION) values ('2','Técnica', 'Habilidad Técnica');

REM INSERTING into CONTRATACION.MODALIDAD_CONTRATO
SET DEFINE OFF;
Insert into CONTRATACION.MODALIDAD_CONTRATO (MODCON_ID,MODCON_NOMBRE) values ('1','Contrato a Término Indefinido');
Insert into CONTRATACION.MODALIDAD_CONTRATO (MODCON_ID,MODCON_NOMBRE) values ('2','Contrato a Término Fijo');
REM INSERTING into CONTRATACION.MONEDA
SET DEFINE OFF;
Insert into CONTRATACION.MONEDA (MON_ID,MON_NOMBRE) values ('USD','Dólar Americano');
Insert into CONTRATACION.MONEDA (MON_ID,MON_NOMBRE) values ('EUR','Euro');
REM INSERTING into CONTRATACION.PERFILCARGO
SET DEFINE OFF;
Insert into CONTRATACION.PERFILCARGO (PERCAR_ID,PERCAR_CARGO,PERCAR_DESCRIPCION) values ('1','Gerente de Ventas', 'Gerente de Ventas');
Insert into CONTRATACION.PERFILCARGO (PERCAR_ID,PERCAR_CARGO,PERCAR_DESCRIPCION) values ('2','Analista de Recursos Humanos','Analista de Recursos Humanos');
Insert into CONTRATACION.PERFILCARGO (PERCAR_ID,PERCAR_CARGO,PERCAR_DESCRIPCION) values ('3','Desarrollador Web', 'Desarrollador Web');
Insert into CONTRATACION.PERFILCARGO (PERCAR_ID,PERCAR_CARGO,PERCAR_DESCRIPCION) values ('4','Analista de Datos', 'Analista de Datos');
Insert into CONTRATACION.PERFILCARGO (PERCAR_ID,PERCAR_CARGO,PERCAR_DESCRIPCION) values ('5','Especialista en Marketing Digital' , 'Especialista en Marketing Digital');
Insert into CONTRATACION.PERFILCARGO (PERCAR_ID,PERCAR_CARGO,PERCAR_DESCRIPCION) values ('6','Ingeniero de Sistemas','Ingeniero de Sistemas');
Insert into CONTRATACION.PERFILCARGO (PERCAR_ID,PERCAR_CARGO,PERCAR_DESCRIPCION) values ('7','Asistente Administrativo', 'Asistente Administrativo');

REM INSERTING into CONTRATACION.SEDE
SET DEFINE OFF;
Insert into CONTRATACION.SEDE (SED_ID,SED_NIT,SED_NOMBRE) values ('1','123456789','Sede Principal');
Insert into CONTRATACION.SEDE (SED_ID,SED_NIT,SED_NOMBRE) values ('2','987654321','Sucursal 1');
REM INSERTING into CONTRATACION.SEGURIDADSOCIAL
SET DEFINE OFF;
Insert into CONTRATACION.SEGURIDADSOCIAL (SEGSOC_ID,SEGSOC_NOMBRE,SEGSOC_TIPO,SEGSOC_DESCRIPCION) values ('1','Empresa de Salud','1', 'Descripcion de la empresa Salud');
Insert into CONTRATACION.SEGURIDADSOCIAL (SEGSOC_ID,SEGSOC_NOMBRE,SEGSOC_TIPO,SEGSOC_DESCRIPCION) values ('2','Empresa de Pensión','2', 'Descripcion de la empresa pensión');
REM INSERTING into CONTRATACION.TIPO_CONTRATO
SET DEFINE OFF;
Insert into CONTRATACION.TIPO_CONTRATO (TIPCON_ID,TIPCON_NOMBRE) values ('1','Tiempo Completo');
Insert into CONTRATACION.TIPO_CONTRATO (TIPCON_ID,TIPCON_NOMBRE) values ('2','Medio Tiempo');
REM INSERTING into CONTRATACION.TIPO_IDENTIFICACION
SET DEFINE OFF;
Insert into CONTRATACION.TIPO_IDENTIFICACION (TIPIDE_ID,TIPIDE_NOMBRE,TIPIDE_ACRONIMO) values ('1','Cédula de Ciudadanía','CC');
Insert into CONTRATACION.TIPO_IDENTIFICACION (TIPIDE_ID,TIPIDE_NOMBRE,TIPIDE_ACRONIMO) values ('2','Tarjeta de Identidad','TI');


REM INSERTING into CONTRATACION.EMPLEADO
SET DEFINE OFF;
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('1','1','123456789','Juan','Pérez',to_date('01/01/90','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('2','2','987654321','María','Gómez',to_date('15/05/85','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('3','1','111111111','Luis','Martínez',to_date('20/06/88','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('4','2','222222222','Ana','Sánchez',to_date('15/03/95','DD/MM/RR'),'FEMENINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('5','1','555555555','Pedro','Rodríguez',to_date('10/10/87','DD/MM/RR'),'MASCULINO');
Insert into CONTRATACION.EMPLEADO (EMP_ID,TIPIDE_ID,EMP_CODIGO_IDENTIFICACION,EMP_NOMBRE,EMP_APELLIDO,EMP_FECHA_NACIMIENTO,EMP_GENERO) values ('6','2','666666666','Laura','López',to_date('25/12/92','DD/MM/RR'),'FEMENINO');

REM INSERTING into CONTRATACION.CONTRATO
SET DEFINE OFF;
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('1','1','1','1','USD','CONTR123',to_date('01/01/22','DD/MM/RR'),to_date('01/01/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('2','2','2','2','EUR','CONTR456',to_date('01/02/22','DD/MM/RR'),to_date('01/02/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('3','1','3','1','USD','CONTR789',to_date('01/03/22','DD/MM/RR'),to_date('01/03/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('4','2','4','2','EUR','CONTR101',to_date('01/04/22','DD/MM/RR'),to_date('01/04/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('5','1','5','1','USD','CONTR111',to_date('01/05/22','DD/MM/RR'),to_date('01/05/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO (CON_ID,TIPCON_ID,EMP_ID,MODCON_ID,MON_ID,CON_FOLIO,CON_FECHA_INICIO,CON_FECHA_FIN) values ('6','2','6','2','EUR','CONTR222',to_date('01/06/22','DD/MM/RR'),to_date('01/06/23','DD/MM/RR'));

REM INSERTING into CONTRATACION.POSICION
SET DEFINE OFF;
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('1',null,'1','1','1','1','10');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('2','1','2','2','2','2','5');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('3','2','1','3','1','3','8');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('4','3','2','4','2','4','5');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('5','4','2','5','1','5','7');
Insert into CONTRATACION.POSICION (POS_ID,JEFE_ID,SED_ID,PERCAR_ID,AREA_ID,POS_CATEGORIA,POS_LIMITE_PLAZAS) values ('6','5','1','6','2','6','4');



REM INSERTING into CONTRATACION.POSICION_CONTRATO
SET DEFINE OFF;
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

REM INSERTING into CONTRATACION.CONTRATO_SEGURIDADSOCIAL
SET DEFINE OFF;
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('1','1',to_date('01/01/22','DD/MM/RR'),'SEG123',to_date('01/01/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('2','2',to_date('01/02/22','DD/MM/RR'),'SEG456',to_date('01/02/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('3','1',to_date('01/03/22','DD/MM/RR'),'SEG789',to_date('01/03/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('4','1',to_date('01/04/22','DD/MM/RR'),'SEG101',to_date('01/04/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('3','2',to_date('01/03/22','DD/MM/RR'),'SEG790',to_date('01/03/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('4','2',to_date('01/04/22','DD/MM/RR'),'SEG105',to_date('01/04/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('5','1',to_date('01/05/22','DD/MM/RR'),'SEG111',to_date('01/05/23','DD/MM/RR'));
Insert into CONTRATACION.CONTRATO_SEGURIDADSOCIAL (CON_ID,SEGSOC_ID,CONSEG_FECHA_INICIO,CONSEG_CODIGO_DOCUMENTO,CONSEG_FECHA_FINALIZACION) values ('6','2',to_date('01/06/22','DD/MM/RR'),'SEG222',to_date('01/06/23','DD/MM/RR'));

REM INSERTING into CONTRATACION.NOVEDADES
SET DEFINE OFF;
Insert into CONTRATACION.NOVEDADES (CON_ID,NOV_CODIGO_DOCUMENTO,NOV_FECHA_INICIO,NOV_FECHA_FIN,NOV_MEDIDA_MANEJO,NOV_TIPO,NOV_DESCRIPCION_MANEJO,NOV_DESCRIPCION) values ('1','NOV123',to_date('01/01/22','DD/MM/RR'),to_date('01/01/23','DD/MM/RR'),'1','1','El empleado fue notifiacdo de la falta', 'No cerró la puerta del archivo');
Insert into CONTRATACION.NOVEDADES (CON_ID,NOV_CODIGO_DOCUMENTO,NOV_FECHA_INICIO,NOV_FECHA_FIN,NOV_MEDIDA_MANEJO,NOV_TIPO,NOV_DESCRIPCION_MANEJO,NOV_DESCRIPCION) values ('2','NOV456',to_date('01/02/22','DD/MM/RR'),to_date('01/02/23','DD/MM/RR'),'2','2','Se le informa de las suspensión', 'Se peleó con el jefe');

REM INSERTING into CONTRATACION.HABILIDADES_PERFILCARGO
SET DEFINE OFF;
