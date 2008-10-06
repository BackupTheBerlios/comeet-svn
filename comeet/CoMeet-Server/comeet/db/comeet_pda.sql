--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

--
-- Name: grupos_gid_seq; Type: SEQUENCE; Schema: public; Owner: comeetadmin
--

CREATE SEQUENCE grupos_gid_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER TABLE public.grupos_gid_seq OWNER TO comeetadmin;

--
-- Name: tipo_grupo_id_tipo_seq; Type: SEQUENCE; Schema: public; Owner: comeetadmin
--

CREATE SEQUENCE tipo_grupo_id_tipo_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER TABLE public.tipo_grupo_id_tipo_seq OWNER TO comeetadmin;

--
-- Name: roles_rid_seq; Type: SEQUENCE; Schema: public; Owner: comeetadmin
--

CREATE SEQUENCE roles_rid_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER TABLE public.roles_rid_seq OWNER TO comeetadmin;

--
-- Name: grupos_gid_seq; Type: SEQUENCE SET; Schema: public; Owner: comeetadmin
--

SELECT pg_catalog.setval('grupos_gid_seq', 66, true);
SELECT pg_catalog.setval('tipo_grupo_id_tipo_seq', 1, true);
SELECT pg_catalog.setval('roles_rid_seq', 1, true);

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: comeetadmin; Tablespace: 
--

CREATE TABLE roles (
    rid integer DEFAULT nextval('roles_rid_seq'::regclass) NOT NULL,
    nombre character varying(40) NOT NULL
);

ALTER TABLE public.roles OWNER TO comeetadmin;

--
-- Name: tipo_grupo; Type: TABLE; Schema: public; Owner: comeetadmin; Tablespace: 
--

CREATE TABLE tipo_grupo (
    id_tipo integer DEFAULT nextval('tipo_grupo_id_tipo_seq'::regclass) NOT NULL,
    nombre character varying(40) NOT NULL
);


ALTER TABLE public.tipo_grupo OWNER TO comeetadmin;

--
-- Name: grupos; Type: TABLE; Schema: public; Owner: comeetadmin; Tablespace: 
--

CREATE TABLE grupos (
    gid integer DEFAULT nextval('grupos_gid_seq'::regclass) NOT NULL,
    nombre character varying(40) NOT NULL,
    visible boolean DEFAULT false NOT NULL,
    tipo_grupo integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.grupos OWNER TO comeetadmin;

--
-- Name: mensajes_mid_seq; Type: SEQUENCE; Schema: public; Owner: comeetadmin
--

CREATE SEQUENCE mensajes_mid_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.mensajes_mid_seq OWNER TO comeetadmin;

--
-- Name: mensajes_mid_seq; Type: SEQUENCE SET; Schema: public; Owner: comeetadmin
--

SELECT pg_catalog.setval('mensajes_mid_seq', 4296, true);


--
-- Name: mensajes; Type: TABLE; Schema: public; Owner: comeetadmin; Tablespace: 
--

CREATE TABLE mensajes (
    mid integer DEFAULT nextval('mensajes_mid_seq'::regclass) NOT NULL,
    uid_destino integer,
    fecha_envio date NOT NULL,
    hora_envio time without time zone NOT NULL,
    asunto character varying(256) NOT NULL,
    texto text NOT NULL,
    confirmado boolean DEFAULT false NOT NULL,
    respuesta_valida boolean DEFAULT false NOT NULL,
    tiempo_vida integer DEFAULT 1 NOT NULL,
    uid_origen integer NOT NULL,
    control boolean DEFAULT false NOT NULL,
    minutos smallint DEFAULT (-1) NOT NULL,
    fecha_confirmacion date NOT NULL,
    hora_confirmacion time without time zone NOT NULL
);


ALTER TABLE public.mensajes OWNER TO comeetadmin;

--
-- Name: mensajes_pda_mid_seq; Type: SEQUENCE; Schema: public; Owner: comeetadmin
--

CREATE SEQUENCE mensajes_pda_mid_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER TABLE public.mensajes_pda_mid_seq OWNER TO comeetadmin;

--
-- Name: mensajes_pda_mid_seq; Type: SEQUENCE SET; Schema: public; Owner: comeetadmin
--

SELECT pg_catalog.setval('mensajes_pda_mid_seq', 1, true);

--
-- Name: mensajes_pda; Type: TABLE; Schema: public; Owner: comeetadmin; Tablespace: 
--

CREATE TABLE mensajes_pda (
    mid integer DEFAULT nextval('mensajes_pda_mid_seq'::regclass) NOT NULL,
    login character varying(30) NOT NULL,
    uid_origen integer NOT NULL,
    fecha_envio date NOT NULL,
    hora_envio time without time zone NOT NULL,
    asunto character varying(256) NOT NULL,
    texto text NOT NULL,
    confirmado boolean DEFAULT false NOT NULL,
    fecha_confirmacion date NOT NULL,
    hora_confirmacion time without time zone NOT NULL
);

ALTER TABLE public.mensajes_pda OWNER TO comeetadmin;

--
-- Name: ubicaciones; Type: TABLE; Schema: public; Owner: comeetadmin; Tablespace: 
--

CREATE TABLE ubicaciones (
    codigo character(4) NOT NULL,
    nombre character varying(50) NOT NULL,
    ip inet DEFAULT '127.0.0.1'::inet,
    gid integer DEFAULT 5 NOT NULL
);

ALTER TABLE public.ubicaciones OWNER TO comeetadmin;

--
-- Name: tipo_usuario; Type: TABLE; Schema: public; Owner: comeetadmin; Tablespace: 
--

CREATE TABLE tipo_usuario (
    id_tipo integer NOT NULL,
    descripcion character varying(30) NOT NULL
);


ALTER TABLE public.tipo_usuario OWNER TO comeetadmin;

--
-- Name: transacciones; Type: TABLE; Schema: public; Owner: comeetadmin; Tablespace: 
--

CREATE TABLE transacciones (
    codigo character(5) NOT NULL,
    nombre character varying(100) NOT NULL,
    driver character varying(200) NOT NULL,
    args text NOT NULL
);


ALTER TABLE public.transacciones OWNER TO comeetadmin;

--
-- Name: usuarios_uid_seq; Type: SEQUENCE; Schema: public; Owner: comeetadmin
--

CREATE SEQUENCE usuarios_uid_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.usuarios_uid_seq OWNER TO comeetadmin;

--
-- Name: usuarios_uid_seq; Type: SEQUENCE SET; Schema: public; Owner: comeetadmin
--

SELECT pg_catalog.setval('usuarios_uid_seq', 5239, true);


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: comeetadmin; Tablespace: 
--

CREATE TABLE usuarios (
    uid integer DEFAULT nextval('usuarios_uid_seq'::regclass) NOT NULL,
    login character varying(30) NOT NULL,
    clave character(32) DEFAULT '827ccb0eea8a706c4c34a16891f84e7b'::bpchar NOT NULL,
    nombres character varying(100) DEFAULT 'Sin Nombre'::character varying,
    correo character varying(200),
    habilitado boolean DEFAULT true NOT NULL,
    gid integer DEFAULT 5 NOT NULL,
    rol integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.usuarios OWNER TO comeetadmin;

--
-- Name: usuarios_ubicacion; Type: TABLE; Schema: public; Owner: comeetadmin; Tablespace: 
--

CREATE TABLE usuarios_ubicacion (
    id_usuario integer NOT NULL,
    codigo_ubicacion character(4) NOT NULL,
    validar_ip boolean DEFAULT false NOT NULL
);


ALTER TABLE public.usuarios_ubicacion OWNER TO comeetadmin;

--
-- Data for Name: tipo_grupo; Type: TABLE DATA; Schema: public; Owner: comeetadmin
--

COPY tipo_grupo (id_tipo, nombre) FROM stdin;
1	ZONA POS
2	GRUPO ADMIN
3	GRUPO LOTE
\.

--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: comeetadmin
--

COPY roles (rid, nombre) FROM stdin;
1	ADMIN
2	AUDITOR
3	VENDEDOR
4	LOTE
\.

--
-- Data for Name: grupos; Type: TABLE DATA; Schema: public; Owner: comeetadmin
--

COPY grupos (gid, nombre, visible, tipo_grupo) FROM stdin;
1	SIN GRUPO	f	1
2	ADMINISTRATIVOS	f	2
3	GERENCIA	t	2
4	AUDITORIA	t	2
5	FALLAS EQUIPOS	t	2
6	NORTE	f	1
7	CENTRO	f	1
8	SUR	f	1
9	OCCIDENTE	f	1
65	CORABASTOS	f	1
0	COMEET	f	2
10	SUBA	f	3
\.

--
-- Data for Name: ubicaciones; Type: TABLE DATA; Schema: public; Owner: comeetadmin
--

COPY ubicaciones (codigo, nombre, ip, gid) FROM stdin;
19  	POLLITO	12.12.1.2	8
0000	PORTAL NORTE	0.0.0.0	6
0003	EL CAMPIN	0.0.0.0	7
0004	CHAPINERO CENTRO	0.0.0.0	7
0005	LA CANDELARIA	0.0.0.0	7
0006	USME	0.0.0.0	8
0007	QUIROGA	0.0.0.0	8
0008	OLAYA	0.0.0.0	8
0009	MODELIA	0.0.0.0	9
0010	SALITRE	0.0.0.0	9
0011	ZONA FRANCA	0.0.0.0	9
14  	POLICIA II	100.100.100.1	7
15  	PORVENIR	127.0.0.1	7
16  	PUNTO X	12.12.12.0	6
0001	ALCALA	0.0.0.3	6
17  	OTRO PUNTO	0.0.0.1	8
18  	NUEVO PUNTO	0.0.0.1	8
0002	LA CAMPINA	0.0.0.1	6
20  	EL ELEFANTE	0.0.0.4	8
\.


--
-- Data for Name: tipo_usuario; Type: TABLE DATA; Schema: public; Owner: comeetadmin
--

COPY tipo_usuario (id_tipo, descripcion) FROM stdin;
1	PC
2	PUNTO DE VENTA
3	LOTE
\.

--
-- Data for Name: transacciones; Type: TABLE DATA; Schema: public; Owner: comeetadmin
--

COPY transacciones (codigo, nombre, driver, args) FROM stdin;
TR001	Adiciona usuarios	com.kazak.comeet.server.businessrules.UserManager	<root>\n    <action>add</action>\n    <arg>INS0001</arg>\n    <arg>INS0002</arg>\n</root>
TR002	Edita Usuarios	com.kazak.comeet.server.businessrules.UserManager	<root>\n    <action>edit</action>\n    <arg>UPD0004</arg>\n    <arg>DEL0001</arg>\n    <arg>INS0002</arg>\n</root>
TR003	Borra Usuarios	com.kazak.comeet.server.businessrules.UserManager	<root>\n    <action>remove</action>\n    <arg>DEL0001</arg>\n    <arg>DEL0002</arg>\n</root>
TR004	Adiciona  un grupo	com.kazak.comeet.server.businessrules.GroupManager	<root>\n    <action>add</action>\n    <arg>INS0006</arg>\n</root>
TR005	Edita un grupo	com.kazak.comeet.server.businessrules.GroupManager	<root>\n    <action>edit</action>\n    <arg>UPD0001</arg>\n</root>
TR006	Borra un grupo	com.kazak.comeet.server.businessrules.GroupManager	<root>\n    <action>remove</action>\n    <arg>SEL0013</arg>\n    <arg>SEL0014</arg>\n    <arg>DEL0003</arg>\n</root>
TR007	Nuevo Punto de Venta	com.kazak.comeet.server.businessrules.PointOfSaleManager	<root>\n    <action>add</action>\n    <arg>INS0007</arg>\n</root>
TR009	Borrar Punto de Venta	com.kazak.comeet.server.businessrules.PointOfSaleManager	<root>\n    <action>remove</action>\n    <arg>DEL0004</arg>\n</root>
TR010	Actualizacion de ContraseÃ±a	com.kazak.comeet.server.businessrules.PasswordExchanger	<root>\n<args>UPD0002</args>\n</root>
TR011	Confirmacion de mensaje	com.kazak.comeet.server.businessrules.MessageConfirmer	<root>\n    <args>UPD0003</args>\n</root>
TR012	Sincronización de las bases de datos Oracle con PostgreSQL	com.kazak.comeet.server.businessrules.SyncManager	<root/>
TR008	Editar Punto de Venta	com.kazak.comeet.server.businessrules.PointOfSaleManager	<root>\n    <action>edit</action>\n    <arg>UPD0005</arg>\n</root>
\.

--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: comeetadmin
--

COPY usuarios (uid, login, clave, nombres, correo, habilitado, gid, rol) FROM stdin;
3	comeetadmin	827ccb0eea8a706c4c34a16891f84e7b	Usuario CoMeet	comeet@localhost	t	0	1
17	gustavo2	827ccb0eea8a706c4c34a16891f84e7b	Gustavo Gonzalez	gustavo@localhost	t	2	1
5232	support	827ccb0eea8a706c4c34a16891f84e7b	Support User	support@localhost	t	0	1
5233	pollito	827ccb0eea8a706c4c34a16891f84e7b	Pollito Gallina	pollito@localhost	t	4	1
2	auditor	827ccb0eea8a706c4c34a16891f84e7b	Usuario Auditor	auditor@localhost	f	4	1
1	admin	21232f297a57a5a743894a0e4a801fc3	Usuario Administrador	admin@localhost	t	2	1
16	gustavo	827ccb0eea8a706c4c34a16891f84e7b	Gustavo Gonzalez G	gustavo@saludtotal.com	t	5	1
5237	canciller	827ccb0eea8a706c4c34a16891f84e7b	Canciller X	canciller@saludtotal.com	f	4	1
18	gustavo3	827ccb0eea8a706c4c34a16891f84e7b	Gustavo Gonzalez	xtingray@localhost	t	3	1
5	CV0002	827ccb0eea8a706c4c34a16891f84e7b	Adriana Medina		f	6	2
6	CV0003	827ccb0eea8a706c4c34a16891f84e7b	Jorge Triana		f	7	2
7	CV0004	827ccb0eea8a706c4c34a16891f84e7b	Joanna Arango		f	6	2
8	CV0005	827ccb0eea8a706c4c34a16891f84e7b	Pedro Garcia		f	7	2
9	CV0006	827ccb0eea8a706c4c34a16891f84e7b	Jose Viena		f	7	2
10	CV0007	827ccb0eea8a706c4c34a16891f84e7b	Daniel Rios		f	8	2
11	CV0008	827ccb0eea8a706c4c34a16891f84e7b	Andres Naranjo		f	8	2
12	CV0009	827ccb0eea8a706c4c34a16891f84e7b	Jairo Perez		f	8	2
13	CV0010	827ccb0eea8a706c4c34a16891f84e7b	Mario Andrade		f	9	2
14	CV0011	827ccb0eea8a706c4c34a16891f84e7b	Marisol Correa		f	9	2
15	CV0012	827ccb0eea8a706c4c34a16891f84e7b	Joaquin Aranda		f	9	2
5227	CV0090	827ccb0eea8a706c4c34a16891f84e7b	Guz		f	1	2
5228	CV0092	827ccb0eea8a706c4c34a16891f84e7b	Proof		f	1	2
5229	CV0098	827ccb0eea8a706c4c34a16891f84e7b	Proof 2		f	1	2
5234	CV0070	827ccb0eea8a706c4c34a16891f84e7b	Vendedor X		f	1	2
5235	DiegoR	827ccb0eea8a706c4c34a16891f84e7b	Diego Rodriguez		f	1	2
5236	pCastro	827ccb0eea8a706c4c34a16891f84e7b	Pablo Castro		f	1	2
5238	DurangoP	827ccb0eea8a706c4c34a16891f84e7b	Durango Palomino		f	1	2
4	CV0001	827ccb0eea8a706c4c34a16891f84e7b	Carolina Perez Pum		f	1	2
5239	suba	827ccb0eea8a706c4c34a16891f84e7b	Lote Suba	suba@localhost	f	10	4
\.

--
-- Data for Name: usuarios_ubicacion; Type: TABLE DATA; Schema: public; Owner: comeetadmin
--

COPY usuarios_ubicacion (id_usuario, codigo_ubicacion, validar_ip) FROM stdin;
5	0001	f
6	0002	f
7	0003	f
8	0004	f
9	0005	f
10	0006	f
11	0007	f
12	0008	f
13	0009	f
13	0010	f
13	0011	f
5227	0001	f
5228	0002	f
5229	0011	f
5234	14  	f
5235	0001	f
5236	0001	f
5238	20  	f
4	0000	f
4	0001	f
\.

--
-- Name: roles_rid_key; Type: CONSTRAINT; Schema: public; Owner: comeetadmin; Tablespace: 
--

ALTER TABLE ONLY tipo_grupo
    ADD CONSTRAINT tipo_grupo_id_tipo_key UNIQUE (id_tipo);

--
-- Name: roles_rid_key; Type: CONSTRAINT; Schema: public; Owner: comeetadmin; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_rid_key UNIQUE (rid);

--
-- Name: grupos_nombre_grupo_key; Type: CONSTRAINT; Schema: public; Owner: comeetadmin; Tablespace: 
--

ALTER TABLE ONLY grupos
    ADD CONSTRAINT grupos_nombre_key UNIQUE (nombre);

--
-- Name: grupos_pkey; Type: CONSTRAINT; Schema: public; Owner: comeetadmin; Tablespace: 
--

ALTER TABLE ONLY grupos
    ADD CONSTRAINT grupos_pkey PRIMARY KEY (gid);


--
-- Name: mensajes_pkey; Type: CONSTRAINT; Schema: public; Owner: comeetadmin; Tablespace: 
--

ALTER TABLE ONLY mensajes
    ADD CONSTRAINT mensajes_pkey PRIMARY KEY (mid);


--
-- Name: ubicaciones_codigo_key; Type: CONSTRAINT; Schema: public; Owner: comeetadmin; Tablespace: 
--

ALTER TABLE ONLY ubicaciones
    ADD CONSTRAINT ubicaciones_codigo_key UNIQUE (codigo);


--
-- Name: puntosv_pkey; Type: CONSTRAINT; Schema: public; Owner: comeetadmin; Tablespace: 
--

ALTER TABLE ONLY ubicaciones
    ADD CONSTRAINT ubicaciones_pkey PRIMARY KEY (codigo);


--
-- Name: tipo_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: comeetadmin; Tablespace: 
--

ALTER TABLE ONLY tipo_usuario
    ADD CONSTRAINT tipo_usuario_pkey PRIMARY KEY (id_tipo);


--
-- Name: transacciones_pkey; Type: CONSTRAINT; Schema: public; Owner: comeetadmin; Tablespace: 
--

ALTER TABLE ONLY transacciones
    ADD CONSTRAINT transacciones_pkey PRIMARY KEY (codigo);

--
-- Name: usuarios_login_key; Type: CONSTRAINT; Schema: public; Owner: comeetadmin; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuarios_login_key UNIQUE (login);


--
-- Name: usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: comeetadmin; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (uid);

--
-- Name: ubicaciones_gid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: comeetadmin
--

ALTER TABLE ONLY ubicaciones
    ADD CONSTRAINT puntosv_gid_fkey FOREIGN KEY (gid) REFERENCES grupos(gid);


--
-- Name: usuarios_gid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: comeetadmin
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuarios_gid_fkey FOREIGN KEY (gid) REFERENCES grupos(gid);


--
-- Name: usuarios_ubicacion_codigo_ubicacion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: comeetadmin
--

ALTER TABLE ONLY usuarios_ubicacion
    ADD CONSTRAINT usuarios_ubicacion_codigo_ubicacion_fkey FOREIGN KEY (codigo_ubicacion) REFERENCES ubicaciones(codigo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: usuarios_ubicacion_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: comeetadmin
--

ALTER TABLE ONLY usuarios_ubicacion
    ADD CONSTRAINT usuarios_ubicacion_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES usuarios(uid);


--
-- Name: usuarios_tipo_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: comeetadmin
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuarios_rol_fkey FOREIGN KEY (rol) REFERENCES roles(rid);

--
-- Name: grupos_tipo_grupo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: comeetadmin
--

ALTER TABLE ONLY grupos
    ADD CONSTRAINT grupos_tipo_grupo_fkey FOREIGN KEY (tipo_grupo) REFERENCES tipo_grupo(id_tipo);

--
-- Name: mensajes_pda_uid_origen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: comeetadmin
--

ALTER TABLE ONLY mensajes_pda
    ADD CONSTRAINT mensajes_pda_uid_origen_fkey FOREIGN KEY (uid_origen) REFERENCES usuarios(uid);

--
-- Name: mensajes_uid_destino_fkey; Type: FK CONSTRAINT; Schema: public; Owner: comeetadmin
--

ALTER TABLE ONLY mensajes
    ADD CONSTRAINT mensajes_uid_destino_fkey FOREIGN KEY (uid_destino) REFERENCES usuarios(uid);

--
-- Name: mensajes_uid_origen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: comeetadmin
--

ALTER TABLE ONLY mensajes
    ADD CONSTRAINT mensajes_uid_origen_fkey FOREIGN KEY (uid_origen) REFERENCES usuarios(uid);

--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

