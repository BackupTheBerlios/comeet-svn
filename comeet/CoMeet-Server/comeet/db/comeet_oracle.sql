--------------------------------------------------------
--  File created - sábado-diciembre-06-2008   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence GRUPOS_GID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "GRUPOS_GID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 17 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence MENSAJES_MID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "MENSAJES_MID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 339 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence MENSAJES_PDA_MID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "MENSAJES_PDA_MID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 68 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence ROLES_RID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "ROLES_RID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 6 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence TIPO_GRUPO_ID_TIPO_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "TIPO_GRUPO_ID_TIPO_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 4 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence UBICACIONES_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "UBICACIONES_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 23 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence USUARIOS_UID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "USUARIOS_UID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 20 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Table GRUPOS
--------------------------------------------------------

  CREATE TABLE "GRUPOS" 
   (	"GRUPO_ID" NUMBER(*,0), 
	"NOMBRE" VARCHAR2(40 CHAR), 
	"VISIBLE" NUMBER(*,0) DEFAULT 0, 
	"TIPO_GRUPO" NUMBER(*,0) DEFAULT 0, 
	"HABILITADO" NUMBER(*,0) DEFAULT 1
   ) ;
--------------------------------------------------------
--  DDL for Table MASIVOS_PDA
--------------------------------------------------------

  CREATE TABLE "MASIVOS_PDA" 
   (	"MID" NUMBER, 
	"LOGIN" VARCHAR2(30 CHAR), 
	"FECHA_CONFIRMACION" DATE, 
	"HORA_CONFIRMACION" VARCHAR2(12 CHAR) DEFAULT '00:00:00 AM'
   ) ;
--------------------------------------------------------
--  DDL for Table MENSAJES
--------------------------------------------------------

  CREATE TABLE "MENSAJES" 
   (	"MID" NUMBER(*,0), 
	"UID_DESTINO" NUMBER(*,0), 
	"FECHA_ENVIO" DATE, 
	"ASUNTO" VARCHAR2(256 CHAR), 
	"TEXTO" VARCHAR2(1024 CHAR), 
	"CONFIRMADO" NUMBER(*,0) DEFAULT 0, 
	"TIEMPO_VIDA" NUMBER(*,0) DEFAULT 5, 
	"UID_ORIGEN" NUMBER(*,0), 
	"CONTROL" NUMBER(*,0) DEFAULT 0, 
	"MINUTOS" NUMBER(*,0), 
	"FECHA_CONFIRMACION" DATE DEFAULT '01-01-50', 
	"HORA_ENVIO" VARCHAR2(12 CHAR) DEFAULT '00:00:00 AM', 
	"HORA_CONFIRMACION" VARCHAR2(12 CHAR) DEFAULT '00:00:00 AM'
   ) ;
--------------------------------------------------------
--  DDL for Table MENSAJES_PDA
--------------------------------------------------------

  CREATE TABLE "MENSAJES_PDA" 
   (	"MID" NUMBER(*,0), 
	"LOGIN_DESTINO" VARCHAR2(30 CHAR), 
	"GID_ORIGEN" NUMBER(*,0), 
	"FECHA_ENVIO" DATE, 
	"ASUNTO" VARCHAR2(256 CHAR), 
	"TEXTO" VARCHAR2(1024 CHAR), 
	"CONFIRMADO" NUMBER(*,0) DEFAULT 0, 
	"FECHA_CONFIRMACION" DATE DEFAULT '01-01-50', 
	"ENTREGADO" NUMBER(*,0) DEFAULT 0, 
	"HORA_ENVIO" VARCHAR2(12 CHAR) DEFAULT '00:00:00 AM', 
	"HORA_CONFIRMACION" VARCHAR2(12 CHAR) DEFAULT '00:00:00 AM'
   ) ;
--------------------------------------------------------
--  DDL for Table ROLES
--------------------------------------------------------

  CREATE TABLE "ROLES" 
   (	"RID" NUMBER(*,0), 
	"NOMBRE" VARCHAR2(40 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table TIPO_GRUPO
--------------------------------------------------------

  CREATE TABLE "TIPO_GRUPO" 
   (	"ID_TIPO" NUMBER(*,0), 
	"DESCRIPCION" VARCHAR2(40 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table TRANSACCIONES
--------------------------------------------------------

  CREATE TABLE "TRANSACCIONES" 
   (	"CODIGO" VARCHAR2(5 CHAR), 
	"DESCRIPCION" VARCHAR2(100 CHAR), 
	"DRIVER" VARCHAR2(200 CHAR), 
	"ARGS" VARCHAR2(500 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table UBICACIONES
--------------------------------------------------------

  CREATE TABLE "UBICACIONES" 
   (	"CODIGO" NUMBER(*,0), 
	"NOMBRE" VARCHAR2(50 CHAR), 
	"IP" VARCHAR2(15 CHAR) DEFAULT '127.0.0.1', 
	"GID" NUMBER(*,0), 
	"HABILITADO" NUMBER(*,0) DEFAULT 1
   ) ;
--------------------------------------------------------
--  DDL for Table USUARIOS
--------------------------------------------------------

  CREATE TABLE "USUARIOS" 
   (	"CODIGO" NUMBER(*,0), 
	"LOGIN" VARCHAR2(30 CHAR), 
	"CLAVE" VARCHAR2(32 CHAR), 
	"NOMBRES" VARCHAR2(100 CHAR) DEFAULT 'Sin Nombre', 
	"CORREO" VARCHAR2(200 CHAR), 
	"HABILITADO" NUMBER(*,0) DEFAULT 1, 
	"GID" NUMBER(*,0) DEFAULT 5, 
	"ROL" NUMBER(*,0)
   ) ;
--------------------------------------------------------
--  DDL for Table USUARIOS_UBICACION
--------------------------------------------------------

  CREATE TABLE "USUARIOS_UBICACION" 
   (	"ID_USUARIO" NUMBER(*,0), 
	"CODIGO_UBICACION" NUMBER(*,0), 
	"VALIDAR_IP" NUMBER(*,0) DEFAULT 0
   ) ;

---------------------------------------------------
--   DATA FOR TABLE GRUPOS
--   FILTER = none used
---------------------------------------------------
REM INSERTING into GRUPOS
Insert into GRUPOS (GRUPO_ID,NOMBRE,VISIBLE,TIPO_GRUPO,HABILITADO) values (1.'SIN GRUPO'.0.1.1);
Insert into GRUPOS (GRUPO_ID,NOMBRE,VISIBLE,TIPO_GRUPO,HABILITADO) values (2.'ADMINISTRATIVOS'.0.2.1);
Insert into GRUPOS (GRUPO_ID,NOMBRE,VISIBLE,TIPO_GRUPO,HABILITADO) values (3.'GERENCIA'.1.2.1);
Insert into GRUPOS (GRUPO_ID,NOMBRE,VISIBLE,TIPO_GRUPO,HABILITADO) values (4.'AUDITORIA'.1.2.1);
Insert into GRUPOS (GRUPO_ID,NOMBRE,VISIBLE,TIPO_GRUPO,HABILITADO) values (5.'SOPORTE TECNICO'.1.2.1);
Insert into GRUPOS (GRUPO_ID,NOMBRE,VISIBLE,TIPO_GRUPO,HABILITADO) values (6.'NORTE'.0.1.1);
Insert into GRUPOS (GRUPO_ID,NOMBRE,VISIBLE,TIPO_GRUPO,HABILITADO) values (7.'CENTRO'.0.1.1);
Insert into GRUPOS (GRUPO_ID,NOMBRE,VISIBLE,TIPO_GRUPO,HABILITADO) values (8.'SUR'.0.1.1);
Insert into GRUPOS (GRUPO_ID,NOMBRE,VISIBLE,TIPO_GRUPO,HABILITADO) values (9.'OCCIDENTE'.0.1.1);
Insert into GRUPOS (GRUPO_ID,NOMBRE,VISIBLE,TIPO_GRUPO,HABILITADO) values (10.'CORABASTOS'.0.1.1);
Insert into GRUPOS (GRUPO_ID,NOMBRE,VISIBLE,TIPO_GRUPO,HABILITADO) values (11.'COMEET'.0.2.1);
Insert into GRUPOS (GRUPO_ID,NOMBRE,VISIBLE,TIPO_GRUPO,HABILITADO) values (12.'SUBA'.0.1.1);
Insert into GRUPOS (GRUPO_ID,NOMBRE,VISIBLE,TIPO_GRUPO,HABILITADO) values (13.'LOTES'.0.3.1);
Insert into GRUPOS (GRUPO_ID,NOMBRE,VISIBLE,TIPO_GRUPO,HABILITADO) values (16.'POPPER'.0.3.0);

---------------------------------------------------
--   END DATA FOR TABLE GRUPOS
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE MASIVOS_PDA
--   FILTER = none used
---------------------------------------------------
REM INSERTING into MASIVOS_PDA
Insert into MASIVOS_PDA (MID,LOGIN,FECHA_CONFIRMACION,HORA_CONFIRMACION) values (325.'000007'.to_timestamp('06/12/08 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'18:58:42 PM');
Insert into MASIVOS_PDA (MID,LOGIN,FECHA_CONFIRMACION,HORA_CONFIRMACION) values (323.'000007'.to_timestamp('06/12/08 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'18:55:49 PM');
Insert into MASIVOS_PDA (MID,LOGIN,FECHA_CONFIRMACION,HORA_CONFIRMACION) values (322.'000007'.to_timestamp('06/12/08 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'18:55:56 PM');
Insert into MASIVOS_PDA (MID,LOGIN,FECHA_CONFIRMACION,HORA_CONFIRMACION) values (321.'000007'.to_timestamp('06/12/08 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'18:56:03 PM');
Insert into MASIVOS_PDA (MID,LOGIN,FECHA_CONFIRMACION,HORA_CONFIRMACION) values (320.'000007'.to_timestamp('06/12/08 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'18:56:10 PM');
Insert into MASIVOS_PDA (MID,LOGIN,FECHA_CONFIRMACION,HORA_CONFIRMACION) values (319.'000007'.to_timestamp('06/12/08 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'18:56:17 PM');
Insert into MASIVOS_PDA (MID,LOGIN,FECHA_CONFIRMACION,HORA_CONFIRMACION) values (323.'000007'.to_timestamp('06/12/08 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'18:56:28 PM');
Insert into MASIVOS_PDA (MID,LOGIN,FECHA_CONFIRMACION,HORA_CONFIRMACION) values (324.'000007'.to_timestamp('06/12/08 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'18:56:43 PM');

---------------------------------------------------
--   END DATA FOR TABLE MASIVOS_PDA
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE MENSAJES
--   FILTER = none used
---------------------------------------------------
REM INSERTING into MENSAJES
Insert into MENSAJES (MID,UID_DESTINO,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,TIEMPO_VIDA,UID_ORIGEN,CONTROL,MINUTOS,FECHA_CONFIRMACION,HORA_ENVIO,HORA_CONFIRMACION) values (321.3.to_timestamp('06/12/08 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'mensaje18'.'hola mundo18'.0.3.17.0.0.to_timestamp('01/01/50 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'17:51:12 PM'.'00:00:00 AM');
Insert into MENSAJES (MID,UID_DESTINO,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,TIEMPO_VIDA,UID_ORIGEN,CONTROL,MINUTOS,FECHA_CONFIRMACION,HORA_ENVIO,HORA_CONFIRMACION) values (322.3.to_timestamp('06/12/08 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'mensaje20'.'hola mundo20'.0.3.17.0.0.to_timestamp('01/01/50 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'18:43:36 PM'.'00:00:00 AM');
Insert into MENSAJES (MID,UID_DESTINO,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,TIEMPO_VIDA,UID_ORIGEN,CONTROL,MINUTOS,FECHA_CONFIRMACION,HORA_ENVIO,HORA_CONFIRMACION) values (323.3.to_timestamp('06/12/08 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'mensaje21'.'hola mundo21'.0.3.17.0.0.to_timestamp('01/01/50 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'18:51:52 PM'.'00:00:00 AM');
Insert into MENSAJES (MID,UID_DESTINO,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,TIEMPO_VIDA,UID_ORIGEN,CONTROL,MINUTOS,FECHA_CONFIRMACION,HORA_ENVIO,HORA_CONFIRMACION) values (324.3.to_timestamp('06/12/08 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'mensaje22'.'hola mundo22'.0.3.17.0.0.to_timestamp('01/01/50 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'18:55:25 PM'.'00:00:00 AM');
Insert into MENSAJES (MID,UID_DESTINO,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,TIEMPO_VIDA,UID_ORIGEN,CONTROL,MINUTOS,FECHA_CONFIRMACION,HORA_ENVIO,HORA_CONFIRMACION) values (325.3.to_timestamp('06/12/08 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'mensaje23'.'hola mundo23'.0.3.17.0.0.to_timestamp('01/01/50 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'18:57:26 PM'.'00:00:00 AM');
Insert into MENSAJES (MID,UID_DESTINO,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,TIEMPO_VIDA,UID_ORIGEN,CONTROL,MINUTOS,FECHA_CONFIRMACION,HORA_ENVIO,HORA_CONFIRMACION) values (326.3.to_timestamp('06/12/08 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'mensaje24'.'hola mundo&39;24&39;'.0.3.17.0.0.to_timestamp('01/01/50 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'18:59:57 PM'.'00:00:00 AM');
Insert into MENSAJES (MID,UID_DESTINO,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,TIEMPO_VIDA,UID_ORIGEN,CONTROL,MINUTOS,FECHA_CONFIRMACION,HORA_ENVIO,HORA_CONFIRMACION) values (319.3.to_timestamp('06/12/08 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'mensaje16'.'hola mundo16'.0.3.17.0.0.to_timestamp('01/01/50 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'17:17:05 PM'.'00:00:00 AM');
Insert into MENSAJES (MID,UID_DESTINO,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,TIEMPO_VIDA,UID_ORIGEN,CONTROL,MINUTOS,FECHA_CONFIRMACION,HORA_ENVIO,HORA_CONFIRMACION) values (320.3.to_timestamp('06/12/08 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'mensaje17'.'hola mundo17'.0.3.17.0.0.to_timestamp('01/01/50 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'17:44:27 PM'.'00:00:00 AM');

---------------------------------------------------
--   END DATA FOR TABLE MENSAJES
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE MENSAJES_PDA
--   FILTER = none used
---------------------------------------------------
REM INSERTING into MENSAJES_PDA
Insert into MENSAJES_PDA (MID,LOGIN_DESTINO,GID_ORIGEN,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,FECHA_CONFIRMACION,ENTREGADO,HORA_ENVIO,HORA_CONFIRMACION) values (53.'000007'.3.to_timestamp('06/12/08 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'mensaje7'.'hola mundo7'.0.to_timestamp('01/01/50 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').1.'16:57:53 PM'.'00:00:00 AM');
Insert into MENSAJES_PDA (MID,LOGIN_DESTINO,GID_ORIGEN,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,FECHA_CONFIRMACION,ENTREGADO,HORA_ENVIO,HORA_CONFIRMACION) values (54.'000007'.3.to_timestamp('06/12/08 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'mensaje8'.'hola mundo8'.0.to_timestamp('01/01/50 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').1.'17:01:11 PM'.'00:00:00 AM');
Insert into MENSAJES_PDA (MID,LOGIN_DESTINO,GID_ORIGEN,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,FECHA_CONFIRMACION,ENTREGADO,HORA_ENVIO,HORA_CONFIRMACION) values (55.'000007'.3.to_timestamp('06/12/08 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'mensaje9'.'hola mundo9'.0.to_timestamp('01/01/50 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').1.'17:02:32 PM'.'00:00:00 AM');
Insert into MENSAJES_PDA (MID,LOGIN_DESTINO,GID_ORIGEN,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,FECHA_CONFIRMACION,ENTREGADO,HORA_ENVIO,HORA_CONFIRMACION) values (56.'000007'.3.to_timestamp('06/12/08 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'mensaje10'.'hola mundo10'.0.to_timestamp('01/01/50 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').1.'17:06:21 PM'.'00:00:00 AM');
Insert into MENSAJES_PDA (MID,LOGIN_DESTINO,GID_ORIGEN,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,FECHA_CONFIRMACION,ENTREGADO,HORA_ENVIO,HORA_CONFIRMACION) values (57.'000007'.3.to_timestamp('06/12/08 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'mensaje11'.'hola mundo11'.0.to_timestamp('01/01/50 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').1.'17:08:33 PM'.'00:00:00 AM');
Insert into MENSAJES_PDA (MID,LOGIN_DESTINO,GID_ORIGEN,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,FECHA_CONFIRMACION,ENTREGADO,HORA_ENVIO,HORA_CONFIRMACION) values (58.'000007'.3.to_timestamp('06/12/08 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'mensaje12'.'hola mundo12'.0.to_timestamp('01/01/50 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').1.'17:09:48 PM'.'00:00:00 AM');
Insert into MENSAJES_PDA (MID,LOGIN_DESTINO,GID_ORIGEN,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,FECHA_CONFIRMACION,ENTREGADO,HORA_ENVIO,HORA_CONFIRMACION) values (59.'000007'.3.to_timestamp('06/12/08 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'mensaje13'.'hola mundo13'.0.to_timestamp('01/01/50 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').1.'17:12:13 PM'.'00:00:00 AM');
Insert into MENSAJES_PDA (MID,LOGIN_DESTINO,GID_ORIGEN,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,FECHA_CONFIRMACION,ENTREGADO,HORA_ENVIO,HORA_CONFIRMACION) values (60.'000007'.3.to_timestamp('06/12/08 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'mensaje14'.'hola mundo14'.0.to_timestamp('01/01/50 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').1.'17:13:53 PM'.'00:00:00 AM');
Insert into MENSAJES_PDA (MID,LOGIN_DESTINO,GID_ORIGEN,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,FECHA_CONFIRMACION,ENTREGADO,HORA_ENVIO,HORA_CONFIRMACION) values (61.'000007'.3.to_timestamp('06/12/08 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').'mensaje15'.'hola mundo15'.1.to_timestamp('06/12/08 12:00:00,000000000 AM','DD/MM/RR HH12:MI:SS,FF AM').1.'17:14:54 PM'.'17:15:41 PM');

---------------------------------------------------
--   END DATA FOR TABLE MENSAJES_PDA
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE ROLES
--   FILTER = none used
---------------------------------------------------
REM INSERTING into ROLES
Insert into ROLES (RID,NOMBRE) values (1.'ADMINISTRADOR DEL SISTEMA');
Insert into ROLES (RID,NOMBRE) values (2.'AUDITOR PROCESOS');
Insert into ROLES (RID,NOMBRE) values (3.'VENDEDOR POS');
Insert into ROLES (RID,NOMBRE) values (4.'LOTE');
Insert into ROLES (RID,NOMBRE) values (5.'FUNCIONARIO ADMINISTRATIVO');

---------------------------------------------------
--   END DATA FOR TABLE ROLES
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE TIPO_GRUPO
--   FILTER = none used
---------------------------------------------------
REM INSERTING into TIPO_GRUPO
Insert into TIPO_GRUPO (ID_TIPO,DESCRIPCION) values (1.'ZONA POS');
Insert into TIPO_GRUPO (ID_TIPO,DESCRIPCION) values (2.'GRUPO ADMIN');
Insert into TIPO_GRUPO (ID_TIPO,DESCRIPCION) values (3.'GRUPO LOTE');

---------------------------------------------------
--   END DATA FOR TABLE TIPO_GRUPO
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE TRANSACCIONES
--   FILTER = none used
---------------------------------------------------
REM INSERTING into TRANSACCIONES
Insert into TRANSACCIONES (CODIGO,DESCRIPCION,DRIVER,ARGS) values ('TR001'.'Adiciona usuarios'.'com.kazak.comeet.server.businessrules.UserManager'.'<root>
 <action>add</action>
 <arg>INS0001</arg>
 <arg>INS0002</arg>
</root>');
Insert into TRANSACCIONES (CODIGO,DESCRIPCION,DRIVER,ARGS) values ('TR002'.'Edita Usuarios'.'com.kazak.comeet.server.businessrules.UserManager'.'<root>
 <action>edit</action>
 <arg>UPD0004</arg>
 <arg>DEL0001</arg>
 <arg>INS0002</arg>
</root>');
Insert into TRANSACCIONES (CODIGO,DESCRIPCION,DRIVER,ARGS) values ('TR003'.'Borra Usuarios'.'com.kazak.comeet.server.businessrules.UserManager'.'<root>
 <action>remove</action>
 <arg>DEL0002</arg>
</root>');
Insert into TRANSACCIONES (CODIGO,DESCRIPCION,DRIVER,ARGS) values ('TR004'.'Adiciona Grupos'.'com.kazak.comeet.server.businessrules.GroupManager'.'<root>
 <action>add</action>
 <arg>INS0006</arg>
</root>');
Insert into TRANSACCIONES (CODIGO,DESCRIPCION,DRIVER,ARGS) values ('TR005'.'Edita Grupos'.'com.kazak.comeet.server.businessrules.GroupManager'.'<root>
 <action>edit</action>
 <arg>UPD0001</arg>
</root>');
Insert into TRANSACCIONES (CODIGO,DESCRIPCION,DRIVER,ARGS) values ('TR006'.'Borra Grupos'.'com.kazak.comeet.server.businessrules.GroupManager'.'<root>
 <action>remove</action>
 <arg>SEL0013</arg>
 <arg>SEL0014</arg>
 <arg>DEL0003</arg>
</root>');
Insert into TRANSACCIONES (CODIGO,DESCRIPCION,DRIVER,ARGS) values ('TR007'.'Adiciona Ubicacion'.'com.kazak.comeet.server.businessrules.PointOfSaleManager'.'<root>
  <action>add</action>
  <arg>INS0007</arg>
</root>');
Insert into TRANSACCIONES (CODIGO,DESCRIPCION,DRIVER,ARGS) values ('TR008'.'Editar Ubicacion'.'com.kazak.comeet.server.businessrules.PointOfSaleManager'.'<root>
 <action>edit</action>
 <arg>UPD0005</arg>
</root>');
Insert into TRANSACCIONES (CODIGO,DESCRIPCION,DRIVER,ARGS) values ('TR009'.'Borrar Ubicacion'.'com.kazak.comeet.server.businessrules.PointOfSaleManager'.'<root>
 <action>remove</action>
 <arg>DEL0004</arg>
</root>');
Insert into TRANSACCIONES (CODIGO,DESCRIPCION,DRIVER,ARGS) values ('TR010'.'Editar Contraseña'.'com.kazak.comeet.server.businessrules.PasswordExchanger'.'<root>
 <args>UPD0002</args>
</root>');
Insert into TRANSACCIONES (CODIGO,DESCRIPCION,DRIVER,ARGS) values ('TR011'.'Confirma Mensaje'.'com.kazak.comeet.server.businessrules.MessageConfirmer'.'<root>
 <args>UPD0003</args>
</root>');
Insert into TRANSACCIONES (CODIGO,DESCRIPCION,DRIVER,ARGS) values ('TR012'.'Sync Oracle/Postgres'.'com.kazak.comeet.server.businessrules.SyncManager'.'<root/>');
Insert into TRANSACCIONES (CODIGO,DESCRIPCION,DRIVER,ARGS) values ('TR013'.'Confirma Mensaje PDA'.'com.kazak.comeet.server.businessrules.MassiveConfirmer'.'<root>
 <args>UPD0003A</args>
</root>');

---------------------------------------------------
--   END DATA FOR TABLE TRANSACCIONES
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE UBICACIONES
--   FILTER = none used
---------------------------------------------------
REM INSERTING into UBICACIONES
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID,HABILITADO) values (22.'PUESTO COMEET'.'192.168.0.4'.11.1);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID,HABILITADO) values (14.'QUIROGA'.'192.168.0.1'.8.1);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID,HABILITADO) values (1.'OFICINA GERENCIA'.'192.168.0.2'.3.1);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID,HABILITADO) values (2.'OFICINA AUDITORIA'.'192.168.0.3'.4.1);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID,HABILITADO) values (3.'OFICINA SOPORTE TECNICO'.'192.168.0.4'.5.1);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID,HABILITADO) values (4.'PORTAL NORTE'.'192.168.0.5'.6.1);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID,HABILITADO) values (5.'ALCALA'.'192.168.0.6'.6.1);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID,HABILITADO) values (6.'CHAPINERO CENTRO'.'192.168.0.7'.7.1);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID,HABILITADO) values (7.'LA CANDELARIA'.'192.168.0.8'.7.1);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID,HABILITADO) values (8.'USME'.'192.168.0.201'.8.1);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID,HABILITADO) values (9.'QUIROGA'.'192.168.0.10'.8.0);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID,HABILITADO) values (10.'MODELIA'.'192.168.0.11'.9.1);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID,HABILITADO) values (11.'SALITRE'.'192.168.0.12'.9.1);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID,HABILITADO) values (12.'DATA CENTER'.'192.168.0.13'.3.1);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID,HABILITADO) values (13.'RECEPCION AUDITORIA'.'192.168.0.14'.4.1);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID,HABILITADO) values (15.'CUARTO LOTES DATA CENTER'.'192.168.0.15'.13.1);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID,HABILITADO) values (16.'POPPER'.'192.168.0.100'.2.1);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID,HABILITADO) values (17.'NONO'.'192.168.0.100'.8.0);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID,HABILITADO) values (18.'NONO'.'192.168.0.202'.2.0);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID,HABILITADO) values (19.'RESTREPO'.'192.168.1.250'.8.1);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID,HABILITADO) values (20.'BITTER'.'127.0.0.1'.8.1);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID,HABILITADO) values (21.'BITTER2'.'192.168.1.131'.8.1);

---------------------------------------------------
--   END DATA FOR TABLE UBICACIONES
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE USUARIOS
--   FILTER = none used
---------------------------------------------------
REM INSERTING into USUARIOS
Insert into USUARIOS (CODIGO,LOGIN,CLAVE,NOMBRES,CORREO,HABILITADO,GID,ROL) values (19.'comeet'.'827ccb0eea8a706c4c34a16891f84e7b'.'Usuario CoMeet'.'xtingray@localhost'.1.11.5);
Insert into USUARIOS (CODIGO,LOGIN,CLAVE,NOMBRES,CORREO,HABILITADO,GID,ROL) values (11.'prueba02'.'827ccb0eea8a706c4c34a16891f84e7b'.'Prueba 02'.'xtingray@localhost'.1.3.5);
Insert into USUARIOS (CODIGO,LOGIN,CLAVE,NOMBRES,CORREO,HABILITADO,GID,ROL) values (9.'mensajero'.'827ccb0eea8a706c4c34a16891f84e7b'.'Mensajero Gerencia'.'xtingray@localhost'.1.3.5);
Insert into USUARIOS (CODIGO,LOGIN,CLAVE,NOMBRES,CORREO,HABILITADO,GID,ROL) values (10.'prueba01'.'827ccb0eea8a706c4c34a16891f84e7b'.'Usuario Prueba 01'.'xtingray@localhost'.1.3.1);
Insert into USUARIOS (CODIGO,LOGIN,CLAVE,NOMBRES,CORREO,HABILITADO,GID,ROL) values (12.'prueba03'.'827ccb0eea8a706c4c34a16891f84e7b'.'Prueba 03'.'xtingray@localhost'.1.3.1);
Insert into USUARIOS (CODIGO,LOGIN,CLAVE,NOMBRES,CORREO,HABILITADO,GID,ROL) values (13.'secretaria'.'827ccb0eea8a706c4c34a16891f84e7b'.'Secretaria Gerencia'.'xtingray@localhost'.1.3.5);
Insert into USUARIOS (CODIGO,LOGIN,CLAVE,NOMBRES,CORREO,HABILITADO,GID,ROL) values (14.'auditor2'.'827ccb0eea8a706c4c34a16891f84e7b'.'Auditor 2'.'xtingray@localhost'.1.4.1);
Insert into USUARIOS (CODIGO,LOGIN,CLAVE,NOMBRES,CORREO,HABILITADO,GID,ROL) values (15.'auditor3'.'827ccb0eea8a706c4c34a16891f84e7b'.'Auditor 3'.'xtingray@localhost'.1.4.2);
Insert into USUARIOS (CODIGO,LOGIN,CLAVE,NOMBRES,CORREO,HABILITADO,GID,ROL) values (16.'auditor4'.'827ccb0eea8a706c4c34a16891f84e7b'.'Auditor 4'.'xtingray@localhost'.1.4.2);
Insert into USUARIOS (CODIGO,LOGIN,CLAVE,NOMBRES,CORREO,HABILITADO,GID,ROL) values (1.'admin'.'21232f297a57a5a743894a0e4a801fc3'.'Usuario Administrador'.'xtingray@localhost'.1.3.1);
Insert into USUARIOS (CODIGO,LOGIN,CLAVE,NOMBRES,CORREO,HABILITADO,GID,ROL) values (2.'auditor'.'827ccb0eea8a706c4c34a16891f84e7b'.'Usuario Auditor'.'xtingray@localhost'.1.4.2);
Insert into USUARIOS (CODIGO,LOGIN,CLAVE,NOMBRES,CORREO,HABILITADO,GID,ROL) values (3.'suba'.'827ccb0eea8a706c4c34a16891f84e7b'.'Lote Suba'.'xtingray@localhost'.1.13.4);
Insert into USUARIOS (CODIGO,LOGIN,CLAVE,NOMBRES,CORREO,HABILITADO,GID,ROL) values (4.'pos01'.'827ccb0eea8a706c4c34a16891f84e7b'.'Vendedor Pos 01'.null.1.1.3);
Insert into USUARIOS (CODIGO,LOGIN,CLAVE,NOMBRES,CORREO,HABILITADO,GID,ROL) values (5.'pos02'.'827ccb0eea8a706c4c34a16891f84e7b'.'Vendedor Pos 02'.null.1.8.3);
Insert into USUARIOS (CODIGO,LOGIN,CLAVE,NOMBRES,CORREO,HABILITADO,GID,ROL) values (17.'raul'.'827ccb0eea8a706c4c34a16891f84e7b'.'Raul Gutierrez'.'raul@katana.com'.1.3.1);
Insert into USUARIOS (CODIGO,LOGIN,CLAVE,NOMBRES,CORREO,HABILITADO,GID,ROL) values (18.'batman'.'827ccb0eea8a706c4c34a16891f84e7b'.'Dark Knight'.'xtingray@localhost'.1.3.1);

---------------------------------------------------
--   END DATA FOR TABLE USUARIOS
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE USUARIOS_UBICACION
--   FILTER = none used
---------------------------------------------------
REM INSERTING into USUARIOS_UBICACION
Insert into USUARIOS_UBICACION (ID_USUARIO,CODIGO_UBICACION,VALIDAR_IP) values (15.2.0);
Insert into USUARIOS_UBICACION (ID_USUARIO,CODIGO_UBICACION,VALIDAR_IP) values (11.1.1);
Insert into USUARIOS_UBICACION (ID_USUARIO,CODIGO_UBICACION,VALIDAR_IP) values (9.1.1);
Insert into USUARIOS_UBICACION (ID_USUARIO,CODIGO_UBICACION,VALIDAR_IP) values (12.12.0);
Insert into USUARIOS_UBICACION (ID_USUARIO,CODIGO_UBICACION,VALIDAR_IP) values (13.1.1);
Insert into USUARIOS_UBICACION (ID_USUARIO,CODIGO_UBICACION,VALIDAR_IP) values (2.2.0);
Insert into USUARIOS_UBICACION (ID_USUARIO,CODIGO_UBICACION,VALIDAR_IP) values (16.2.0);
Insert into USUARIOS_UBICACION (ID_USUARIO,CODIGO_UBICACION,VALIDAR_IP) values (1.1.0);
Insert into USUARIOS_UBICACION (ID_USUARIO,CODIGO_UBICACION,VALIDAR_IP) values (14.2.0);
Insert into USUARIOS_UBICACION (ID_USUARIO,CODIGO_UBICACION,VALIDAR_IP) values (3.15.0);
Insert into USUARIOS_UBICACION (ID_USUARIO,CODIGO_UBICACION,VALIDAR_IP) values (5.8.0);
Insert into USUARIOS_UBICACION (ID_USUARIO,CODIGO_UBICACION,VALIDAR_IP) values (17.1.0);
Insert into USUARIOS_UBICACION (ID_USUARIO,CODIGO_UBICACION,VALIDAR_IP) values (4.4.0);
Insert into USUARIOS_UBICACION (ID_USUARIO,CODIGO_UBICACION,VALIDAR_IP) values (10.12.0);
Insert into USUARIOS_UBICACION (ID_USUARIO,CODIGO_UBICACION,VALIDAR_IP) values (18.12.0);
Insert into USUARIOS_UBICACION (ID_USUARIO,CODIGO_UBICACION,VALIDAR_IP) values (4.5.0);
Insert into USUARIOS_UBICACION (ID_USUARIO,CODIGO_UBICACION,VALIDAR_IP) values (4.10.0);

---------------------------------------------------
--   END DATA FOR TABLE USUARIOS_UBICACION
---------------------------------------------------
--------------------------------------------------------
--  Constraints for Table MASIVOS_PDA
--------------------------------------------------------

  ALTER TABLE "MASIVOS_PDA" MODIFY ("MID" NOT NULL ENABLE);
 
  ALTER TABLE "MASIVOS_PDA" MODIFY ("LOGIN" NOT NULL ENABLE);
 
  ALTER TABLE "MASIVOS_PDA" MODIFY ("FECHA_CONFIRMACION" NOT NULL ENABLE);
 
  ALTER TABLE "MASIVOS_PDA" MODIFY ("HORA_CONFIRMACION" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table GRUPOS
--------------------------------------------------------

  ALTER TABLE "GRUPOS" ADD CONSTRAINT "GRUPOS_PK" PRIMARY KEY ("GRUPO_ID") ENABLE;
 
  ALTER TABLE "GRUPOS" MODIFY ("GRUPO_ID" NOT NULL ENABLE);
 
  ALTER TABLE "GRUPOS" MODIFY ("NOMBRE" NOT NULL ENABLE);
 
  ALTER TABLE "GRUPOS" MODIFY ("VISIBLE" NOT NULL ENABLE);
 
  ALTER TABLE "GRUPOS" MODIFY ("TIPO_GRUPO" NOT NULL ENABLE);
 
  ALTER TABLE "GRUPOS" MODIFY ("HABILITADO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table USUARIOS_UBICACION
--------------------------------------------------------

  ALTER TABLE "USUARIOS_UBICACION" MODIFY ("ID_USUARIO" NOT NULL ENABLE);
 
  ALTER TABLE "USUARIOS_UBICACION" MODIFY ("CODIGO_UBICACION" NOT NULL ENABLE);
 
  ALTER TABLE "USUARIOS_UBICACION" MODIFY ("VALIDAR_IP" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table TRANSACCIONES
--------------------------------------------------------

  ALTER TABLE "TRANSACCIONES" MODIFY ("CODIGO" NOT NULL ENABLE);
 
  ALTER TABLE "TRANSACCIONES" MODIFY ("DESCRIPCION" NOT NULL ENABLE);
 
  ALTER TABLE "TRANSACCIONES" MODIFY ("DRIVER" NOT NULL ENABLE);
 
  ALTER TABLE "TRANSACCIONES" MODIFY ("ARGS" NOT NULL ENABLE);
 
  ALTER TABLE "TRANSACCIONES" ADD CONSTRAINT "TRANSACCIONES_PK" PRIMARY KEY ("CODIGO") ENABLE;
--------------------------------------------------------
--  Constraints for Table ROLES
--------------------------------------------------------

  ALTER TABLE "ROLES" ADD CONSTRAINT "ROLES_PK" PRIMARY KEY ("RID") ENABLE;
 
  ALTER TABLE "ROLES" MODIFY ("RID" NOT NULL ENABLE);
 
  ALTER TABLE "ROLES" MODIFY ("NOMBRE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table MENSAJES
--------------------------------------------------------

  ALTER TABLE "MENSAJES" ADD CONSTRAINT "MENSAJES_PK" PRIMARY KEY ("MID") ENABLE;
 
  ALTER TABLE "MENSAJES" MODIFY ("MID" NOT NULL ENABLE);
 
  ALTER TABLE "MENSAJES" MODIFY ("UID_DESTINO" NOT NULL ENABLE);
 
  ALTER TABLE "MENSAJES" MODIFY ("FECHA_ENVIO" NOT NULL ENABLE);
 
  ALTER TABLE "MENSAJES" MODIFY ("ASUNTO" NOT NULL ENABLE);
 
  ALTER TABLE "MENSAJES" MODIFY ("TEXTO" NOT NULL ENABLE);
 
  ALTER TABLE "MENSAJES" MODIFY ("CONFIRMADO" NOT NULL ENABLE);
 
  ALTER TABLE "MENSAJES" MODIFY ("TIEMPO_VIDA" NOT NULL ENABLE);
 
  ALTER TABLE "MENSAJES" MODIFY ("UID_ORIGEN" NOT NULL ENABLE);
 
  ALTER TABLE "MENSAJES" MODIFY ("CONTROL" NOT NULL ENABLE);
 
  ALTER TABLE "MENSAJES" MODIFY ("MINUTOS" NOT NULL ENABLE);
 
  ALTER TABLE "MENSAJES" MODIFY ("FECHA_CONFIRMACION" NOT NULL ENABLE);
 
  ALTER TABLE "MENSAJES" MODIFY ("HORA_ENVIO" NOT NULL ENABLE);
 
  ALTER TABLE "MENSAJES" MODIFY ("HORA_CONFIRMACION" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table USUARIOS
--------------------------------------------------------

  ALTER TABLE "USUARIOS" MODIFY ("CODIGO" NOT NULL ENABLE);
 
  ALTER TABLE "USUARIOS" MODIFY ("LOGIN" NOT NULL ENABLE);
 
  ALTER TABLE "USUARIOS" MODIFY ("CLAVE" NOT NULL ENABLE);
 
  ALTER TABLE "USUARIOS" MODIFY ("NOMBRES" NOT NULL ENABLE);
 
  ALTER TABLE "USUARIOS" MODIFY ("HABILITADO" NOT NULL ENABLE);
 
  ALTER TABLE "USUARIOS" MODIFY ("GID" NOT NULL ENABLE);
 
  ALTER TABLE "USUARIOS" MODIFY ("ROL" NOT NULL ENABLE);
 
  ALTER TABLE "USUARIOS" ADD CONSTRAINT "USUARIOS_PK" PRIMARY KEY ("CODIGO") ENABLE;
--------------------------------------------------------
--  Constraints for Table TIPO_GRUPO
--------------------------------------------------------

  ALTER TABLE "TIPO_GRUPO" MODIFY ("ID_TIPO" NOT NULL ENABLE);
 
  ALTER TABLE "TIPO_GRUPO" MODIFY ("DESCRIPCION" NOT NULL ENABLE);
 
  ALTER TABLE "TIPO_GRUPO" ADD CONSTRAINT "TIPO_GRUPO_PK" PRIMARY KEY ("ID_TIPO") ENABLE;
--------------------------------------------------------
--  Constraints for Table UBICACIONES
--------------------------------------------------------

  ALTER TABLE "UBICACIONES" MODIFY ("CODIGO" NOT NULL ENABLE);
 
  ALTER TABLE "UBICACIONES" MODIFY ("NOMBRE" NOT NULL ENABLE);
 
  ALTER TABLE "UBICACIONES" MODIFY ("IP" NOT NULL ENABLE);
 
  ALTER TABLE "UBICACIONES" MODIFY ("GID" NOT NULL ENABLE);
 
  ALTER TABLE "UBICACIONES" MODIFY ("HABILITADO" NOT NULL ENABLE);
 
  ALTER TABLE "UBICACIONES" ADD CONSTRAINT "UBICACIONES_PK" PRIMARY KEY ("CODIGO") ENABLE;
--------------------------------------------------------
--  Constraints for Table MENSAJES_PDA
--------------------------------------------------------

  ALTER TABLE "MENSAJES_PDA" ADD CONSTRAINT "MENSAJES_PDA_PK" PRIMARY KEY ("MID") ENABLE;
 
  ALTER TABLE "MENSAJES_PDA" MODIFY ("MID" NOT NULL ENABLE);
 
  ALTER TABLE "MENSAJES_PDA" MODIFY ("LOGIN_DESTINO" NOT NULL ENABLE);
 
  ALTER TABLE "MENSAJES_PDA" MODIFY ("GID_ORIGEN" NOT NULL ENABLE);
 
  ALTER TABLE "MENSAJES_PDA" MODIFY ("FECHA_ENVIO" NOT NULL ENABLE);
 
  ALTER TABLE "MENSAJES_PDA" MODIFY ("ASUNTO" NOT NULL ENABLE);
 
  ALTER TABLE "MENSAJES_PDA" MODIFY ("TEXTO" NOT NULL ENABLE);
 
  ALTER TABLE "MENSAJES_PDA" MODIFY ("CONFIRMADO" NOT NULL ENABLE);
 
  ALTER TABLE "MENSAJES_PDA" MODIFY ("FECHA_CONFIRMACION" NOT NULL ENABLE);
 
  ALTER TABLE "MENSAJES_PDA" MODIFY ("ENTREGADO" NOT NULL ENABLE);
 
  ALTER TABLE "MENSAJES_PDA" MODIFY ("HORA_ENVIO" NOT NULL ENABLE);
 
  ALTER TABLE "MENSAJES_PDA" MODIFY ("HORA_CONFIRMACION" NOT NULL ENABLE);
--------------------------------------------------------
--  DDL for Index ROLES_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ROLES_PK" ON "ROLES" ("RID") 
  ;
--------------------------------------------------------
--  DDL for Index MENSAJES_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENSAJES_PK" ON "MENSAJES" ("MID") 
  ;
--------------------------------------------------------
--  DDL for Index USUARIOS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "USUARIOS_PK" ON "USUARIOS" ("CODIGO") 
  ;
--------------------------------------------------------
--  DDL for Index UBICACIONES_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "UBICACIONES_PK" ON "UBICACIONES" ("CODIGO") 
  ;
--------------------------------------------------------
--  DDL for Index MENSAJES_PDA_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENSAJES_PDA_PK" ON "MENSAJES_PDA" ("MID") 
  ;
--------------------------------------------------------
--  DDL for Index TIPO_GRUPO_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "TIPO_GRUPO_PK" ON "TIPO_GRUPO" ("ID_TIPO") 
  ;
--------------------------------------------------------
--  DDL for Index TRANSACCIONES_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "TRANSACCIONES_PK" ON "TRANSACCIONES" ("CODIGO") 
  ;
--------------------------------------------------------
--  DDL for Index GRUPOS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "GRUPOS_PK" ON "GRUPOS" ("GRUPO_ID") 
  ;
--------------------------------------------------------
--  Ref Constraints for Table GRUPOS
--------------------------------------------------------

  ALTER TABLE "GRUPOS" ADD CONSTRAINT "GRUPOS_TIPO_GRUPO_FK1" FOREIGN KEY ("TIPO_GRUPO")
	  REFERENCES "TIPO_GRUPO" ("ID_TIPO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table MASIVOS_PDA
--------------------------------------------------------

  ALTER TABLE "MASIVOS_PDA" ADD CONSTRAINT "MASIVOS_PDA_MENSAJES_FK1" FOREIGN KEY ("MID")
	  REFERENCES "MENSAJES" ("MID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table MENSAJES
--------------------------------------------------------

  ALTER TABLE "MENSAJES" ADD CONSTRAINT "MENSAJES_USUARIOS_FK1" FOREIGN KEY ("UID_DESTINO")
	  REFERENCES "USUARIOS" ("CODIGO") ENABLE;
 
  ALTER TABLE "MENSAJES" ADD CONSTRAINT "MENSAJES_USUARIOS_FK2" FOREIGN KEY ("UID_ORIGEN")
	  REFERENCES "USUARIOS" ("CODIGO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table MENSAJES_PDA
--------------------------------------------------------

  ALTER TABLE "MENSAJES_PDA" ADD CONSTRAINT "MENSAJES_PDA_GRUPOS_FK1" FOREIGN KEY ("GID_ORIGEN")
	  REFERENCES "GRUPOS" ("GRUPO_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table UBICACIONES
--------------------------------------------------------

  ALTER TABLE "UBICACIONES" ADD CONSTRAINT "UBICACIONES_GRUPOS_FK1" FOREIGN KEY ("GID")
	  REFERENCES "GRUPOS" ("GRUPO_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table USUARIOS
--------------------------------------------------------

  ALTER TABLE "USUARIOS" ADD CONSTRAINT "USUARIOS_GRUPOS_FK1" FOREIGN KEY ("GID")
	  REFERENCES "GRUPOS" ("GRUPO_ID") ENABLE;
 
  ALTER TABLE "USUARIOS" ADD CONSTRAINT "USUARIOS_ROLES_FK1" FOREIGN KEY ("ROL")
	  REFERENCES "ROLES" ("RID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table USUARIOS_UBICACION
--------------------------------------------------------

  ALTER TABLE "USUARIOS_UBICACION" ADD CONSTRAINT "USUARIOS_UBICACION_UBICAC_FK1" FOREIGN KEY ("CODIGO_UBICACION")
	  REFERENCES "UBICACIONES" ("CODIGO") ENABLE;
 
  ALTER TABLE "USUARIOS_UBICACION" ADD CONSTRAINT "USUARIOS_UBICACION_USUARI_FK1" FOREIGN KEY ("ID_USUARIO")
	  REFERENCES "USUARIOS" ("CODIGO") ENABLE;
--------------------------------------------------------
--  DDL for Trigger GRUPOS_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "GRUPOS_TRG" 
BEFORE INSERT ON GRUPOS
FOR EACH ROW 
BEGIN
  SELECT GRUPOS_GID_SEQ.NEXTVAL INTO :NEW.GRUPO_ID FROM DUAL;
END;
/
ALTER TRIGGER "GRUPOS_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger MENSAJES_PDA_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "MENSAJES_PDA_TRG" 
BEFORE INSERT ON MENSAJES_PDA
FOR EACH ROW 
BEGIN
  SELECT MENSAJES_PDA_MID_SEQ.NEXTVAL INTO :NEW.MID FROM DUAL;
END;
/
ALTER TRIGGER "MENSAJES_PDA_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger MENSAJES_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "MENSAJES_TRG" 
BEFORE INSERT ON MENSAJES
FOR EACH ROW 
BEGIN
  SELECT MENSAJES_MID_SEQ.NEXTVAL INTO :NEW.MID FROM DUAL;
END;
/
ALTER TRIGGER "MENSAJES_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger ROLES_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ROLES_TRG" 
BEFORE INSERT ON ROLES
FOR EACH ROW 
BEGIN
  SELECT ROLES_RID_SEQ.NEXTVAL INTO :NEW.RID FROM DUAL;
END;
/
ALTER TRIGGER "ROLES_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TIPO_GRUPO_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "TIPO_GRUPO_TRG" 
BEFORE INSERT ON TIPO_GRUPO
FOR EACH ROW 
BEGIN
  SELECT TIPO_GRUPO_ID_TIPO_SEQ.NEXTVAL INTO :NEW.ID_TIPO FROM DUAL;
END;
/
ALTER TRIGGER "TIPO_GRUPO_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger UBICACIONES_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "UBICACIONES_TRG" 
BEFORE INSERT ON UBICACIONES
FOR EACH ROW 
BEGIN
  SELECT UBICACIONES_SEQ.NEXTVAL INTO :NEW.CODIGO FROM DUAL;
END;
/
ALTER TRIGGER "UBICACIONES_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger USUARIOS_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "USUARIOS_TRG" 
BEFORE INSERT ON USUARIOS
FOR EACH ROW 
BEGIN
  SELECT USUARIOS_UID_SEQ.NEXTVAL INTO :NEW."CODIGO" FROM DUAL;
END;
/
ALTER TRIGGER "USUARIOS_TRG" ENABLE;
