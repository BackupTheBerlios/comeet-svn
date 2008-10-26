--------------------------------------------------------
--  File created - Sunday-October-26-2008   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence GRUPOS_GID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "GRUPOS_GID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 14 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence MENSAJES_MID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "MENSAJES_MID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 67 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence MENSAJES_PDA_MID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "MENSAJES_PDA_MID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 5 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence ROLES_RID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "ROLES_RID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 5 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence TIPO_GRUPO_ID_TIPO_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "TIPO_GRUPO_ID_TIPO_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 4 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence UBICACIONES_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "UBICACIONES_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 13 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence USUARIOS_UID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "USUARIOS_UID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 8 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Table GRUPOS
--------------------------------------------------------

  CREATE TABLE "GRUPOS" 
   (	"GRUPO_ID" NUMBER(*,0), 
	"NOMBRE" VARCHAR2(40 CHAR), 
	"VISIBLE" NUMBER(*,0) DEFAULT 0, 
	"TIPO_GRUPO" NUMBER(*,0) DEFAULT 0
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
	"FECHA_CONFIRMACION" DATE DEFAULT '01-JAN-50', 
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
	"FECHA_CONFIRMACION" DATE DEFAULT '01-JAN-50', 
	"ENTREGADO" NUMBER(*,0) DEFAULT 0, 
	"HORA_ENVIO" VARCHAR2(8 CHAR) DEFAULT '00:00 AM', 
	"HORA_CONFIRMACION" VARCHAR2(8 CHAR) DEFAULT '00:00 AM'
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
	"GID" NUMBER(*,0)
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
Insert into GRUPOS (GRUPO_ID,NOMBRE,VISIBLE,TIPO_GRUPO) values (1,'SIN GRUPO',0,1);
Insert into GRUPOS (GRUPO_ID,NOMBRE,VISIBLE,TIPO_GRUPO) values (2,'ADMINISTRATIVOS',0,2);
Insert into GRUPOS (GRUPO_ID,NOMBRE,VISIBLE,TIPO_GRUPO) values (3,'GERENCIA',1,2);
Insert into GRUPOS (GRUPO_ID,NOMBRE,VISIBLE,TIPO_GRUPO) values (4,'AUDITORIA',1,2);
Insert into GRUPOS (GRUPO_ID,NOMBRE,VISIBLE,TIPO_GRUPO) values (5,'SOPORTE TECNICO',1,2);
Insert into GRUPOS (GRUPO_ID,NOMBRE,VISIBLE,TIPO_GRUPO) values (6,'NORTE',0,1);
Insert into GRUPOS (GRUPO_ID,NOMBRE,VISIBLE,TIPO_GRUPO) values (7,'CENTRO',0,1);
Insert into GRUPOS (GRUPO_ID,NOMBRE,VISIBLE,TIPO_GRUPO) values (8,'SUR',0,1);
Insert into GRUPOS (GRUPO_ID,NOMBRE,VISIBLE,TIPO_GRUPO) values (9,'OCCIDENTE',0,1);
Insert into GRUPOS (GRUPO_ID,NOMBRE,VISIBLE,TIPO_GRUPO) values (10,'CORABASTOS',0,1);
Insert into GRUPOS (GRUPO_ID,NOMBRE,VISIBLE,TIPO_GRUPO) values (11,'COMEET',0,2);
Insert into GRUPOS (GRUPO_ID,NOMBRE,VISIBLE,TIPO_GRUPO) values (12,'SUBA',0,3);

---------------------------------------------------
--   END DATA FOR TABLE GRUPOS
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE MENSAJES
--   FILTER = none used
---------------------------------------------------
REM INSERTING into MENSAJES
Insert into MENSAJES (MID,UID_DESTINO,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,TIEMPO_VIDA,UID_ORIGEN,CONTROL,MINUTOS,FECHA_CONFIRMACION,HORA_ENVIO,HORA_CONFIRMACION) values (50,4,to_timestamp('25-OCT-08 12.00.00.000000000 AM','DD-MON-RR HH.MI.SS.FF AM'),'never mind','ni lo pienses',1,3,1,0,0,to_timestamp('25-OCT-08 12.00.00.000000000 AM','DD-MON-RR HH.MI.SS.FF AM'),'20:41:06 PM','22:29:53 PM');
Insert into MENSAJES (MID,UID_DESTINO,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,TIEMPO_VIDA,UID_ORIGEN,CONTROL,MINUTOS,FECHA_CONFIRMACION,HORA_ENVIO,HORA_CONFIRMACION) values (51,4,to_timestamp('25-OCT-08 12.00.00.000000000 AM','DD-MON-RR HH.MI.SS.FF AM'),'como crees?','ja ja ja!',1,3,1,0,0,to_timestamp('25-OCT-08 12.00.00.000000000 AM','DD-MON-RR HH.MI.SS.FF AM'),'11:41:26 AM','21:54:06 PM');
Insert into MENSAJES (MID,UID_DESTINO,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,TIEMPO_VIDA,UID_ORIGEN,CONTROL,MINUTOS,FECHA_CONFIRMACION,HORA_ENVIO,HORA_CONFIRMACION) values (52,4,to_timestamp('25-OCT-08 12.00.00.000000000 AM','DD-MON-RR HH.MI.SS.FF AM'),'completamente','por chetes',1,3,1,0,0,to_timestamp('25-OCT-08 12.00.00.000000000 AM','DD-MON-RR HH.MI.SS.FF AM'),'22:31:43 PM','22:31:50 PM');
Insert into MENSAJES (MID,UID_DESTINO,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,TIEMPO_VIDA,UID_ORIGEN,CONTROL,MINUTOS,FECHA_CONFIRMACION,HORA_ENVIO,HORA_CONFIRMACION) values (53,4,to_timestamp('25-OCT-08 12.00.00.000000000 AM','DD-MON-RR HH.MI.SS.FF AM'),'mensaje 1','hola mundo!',1,3,1,0,0,to_timestamp('26-OCT-08 12.00.00.000000000 AM','DD-MON-RR HH.MI.SS.FF AM'),'22:38:55 PM','00:44:35 AM');
Insert into MENSAJES (MID,UID_DESTINO,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,TIEMPO_VIDA,UID_ORIGEN,CONTROL,MINUTOS,FECHA_CONFIRMACION,HORA_ENVIO,HORA_CONFIRMACION) values (54,4,to_timestamp('25-OCT-08 12.00.00.000000000 AM','DD-MON-RR HH.MI.SS.FF AM'),'mensaje 2','prueba de concepto 2',1,3,1,0,0,to_timestamp('26-OCT-08 12.00.00.000000000 AM','DD-MON-RR HH.MI.SS.FF AM'),'22:39:25 PM','00:44:37 AM');
Insert into MENSAJES (MID,UID_DESTINO,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,TIEMPO_VIDA,UID_ORIGEN,CONTROL,MINUTOS,FECHA_CONFIRMACION,HORA_ENVIO,HORA_CONFIRMACION) values (55,4,to_timestamp('26-OCT-08 12.00.00.000000000 AM','DD-MON-RR HH.MI.SS.FF AM'),'mensaje 3','prueba 3',1,3,1,0,0,to_timestamp('26-OCT-08 12.00.00.000000000 AM','DD-MON-RR HH.MI.SS.FF AM'),'00:40:19 AM','00:44:39 AM');
Insert into MENSAJES (MID,UID_DESTINO,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,TIEMPO_VIDA,UID_ORIGEN,CONTROL,MINUTOS,FECHA_CONFIRMACION,HORA_ENVIO,HORA_CONFIRMACION) values (48,4,to_timestamp('25-OCT-08 12.00.00.000000000 AM','DD-MON-RR HH.MI.SS.FF AM'),'hola mundo','hello world',1,3,1,0,0,to_timestamp('25-OCT-08 12.00.00.000000000 AM','DD-MON-RR HH.MI.SS.FF AM'),'20:25:08 PM','22:28:55 PM');
Insert into MENSAJES (MID,UID_DESTINO,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,TIEMPO_VIDA,UID_ORIGEN,CONTROL,MINUTOS,FECHA_CONFIRMACION,HORA_ENVIO,HORA_CONFIRMACION) values (49,4,to_timestamp('25-OCT-08 12.00.00.000000000 AM','DD-MON-RR HH.MI.SS.FF AM'),'prueba de concepto','vamos a ver',1,3,1,0,0,to_timestamp('25-OCT-08 12.00.00.000000000 AM','DD-MON-RR HH.MI.SS.FF AM'),'20:40:46 PM','22:29:52 PM');
Insert into MENSAJES (MID,UID_DESTINO,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,TIEMPO_VIDA,UID_ORIGEN,CONTROL,MINUTOS,FECHA_CONFIRMACION,HORA_ENVIO,HORA_CONFIRMACION) values (56,4,to_timestamp('26-OCT-08 12.00.00.000000000 AM','DD-MON-RR HH.MI.SS.FF AM'),'mensaje 4','prueba 4',1,3,1,0,0,to_timestamp('26-OCT-08 12.00.00.000000000 AM','DD-MON-RR HH.MI.SS.FF AM'),'00:40:49 AM','00:44:40 AM');
Insert into MENSAJES (MID,UID_DESTINO,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,TIEMPO_VIDA,UID_ORIGEN,CONTROL,MINUTOS,FECHA_CONFIRMACION,HORA_ENVIO,HORA_CONFIRMACION) values (57,4,to_timestamp('26-OCT-08 12.00.00.000000000 AM','DD-MON-RR HH.MI.SS.FF AM'),'mensaje 5','prueba 5',1,3,1,0,0,to_timestamp('26-OCT-08 12.00.00.000000000 AM','DD-MON-RR HH.MI.SS.FF AM'),'00:41:09 AM','00:44:42 AM');
Insert into MENSAJES (MID,UID_DESTINO,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,TIEMPO_VIDA,UID_ORIGEN,CONTROL,MINUTOS,FECHA_CONFIRMACION,HORA_ENVIO,HORA_CONFIRMACION) values (58,4,to_timestamp('26-OCT-08 12.00.00.000000000 AM','DD-MON-RR HH.MI.SS.FF AM'),'otro mensaje','veamos que pasa!',1,3,1,0,0,to_timestamp('26-OCT-08 12.00.00.000000000 AM','DD-MON-RR HH.MI.SS.FF AM'),'01:00:02 AM','01:03:00 AM');
Insert into MENSAJES (MID,UID_DESTINO,FECHA_ENVIO,ASUNTO,TEXTO,CONFIRMADO,TIEMPO_VIDA,UID_ORIGEN,CONTROL,MINUTOS,FECHA_CONFIRMACION,HORA_ENVIO,HORA_CONFIRMACION) values (59,4,to_timestamp('26-OCT-08 12.00.00.000000000 AM','DD-MON-RR HH.MI.SS.FF AM'),'vientos desde el mas alla','la ley',1,3,1,0,0,to_timestamp('26-OCT-08 12.00.00.000000000 AM','DD-MON-RR HH.MI.SS.FF AM'),'01:02:33 AM','01:03:01 AM');

---------------------------------------------------
--   END DATA FOR TABLE MENSAJES
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE MENSAJES_PDA
--   FILTER = none used
---------------------------------------------------
REM INSERTING into MENSAJES_PDA

---------------------------------------------------
--   END DATA FOR TABLE MENSAJES_PDA
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE ROLES
--   FILTER = none used
---------------------------------------------------
REM INSERTING into ROLES
Insert into ROLES (RID,NOMBRE) values (1,'ADMIN');
Insert into ROLES (RID,NOMBRE) values (2,'AUDITOR');
Insert into ROLES (RID,NOMBRE) values (3,'VENDEDOR');
Insert into ROLES (RID,NOMBRE) values (4,'LOTE');

---------------------------------------------------
--   END DATA FOR TABLE ROLES
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE TIPO_GRUPO
--   FILTER = none used
---------------------------------------------------
REM INSERTING into TIPO_GRUPO
Insert into TIPO_GRUPO (ID_TIPO,DESCRIPCION) values (1,'ZONA POS');
Insert into TIPO_GRUPO (ID_TIPO,DESCRIPCION) values (2,'GRUPO ADMIN');
Insert into TIPO_GRUPO (ID_TIPO,DESCRIPCION) values (3,'GRUPO LOTE');

---------------------------------------------------
--   END DATA FOR TABLE TIPO_GRUPO
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE TRANSACCIONES
--   FILTER = none used
---------------------------------------------------
REM INSERTING into TRANSACCIONES
Insert into TRANSACCIONES (CODIGO,DESCRIPCION,DRIVER,ARGS) values ('TR001','Adiciona usuarios','com.kazak.comeet.server.businessrules.UserManager','<root>
 <action>add</action>
 <arg>INS0001</arg>
 <arg>INS0002</arg>
</root>');
Insert into TRANSACCIONES (CODIGO,DESCRIPCION,DRIVER,ARGS) values ('TR002','Edita Usuarios','com.kazak.comeet.server.businessrules.UserManager','<root>
 <action>edit</action>
 <arg>UPD0004</arg>
 <arg>DEL0001</arg>
 <arg>INS0002</arg>
</root>');
Insert into TRANSACCIONES (CODIGO,DESCRIPCION,DRIVER,ARGS) values ('TR003','Borra Usuarios','com.kazak.comeet.server.businessrules.UserManager','<root>
 <action>remove</action>
 <arg>DEL0001</arg>
 <arg>DEL0002</arg>
</root>');
Insert into TRANSACCIONES (CODIGO,DESCRIPCION,DRIVER,ARGS) values ('TR004','Adiciona Grupos','com.kazak.comeet.server.businessrules.GroupManager','<root>
 <action>add</action>
 <arg>INS0006</arg>
</root>');
Insert into TRANSACCIONES (CODIGO,DESCRIPCION,DRIVER,ARGS) values ('TR005','Edita Grupos','com.kazak.comeet.server.businessrules.GroupManager','<root>
 <action>edit</action>
 <arg>UPD0001</arg>
</root>');
Insert into TRANSACCIONES (CODIGO,DESCRIPCION,DRIVER,ARGS) values ('TR006','Borra Grupos','com.kazak.comeet.server.businessrules.GroupManager','<root>
 <action>remove</action>
 <arg>SEL0013</arg>
 <arg>SEL0014</arg>
 <arg>DEL0003</arg>
</root>');
Insert into TRANSACCIONES (CODIGO,DESCRIPCION,DRIVER,ARGS) values ('TR007','Adiciona Ubicacion','com.kazak.comeet.server.businessrules.PointOfSaleManager','<root>
  <action>add</action>
  <arg>INS0007</arg>
</root>');
Insert into TRANSACCIONES (CODIGO,DESCRIPCION,DRIVER,ARGS) values ('TR008','Editar Ubicacion','com.kazak.comeet.server.businessrules.PointOfSaleManager','<root>
 <action>edit</action>
 <arg>UPD0005</arg>
</root>');
Insert into TRANSACCIONES (CODIGO,DESCRIPCION,DRIVER,ARGS) values ('TR009','Borrar Ubicacion','com.kazak.comeet.server.businessrules.PointOfSaleManager','<root>
 <action>remove</action>
 <arg>DEL0004</arg>
</root>');
Insert into TRANSACCIONES (CODIGO,DESCRIPCION,DRIVER,ARGS) values ('TR010','Editar Contraseña','com.kazak.comeet.server.businessrules.PasswordExchanger','<root>
 <args>UPD0002</args>
</root>');
Insert into TRANSACCIONES (CODIGO,DESCRIPCION,DRIVER,ARGS) values ('TR011','Confirma Mensaje','com.kazak.comeet.server.businessrules.MessageConfirmer','<root>
 <args>UPD0003</args>
</root>');
Insert into TRANSACCIONES (CODIGO,DESCRIPCION,DRIVER,ARGS) values ('TR012','Sync Oracle/Postgres','com.kazak.comeet.server.businessrules.SyncManager','<root/>');

---------------------------------------------------
--   END DATA FOR TABLE TRANSACCIONES
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE UBICACIONES
--   FILTER = none used
---------------------------------------------------
REM INSERTING into UBICACIONES
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID) values (1,'OFICINA GERENCIA','127.0.0.1',3);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID) values (2,'OFICINA AUDITORIA','127.0.0.1',4);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID) values (3,'OFICINA SOPORTE TECNICO','127.0.0.1',5);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID) values (4,'PORTAL NORTE','127.0.0.1',6);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID) values (5,'ALCALA','127.0.0.1',6);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID) values (6,'CHAPINERO CENTRO','127.0.0.1',7);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID) values (7,'LA CANDELARIA','127.0.0.1',7);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID) values (8,'USME','127.0.0.1',8);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID) values (9,'QUIROGA','127.0.0.1',8);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID) values (10,'MODELIA','127.0.0.1',9);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID) values (11,'SALITRE','127.0.0.1',9);
Insert into UBICACIONES (CODIGO,NOMBRE,IP,GID) values (12,'DATA CENTER','127.0.0.1',3);

---------------------------------------------------
--   END DATA FOR TABLE UBICACIONES
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE USUARIOS
--   FILTER = none used
---------------------------------------------------
REM INSERTING into USUARIOS
Insert into USUARIOS (CODIGO,LOGIN,CLAVE,NOMBRES,CORREO,HABILITADO,GID,ROL) values (1,'admin','21232f297a57a5a743894a0e4a801fc3','Usuario Administrador','xtingray@localhost',1,3,1);
Insert into USUARIOS (CODIGO,LOGIN,CLAVE,NOMBRES,CORREO,HABILITADO,GID,ROL) values (2,'auditor','827ccb0eea8a706c4c34a16891f84e7b','Usuario Auditor','xtingray@localhost',1,4,2);
Insert into USUARIOS (CODIGO,LOGIN,CLAVE,NOMBRES,CORREO,HABILITADO,GID,ROL) values (3,'suba','827ccb0eea8a706c4c34a16891f84e7b','Lote Suba','soporte@localhost',1,12,4);
Insert into USUARIOS (CODIGO,LOGIN,CLAVE,NOMBRES,CORREO,HABILITADO,GID,ROL) values (4,'pos01','827ccb0eea8a706c4c34a16891f84e7b','Vendedor Pos 01',null,1,6,3);
Insert into USUARIOS (CODIGO,LOGIN,CLAVE,NOMBRES,CORREO,HABILITADO,GID,ROL) values (5,'pos02','827ccb0eea8a706c4c34a16891f84e7b','Vendedor Pos 02',null,1,8,3);

---------------------------------------------------
--   END DATA FOR TABLE USUARIOS
---------------------------------------------------

---------------------------------------------------
--   DATA FOR TABLE USUARIOS_UBICACION
--   FILTER = none used
---------------------------------------------------
REM INSERTING into USUARIOS_UBICACION
Insert into USUARIOS_UBICACION (ID_USUARIO,CODIGO_UBICACION,VALIDAR_IP) values (1,1,0);
Insert into USUARIOS_UBICACION (ID_USUARIO,CODIGO_UBICACION,VALIDAR_IP) values (2,2,0);
Insert into USUARIOS_UBICACION (ID_USUARIO,CODIGO_UBICACION,VALIDAR_IP) values (3,12,0);
Insert into USUARIOS_UBICACION (ID_USUARIO,CODIGO_UBICACION,VALIDAR_IP) values (4,4,0);
Insert into USUARIOS_UBICACION (ID_USUARIO,CODIGO_UBICACION,VALIDAR_IP) values (5,8,0);

---------------------------------------------------
--   END DATA FOR TABLE USUARIOS_UBICACION
---------------------------------------------------
--------------------------------------------------------
--  Constraints for Table GRUPOS
--------------------------------------------------------

  ALTER TABLE "GRUPOS" ADD CONSTRAINT "GRUPOS_PK" PRIMARY KEY ("GRUPO_ID") ENABLE;
 
  ALTER TABLE "GRUPOS" MODIFY ("GRUPO_ID" NOT NULL ENABLE);
 
  ALTER TABLE "GRUPOS" MODIFY ("NOMBRE" NOT NULL ENABLE);
 
  ALTER TABLE "GRUPOS" MODIFY ("VISIBLE" NOT NULL ENABLE);
 
  ALTER TABLE "GRUPOS" MODIFY ("TIPO_GRUPO" NOT NULL ENABLE);
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
  SELECT GRUPOS_GID_SEQ.NEXTVAL INTO :NEW.GID FROM DUAL;
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
  SELECT USUARIOS_UID_SEQ.NEXTVAL INTO :NEW."UID" FROM DUAL;
END;

/
ALTER TRIGGER "USUARIOS_TRG" ENABLE;
