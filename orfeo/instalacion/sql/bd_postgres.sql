--
-- PostgreSQL database dump
--

SET client_encoding = 'LATIN1';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'Standard public schema';


--
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE PROCEDURAL LANGUAGE plpgsql;


SET search_path = public, pg_catalog;

--
-- Name: concat(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION concat(text, text) RETURNS text
    AS $_$select case when $1 = '' then $2 else ($1 || ', ' || $2) end$_$
    LANGUAGE sql;


ALTER FUNCTION public.concat(text, text) OWNER TO postgres;

--
-- Name: concat(text); Type: AGGREGATE; Schema: public; Owner: postgres
--

CREATE AGGREGATE concat(text) (
    SFUNC = public.concat,
    STYPE = text,
    INITCOND = ''
);


ALTER AGGREGATE public.concat(text) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: anexos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE anexos (
    anex_radi_nume numeric(15,0) NOT NULL,
    anex_codigo character varying(20) NOT NULL,
    anex_tipo numeric(4,0) NOT NULL,
    anex_tamano numeric,
    anex_solo_lect character varying(1) NOT NULL,
    anex_creador character varying(15) NOT NULL,
    anex_desc character varying(512),
    anex_numero numeric(5,0) NOT NULL,
    anex_nomb_archivo character varying(50) NOT NULL,
    anex_borrado character varying(1) NOT NULL,
    anex_origen numeric(1,0) DEFAULT 0,
    anex_ubic character varying(15),
    anex_salida numeric(1,0) DEFAULT 0,
    radi_nume_salida numeric(15,0),
    anex_radi_fech timestamp with time zone,
    anex_estado numeric(1,0) DEFAULT 0,
    usua_doc character varying(14),
    sgd_rem_destino numeric(1,0) DEFAULT 0,
    anex_fech_envio timestamp with time zone,
    sgd_dir_tipo numeric(4,0),
    anex_fech_impres timestamp with time zone,
    anex_depe_creador numeric(4,0),
    sgd_doc_secuencia numeric(15,0),
    sgd_doc_padre character varying(20),
    sgd_arg_codigo numeric(2,0),
    sgd_tpr_codigo numeric(4,0),
    sgd_deve_codigo numeric(2,0),
    sgd_deve_fech date,
    sgd_fech_impres date,
    anex_fech_anex date,
    anex_depe_codi character varying(3),
    sgd_pnufe_codi numeric(4,0),
    sgd_dnufe_codi numeric(4,0),
    anex_usudoc_creador character varying(15),
    sgd_fech_doc date,
    sgd_apli_codi numeric(4,0),
    sgd_trad_codigo numeric(2,0),
    sgd_dir_direccion character varying(150),
    sgd_exp_numero character varying(18)
);


ALTER TABLE public.anexos OWNER TO postgres;

--
-- Name: TABLE anexos; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE anexos IS 'tabla de registro de los anexos';


--
-- Name: COLUMN anexos.anex_nomb_archivo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN anexos.anex_nomb_archivo IS 'Contiene el nombre del docuemnto.';


--
-- Name: COLUMN anexos.anex_salida; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN anexos.anex_salida IS 'Indica si el documento es un doc. que se enviara.';


--
-- Name: COLUMN anexos.radi_nume_salida; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN anexos.radi_nume_salida IS 'Almacena el numero con el que va a salir.';


--
-- Name: COLUMN anexos.anex_estado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN anexos.anex_estado IS '0 Anexo normal
1 Anexo Normal
2 Ya se genero un Radicado.
3 Impreso
4 Enviado';


--
-- Name: COLUMN anexos.sgd_dir_tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN anexos.sgd_dir_tipo IS 'Tipo de destinatario....
Si es 1 remitente
2 predio
3 esp contra el proceso
si antecede de 7 significa que va dirigido a una persona que no es remitente o empresa a la que se refiere el radicado original.';


--
-- Name: anexos_historico; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE anexos_historico (
    anex_hist_anex_codi character varying(20) NOT NULL,
    anex_hist_num_ver numeric(4,0) NOT NULL,
    anex_hist_tipo_mod character varying(2) NOT NULL,
    anex_hist_usua character varying(15) NOT NULL,
    anex_hist_fecha date NOT NULL,
    usua_doc character varying(14)
);


ALTER TABLE public.anexos_historico OWNER TO postgres;

--
-- Name: TABLE anexos_historico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE anexos_historico IS 'historico de los anexos subidos';


--
-- Name: anexos_tipo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE anexos_tipo (
    anex_tipo_codi numeric(4,0) NOT NULL,
    anex_tipo_ext character varying(10) NOT NULL,
    anex_tipo_desc character varying(50)
);


ALTER TABLE public.anexos_tipo OWNER TO postgres;

--
-- Name: TABLE anexos_tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE anexos_tipo IS 'diferentes extenciones habilitadas para los archivos';


--
-- Name: bodega_empresas; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE bodega_empresas (
    nombre_de_la_empresa character varying(160),
    nuir character varying(13),
    nit_de_la_empresa character varying(80),
    sigla_de_la_empresa character varying(80),
    direccion character varying(4000),
    codigo_del_departamento character varying(4000),
    codigo_del_municipio character varying(4000),
    telefono_1 character varying(4000),
    telefono_2 character varying(4000),
    email character varying(4000),
    nombre_rep_legal character varying(4000),
    cargo_rep_legal character varying(4000),
    identificador_empresa numeric(5,0),
    are_esp_secue numeric(8,0) NOT NULL,
    id_cont numeric(2,0) DEFAULT 1,
    id_pais numeric(4,0) DEFAULT 170,
    activa numeric(1,0) DEFAULT 1,
    flag_rups numeric(1,0) DEFAULT 0
);


ALTER TABLE public.bodega_empresas OWNER TO postgres;

--
-- Name: TABLE bodega_empresas; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE bodega_empresas IS 'entidades publicas de la nacion';


--
-- Name: carpeta; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE carpeta (
    carp_codi numeric(2,0) NOT NULL,
    carp_desc character varying(80) NOT NULL
);


ALTER TABLE public.carpeta OWNER TO postgres;

--
-- Name: TABLE carpeta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE carpeta IS 'CARPETA';


--
-- Name: COLUMN carpeta.carp_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN carpeta.carp_codi IS 'CARP_CODI';


--
-- Name: COLUMN carpeta.carp_desc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN carpeta.carp_desc IS 'CARP_DESC';


--
-- Name: carpeta_per; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE carpeta_per (
    usua_codi numeric(3,0) NOT NULL,
    depe_codi numeric(5,0) NOT NULL,
    nomb_carp character varying(10),
    desc_carp character varying(30),
    codi_carp numeric(3,0)
);


ALTER TABLE public.carpeta_per OWNER TO postgres;

--
-- Name: TABLE carpeta_per; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE carpeta_per IS 'carpetas personales de los usuarios';


--
-- Name: departamento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE departamento (
    dpto_codi numeric(2,0) NOT NULL,
    dpto_nomb character varying(70) NOT NULL,
    id_cont numeric(2,0) DEFAULT 1,
    id_pais numeric(4,0) DEFAULT 170
);


ALTER TABLE public.departamento OWNER TO postgres;

--
-- Name: TABLE departamento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE departamento IS 'DEPARTAMENTO';


--
-- Name: COLUMN departamento.dpto_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN departamento.dpto_codi IS 'DPTO_CODI';


--
-- Name: COLUMN departamento.dpto_nomb; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN departamento.dpto_nomb IS 'DPTO_NOMB';


--
-- Name: departamento2; Type: TABLE; Schema: public; Owner: orfeo; Tablespace: 
--

CREATE TABLE departamento2 (
    dpto_codi numeric(4,0) NOT NULL,
    dpto_nomb character varying(120) NOT NULL,
    id_cont numeric(2,0),
    id_pais numeric(4,0)
);


ALTER TABLE public.departamento2 OWNER TO orfeo;

--
-- Name: TABLE departamento2; Type: COMMENT; Schema: public; Owner: orfeo
--

COMMENT ON TABLE departamento2 IS 'DEPARTAMENTO';


--
-- Name: COLUMN departamento2.dpto_codi; Type: COMMENT; Schema: public; Owner: orfeo
--

COMMENT ON COLUMN departamento2.dpto_codi IS 'DPTO_CODI';


--
-- Name: COLUMN departamento2.dpto_nomb; Type: COMMENT; Schema: public; Owner: orfeo
--

COMMENT ON COLUMN departamento2.dpto_nomb IS 'DPTO_NOMB';


--
-- Name: COLUMN departamento2.id_cont; Type: COMMENT; Schema: public; Owner: orfeo
--

COMMENT ON COLUMN departamento2.id_cont IS 'Identificación del Continente';


--
-- Name: COLUMN departamento2.id_pais; Type: COMMENT; Schema: public; Owner: orfeo
--

COMMENT ON COLUMN departamento2.id_pais IS 'Identificación del País';


--
-- Name: dependencia; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dependencia (
    depe_codi numeric(5,0) NOT NULL,
    depe_nomb character varying(70) NOT NULL,
    dpto_codi numeric(2,0),
    depe_codi_padre numeric(5,0),
    muni_codi numeric(4,0),
    depe_codi_territorial numeric(4,0),
    dep_sigla character varying(100),
    dep_central numeric(1,0),
    dep_direccion character varying(100),
    depe_num_interna numeric(4,0),
    depe_num_resolucion numeric(4,0),
    depe_rad_tp1 numeric(3,0),
    depe_rad_tp2 numeric(3,0),
    depe_rad_tp3 numeric(3,0),
    depe_rad_tp4 numeric(3,0),
    depe_rad_tp5 numeric(3,0),
    depe_rad_tp9 numeric(3,0),
    id_cont numeric(2,0) DEFAULT 1,
    id_pais numeric(4,0) DEFAULT 170,
    depe_estado smallint DEFAULT 0,
    depe_rad_tp8 smallint
);


ALTER TABLE public.dependencia OWNER TO postgres;

--
-- Name: TABLE dependencia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE dependencia IS 'DEPENDENCIA';


--
-- Name: COLUMN dependencia.depe_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN dependencia.depe_codi IS 'CODIGO DE DEPENDENCIA';


--
-- Name: COLUMN dependencia.depe_nomb; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN dependencia.depe_nomb IS 'NOMBRE DE DEPENDENCIA';


--
-- Name: COLUMN dependencia.dep_sigla; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN dependencia.dep_sigla IS 'SIGLA DE LA DEPENDENCIA';


--
-- Name: COLUMN dependencia.dep_central; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN dependencia.dep_central IS 'INDICA SI SE TRATA DE UNA DEPENDENCIA DEL NIVEL CENTRAL';


--
-- Name: dependencia_visibilidad; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dependencia_visibilidad (
    codigo_visibilidad numeric(18,0) NOT NULL,
    dependencia_visible numeric(5,0) NOT NULL,
    dependencia_observa numeric(5,0) NOT NULL
);


ALTER TABLE public.dependencia_visibilidad OWNER TO postgres;

--
-- Name: TABLE dependencia_visibilidad; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE dependencia_visibilidad IS 'visibilidad de los funcionarios de una dependencia por otra dependencia distinta';


--
-- Name: dependencias; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE dependencias
    START WITH 0
    INCREMENT BY 1
    MAXVALUE 9999
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.dependencias OWNER TO postgres;

--
-- Name: encuesta; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE encuesta (
    usua_doc character varying(14) NOT NULL,
    fecha date,
    p1 character varying(100),
    p2 character varying(100),
    p3 character varying(100),
    p4 character varying(100),
    p5 character varying(100),
    p6 character varying(100),
    p7 character varying(100),
    p7_cual character varying(150),
    p8 character varying(100),
    p9 character varying(100),
    p10 character varying(100),
    p11 character varying(100),
    p12 character varying(100),
    p13 character varying(100),
    p14 character varying(100),
    p15 character varying(100),
    p16 character varying(100),
    p17 character varying(100),
    p18 character varying(100),
    p19 character varying(100),
    p20 character varying(100),
    p20_cual character varying(150),
    p21 character varying(100),
    p22 character varying(100),
    p23 character varying(100),
    p24 character varying(100),
    p25 character varying(100)
);


ALTER TABLE public.encuesta OWNER TO postgres;

--
-- Name: TABLE encuesta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE encuesta IS 'encuesta';


--
-- Name: hist_eventos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hist_eventos (
    depe_codi numeric(5,0) NOT NULL,
    hist_fech timestamp with time zone NOT NULL,
    usua_codi numeric(10,0) NOT NULL,
    radi_nume_radi numeric(15,0) NOT NULL,
    hist_obse character varying(600) NOT NULL,
    usua_codi_dest numeric(10,0),
    usua_doc character varying(14),
    usua_doc_old character varying(15),
    sgd_ttr_codigo numeric(3,0),
    hist_usua_autor character varying(14),
    hist_doc_dest character varying(14),
    depe_codi_dest numeric(3,0)
);


ALTER TABLE public.hist_eventos OWNER TO postgres;

--
-- Name: TABLE hist_eventos; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE hist_eventos IS 'HIST_EVENTOS';


--
-- Name: COLUMN hist_eventos.depe_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN hist_eventos.depe_codi IS 'DEPE_CODI';


--
-- Name: COLUMN hist_eventos.hist_fech; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN hist_eventos.hist_fech IS 'HIST_FECH';


--
-- Name: COLUMN hist_eventos.usua_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN hist_eventos.usua_codi IS 'USUA_CODI';


--
-- Name: COLUMN hist_eventos.radi_nume_radi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN hist_eventos.radi_nume_radi IS 'Numero de Radicado';


--
-- Name: COLUMN hist_eventos.hist_obse; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN hist_eventos.hist_obse IS 'HIST_OBSE';


--
-- Name: COLUMN hist_eventos.usua_codi_dest; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN hist_eventos.usua_codi_dest IS 'Codigo del usuario destino.';


--
-- Name: COLUMN hist_eventos.sgd_ttr_codigo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN hist_eventos.sgd_ttr_codigo IS 'Tipo de Evento';


--
-- Name: COLUMN hist_eventos.hist_doc_dest; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN hist_eventos.hist_doc_dest IS 'Documento del usuario destino No. implentado';


--
-- Name: COLUMN hist_eventos.depe_codi_dest; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN hist_eventos.depe_codi_dest IS 'Codigo de la dependencia del usuario destino';


--
-- Name: informados; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE informados (
    radi_nume_radi numeric(15,0) NOT NULL,
    usua_codi numeric(20,0) NOT NULL,
    depe_codi numeric(3,0) NOT NULL,
    info_desc character varying(600),
    info_fech date NOT NULL,
    info_leido numeric(1,0) DEFAULT 0,
    usua_codi_info numeric(3,0),
    info_codi numeric(20,0),
    usua_doc character varying(14),
    info_resp character(10) DEFAULT 0
);


ALTER TABLE public.informados OWNER TO postgres;

--
-- Name: TABLE informados; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE informados IS 'registro de informados
';


--
-- Name: COLUMN informados.usua_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN informados.usua_codi IS 'Codigo de usuario';


--
-- Name: medio_recepcion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE medio_recepcion (
    mrec_codi numeric(2,0) NOT NULL,
    mrec_desc character varying(100) NOT NULL
);


ALTER TABLE public.medio_recepcion OWNER TO postgres;

--
-- Name: TABLE medio_recepcion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE medio_recepcion IS 'MEDIO_RECEPCION';


--
-- Name: COLUMN medio_recepcion.mrec_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN medio_recepcion.mrec_codi IS 'CODIGO DE MEDIO DE RECEPCION';


--
-- Name: COLUMN medio_recepcion.mrec_desc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN medio_recepcion.mrec_desc IS 'DESCRIPCION DEL MEDIO';


--
-- Name: municipio; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE municipio (
    muni_codi numeric(4,0) NOT NULL,
    dpto_codi numeric(2,0) NOT NULL,
    muni_nomb character varying(100) NOT NULL,
    id_cont numeric(2,0) DEFAULT 1,
    id_pais numeric(4,0) DEFAULT 170,
    homologa_muni character varying(10),
    homologa_idmuni numeric(4,0),
    activa numeric(1,0) DEFAULT 1
);


ALTER TABLE public.municipio OWNER TO postgres;

--
-- Name: TABLE municipio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE municipio IS 'MUNICIPIO';


--
-- Name: COLUMN municipio.muni_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN municipio.muni_codi IS 'MUNI_CODI';


--
-- Name: COLUMN municipio.dpto_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN municipio.dpto_codi IS 'DPTO_CODI';


--
-- Name: COLUMN municipio.muni_nomb; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN municipio.muni_nomb IS 'MUNI_NOMB';


--
-- Name: municipio2; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE municipio2 (
    muni_codi numeric(4,0) NOT NULL,
    dpto_codi numeric(4,0) NOT NULL,
    muni_nomb character varying(140) NOT NULL,
    id_cont numeric(2,0),
    id_pais numeric(4,0)
);


ALTER TABLE public.municipio2 OWNER TO postgres;

--
-- Name: TABLE municipio2; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE municipio2 IS 'MUNICIPIO';


--
-- Name: COLUMN municipio2.muni_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN municipio2.muni_codi IS 'MUNI_CODI';


--
-- Name: COLUMN municipio2.dpto_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN municipio2.dpto_codi IS 'DPTO_CODI';


--
-- Name: COLUMN municipio2.muni_nomb; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN municipio2.muni_nomb IS 'MUNI_NOMB';


--
-- Name: par_serv_servicios; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE par_serv_servicios (
    par_serv_secue numeric(8,0) NOT NULL,
    par_serv_codigo character varying(5),
    par_serv_nombre character varying(100),
    par_serv_estado character varying(1)
);


ALTER TABLE public.par_serv_servicios OWNER TO postgres;

--
-- Name: plan_table; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE plan_table (
    statement_id character varying(30),
    "timestamp" date,
    remarks character varying(80),
    operation character varying(30),
    options character varying(30),
    object_node character varying(128),
    object_owner character varying(30),
    object_name character varying(30),
    object_instance integer,
    object_type character varying(30),
    optimizer character varying(255),
    search_columns numeric,
    id integer,
    parent_id integer,
    "position" integer,
    cost integer,
    cardinality integer,
    s integer,
    other_tag character varying(255),
    partition_start character varying(255),
    partition_stop character varying(255),
    partition_id integer,
    other character varying(255),
    distribution character varying(30)
);


ALTER TABLE public.plan_table OWNER TO postgres;

--
-- Name: TABLE plan_table; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE plan_table IS 'tabla de adodb';


--
-- Name: plsql_profiler_runnumeric; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE plsql_profiler_runnumeric
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 99999999999999999
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.plsql_profiler_runnumeric OWNER TO postgres;

--
-- Name: pqr; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE pqr (
    radi_nume_radi text NOT NULL,
    visita integer,
    sgd_ciu_codigo numeric,
    informacion smallint,
    relacion1 smallint DEFAULT 0,
    instalaciones text,
    tramites text,
    autoridades text,
    comercio text,
    otros text,
    aerolinea text,
    vuelo text,
    origen text,
    destino text,
    hora text,
    motivo1 smallint,
    descripcion text,
    relacion2 smallint DEFAULT 0,
    relacion3 smallint DEFAULT 0,
    relacion4 smallint DEFAULT 0,
    relacion5 smallint DEFAULT 0,
    relacion6 smallint DEFAULT 0,
    motivo2 smallint DEFAULT 0,
    motivo3 smallint DEFAULT 0,
    motivo4 smallint DEFAULT 0,
    motivo5 smallint DEFAULT 0,
    motivo6 smallint DEFAULT 0,
    motivo7 smallint DEFAULT 0,
    fecha timestamp without time zone
);


ALTER TABLE public.pqr OWNER TO postgres;

--
-- Name: TABLE pqr; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE pqr IS 'tabla de las PQRS';


--
-- Name: pres_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pres_seq
    START WITH 30392
    INCREMENT BY 1
    MAXVALUE 99999999999999999
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.pres_seq OWNER TO postgres;

--
-- Name: prestamo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE prestamo (
    pres_id numeric(10,0) NOT NULL,
    radi_nume_radi numeric(15,0) NOT NULL,
    usua_login_actu character varying(15) NOT NULL,
    depe_codi numeric(5,0) NOT NULL,
    usua_login_pres character varying(15),
    pres_desc character varying(200),
    pres_fech_pres date,
    pres_fech_devo date,
    pres_fech_pedi date NOT NULL,
    pres_estado numeric(2,0),
    pres_requerimiento numeric(2,0),
    pres_depe_arch numeric(5,0),
    pres_fech_venc date,
    dev_desc character varying(500),
    pres_fech_canc date,
    usua_login_canc character varying(15),
    usua_login_rx character varying(15)
);


ALTER TABLE public.prestamo OWNER TO postgres;

--
-- Name: COLUMN prestamo.dev_desc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN prestamo.dev_desc IS 'Observaciones realizadas por el usuario que recibe la devolucion acerca de la cantidad, el estado, tipo o sucesos acontecidos con los documentos y anexos fisicos';


--
-- Name: COLUMN prestamo.pres_fech_canc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN prestamo.pres_fech_canc IS 'Fecha de cancelacion de la solicitud';


--
-- Name: COLUMN prestamo.usua_login_canc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN prestamo.usua_login_canc IS 'Login del usuario que cancela la solicitud';


--
-- Name: COLUMN prestamo.usua_login_rx; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN prestamo.usua_login_rx IS 'Login del usuario que recibe el documento al momento de entregar.';


--
-- Name: radicado; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE radicado (
    radi_nume_radi numeric(15,0) NOT NULL,
    radi_fech_radi timestamp with time zone NOT NULL,
    tdoc_codi numeric(4,0) NOT NULL,
    trte_codi numeric(2,0),
    mrec_codi numeric(2,0),
    eesp_codi numeric(10,0),
    eotra_codi numeric(10,0),
    radi_tipo_empr character varying(2),
    radi_fech_ofic date,
    tdid_codi numeric(2,0),
    radi_nume_iden character varying(15),
    radi_nomb character varying(90),
    radi_prim_apel character varying(50),
    radi_segu_apel character varying(50),
    radi_pais character varying(70),
    muni_codi numeric(5,0),
    cpob_codi numeric(4,0),
    carp_codi numeric(3,0) DEFAULT 2,
    esta_codi numeric(2,0),
    dpto_codi numeric(2,0),
    cen_muni_codi numeric(4,0),
    cen_dpto_codi numeric(2,0),
    radi_dire_corr character varying(100),
    radi_tele_cont numeric(15,0),
    radi_nume_hoja numeric(4,0),
    radi_desc_anex character varying(200),
    radi_nume_deri numeric(15,0),
    radi_path character varying(100),
    radi_usua_actu numeric(10,0),
    radi_depe_actu numeric(5,0),
    radi_fech_asig timestamp with time zone,
    radi_arch1 character varying(10),
    radi_arch2 character varying(10),
    radi_arch3 character varying(10),
    radi_arch4 character varying(100),
    ra_asun character varying(350),
    radi_usu_ante character varying(45),
    radi_depe_radi numeric(3,0),
    radi_rem character varying(60),
    radi_usua_radi numeric(10,0),
    codi_nivel numeric(2,0) DEFAULT 1,
    flag_nivel integer DEFAULT 1,
    carp_per numeric(1,0) DEFAULT 0,
    radi_leido numeric(1,0) DEFAULT 0,
    radi_cuentai character varying(30),
    radi_tipo_deri numeric(2,0) DEFAULT 0,
    listo character varying(2),
    sgd_tma_codigo numeric(4,0),
    sgd_mtd_codigo numeric(4,0),
    par_serv_secue numeric(8,0),
    sgd_fld_codigo numeric(3,0) DEFAULT 0,
    radi_agend numeric(1,0),
    radi_fech_agend timestamp with time zone,
    radi_fech_doc date,
    sgd_doc_secuencia numeric(15,0),
    sgd_pnufe_codi numeric(4,0),
    sgd_eanu_codigo numeric(1,0),
    sgd_not_codi numeric(3,0),
    radi_fech_notif timestamp with time zone,
    sgd_tdec_codigo numeric(4,0),
    sgd_apli_codi numeric(4,0),
    sgd_ttr_codigo integer DEFAULT 0,
    usua_doc_ante character varying(14),
    radi_fech_antetx timestamp with time zone,
    sgd_trad_codigo numeric(2,0),
    fech_vcmto timestamp with time zone,
    tdoc_vcmto numeric(4,0),
    sgd_termino_real numeric(4,0),
    id_cont numeric(2,0) DEFAULT 1,
    sgd_spub_codigo numeric(2,0) DEFAULT 0,
    id_pais numeric(2,0),
    medio_m character varying(5)
);


ALTER TABLE public.radicado OWNER TO postgres;

--
-- Name: COLUMN radicado.radi_nume_radi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.radi_nume_radi IS 'Numero de Radicado';


--
-- Name: COLUMN radicado.radi_fech_radi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.radi_fech_radi IS 'FECHA DE RADICACION';


--
-- Name: COLUMN radicado.tdoc_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.tdoc_codi IS 'Tipo de Documento, (ej. Res, derecho pet, tutela, etc .. . . . .)';


--
-- Name: COLUMN radicado.trte_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.trte_codi IS 'TRTE_CODI';


--
-- Name: COLUMN radicado.mrec_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.mrec_codi IS 'MREC_CODI';


--
-- Name: COLUMN radicado.eesp_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.eesp_codi IS 'EESP_CODI';


--
-- Name: COLUMN radicado.eotra_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.eotra_codi IS 'EOTRA_CODI';


--
-- Name: COLUMN radicado.radi_tipo_empr; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.radi_tipo_empr IS 'TIPO DE EMPRESA (OTRA O ESP)';


--
-- Name: COLUMN radicado.radi_fech_ofic; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.radi_fech_ofic IS 'FECHA DE OFICIO';


--
-- Name: COLUMN radicado.tdid_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.tdid_codi IS 'TDID_CODI';


--
-- Name: COLUMN radicado.radi_nume_iden; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.radi_nume_iden IS 'NUMERO DE IDENTIFICACION';


--
-- Name: COLUMN radicado.radi_nomb; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.radi_nomb IS 'NOMBRE';


--
-- Name: COLUMN radicado.radi_prim_apel; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.radi_prim_apel IS '1 APELLIDO';


--
-- Name: COLUMN radicado.radi_segu_apel; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.radi_segu_apel IS '2 APELLIDO';


--
-- Name: COLUMN radicado.radi_pais; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.radi_pais IS 'PAIS (DEFAULT COLOMBIA)';


--
-- Name: COLUMN radicado.muni_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.muni_codi IS 'MUNI_CODI';


--
-- Name: COLUMN radicado.cpob_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.cpob_codi IS 'CPOB_CODI';


--
-- Name: COLUMN radicado.carp_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.carp_codi IS 'CARP_CODI';


--
-- Name: COLUMN radicado.esta_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.esta_codi IS 'ESTA_CODI';


--
-- Name: COLUMN radicado.dpto_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.dpto_codi IS 'DPTO_CODI';


--
-- Name: COLUMN radicado.cen_muni_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.cen_muni_codi IS 'CEN_MUNI_CODI';


--
-- Name: COLUMN radicado.cen_dpto_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.cen_dpto_codi IS 'CEN_DPTO_CODI';


--
-- Name: COLUMN radicado.radi_dire_corr; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.radi_dire_corr IS 'DIRECCION CORRESPONDENCIA';


--
-- Name: COLUMN radicado.radi_tele_cont; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.radi_tele_cont IS 'TELEFONO CONTACTO';


--
-- Name: COLUMN radicado.radi_nume_hoja; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.radi_nume_hoja IS 'NUMERO DE HOJAS';


--
-- Name: COLUMN radicado.radi_desc_anex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.radi_desc_anex IS 'DESCRIPCION DE ANEXOS';


--
-- Name: COLUMN radicado.radi_nume_deri; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.radi_nume_deri IS 'NUMERO DERIVADO';


--
-- Name: COLUMN radicado.radi_path; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.radi_path IS 'RADI_PATH';


--
-- Name: COLUMN radicado.radi_usua_actu; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.radi_usua_actu IS 'USUARIO ACTUAL';


--
-- Name: COLUMN radicado.radi_depe_actu; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.radi_depe_actu IS 'DEPENDENCIA ACTUAL (USUARIO)';


--
-- Name: COLUMN radicado.radi_fech_asig; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.radi_fech_asig IS 'FECHA DE ASIGNACION DEL USUARIO';


--
-- Name: COLUMN radicado.radi_arch1; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.radi_arch1 IS 'CAMPO PARA ARCHIVO FISICO';


--
-- Name: COLUMN radicado.radi_arch2; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.radi_arch2 IS 'CAMPO PARA ARCHIVO FISICO';


--
-- Name: COLUMN radicado.radi_arch3; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.radi_arch3 IS 'CAMPO PARA ARCHIVO FISICO';


--
-- Name: COLUMN radicado.radi_arch4; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.radi_arch4 IS 'CAMPO PARA ARCHIVO FISICO';


--
-- Name: COLUMN radicado.usua_doc_ante; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.usua_doc_ante IS 'Codigo TTR. transaccion.';


--
-- Name: COLUMN radicado.radi_fech_antetx; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.radi_fech_antetx IS 'Documento del usuario que realizo la anterior tx';


--
-- Name: COLUMN radicado.sgd_trad_codigo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN radicado.sgd_trad_codigo IS 'Fecha de la Ultima transaccion.';


--
-- Name: rad1000; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW rad1000 AS
    SELECT radicado.radi_nume_radi, radicado.radi_fech_radi FROM radicado WHERE (((((((((radicado.radi_nume_radi = ((1995000001142::bigint - 5))::numeric) OR (radicado.radi_nume_radi = ((1995000001281::bigint - 5))::numeric)) OR (radicado.radi_nume_radi = ((1995000001387::bigint - 5))::numeric)) OR (radicado.radi_nume_radi = ((1996000000015::bigint - 5))::numeric)) OR (radicado.radi_nume_radi = ((1996000000374::bigint - 5))::numeric)) OR (radicado.radi_nume_radi = ((1996000000390::bigint - 5))::numeric)) OR (radicado.radi_nume_radi = ((1996000000526::bigint - 5))::numeric)) OR (radicado.radi_nume_radi = ((1996000000647::bigint - 5))::numeric)) OR (radicado.radi_nume_radi = ((1996000000717::bigint - 5))::numeric));


ALTER TABLE public.rad1000 OWNER TO postgres;

--
-- Name: rta_compartida; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE rta_compartida (
    radi_nume_radi numeric(15,0) NOT NULL,
    usua_codi numeric(20,0) NOT NULL,
    depe_codi numeric(3,0) NOT NULL,
    rta_desc character varying(600),
    rta_fech date NOT NULL,
    rta_leido numeric(1,0) DEFAULT 0,
    usua_codi_info numeric(3,0),
    rta_codi numeric(20,0),
    usua_doc character varying(14),
    rta_resp character(10) DEFAULT 0
);


ALTER TABLE public.rta_compartida OWNER TO postgres;

--
-- Name: TABLE rta_compartida; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE rta_compartida IS 'registro de informados
';


--
-- Name: COLUMN rta_compartida.usua_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN rta_compartida.usua_codi IS 'Codigo de usuario';


--
-- Name: sec_bodega_empresas; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sec_bodega_empresas
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sec_bodega_empresas OWNER TO postgres;

--
-- Name: sec_central; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sec_central
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sec_central OWNER TO postgres;

--
-- Name: sec_ciu_ciudadano; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sec_ciu_ciudadano
    INCREMENT BY 1
    MAXVALUE 99999999999999999
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.sec_ciu_ciudadano OWNER TO postgres;

--
-- Name: sec_def_contactos; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sec_def_contactos
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sec_def_contactos OWNER TO postgres;

--
-- Name: sec_dir_direcciones; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sec_dir_direcciones
    INCREMENT BY 1
    MAXVALUE 99999999999999999
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.sec_dir_direcciones OWNER TO postgres;

--
-- Name: sec_edificio; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sec_edificio
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sec_edificio OWNER TO postgres;

--
-- Name: sec_inv; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sec_inv
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sec_inv OWNER TO postgres;

--
-- Name: sec_oem_oempresas; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sec_oem_oempresas
    INCREMENT BY 1
    MAXVALUE 99999999999999999
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.sec_oem_oempresas OWNER TO postgres;

--
-- Name: sec_prestamo; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sec_prestamo
    INCREMENT BY 1
    MAXVALUE 99999999999999999
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sec_prestamo OWNER TO postgres;

--
-- Name: sec_sgd_hfld_histflujodoc; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sec_sgd_hfld_histflujodoc
    START WITH 22298
    INCREMENT BY 1
    MAXVALUE 99999999999999999
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sec_sgd_hfld_histflujodoc OWNER TO postgres;

--
-- Name: secr_tp1_; Type: SEQUENCE; Schema: public; Owner: orfeo
--

CREATE SEQUENCE secr_tp1_
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.secr_tp1_ OWNER TO orfeo;

--
-- Name: secr_tp1_100; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE secr_tp1_100
    INCREMENT BY 1
    MAXVALUE 99999
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.secr_tp1_100 OWNER TO postgres;

--
-- Name: secr_tp1_900; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE secr_tp1_900
    INCREMENT BY 1
    MAXVALUE 99999
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.secr_tp1_900 OWNER TO postgres;

--
-- Name: secr_tp2_100; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE secr_tp2_100
    INCREMENT BY 1
    MAXVALUE 99999
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.secr_tp2_100 OWNER TO postgres;

--
-- Name: secr_tp2_240; Type: SEQUENCE; Schema: public; Owner: orfeo
--

CREATE SEQUENCE secr_tp2_240
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.secr_tp2_240 OWNER TO orfeo;

--
-- Name: secr_tp2_900; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE secr_tp2_900
    INCREMENT BY 1
    MAXVALUE 99999
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.secr_tp2_900 OWNER TO postgres;

--
-- Name: secr_tp3_100; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE secr_tp3_100
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 99999999999999999
    MINVALUE 0
    CACHE 1;


ALTER TABLE public.secr_tp3_100 OWNER TO postgres;

--
-- Name: secr_tp3_900; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE secr_tp3_900
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.secr_tp3_900 OWNER TO postgres;

--
-- Name: secr_tp8_; Type: SEQUENCE; Schema: public; Owner: orfeo
--

CREATE SEQUENCE secr_tp8_
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.secr_tp8_ OWNER TO orfeo;

--
-- Name: secr_tp8_100; Type: SEQUENCE; Schema: public; Owner: orfeo
--

CREATE SEQUENCE secr_tp8_100
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.secr_tp8_100 OWNER TO orfeo;

--
-- Name: secr_tp8_110; Type: SEQUENCE; Schema: public; Owner: orfeo
--

CREATE SEQUENCE secr_tp8_110
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.secr_tp8_110 OWNER TO orfeo;

--
-- Name: secr_tp8_900; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE secr_tp8_900
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.secr_tp8_900 OWNER TO postgres;

--
-- Name: series; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE series (
    depe_codi numeric(5,0) NOT NULL,
    seri_nume numeric(7,0) NOT NULL,
    seri_tipo numeric(2,0),
    seri_ano numeric(4,0),
    dpto_codi numeric(2,0) NOT NULL,
    bloq character varying(20)
);


ALTER TABLE public.series OWNER TO postgres;

--
-- Name: TABLE series; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE series IS 'SERIES';


--
-- Name: COLUMN series.depe_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN series.depe_codi IS 'CODIGO SERIE DEPENDENCIA';


--
-- Name: COLUMN series.seri_nume; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN series.seri_nume IS 'NUMERO DE SERIE PARA DEPENDENCIA';


--
-- Name: sgd_acm_acusemsg; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_acm_acusemsg (
    sgd_msg_codi numeric(15,0) NOT NULL,
    usua_doc character varying(14),
    sgd_msg_leido numeric(3,0)
);


ALTER TABLE public.sgd_acm_acusemsg OWNER TO postgres;

--
-- Name: sgd_actadd_actualiadicional; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_actadd_actualiadicional (
    sgd_actadd_codi numeric(4,0),
    sgd_apli_codi numeric(4,0),
    sgd_instorf_codi numeric(4,0),
    sgd_actadd_query character varying(500),
    sgd_actadd_desc character varying(150)
);


ALTER TABLE public.sgd_actadd_actualiadicional OWNER TO postgres;

--
-- Name: sgd_agen_agendados; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_agen_agendados (
    sgd_agen_fech date,
    sgd_agen_observacion character varying(4000),
    radi_nume_radi numeric(15,0) NOT NULL,
    usua_doc character varying(18) NOT NULL,
    depe_codi character varying(3),
    sgd_agen_codigo numeric,
    sgd_agen_fechplazo date,
    sgd_agen_activo numeric
);


ALTER TABLE public.sgd_agen_agendados OWNER TO postgres;

--
-- Name: sgd_anar_anexarg; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_anar_anexarg (
    sgd_anar_codi numeric(4,0) NOT NULL,
    anex_codigo character varying(20),
    sgd_argd_codi numeric(4,0),
    sgd_anar_argcod numeric(4,0)
);


ALTER TABLE public.sgd_anar_anexarg OWNER TO postgres;

--
-- Name: TABLE sgd_anar_anexarg; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sgd_anar_anexarg IS 'Indica los argumentos o criterios a incluir dentro de un tipo de documento generado';


--
-- Name: COLUMN sgd_anar_anexarg.sgd_anar_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_anar_anexarg.sgd_anar_codi IS 'id del registro';


--
-- Name: COLUMN sgd_anar_anexarg.anex_codigo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_anar_anexarg.anex_codigo IS 'codigo del anexo';


--
-- Name: COLUMN sgd_anar_anexarg.sgd_argd_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_anar_anexarg.sgd_argd_codi IS 'codigo del argumento empleado';


--
-- Name: COLUMN sgd_anar_anexarg.sgd_anar_argcod; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_anar_anexarg.sgd_anar_argcod IS 'valor del campo llave, de tabla que contiene el argumento referenciado';


--
-- Name: sgd_anar_secue; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sgd_anar_secue
    START WITH 529
    INCREMENT BY 1
    MAXVALUE 99999999999999999
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sgd_anar_secue OWNER TO postgres;

--
-- Name: sgd_anu_anulados; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_anu_anulados (
    sgd_anu_id numeric(4,0),
    sgd_anu_desc character varying(250),
    radi_nume_radi numeric,
    sgd_eanu_codi numeric(4,0),
    sgd_anu_sol_fech date,
    sgd_anu_fech date,
    depe_codi numeric(3,0),
    usua_doc character varying(14),
    usua_codi numeric(4,0),
    depe_codi_anu numeric(3,0),
    usua_doc_anu character varying(14),
    usua_codi_anu numeric(4,0),
    usua_anu_acta numeric(8,0),
    sgd_anu_path_acta character varying(200),
    sgd_trad_codigo numeric(2,0)
);


ALTER TABLE public.sgd_anu_anulados OWNER TO postgres;

--
-- Name: sgd_aplfad_plicfunadi; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_aplfad_plicfunadi (
    sgd_aplfad_codi numeric(4,0),
    sgd_apli_codi numeric(4,0),
    sgd_aplfad_menu character varying(150) NOT NULL,
    sgd_aplfad_lk1 character varying(150) NOT NULL,
    sgd_aplfad_desc character varying(150) NOT NULL
);


ALTER TABLE public.sgd_aplfad_plicfunadi OWNER TO postgres;

--
-- Name: sgd_apli_aplintegra; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_apli_aplintegra (
    sgd_apli_codi numeric(4,0),
    sgd_apli_descrip character varying(150),
    sgd_apli_lk1desc character varying(150),
    sgd_apli_lk1 character varying(150),
    sgd_apli_lk2desc character varying(150),
    sgd_apli_lk2 character varying(150),
    sgd_apli_lk3desc character varying(150),
    sgd_apli_lk3 character varying(150),
    sgd_apli_lk4desc character varying(150),
    sgd_apli_lk4 character varying(150)
);


ALTER TABLE public.sgd_apli_aplintegra OWNER TO postgres;

--
-- Name: sgd_aplmen_aplimens; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_aplmen_aplimens (
    sgd_aplmen_codi numeric(4,0),
    sgd_apli_codi numeric(4,0),
    sgd_aplmen_ref character varying(20),
    sgd_aplmen_haciaorfeo numeric(4,0),
    sgd_aplmen_desdeorfeo numeric(4,0)
);


ALTER TABLE public.sgd_aplmen_aplimens OWNER TO postgres;

--
-- Name: sgd_aplus_plicusua; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_aplus_plicusua (
    sgd_aplus_codi numeric(4,0),
    sgd_apli_codi numeric(4,0),
    usua_doc character varying(14),
    sgd_trad_codigo numeric(2,0),
    sgd_aplus_prioridad numeric(1,0)
);


ALTER TABLE public.sgd_aplus_plicusua OWNER TO postgres;

--
-- Name: sgd_archivo_central; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_archivo_central (
    sgd_archivo_id numeric NOT NULL,
    sgd_archivo_tipo numeric,
    sgd_archivo_orden character varying(15),
    sgd_archivo_fechai timestamp with time zone,
    sgd_archivo_demandado character varying(1500),
    sgd_archivo_demandante character varying(200),
    sgd_archivo_cc_demandante numeric,
    sgd_archivo_depe character varying(5),
    sgd_archivo_zona character varying(4),
    sgd_archivo_carro numeric,
    sgd_archivo_cara character varying(4),
    sgd_archivo_estante numeric,
    sgd_archivo_entrepano numeric,
    sgd_archivo_caja numeric,
    sgd_archivo_unidocu character varying(40),
    sgd_archivo_anexo character varying(4000),
    sgd_archivo_inder numeric DEFAULT 0,
    sgd_archivo_path character varying(4000),
    sgd_archivo_year numeric(4,0),
    sgd_archivo_rad character varying(15) NOT NULL,
    sgd_archivo_srd numeric,
    sgd_archivo_sbrd numeric,
    sgd_archivo_folios numeric,
    sgd_archivo_mata numeric DEFAULT 0,
    sgd_archivo_fechaf timestamp with time zone,
    sgd_archivo_prestamo numeric(1,0),
    sgd_archivo_funprest character(100),
    sgd_archivo_fechprest timestamp with time zone,
    sgd_archivo_fechprestf timestamp with time zone,
    depe_codi character varying(5),
    sgd_archivo_usua character varying(15),
    sgd_archivo_fech timestamp with time zone
);


ALTER TABLE public.sgd_archivo_central OWNER TO postgres;

--
-- Name: sgd_archivo_hist; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_archivo_hist (
    depe_codi numeric(5,0) NOT NULL,
    hist_fech timestamp with time zone NOT NULL,
    usua_codi numeric(10,0) NOT NULL,
    sgd_archivo_rad character varying(14),
    hist_obse character varying(600) NOT NULL,
    usua_doc character varying(14),
    sgd_ttr_codigo numeric(3,0),
    hist_id numeric
);


ALTER TABLE public.sgd_archivo_hist OWNER TO postgres;

--
-- Name: sgd_arg_pliego; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_arg_pliego (
    sgd_arg_codigo numeric(2,0) NOT NULL,
    sgd_arg_desc character varying(150) NOT NULL
);


ALTER TABLE public.sgd_arg_pliego OWNER TO postgres;

--
-- Name: sgd_argd_argdoc; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_argd_argdoc (
    sgd_argd_codi numeric(4,0) NOT NULL,
    sgd_pnufe_codi numeric(4,0),
    sgd_argd_tabla character varying(100),
    sgd_argd_tcodi character varying(100),
    sgd_argd_tdes character varying(100),
    sgd_argd_llist character varying(150),
    sgd_argd_campo character varying(100)
);


ALTER TABLE public.sgd_argd_argdoc OWNER TO postgres;

--
-- Name: TABLE sgd_argd_argdoc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sgd_argd_argdoc IS 'Define los argumentos que ha de incluir un tipo de documento';


--
-- Name: COLUMN sgd_argd_argdoc.sgd_argd_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_argd_argdoc.sgd_argd_codi IS 'Id del registro';


--
-- Name: COLUMN sgd_argd_argdoc.sgd_pnufe_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_argd_argdoc.sgd_pnufe_codi IS 'Codigo del proceso';


--
-- Name: COLUMN sgd_argd_argdoc.sgd_argd_tabla; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_argd_argdoc.sgd_argd_tabla IS 'Nombre de la tabla tabla a la que hace refencia el argumento';


--
-- Name: COLUMN sgd_argd_argdoc.sgd_argd_tcodi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_argd_argdoc.sgd_argd_tcodi IS 'Nombre del campo llave de la tabla referenciada';


--
-- Name: COLUMN sgd_argd_argdoc.sgd_argd_tdes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_argd_argdoc.sgd_argd_tdes IS 'Nombre del campo descripcion de la tabla referenciada';


--
-- Name: COLUMN sgd_argd_argdoc.sgd_argd_llist; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_argd_argdoc.sgd_argd_llist IS 'Texto del label descriptor  que ha  de aparecen de forma dinamica en la pagina web';


--
-- Name: COLUMN sgd_argd_argdoc.sgd_argd_campo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_argd_argdoc.sgd_argd_campo IS 'Etiqueta que ha de incluirse en el documento para referenciar este campo';


--
-- Name: sgd_camexp_campoexpediente; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_camexp_campoexpediente (
    sgd_camexp_codigo numeric(4,0) NOT NULL,
    sgd_camexp_campo character varying(30) NOT NULL,
    sgd_parexp_codigo numeric(4,0) NOT NULL,
    sgd_camexp_fk numeric DEFAULT 0,
    sgd_camexp_tablafk character varying(30),
    sgd_camexp_campofk character varying(30),
    sgd_camexp_campovalor character varying(30),
    sgd_camexp_orden numeric(1,0)
);


ALTER TABLE public.sgd_camexp_campoexpediente OWNER TO postgres;

--
-- Name: sgd_carp_descripcion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_carp_descripcion (
    sgd_carp_depecodi numeric(5,0) NOT NULL,
    sgd_carp_tiporad numeric(2,0) NOT NULL,
    sgd_carp_descr character varying(40)
);


ALTER TABLE public.sgd_carp_descripcion OWNER TO postgres;

--
-- Name: sgd_cau_causal; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_cau_causal (
    sgd_cau_codigo numeric(4,0) NOT NULL,
    sgd_cau_descrip character varying(150)
);


ALTER TABLE public.sgd_cau_causal OWNER TO postgres;

--
-- Name: sgd_caux_causales; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_caux_causales (
    sgd_caux_codigo numeric(10,0) NOT NULL,
    radi_nume_radi numeric(15,0),
    sgd_dcau_codigo numeric(4,0),
    sgd_ddca_codigo numeric(4,0),
    sgd_caux_fecha date,
    usua_doc character varying(14)
);


ALTER TABLE public.sgd_caux_causales OWNER TO postgres;

--
-- Name: sgd_ciu_ciudadano; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_ciu_ciudadano (
    tdid_codi numeric(2,0),
    sgd_ciu_codigo numeric(8,0) NOT NULL,
    sgd_ciu_nombre character varying(150),
    sgd_ciu_direccion character varying(150),
    sgd_ciu_apell1 character varying(50),
    sgd_ciu_apell2 character varying(50),
    sgd_ciu_telefono character varying(50),
    sgd_ciu_email character varying(50),
    muni_codi numeric(4,0),
    dpto_codi numeric(2,0),
    sgd_ciu_cedula character varying(13),
    id_cont numeric(2,0) DEFAULT 1,
    id_pais numeric(4,0) DEFAULT 170
);


ALTER TABLE public.sgd_ciu_ciudadano OWNER TO postgres;

--
-- Name: sgd_ciu_secue; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sgd_ciu_secue
    START WITH 16262
    INCREMENT BY 1
    MAXVALUE 99999999
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sgd_ciu_secue OWNER TO postgres;

--
-- Name: sgd_clta_clstarif; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_clta_clstarif (
    sgd_fenv_codigo numeric(5,0),
    sgd_clta_codser numeric(5,0),
    sgd_tar_codigo numeric(5,0),
    sgd_clta_descrip character varying(100),
    sgd_clta_pesdes numeric(15,0),
    sgd_clta_peshast numeric(15,0)
);


ALTER TABLE public.sgd_clta_clstarif OWNER TO postgres;

--
-- Name: sgd_cob_campobliga; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_cob_campobliga (
    sgd_cob_codi numeric(4,0) NOT NULL,
    sgd_cob_desc character varying(150),
    sgd_cob_label character varying(50),
    sgd_tidm_codi numeric(4,0)
);


ALTER TABLE public.sgd_cob_campobliga OWNER TO postgres;

--
-- Name: TABLE sgd_cob_campobliga; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sgd_cob_campobliga IS 'Indica los campos obligatorios que hacen parte de un tipo de documento de correspondencia masiva';


--
-- Name: COLUMN sgd_cob_campobliga.sgd_cob_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_cob_campobliga.sgd_cob_codi IS 'ID del registro';


--
-- Name: COLUMN sgd_cob_campobliga.sgd_cob_desc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_cob_campobliga.sgd_cob_desc IS 'Descripcion';


--
-- Name: COLUMN sgd_cob_campobliga.sgd_cob_label; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_cob_campobliga.sgd_cob_label IS 'Rotulo del campo a incluir dentro del documento';


--
-- Name: COLUMN sgd_cob_campobliga.sgd_tidm_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_cob_campobliga.sgd_tidm_codi IS 'Codigo del documento';


--
-- Name: sgd_dcau_causal; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_dcau_causal (
    sgd_dcau_codigo numeric(4,0) NOT NULL,
    sgd_cau_codigo numeric(4,0),
    sgd_dcau_descrip character varying(150)
);


ALTER TABLE public.sgd_dcau_causal OWNER TO postgres;

--
-- Name: sgd_ddca_ddsgrgdo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_ddca_ddsgrgdo (
    sgd_ddca_codigo numeric(4,0) NOT NULL,
    sgd_dcau_codigo numeric(4,0),
    par_serv_secue numeric(8,0),
    sgd_ddca_descrip character varying(150)
);


ALTER TABLE public.sgd_ddca_ddsgrgdo OWNER TO postgres;

--
-- Name: sgd_def_contactos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_def_contactos (
    ctt_id numeric(15,0) NOT NULL,
    ctt_nombre character varying(60) NOT NULL,
    ctt_cargo character varying(60) NOT NULL,
    ctt_telefono character varying(25),
    ctt_id_tipo numeric(4,0) NOT NULL,
    ctt_id_empresa numeric(15,0) NOT NULL
);


ALTER TABLE public.sgd_def_contactos OWNER TO postgres;

--
-- Name: sgd_def_continentes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_def_continentes (
    id_cont numeric(2,0),
    nombre_cont character varying(20) NOT NULL
);


ALTER TABLE public.sgd_def_continentes OWNER TO postgres;

--
-- Name: sgd_def_paises; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_def_paises (
    id_pais numeric(4,0),
    id_cont numeric(2,0) DEFAULT 1 NOT NULL,
    nombre_pais character varying(100) NOT NULL
);


ALTER TABLE public.sgd_def_paises OWNER TO postgres;

--
-- Name: sgd_def_paises2; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_def_paises2 (
    id_pais numeric(4,0),
    id_cont numeric(2,0) DEFAULT 1 NOT NULL,
    nombre_pais character varying(100) NOT NULL
);


ALTER TABLE public.sgd_def_paises2 OWNER TO postgres;

--
-- Name: TABLE sgd_def_paises2; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sgd_def_paises2 IS 'paises pqr';


--
-- Name: sgd_deve_dev_envio; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_deve_dev_envio (
    sgd_deve_codigo numeric(2,0) NOT NULL,
    sgd_deve_desc character varying(150) NOT NULL
);


ALTER TABLE public.sgd_deve_dev_envio OWNER TO postgres;

--
-- Name: sgd_dir_drecciones; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_dir_drecciones (
    sgd_dir_codigo numeric(10,0) NOT NULL,
    sgd_dir_tipo numeric(4,0) NOT NULL,
    sgd_oem_codigo numeric(8,0),
    sgd_ciu_codigo numeric(8,0),
    radi_nume_radi numeric(15,0),
    sgd_esp_codi numeric(5,0),
    muni_codi numeric(4,0),
    dpto_codi numeric(2,0),
    sgd_dir_direccion character varying(150),
    sgd_dir_telefono character varying(50),
    sgd_dir_mail character varying(50),
    sgd_sec_codigo numeric(13,0),
    sgd_temporal_nombre character varying(150),
    anex_codigo numeric(20,0),
    sgd_anex_codigo character varying(20),
    sgd_dir_nombre character varying(150),
    sgd_doc_fun character varying(14),
    sgd_dir_nomremdes character varying(1000),
    sgd_trd_codigo numeric(1,0),
    sgd_dir_tdoc numeric(1,0),
    sgd_dir_doc character varying(14),
    id_pais numeric(4,0) DEFAULT 170,
    id_cont numeric(2,0) DEFAULT 1
);


ALTER TABLE public.sgd_dir_drecciones OWNER TO postgres;

--
-- Name: COLUMN sgd_dir_drecciones.sgd_dir_nomremdes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_dir_drecciones.sgd_dir_nomremdes IS 'NOMBRE DE REMITENTE O DESTINATARIO';


--
-- Name: COLUMN sgd_dir_drecciones.sgd_trd_codigo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_dir_drecciones.sgd_trd_codigo IS 'TIPO DE REMITENTE/DESTINATARIO (1 Ciudadanao, 2 OtrasEmpresas, 3 Esp, 4 Funcionario)';


--
-- Name: COLUMN sgd_dir_drecciones.sgd_dir_tdoc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_dir_drecciones.sgd_dir_tdoc IS 'NUMERO DE DOCUMENTO';


--
-- Name: sgd_dir_secue; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sgd_dir_secue
    INCREMENT BY 1
    MAXVALUE 99999999
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sgd_dir_secue OWNER TO postgres;

--
-- Name: sgd_dnufe_docnufe; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_dnufe_docnufe (
    sgd_dnufe_codi numeric(4,0) NOT NULL,
    sgd_pnufe_codi numeric(4,0),
    sgd_tpr_codigo numeric(4,0),
    sgd_dnufe_label character varying(150),
    trte_codi numeric(2,0),
    sgd_dnufe_main character varying(1),
    sgd_dnufe_path character varying(150),
    sgd_dnufe_gerarq character varying(10),
    anex_tipo_codi numeric(4,0)
);


ALTER TABLE public.sgd_dnufe_docnufe OWNER TO postgres;

--
-- Name: TABLE sgd_dnufe_docnufe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sgd_dnufe_docnufe IS 'Indica los documentos que componen un proceso de numeracion y fechado';


--
-- Name: COLUMN sgd_dnufe_docnufe.sgd_dnufe_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_dnufe_docnufe.sgd_dnufe_codi IS 'Id del registro';


--
-- Name: COLUMN sgd_dnufe_docnufe.sgd_pnufe_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_dnufe_docnufe.sgd_pnufe_codi IS 'codigo del proceso';


--
-- Name: COLUMN sgd_dnufe_docnufe.sgd_tpr_codigo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_dnufe_docnufe.sgd_tpr_codigo IS 'codigo del documento que hace parte de un proceso de numeracion y fechado';


--
-- Name: COLUMN sgd_dnufe_docnufe.sgd_dnufe_label; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_dnufe_docnufe.sgd_dnufe_label IS 'label del documento que ha de usarse en la interfaz de gestion de procesos de numeracion y fechado';


--
-- Name: COLUMN sgd_dnufe_docnufe.trte_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_dnufe_docnufe.trte_codi IS 'indica el tipo de remitente para quien va dirigida la comunicacion';


--
-- Name: COLUMN sgd_dnufe_docnufe.sgd_dnufe_main; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_dnufe_docnufe.sgd_dnufe_main IS 'Indica si el registro es el documento principal del paquete';


--
-- Name: sgd_eanu_estanulacion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_eanu_estanulacion (
    sgd_eanu_desc character varying(150),
    sgd_eanu_codi numeric
);


ALTER TABLE public.sgd_eanu_estanulacion OWNER TO postgres;

--
-- Name: sgd_einv_inventario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_einv_inventario (
    sgd_einv_codigo numeric NOT NULL,
    sgd_depe_nomb character varying(400),
    sgd_depe_codi character varying(3),
    sgd_einv_expnum character varying(18),
    sgd_einv_titulo character varying(400),
    sgd_einv_unidad numeric,
    sgd_einv_fech date,
    sgd_einv_fechfin date,
    sgd_einv_radicados character varying(40),
    sgd_einv_folios numeric,
    sgd_einv_nundocu numeric,
    sgd_einv_nundocubodega numeric,
    sgd_einv_caja numeric,
    sgd_einv_cajabodega numeric,
    sgd_einv_srd numeric,
    sgd_einv_nomsrd character varying(400),
    sgd_einv_sbrd numeric,
    sgd_einv_nomsbrd character varying(400),
    sgd_einv_retencion character varying(400),
    sgd_einv_disfinal character varying(400),
    sgd_einv_ubicacion character varying(400),
    sgd_einv_observacion character varying(400)
);


ALTER TABLE public.sgd_einv_inventario OWNER TO postgres;

--
-- Name: sgd_eit_items; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_eit_items (
    sgd_eit_codigo numeric NOT NULL,
    sgd_eit_cod_padre numeric DEFAULT 0,
    sgd_eit_nombre character varying(40),
    sgd_eit_sigla character varying(6),
    codi_dpto numeric(4,0),
    codi_muni numeric(5,0)
);


ALTER TABLE public.sgd_eit_items OWNER TO postgres;

--
-- Name: sgd_enve_envioespecial; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_enve_envioespecial (
    sgd_fenv_codigo numeric(4,0),
    sgd_enve_valorl character varying(30),
    sgd_enve_valorn character varying(30),
    sgd_enve_desc character varying(30)
);


ALTER TABLE public.sgd_enve_envioespecial OWNER TO postgres;

--
-- Name: COLUMN sgd_enve_envioespecial.sgd_fenv_codigo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_enve_envioespecial.sgd_fenv_codigo IS 'Codigo Empresa de envio';


--
-- Name: COLUMN sgd_enve_envioespecial.sgd_enve_valorl; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_enve_envioespecial.sgd_enve_valorl IS 'Valor Campo Local';


--
-- Name: COLUMN sgd_enve_envioespecial.sgd_enve_valorn; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_enve_envioespecial.sgd_enve_valorn IS 'Valor Campo Nacional';


--
-- Name: COLUMN sgd_enve_envioespecial.sgd_enve_desc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_enve_envioespecial.sgd_enve_desc IS 'Descripcion Valor';


--
-- Name: tipo_doc_identificacion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipo_doc_identificacion (
    tdid_codi numeric(2,0) NOT NULL,
    tdid_desc character varying(100) NOT NULL
);


ALTER TABLE public.tipo_doc_identificacion OWNER TO postgres;

--
-- Name: TABLE tipo_doc_identificacion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE tipo_doc_identificacion IS 'TIPO_DOC_IDENTIFICACION';


--
-- Name: COLUMN tipo_doc_identificacion.tdid_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN tipo_doc_identificacion.tdid_codi IS 'CODIGO DEL TIPO DE DOCUMENTO DE IDENTIFICACION';


--
-- Name: COLUMN tipo_doc_identificacion.tdid_desc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN tipo_doc_identificacion.tdid_desc IS 'DESCIPCION DEL TIPO DE DOCUMENTO DE IDENTIFICACION';


--
-- Name: tipo_remitente; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipo_remitente (
    trte_codi numeric(2,0) NOT NULL,
    trte_desc character varying(100) NOT NULL
);


ALTER TABLE public.tipo_remitente OWNER TO postgres;

--
-- Name: TABLE tipo_remitente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE tipo_remitente IS 'TIPO_REMITENTE';


--
-- Name: COLUMN tipo_remitente.trte_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN tipo_remitente.trte_codi IS 'CODIGO TIPO DE REMITENTE';


--
-- Name: COLUMN tipo_remitente.trte_desc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN tipo_remitente.trte_desc IS 'DESC DEL TIPO DE REMITENTE';


--
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuario (
    usua_codi numeric(10,0) NOT NULL,
    depe_codi numeric(5,0) NOT NULL,
    usua_login character varying(15) NOT NULL,
    usua_fech_crea date NOT NULL,
    usua_pasw character varying(35) NOT NULL,
    usua_esta character varying(10) NOT NULL,
    usua_nomb character varying(45),
    perm_radi character(1) DEFAULT 0,
    usua_admin character(1) DEFAULT 0,
    usua_nuevo character(1) DEFAULT 0,
    usua_doc character varying(14) DEFAULT 0,
    codi_nivel numeric(2,0) DEFAULT 1,
    usua_sesion character varying(30),
    usua_fech_sesion date,
    usua_ext numeric(4,0),
    usua_nacim date,
    usua_email character varying(50),
    usua_at character varying(15),
    usua_piso numeric(2,0),
    perm_radi_sal numeric DEFAULT 0,
    usua_admin_archivo numeric(1,0) DEFAULT 0,
    usua_masiva numeric(1,0) DEFAULT 0,
    usua_perm_dev numeric(1,0) DEFAULT 0,
    usua_perm_numera_res character varying(1),
    usua_doc_suip character varying(15),
    usua_perm_numeradoc numeric(1,0),
    sgd_panu_codi numeric(4,0),
    usua_prad_tp1 numeric(1,0) DEFAULT 0,
    usua_prad_tp2 numeric(1,0) DEFAULT 0,
    usua_prad_tp3 numeric(1,0) DEFAULT 0,
    usua_prad_tp4 numeric(1,0) DEFAULT 0,
    usua_prad_tp5 numeric(1,0) DEFAULT 0,
    usua_perm_envios numeric(1,0) DEFAULT 0,
    usua_perm_modifica numeric(1,0) DEFAULT 0,
    usua_perm_impresion numeric(1,0) DEFAULT 0,
    usua_prad_tp9 numeric(1,0),
    sgd_aper_codigo numeric(2,0),
    usu_telefono1 character varying(14),
    usua_encuesta character varying(1),
    sgd_perm_estadistica numeric(2,0),
    usua_perm_sancionados numeric(1,0),
    usua_admin_sistema numeric(1,0),
    usua_perm_trd numeric(1,0),
    usua_perm_firma numeric(1,0),
    usua_perm_prestamo numeric(1,0),
    usuario_publico numeric(1,0),
    usuario_reasignar numeric(1,0),
    usua_perm_notifica numeric(1,0),
    usua_perm_expediente numeric,
    usua_login_externo character varying(15),
    id_pais numeric(4,0) DEFAULT 170,
    id_cont numeric(2,0) DEFAULT 1,
    usua_auth_ldap numeric(1,0) DEFAULT 0 NOT NULL,
    perm_archi character(1) DEFAULT 1,
    perm_vobo character(1) DEFAULT 1,
    perm_borrar_anexo numeric(1,0),
    perm_tipif_anexo numeric(1,0),
    usua_perm_adminflujos numeric(1,0) DEFAULT 0 NOT NULL,
    usua_exp_trd numeric(2,0) DEFAULT 0,
    usua_prad_tp8 smallint
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- Name: TABLE usuario; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE usuario IS 'USUARIO';


--
-- Name: COLUMN usuario.usua_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_codi IS 'CODIGO DE USUARIO';


--
-- Name: COLUMN usuario.depe_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.depe_codi IS 'DEPE_CODI';


--
-- Name: COLUMN usuario.usua_login; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_login IS 'LOGIN USUARIO';


--
-- Name: COLUMN usuario.usua_fech_crea; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_fech_crea IS 'FECHA DE CREACION DEL USUARIO';


--
-- Name: COLUMN usuario.usua_pasw; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_pasw IS 'USUA_PASW';


--
-- Name: COLUMN usuario.usua_esta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_esta IS 'ESTADO DEL USUARIO - Activo o No (1/0)';


--
-- Name: COLUMN usuario.usua_nomb; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_nomb IS 'NOMBRE DEL USUARIO';


--
-- Name: COLUMN usuario.perm_radi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.perm_radi IS 'Permiso para digitalizacion de documentos: 1 permiso asignado';


--
-- Name: COLUMN usuario.usua_admin; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_admin IS 'Prestamo de documentos fisicos: 0 sin permiso -  1 permiso asignado ';


--
-- Name: COLUMN usuario.usua_nuevo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_nuevo IS 'Usuario Nuevo ? Si esta en ''0'' resetea la contrase?a';


--
-- Name: COLUMN usuario.usua_doc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_doc IS 'No. de Documento de Identificacion. ';


--
-- Name: COLUMN usuario.codi_nivel; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.codi_nivel IS 'Nivel del Usuario';


--
-- Name: COLUMN usuario.usua_sesion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_sesion IS 'Sesion Actual del usuario o Ultima fecha que entro.';


--
-- Name: COLUMN usuario.usua_fech_sesion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_fech_sesion IS 'Fecha de Actual de la session o Ultima Fecha.';


--
-- Name: COLUMN usuario.usua_ext; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_ext IS 'Numero de extension del usuario';


--
-- Name: COLUMN usuario.usua_nacim; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_nacim IS 'Fecha Nacimiento';


--
-- Name: COLUMN usuario.usua_email; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_email IS 'Mail';


--
-- Name: COLUMN usuario.usua_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_at IS 'Nombre del Equipo';


--
-- Name: COLUMN usuario.usua_piso; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_piso IS 'Piso en el que se encuentra laborando';


--
-- Name: COLUMN usuario.usua_admin_archivo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_admin_archivo IS 'Administrador de Archivo (Expedientes): 0 sin permiso - 1 permiso asignado ';


--
-- Name: COLUMN usuario.usua_masiva; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_masiva IS 'Permiso de radicacion masiva de documentos';


--
-- Name: COLUMN usuario.usua_perm_dev; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_perm_dev IS 'Devoluciones de correo (Dev_correo): 0 sin permiso - 1 permiso asignado';


--
-- Name: COLUMN usuario.sgd_panu_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.sgd_panu_codi IS 'Permisos de anulacion de radicados: 1 - Permiso de solicitud de anulado 2- Permiso de anulacion y generacion de actas 3- Permiso 1 y 2';


--
-- Name: COLUMN usuario.usua_prad_tp1; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_prad_tp1 IS 'Si esta en ''1'' El usuario Tiene Permisos de radicacicion Tipo 1.  En nuestro caso de salida';


--
-- Name: COLUMN usuario.usua_prad_tp2; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_prad_tp2 IS 'Si esta en ''2'' El usuario Tiene Permisos de radicacicion Tipo 2.  En nuestro caso de Entrada';


--
-- Name: COLUMN usuario.usua_prad_tp3; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_prad_tp3 IS 'Si esta en ''3'' El usuario Tiene Permisos de radicacicion Tipo 3.  En nuestro caso de Interna';


--
-- Name: COLUMN usuario.usua_prad_tp4; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_prad_tp4 IS 'Si esta en ''4'' El usuario Tiene Permisos de radicacicion Tipo 4.  En nuestro caso de ...';


--
-- Name: COLUMN usuario.usua_prad_tp5; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_prad_tp5 IS 'Si esta en ''5'' El usuario Tiene Permisos de radicacicion Tipo 5.  En nuestro caso de Memorandos';


--
-- Name: COLUMN usuario.usua_perm_envios; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_perm_envios IS 'Envios de correo (correspondencia): 0 sin permiso - 1 permiso asignado';


--
-- Name: COLUMN usuario.usua_perm_modifica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_perm_modifica IS 'Permiso de modificar Radicados';


--
-- Name: COLUMN usuario.usua_perm_impresion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_perm_impresion IS 'Carpeta de impresion: 0 sin permiso - 1 permiso asignado';


--
-- Name: COLUMN usuario.usua_prad_tp9; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_prad_tp9 IS 'Si esta en ''9'' El usuario Tiene Permisos de radicacicion Tipo 9.  En nuestro caso de Proyectos';


--
-- Name: COLUMN usuario.sgd_perm_estadistica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.sgd_perm_estadistica IS 'Si tiene ''1'' tiene permisos como jefe para ver las estadisticas de la dependencia.';


--
-- Name: COLUMN usuario.usua_admin_sistema; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_admin_sistema IS 'Administrador del sistema : 0 sin permiso - 1 permiso asignado';


--
-- Name: COLUMN usuario.usua_perm_trd; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_perm_trd IS 'Usuario Administracion de tablas de retencion documental : 0 sin permiso - 1 permiso asignado';


--
-- Name: COLUMN usuario.usua_perm_prestamo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.usua_perm_prestamo IS 'Indica si un usuario tiene o no permiso de acceso al modulo de prestamo. Segun su valor:
Tiene permiso
(0) No tiene permiso';


--
-- Name: COLUMN usuario.perm_borrar_anexo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.perm_borrar_anexo IS 'Indica si un usuario tiene (1) o no (0) permiso para tipificar anexos .tif';


--
-- Name: COLUMN usuario.perm_tipif_anexo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usuario.perm_tipif_anexo IS 'Indica si un usuario tiene (1)  o no (0) permiso para tipificar anexos .tif';


--
-- Name: sgd_est_estadi; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW sgd_est_estadi AS
    SELECT a.radi_nume_radi, a.radi_fech_radi, a.radi_depe_radi, a.radi_usua_radi, a.radi_depe_actu, a.radi_usua_actu, a.trte_codi, a.tdid_codi, a.radi_nomb, a.eesp_codi, b.usua_nomb, c.depe_nomb, d.tdid_desc FROM radicado a, usuario b, dependencia c, tipo_doc_identificacion d, tipo_remitente e WHERE (((((a.radi_usua_actu = b.usua_codi) AND (a.radi_depe_actu = b.depe_codi)) AND (a.radi_depe_actu = c.depe_codi)) AND (d.tdid_codi = a.tdoc_codi)) AND (a.trte_codi = e.trte_codi));


ALTER TABLE public.sgd_est_estadi OWNER TO postgres;

--
-- Name: sgd_estinst_estadoinstancia; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_estinst_estadoinstancia (
    sgd_estinst_codi numeric(4,0),
    sgd_apli_codi numeric(4,0),
    sgd_instorf_codi numeric(4,0),
    sgd_estinst_valor numeric(4,0),
    sgd_estinst_habilita numeric(1,0),
    sgd_estinst_mensaje character varying(100)
);


ALTER TABLE public.sgd_estinst_estadoinstancia OWNER TO postgres;

--
-- Name: sgd_exp_expediente; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_exp_expediente (
    sgd_exp_numero character varying(18),
    radi_nume_radi numeric(18,0),
    sgd_exp_fech date,
    sgd_exp_fech_mod date,
    depe_codi numeric(4,0),
    usua_codi numeric(3,0),
    usua_doc character varying(15),
    sgd_exp_estado numeric(1,0) DEFAULT 0,
    sgd_exp_titulo character varying(50),
    sgd_exp_asunto character varying(150),
    sgd_exp_carpeta character varying(30),
    sgd_exp_ufisica character varying(20),
    sgd_exp_isla character varying(10),
    sgd_exp_estante character varying(10),
    sgd_exp_caja character varying(10),
    sgd_exp_fech_arch date,
    sgd_srd_codigo numeric(3,0),
    sgd_sbrd_codigo numeric(3,0),
    sgd_fexp_codigo numeric(3,0),
    sgd_exp_subexpediente integer,
    sgd_exp_archivo numeric(1,0),
    sgd_exp_unicon numeric(1,0),
    sgd_exp_fechfin date,
    sgd_exp_folios character varying(6),
    sgd_exp_rete numeric(2,0),
    sgd_exp_entrepa numeric(6,0),
    radi_usua_arch character varying(40),
    sgd_exp_edificio character varying(400),
    sgd_exp_caja_bodega character varying(40),
    sgd_exp_carro character varying(40),
    sgd_exp_carpeta_bodega character varying(40),
    sgd_exp_privado numeric(1,0),
    sgd_exp_cd character varying(10),
    sgd_exp_nref character varying(7)
);


ALTER TABLE public.sgd_exp_expediente OWNER TO postgres;

--
-- Name: COLUMN sgd_exp_expediente.sgd_exp_numero; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_exp_expediente.sgd_exp_numero IS 'Numero de Expediente';


--
-- Name: COLUMN sgd_exp_expediente.radi_nume_radi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_exp_expediente.radi_nume_radi IS 'Radicado Asociado por cada radicado puede existir un registro de ubicacion en el expediente.';


--
-- Name: COLUMN sgd_exp_expediente.sgd_exp_fech; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_exp_expediente.sgd_exp_fech IS 'Fecha de Creacion del Expediente';


--
-- Name: COLUMN sgd_exp_expediente.sgd_exp_fech_mod; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_exp_expediente.sgd_exp_fech_mod IS 'Fecha de Ultima modificacion';


--
-- Name: COLUMN sgd_exp_expediente.depe_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_exp_expediente.depe_codi IS 'Dependencia que crea el expediente';


--
-- Name: COLUMN sgd_exp_expediente.usua_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_exp_expediente.usua_codi IS 'Codigo del Usuario que crea el expediente ';


--
-- Name: COLUMN sgd_exp_expediente.usua_doc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_exp_expediente.usua_doc IS 'Documento del usuario que crea el documento';


--
-- Name: COLUMN sgd_exp_expediente.sgd_exp_estado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_exp_expediente.sgd_exp_estado IS 'Indica si el radicado esta archivado (1) o no (0)';


--
-- Name: COLUMN sgd_exp_expediente.sgd_exp_titulo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_exp_expediente.sgd_exp_titulo IS 'Titulo de expediente se coloca en archivo';


--
-- Name: COLUMN sgd_exp_expediente.sgd_exp_asunto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_exp_expediente.sgd_exp_asunto IS 'Asunto del expediente';


--
-- Name: COLUMN sgd_exp_expediente.sgd_exp_carpeta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_exp_expediente.sgd_exp_carpeta IS 'Ubicacion en carpeta';


--
-- Name: COLUMN sgd_exp_expediente.sgd_exp_ufisica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_exp_expediente.sgd_exp_ufisica IS 'Ubicacion fisica';


--
-- Name: COLUMN sgd_exp_expediente.sgd_exp_isla; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_exp_expediente.sgd_exp_isla IS 'Isla';


--
-- Name: COLUMN sgd_exp_expediente.sgd_exp_estante; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_exp_expediente.sgd_exp_estante IS 'Estante';


--
-- Name: COLUMN sgd_exp_expediente.sgd_exp_caja; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_exp_expediente.sgd_exp_caja IS 'Caja';


--
-- Name: COLUMN sgd_exp_expediente.sgd_exp_fech_arch; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_exp_expediente.sgd_exp_fech_arch IS 'Fecha de archivado';


--
-- Name: COLUMN sgd_exp_expediente.sgd_srd_codigo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_exp_expediente.sgd_srd_codigo IS 'Serie';


--
-- Name: COLUMN sgd_exp_expediente.sgd_sbrd_codigo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_exp_expediente.sgd_sbrd_codigo IS 'Subserie';


--
-- Name: COLUMN sgd_exp_expediente.sgd_fexp_codigo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_exp_expediente.sgd_fexp_codigo IS 'Fecha del expediente';


--
-- Name: sgd_fars_faristas; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_fars_faristas (
    sgd_fars_codigo numeric(5,0) NOT NULL,
    sgd_pexp_codigo numeric(4,0),
    sgd_fexp_codigoini numeric(6,0),
    sgd_fexp_codigofin numeric(6,0),
    sgd_fars_diasminimo numeric(3,0),
    sgd_fars_diasmaximo numeric(3,0),
    sgd_fars_desc character varying(100),
    sgd_trad_codigo numeric(2,0),
    sgd_srd_codigo numeric(3,0),
    sgd_sbrd_codigo numeric(3,0),
    sgd_fars_tipificacion numeric(1,0),
    sgd_tpr_codigo numeric,
    sgd_fars_automatico numeric,
    sgd_fars_rolgeneral numeric
);


ALTER TABLE public.sgd_fars_faristas OWNER TO postgres;

--
-- Name: sgd_fenv_frmenvio; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_fenv_frmenvio (
    sgd_fenv_codigo numeric(5,0) NOT NULL,
    sgd_fenv_descrip character varying(40),
    sgd_fenv_planilla numeric(1,0) DEFAULT 0 NOT NULL,
    sgd_fenv_estado numeric(1,0) DEFAULT 1 NOT NULL
);


ALTER TABLE public.sgd_fenv_frmenvio OWNER TO postgres;

--
-- Name: sgd_fexp_flujoexpedientes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_fexp_flujoexpedientes (
    sgd_fexp_codigo numeric(6,0),
    sgd_pexp_codigo numeric(6,0),
    sgd_fexp_orden numeric(4,0),
    sgd_fexp_terminos numeric(4,0),
    sgd_fexp_imagen character varying(50),
    sgd_fexp_descrip character varying(50)
);


ALTER TABLE public.sgd_fexp_flujoexpedientes OWNER TO postgres;

--
-- Name: TABLE sgd_fexp_flujoexpedientes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sgd_fexp_flujoexpedientes IS 'Descripcion de la etapa en el Tipo de Proceso incicado en el campo SGD_PEXP_CODIGO';


--
-- Name: COLUMN sgd_fexp_flujoexpedientes.sgd_fexp_codigo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_fexp_flujoexpedientes.sgd_fexp_codigo IS 'Codigo etapa del Flujo. Codigo debe ser Unico.';


--
-- Name: COLUMN sgd_fexp_flujoexpedientes.sgd_pexp_codigo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_fexp_flujoexpedientes.sgd_pexp_codigo IS 'Codigo de proceso al cual se le incluira el flujo';


--
-- Name: COLUMN sgd_fexp_flujoexpedientes.sgd_fexp_orden; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_fexp_flujoexpedientes.sgd_fexp_orden IS 'Orden de la Etapa en el Flujo Documental';


--
-- Name: COLUMN sgd_fexp_flujoexpedientes.sgd_fexp_terminos; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_fexp_flujoexpedientes.sgd_fexp_terminos IS 'Numero de dias de plazo para cumplimiento de esta etapa.';


--
-- Name: COLUMN sgd_fexp_flujoexpedientes.sgd_fexp_imagen; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_fexp_flujoexpedientes.sgd_fexp_imagen IS 'Icono para distinguir la etapa.';


--
-- Name: COLUMN sgd_fexp_flujoexpedientes.sgd_fexp_descrip; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_fexp_flujoexpedientes.sgd_fexp_descrip IS 'Descripcion de la etapa en el Tipo de Proceso incicado en el campo SGD_PEXP_CODIGO';


--
-- Name: sgd_firrad_firmarads; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_firrad_firmarads (
    sgd_firrad_id numeric(15,0) NOT NULL,
    radi_nume_radi numeric(15,0) NOT NULL,
    usua_doc character varying(14) NOT NULL,
    sgd_firrad_firma character varying(255),
    sgd_firrad_fecha date,
    sgd_firrad_docsolic character varying(14) NOT NULL,
    sgd_firrad_fechsolic date NOT NULL,
    sgd_firrad_pk character varying(255)
);


ALTER TABLE public.sgd_firrad_firmarads OWNER TO postgres;

--
-- Name: sgd_fld_flujodoc; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_fld_flujodoc (
    sgd_fld_codigo numeric(3,0),
    sgd_fld_desc character varying(100),
    sgd_tpr_codigo numeric(3,0),
    sgd_fld_imagen character varying(50),
    sgd_fld_grupoweb integer DEFAULT 0
);


ALTER TABLE public.sgd_fld_flujodoc OWNER TO postgres;

--
-- Name: sgd_fun_funciones; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_fun_funciones (
    sgd_fun_codigo numeric(4,0) NOT NULL,
    sgd_fun_descrip character varying(530),
    sgd_fun_fech_ini date,
    sgd_fun_fech_fin date
);


ALTER TABLE public.sgd_fun_funciones OWNER TO postgres;

--
-- Name: sgd_hfld_histflujodoc; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_hfld_histflujodoc (
    sgd_hfld_codigo numeric(6,0),
    sgd_fexp_codigo numeric(3,0) NOT NULL,
    sgd_exp_fechflujoant date,
    sgd_hfld_fech date,
    sgd_exp_numero character varying(18),
    radi_nume_radi numeric(15,0),
    usua_doc character varying(10),
    usua_codi numeric(10,0),
    depe_codi numeric(4,0),
    sgd_ttr_codigo numeric(2,0),
    sgd_fexp_observa character varying(500),
    sgd_hfld_observa character varying(500),
    sgd_fars_codigo numeric,
    sgd_hfld_automatico numeric
);


ALTER TABLE public.sgd_hfld_histflujodoc OWNER TO postgres;

--
-- Name: sgd_hmtd_hismatdoc; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_hmtd_hismatdoc (
    sgd_hmtd_codigo numeric(6,0) NOT NULL,
    sgd_hmtd_fecha date NOT NULL,
    radi_nume_radi numeric(15,0) NOT NULL,
    usua_codi numeric(10,0) NOT NULL,
    sgd_hmtd_obse character varying(600) NOT NULL,
    usua_doc numeric(13,0),
    depe_codi numeric(5,0),
    sgd_mtd_codigo numeric(4,0)
);


ALTER TABLE public.sgd_hmtd_hismatdoc OWNER TO postgres;

--
-- Name: sgd_hmtd_secue; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sgd_hmtd_secue
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 999999
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sgd_hmtd_secue OWNER TO postgres;

--
-- Name: sgd_info_secue; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sgd_info_secue
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 9999999999
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sgd_info_secue OWNER TO postgres;

--
-- Name: sgd_instorf_instanciasorfeo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_instorf_instanciasorfeo (
    sgd_instorf_codi numeric(4,0),
    sgd_instorf_desc character varying(100)
);


ALTER TABLE public.sgd_instorf_instanciasorfeo OWNER TO postgres;

--
-- Name: TABLE sgd_instorf_instanciasorfeo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sgd_instorf_instanciasorfeo IS 'tabla de integracion de instancias';


--
-- Name: sgd_mat_matriz; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_mat_matriz (
    sgd_mat_codigo numeric(4,0) NOT NULL,
    depe_codi numeric(5,0),
    sgd_fun_codigo numeric(4,0),
    sgd_prc_codigo numeric(4,0),
    sgd_prd_codigo numeric(4,0),
    sgd_mat_fech_ini date,
    sgd_mat_fech_fin date,
    sgd_mat_peso_prd numeric(5,2)
);


ALTER TABLE public.sgd_mat_matriz OWNER TO postgres;

--
-- Name: sgd_mat_secue; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sgd_mat_secue
    INCREMENT BY 1
    MAXVALUE 99999999
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sgd_mat_secue OWNER TO postgres;

--
-- Name: sgd_mrd_matrird; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_mrd_matrird (
    sgd_mrd_codigo numeric(5,0) NOT NULL,
    depe_codi numeric(5,0) NOT NULL,
    sgd_srd_codigo numeric(4,0) NOT NULL,
    sgd_sbrd_codigo numeric(4,0) NOT NULL,
    sgd_tpr_codigo numeric(4,0) NOT NULL,
    soporte character varying(10),
    sgd_mrd_fechini date,
    sgd_mrd_fechfin date,
    sgd_mrd_esta character varying(10)
);


ALTER TABLE public.sgd_mrd_matrird OWNER TO postgres;

--
-- Name: sgd_msdep_msgdep; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_msdep_msgdep (
    sgd_msdep_codi numeric(15,0) NOT NULL,
    depe_codi numeric(5,0) NOT NULL,
    sgd_msg_codi numeric(15,0) NOT NULL
);


ALTER TABLE public.sgd_msdep_msgdep OWNER TO postgres;

--
-- Name: sgd_msg_mensaje; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_msg_mensaje (
    sgd_msg_codi numeric(15,0) NOT NULL,
    sgd_tme_codi numeric(3,0) NOT NULL,
    sgd_msg_desc character varying(150),
    sgd_msg_fechdesp date NOT NULL,
    sgd_msg_url character varying(150) NOT NULL,
    sgd_msg_veces numeric(3,0) NOT NULL,
    sgd_msg_ancho numeric(6,0) NOT NULL,
    sgd_msg_largo numeric(6,0) NOT NULL
);


ALTER TABLE public.sgd_msg_mensaje OWNER TO postgres;

--
-- Name: sgd_mtd_matriz_doc; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_mtd_matriz_doc (
    sgd_mtd_codigo numeric(4,0) NOT NULL,
    sgd_mat_codigo numeric(4,0),
    sgd_tpr_codigo numeric(4,0)
);


ALTER TABLE public.sgd_mtd_matriz_doc OWNER TO postgres;

--
-- Name: sgd_noh_nohabiles; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_noh_nohabiles (
    noh_fecha date NOT NULL
);


ALTER TABLE public.sgd_noh_nohabiles OWNER TO postgres;

--
-- Name: sgd_not_notificacion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_not_notificacion (
    sgd_not_codi numeric(3,0) NOT NULL,
    sgd_not_descrip character varying(100) NOT NULL
);


ALTER TABLE public.sgd_not_notificacion OWNER TO postgres;

--
-- Name: sgd_ntrd_notifrad; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_ntrd_notifrad (
    radi_nume_radi numeric(15,0) NOT NULL,
    sgd_not_codi numeric(3,0) NOT NULL,
    sgd_ntrd_notificador character varying(150),
    sgd_ntrd_notificado character varying(150),
    sgd_ntrd_fecha_not date,
    sgd_ntrd_num_edicto numeric(6,0),
    sgd_ntrd_fecha_fija date,
    sgd_ntrd_fecha_desfija date,
    sgd_ntrd_observaciones character varying(150)
);


ALTER TABLE public.sgd_ntrd_notifrad OWNER TO postgres;

--
-- Name: sgd_oem_oempresas; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_oem_oempresas (
    sgd_oem_codigo numeric(8,0) NOT NULL,
    tdid_codi numeric(2,0),
    sgd_oem_oempresa character varying(150),
    sgd_oem_rep_legal character varying(150),
    sgd_oem_nit character varying(14),
    sgd_oem_sigla character varying(50),
    muni_codi numeric(4,0),
    dpto_codi numeric(2,0),
    sgd_oem_direccion character varying(150),
    sgd_oem_telefono character varying(50),
    id_cont numeric(2,0) DEFAULT 1,
    id_pais numeric(4,0) DEFAULT 170
);


ALTER TABLE public.sgd_oem_oempresas OWNER TO postgres;

--
-- Name: sgd_oem_secue; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sgd_oem_secue
    START WITH 18398
    INCREMENT BY 1
    MAXVALUE 99999999
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sgd_oem_secue OWNER TO postgres;

--
-- Name: sgd_panu_peranulados; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_panu_peranulados (
    sgd_panu_codi numeric(4,0),
    sgd_panu_desc character varying(200)
);


ALTER TABLE public.sgd_panu_peranulados OWNER TO postgres;

--
-- Name: TABLE sgd_panu_peranulados; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sgd_panu_peranulados IS 'Define los permisos de anulacion de documentos';


--
-- Name: COLUMN sgd_panu_peranulados.sgd_panu_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_panu_peranulados.sgd_panu_codi IS 'Descripcion';


--
-- Name: sgd_parametro; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_parametro (
    param_nomb character varying(25) NOT NULL,
    param_codi numeric(5,0) NOT NULL,
    param_valor character varying(25) NOT NULL
);


ALTER TABLE public.sgd_parametro OWNER TO postgres;

--
-- Name: TABLE sgd_parametro; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sgd_parametro IS 'Almacena parametros compuestos por dos valores: identificador y valor';


--
-- Name: COLUMN sgd_parametro.param_nomb; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_parametro.param_nomb IS 'Nombre del tipo de parametro';


--
-- Name: COLUMN sgd_parametro.param_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_parametro.param_codi IS 'Codigo identificador del parametro';


--
-- Name: COLUMN sgd_parametro.param_valor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_parametro.param_valor IS 'Valor del parametro';


--
-- Name: sgd_parexp_paramexpediente; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_parexp_paramexpediente (
    sgd_parexp_codigo numeric(4,0) NOT NULL,
    depe_codi numeric(4,0) NOT NULL,
    sgd_parexp_tabla character varying(30) NOT NULL,
    sgd_parexp_etiqueta character varying(15) NOT NULL,
    sgd_parexp_orden numeric(1,0)
);


ALTER TABLE public.sgd_parexp_paramexpediente OWNER TO postgres;

--
-- Name: sgd_pexp_procexpedientes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_pexp_procexpedientes (
    sgd_pexp_codigo numeric NOT NULL,
    sgd_pexp_descrip character varying(100),
    sgd_pexp_terminos numeric DEFAULT 0,
    sgd_srd_codigo numeric(3,0),
    sgd_sbrd_codigo numeric(3,0),
    sgd_pexp_automatico numeric(1,0) DEFAULT 1
);


ALTER TABLE public.sgd_pexp_procexpedientes OWNER TO postgres;

--
-- Name: COLUMN sgd_pexp_procexpedientes.sgd_pexp_codigo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_pexp_procexpedientes.sgd_pexp_codigo IS 'Codigo que identifica el proceso';


--
-- Name: COLUMN sgd_pexp_procexpedientes.sgd_pexp_descrip; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_pexp_procexpedientes.sgd_pexp_descrip IS 'Nombre del proceso';


--
-- Name: COLUMN sgd_pexp_procexpedientes.sgd_pexp_terminos; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_pexp_procexpedientes.sgd_pexp_terminos IS 'termino del proceso';


--
-- Name: COLUMN sgd_pexp_procexpedientes.sgd_srd_codigo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_pexp_procexpedientes.sgd_srd_codigo IS 'Serie (trd) que identifica el proceso';


--
-- Name: COLUMN sgd_pexp_procexpedientes.sgd_sbrd_codigo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_pexp_procexpedientes.sgd_sbrd_codigo IS 'Subserie (trd) que identifica el proceso';


--
-- Name: sgd_plg_secue; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sgd_plg_secue
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 9999999999
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sgd_plg_secue OWNER TO postgres;

--
-- Name: sgd_pnufe_procnumfe; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_pnufe_procnumfe (
    sgd_pnufe_codi numeric(4,0) NOT NULL,
    sgd_tpr_codigo numeric(4,0),
    sgd_pnufe_descrip character varying(150),
    sgd_pnufe_serie character varying(50)
);


ALTER TABLE public.sgd_pnufe_procnumfe OWNER TO postgres;

--
-- Name: TABLE sgd_pnufe_procnumfe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sgd_pnufe_procnumfe IS 'Cataloga los procesos de numeracion y fechado';


--
-- Name: COLUMN sgd_pnufe_procnumfe.sgd_pnufe_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_pnufe_procnumfe.sgd_pnufe_codi IS 'Codigo del proceso';


--
-- Name: COLUMN sgd_pnufe_procnumfe.sgd_tpr_codigo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_pnufe_procnumfe.sgd_tpr_codigo IS 'Codigo del documento que genera el procedimiento';


--
-- Name: COLUMN sgd_pnufe_procnumfe.sgd_pnufe_descrip; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_pnufe_procnumfe.sgd_pnufe_descrip IS 'Descripcion del procedimiento generado';


--
-- Name: COLUMN sgd_pnufe_procnumfe.sgd_pnufe_serie; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_pnufe_procnumfe.sgd_pnufe_serie IS 'Serie que maneja la numeracion de los documentos';


--
-- Name: sgd_pnun_procenum; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_pnun_procenum (
    sgd_pnun_codi numeric(4,0) NOT NULL,
    sgd_pnufe_codi numeric(4,0),
    depe_codi numeric(5,0),
    sgd_pnun_prepone character varying(50)
);


ALTER TABLE public.sgd_pnun_procenum OWNER TO postgres;

--
-- Name: COLUMN sgd_pnun_procenum.sgd_pnun_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_pnun_procenum.sgd_pnun_codi IS 'Id del registro';


--
-- Name: COLUMN sgd_pnun_procenum.sgd_pnufe_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_pnun_procenum.sgd_pnufe_codi IS 'Codigo del proceso';


--
-- Name: COLUMN sgd_pnun_procenum.depe_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_pnun_procenum.depe_codi IS 'Codigo de la dependencia';


--
-- Name: COLUMN sgd_pnun_procenum.sgd_pnun_prepone; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_pnun_procenum.sgd_pnun_prepone IS 'Preposicion empleada para generar el numero completo del documento';


--
-- Name: sgd_prc_proceso; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_prc_proceso (
    sgd_prc_codigo numeric(4,0) NOT NULL,
    sgd_prc_descrip character varying(150),
    sgd_prc_fech_ini date,
    sgd_prc_fech_fin date
);


ALTER TABLE public.sgd_prc_proceso OWNER TO postgres;

--
-- Name: sgd_prd_prcdmentos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_prd_prcdmentos (
    sgd_prd_codigo numeric(4,0) NOT NULL,
    sgd_prd_descrip character varying(200),
    sgd_prd_fech_ini date,
    sgd_prd_fech_fin date
);


ALTER TABLE public.sgd_prd_prcdmentos OWNER TO postgres;

--
-- Name: sgd_rda_retdoca; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_rda_retdoca (
    anex_radi_nume numeric(15,0) NOT NULL,
    anex_codigo character varying(20) NOT NULL,
    radi_nume_salida numeric(15,0),
    anex_borrado character varying(1),
    sgd_mrd_codigo numeric(4,0) NOT NULL,
    depe_codi numeric(5,0) NOT NULL,
    usua_codi numeric(10,0) NOT NULL,
    usua_doc character varying(14) NOT NULL,
    sgd_rda_fech date,
    sgd_deve_codigo numeric(2,0),
    anex_solo_lect character varying(1),
    anex_radi_fech date,
    anex_estado numeric(1,0),
    anex_nomb_archivo character varying(50),
    anex_tipo numeric(4,0),
    sgd_dir_tipo numeric(4,0)
);


ALTER TABLE public.sgd_rda_retdoca OWNER TO postgres;

--
-- Name: sgd_rdf_retdocf; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_rdf_retdocf (
    sgd_mrd_codigo numeric(10,0) NOT NULL,
    radi_nume_radi numeric(15,0) NOT NULL,
    depe_codi numeric(5,0) NOT NULL,
    usua_codi numeric(10,0) NOT NULL,
    usua_doc character varying(14) NOT NULL,
    sgd_rdf_fech date NOT NULL
);


ALTER TABLE public.sgd_rdf_retdocf OWNER TO postgres;

--
-- Name: sgd_renv_regenvio; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_renv_regenvio (
    sgd_renv_codigo numeric NOT NULL,
    sgd_fenv_codigo numeric,
    sgd_renv_fech date,
    radi_nume_sal numeric,
    sgd_renv_destino character varying,
    sgd_renv_telefono character varying,
    sgd_renv_mail character varying,
    sgd_renv_peso character varying,
    sgd_renv_valor numeric,
    sgd_renv_certificado numeric,
    sgd_renv_estado numeric,
    usua_doc numeric,
    sgd_renv_nombre character varying,
    sgd_rem_destino numeric DEFAULT 0,
    sgd_dir_codigo numeric,
    sgd_renv_planilla character varying(8),
    sgd_renv_fech_sal date,
    depe_codi numeric(5,0),
    sgd_dir_tipo numeric(4,0) DEFAULT 0,
    radi_nume_grupo numeric(14,0),
    sgd_renv_dir character varying(100),
    sgd_renv_depto character varying(30),
    sgd_renv_mpio character varying(30),
    sgd_renv_tel character varying(20),
    sgd_renv_cantidad numeric(4,0) DEFAULT 0,
    sgd_renv_tipo numeric(1,0) DEFAULT 0,
    sgd_renv_observa character varying(200),
    sgd_renv_grupo numeric(14,0),
    sgd_deve_codigo numeric(2,0),
    sgd_deve_fech date,
    sgd_renv_valortotal character varying(14) DEFAULT 0,
    sgd_renv_valistamiento character varying(10) DEFAULT 0,
    sgd_renv_vdescuento character varying(10) DEFAULT 0,
    sgd_renv_vadicional character varying(14) DEFAULT 0,
    sgd_depe_genera numeric(5,0),
    sgd_renv_pais character varying(30) DEFAULT 'colombia'::character varying
);


ALTER TABLE public.sgd_renv_regenvio OWNER TO postgres;

--
-- Name: sgd_rfax_reservafax; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_rfax_reservafax (
    sgd_rfax_codigo numeric(10,0),
    sgd_rfax_fax character varying(30),
    usua_login character varying(30),
    sgd_rfax_fech date,
    sgd_rfax_fechradi date,
    radi_nume_radi numeric(15,0),
    sgd_rfax_observa character varying(500)
);


ALTER TABLE public.sgd_rfax_reservafax OWNER TO postgres;

--
-- Name: sgd_rmr_radmasivre; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_rmr_radmasivre (
    sgd_rmr_grupo numeric(15,0) NOT NULL,
    sgd_rmr_radi numeric(15,0) NOT NULL
);


ALTER TABLE public.sgd_rmr_radmasivre OWNER TO postgres;

--
-- Name: sgd_san_sancionados; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_san_sancionados (
    sgd_san_ref character varying(20) NOT NULL,
    sgd_san_decision character varying(60),
    sgd_san_cargo character varying(50),
    sgd_san_expediente character varying(20),
    sgd_san_tipo_sancion character varying(50),
    sgd_san_plazo character varying(100),
    sgd_san_valor numeric(14,2),
    sgd_san_radicacion character varying(15),
    sgd_san_fecha_radicado date,
    sgd_san_valorletras character varying(1000),
    sgd_san_nombreempresa character varying(160),
    sgd_san_motivos character varying(160),
    sgd_san_sectores character varying(160),
    sgd_san_padre character varying(15),
    sgd_san_fecha_padre date,
    sgd_san_notificado character varying(100)
);


ALTER TABLE public.sgd_san_sancionados OWNER TO postgres;

--
-- Name: sgd_sbrd_subserierd; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_sbrd_subserierd (
    sgd_srd_codigo numeric(4,0) NOT NULL,
    sgd_sbrd_codigo numeric(4,0) NOT NULL,
    sgd_sbrd_descrip character varying(200) NOT NULL,
    sgd_sbrd_fechini date NOT NULL,
    sgd_sbrd_fechfin date NOT NULL,
    sgd_sbrd_tiemag numeric(4,0),
    sgd_sbrd_tiemac numeric(4,0),
    sgd_sbrd_dispfin character varying(50),
    sgd_sbrd_soporte character varying(50),
    sgd_sbrd_procedi character varying(200)
);


ALTER TABLE public.sgd_sbrd_subserierd OWNER TO postgres;

--
-- Name: sgd_senuf_secnumfe; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_senuf_secnumfe (
    sgd_senuf_codi numeric(4,0) NOT NULL,
    sgd_pnufe_codi numeric(4,0),
    depe_codi numeric(5,0),
    sgd_senuf_sec character varying(50)
);


ALTER TABLE public.sgd_senuf_secnumfe OWNER TO postgres;

--
-- Name: sgd_sexp_secexpedientes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_sexp_secexpedientes (
    sgd_exp_numero character varying(18) NOT NULL,
    sgd_srd_codigo numeric,
    sgd_sbrd_codigo numeric,
    sgd_sexp_secuencia numeric,
    depe_codi numeric,
    usua_doc character varying(15),
    sgd_sexp_fech date,
    sgd_fexp_codigo numeric,
    sgd_sexp_ano numeric,
    usua_doc_responsable character varying(18),
    sgd_sexp_parexp1 character varying(250),
    sgd_sexp_parexp2 character varying(160),
    sgd_sexp_parexp3 character varying(160),
    sgd_sexp_parexp4 character varying(160),
    sgd_sexp_parexp5 character varying(160),
    sgd_pexp_codigo numeric(3,0),
    sgd_exp_fech_arch date,
    sgd_fld_codigo numeric(3,0),
    sgd_exp_fechflujoant date,
    sgd_mrd_codigo numeric(4,0),
    sgd_exp_subexpediente numeric(18,0),
    sgd_exp_privado numeric(1,0)
);


ALTER TABLE public.sgd_sexp_secexpedientes OWNER TO postgres;

--
-- Name: COLUMN sgd_sexp_secexpedientes.sgd_exp_numero; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_sexp_secexpedientes.sgd_exp_numero IS 'Numero del expediente';


--
-- Name: COLUMN sgd_sexp_secexpedientes.sgd_srd_codigo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_sexp_secexpedientes.sgd_srd_codigo IS 'codigo serie';


--
-- Name: COLUMN sgd_sexp_secexpedientes.sgd_sbrd_codigo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_sexp_secexpedientes.sgd_sbrd_codigo IS 'codigo subserie';


--
-- Name: COLUMN sgd_sexp_secexpedientes.sgd_sexp_secuencia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_sexp_secexpedientes.sgd_sexp_secuencia IS 'numero del expediente';


--
-- Name: COLUMN sgd_sexp_secexpedientes.depe_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_sexp_secexpedientes.depe_codi IS 'Dependencia creadora';


--
-- Name: COLUMN sgd_sexp_secexpedientes.usua_doc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_sexp_secexpedientes.usua_doc IS 'Documento del usuario creador';


--
-- Name: COLUMN sgd_sexp_secexpedientes.sgd_sexp_fech; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_sexp_secexpedientes.sgd_sexp_fech IS 'Fecha de inicio del proceso';


--
-- Name: COLUMN sgd_sexp_secexpedientes.sgd_fexp_codigo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_sexp_secexpedientes.sgd_fexp_codigo IS 'Codigo de proceso';


--
-- Name: COLUMN sgd_sexp_secexpedientes.sgd_sexp_ano; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_sexp_secexpedientes.sgd_sexp_ano IS 'A?o del expediente';


--
-- Name: sgd_srd_seriesrd; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_srd_seriesrd (
    sgd_srd_codigo numeric(4,0) NOT NULL,
    sgd_srd_descrip character varying(50) NOT NULL,
    sgd_srd_fechini date NOT NULL,
    sgd_srd_fechfin date NOT NULL
);


ALTER TABLE public.sgd_srd_seriesrd OWNER TO postgres;

--
-- Name: sgd_tar_tarifas; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_tar_tarifas (
    sgd_fenv_codigo numeric(5,0),
    sgd_tar_codser numeric(5,0),
    sgd_tar_codigo numeric(5,0),
    sgd_tar_valenv1 numeric(15,0),
    sgd_tar_valenv2 numeric(15,0),
    sgd_tar_valenv1g1 numeric(15,0),
    sgd_clta_codser numeric(5,0),
    sgd_tar_valenv2g2 numeric(15,0),
    sgd_clta_descrip character varying(100)
);


ALTER TABLE public.sgd_tar_tarifas OWNER TO postgres;

--
-- Name: sgd_tdec_tipodecision; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_tdec_tipodecision (
    sgd_apli_codi numeric(4,0) NOT NULL,
    sgd_tdec_codigo numeric(4,0) NOT NULL,
    sgd_tdec_descrip character varying(150),
    sgd_tdec_sancionar numeric(1,0),
    sgd_tdec_firmeza numeric(1,0),
    sgd_tdec_versancion numeric(1,0),
    sgd_tdec_showmenu numeric(1,0),
    sgd_tdec_updnotif numeric(1,0),
    sgd_tdec_veragota numeric(1,0)
);


ALTER TABLE public.sgd_tdec_tipodecision OWNER TO postgres;

--
-- Name: sgd_tid_tipdecision; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_tid_tipdecision (
    sgd_tid_codi numeric(4,0) NOT NULL,
    sgd_tid_desc character varying(150),
    sgd_tpr_codigo numeric(4,0),
    sgd_pexp_codigo numeric(2,0),
    sgd_tpr_codigop numeric(2,0)
);


ALTER TABLE public.sgd_tid_tipdecision OWNER TO postgres;

--
-- Name: TABLE sgd_tid_tipdecision; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sgd_tid_tipdecision IS 'Tipos de decision';


--
-- Name: COLUMN sgd_tid_tipdecision.sgd_tid_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_tid_tipdecision.sgd_tid_codi IS 'Id del registro';


--
-- Name: COLUMN sgd_tid_tipdecision.sgd_tid_desc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_tid_tipdecision.sgd_tid_desc IS 'Descripcion';


--
-- Name: sgd_tidm_tidocmasiva; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_tidm_tidocmasiva (
    sgd_tidm_codi numeric(4,0) NOT NULL,
    sgd_tidm_desc character varying(150)
);


ALTER TABLE public.sgd_tidm_tidocmasiva OWNER TO postgres;

--
-- Name: TABLE sgd_tidm_tidocmasiva; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sgd_tidm_tidocmasiva IS 'Cataloga los documentos que hacen parte del procedimiento de correspondencia masiva';


--
-- Name: COLUMN sgd_tidm_tidocmasiva.sgd_tidm_codi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_tidm_tidocmasiva.sgd_tidm_codi IS 'Codigo del documento';


--
-- Name: COLUMN sgd_tidm_tidocmasiva.sgd_tidm_desc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_tidm_tidocmasiva.sgd_tidm_desc IS 'Descripcion';


--
-- Name: sgd_tip3_tipotercero; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_tip3_tipotercero (
    sgd_tip3_codigo numeric(2,0) NOT NULL,
    sgd_dir_tipo numeric(4,0),
    sgd_tip3_nombre character varying(15),
    sgd_tip3_desc character varying(30),
    sgd_tip3_imgpestana character varying(20),
    sgd_tpr_tp1 numeric(1,0) DEFAULT 0,
    sgd_tpr_tp2 numeric(1,0) DEFAULT 0,
    sgd_tpr_tp3 numeric(1,0) DEFAULT 0,
    sgd_tpr_tp4 numeric(1,0) DEFAULT 0,
    sgd_tpr_tp9 numeric(1,0) DEFAULT 0,
    sgd_tpr_tp5 numeric(1,0) DEFAULT 0,
    sgd_tpr_tp8 smallint DEFAULT 1
);


ALTER TABLE public.sgd_tip3_tipotercero OWNER TO postgres;

--
-- Name: sgd_tma_temas; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_tma_temas (
    sgd_tma_codigo numeric(4,0) NOT NULL,
    depe_codi numeric(5,0),
    sgd_prc_codigo numeric(4,0),
    sgd_tma_descrip character varying(150)
);


ALTER TABLE public.sgd_tma_temas OWNER TO postgres;

--
-- Name: sgd_tmd_temadepe; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_tmd_temadepe (
    id integer NOT NULL,
    sgd_tma_codigo smallint NOT NULL,
    depe_codi smallint NOT NULL
);


ALTER TABLE public.sgd_tmd_temadepe OWNER TO postgres;

--
-- Name: sgd_tme_tipmen; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_tme_tipmen (
    sgd_tme_codi numeric(3,0) NOT NULL,
    sgd_tme_desc character varying(150)
);


ALTER TABLE public.sgd_tme_tipmen OWNER TO postgres;

--
-- Name: sgd_tpr_tpdcumento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_tpr_tpdcumento (
    sgd_tpr_codigo numeric(4,0) NOT NULL,
    sgd_tpr_descrip character varying(150),
    sgd_tpr_termino numeric(4,0),
    sgd_tpr_tpuso numeric(1,0),
    sgd_tpr_numera character(1),
    sgd_tpr_radica character(1),
    sgd_tpr_tp3 numeric(1,0) DEFAULT 0,
    sgd_tpr_tp5 numeric(1,0) DEFAULT 0,
    sgd_tpr_tp1 numeric(1,0) DEFAULT 0,
    sgd_tpr_tp2 numeric(1,0) DEFAULT 0,
    sgd_tpr_tp4 numeric(1,0) DEFAULT 0,
    sgd_tpr_tp9 numeric(1,0),
    sgd_tpr_estado numeric(1,0),
    sgd_termino_real numeric(4,0),
    sgd_tpr_tp8 smallint
);


ALTER TABLE public.sgd_tpr_tpdcumento OWNER TO postgres;

--
-- Name: COLUMN sgd_tpr_tpdcumento.sgd_tpr_numera; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_tpr_tpdcumento.sgd_tpr_numera IS 'INDICA SI UN DOCUMNTO PUEDE NUMERARSE';


--
-- Name: COLUMN sgd_tpr_tpdcumento.sgd_tpr_radica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_tpr_tpdcumento.sgd_tpr_radica IS 'INDICA SI UN DOCUMNTO PUEDE RADICARSE';


--
-- Name: COLUMN sgd_tpr_tpdcumento.sgd_tpr_tp3; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_tpr_tpdcumento.sgd_tpr_tp3 IS 'Radicados de Memorando';


--
-- Name: COLUMN sgd_tpr_tpdcumento.sgd_tpr_tp5; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_tpr_tpdcumento.sgd_tpr_tp5 IS 'Radicados de Resoluciones';


--
-- Name: COLUMN sgd_tpr_tpdcumento.sgd_tpr_tp1; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_tpr_tpdcumento.sgd_tpr_tp1 IS 'Radicados de salida';


--
-- Name: COLUMN sgd_tpr_tpdcumento.sgd_tpr_tp2; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_tpr_tpdcumento.sgd_tpr_tp2 IS 'Radicados de entrada';


--
-- Name: COLUMN sgd_tpr_tpdcumento.sgd_tpr_tp9; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_tpr_tpdcumento.sgd_tpr_tp9 IS 'Radicacion de Proyectos';


--
-- Name: COLUMN sgd_tpr_tpdcumento.sgd_tpr_estado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN sgd_tpr_tpdcumento.sgd_tpr_estado IS 'Estado del documento 1- habilitado 2- deshabilitado';


--
-- Name: sgd_trad_tiporad; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_trad_tiporad (
    sgd_trad_codigo numeric(2,0) NOT NULL,
    sgd_trad_descr character varying(30),
    sgd_trad_icono character varying(30),
    sgd_trad_genradsal numeric(1,0)
);


ALTER TABLE public.sgd_trad_tiporad OWNER TO postgres;

--
-- Name: sgd_ttr_transaccion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_ttr_transaccion (
    sgd_ttr_codigo numeric(3,0) NOT NULL,
    sgd_ttr_descrip character varying(100) NOT NULL
);


ALTER TABLE public.sgd_ttr_transaccion OWNER TO postgres;

--
-- Name: sgd_ush_usuhistorico; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_ush_usuhistorico (
    sgd_ush_admcod numeric(10,0) NOT NULL,
    sgd_ush_admdep numeric(5,0) NOT NULL,
    sgd_ush_admdoc character varying(14) NOT NULL,
    sgd_ush_usucod numeric(10,0) NOT NULL,
    sgd_ush_usudep numeric(5,0) NOT NULL,
    sgd_ush_usudoc character varying(14) NOT NULL,
    sgd_ush_modcod numeric(5,0) NOT NULL,
    sgd_ush_fechevento date NOT NULL,
    sgd_ush_usulogin character varying(20) NOT NULL
);


ALTER TABLE public.sgd_ush_usuhistorico OWNER TO postgres;

--
-- Name: TABLE sgd_ush_usuhistorico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sgd_ush_usuhistorico IS 'Representa las modificaciones hechas a los usuarios. Registro historico por usuario sobre el tipo de transaccion realizada y los cambios con fecha y hora de realizacion.';


--
-- Name: sgd_usm_usumodifica; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sgd_usm_usumodifica (
    sgd_usm_modcod numeric(5,0) NOT NULL,
    sgd_usm_moddescr character varying(60) NOT NULL
);


ALTER TABLE public.sgd_usm_usumodifica OWNER TO postgres;

--
-- Name: TABLE sgd_usm_usumodifica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sgd_usm_usumodifica IS 'Contiene los tipos de modificaciones que se pueden hacer a los usuarios del sistema.';


--
-- Name: v_usuario; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW v_usuario AS
    SELECT usuario.usua_codi, usuario.usua_nomb, usuario.usua_login, usuario.depe_codi FROM usuario;


ALTER TABLE public.v_usuario OWNER TO postgres;

--
-- Name: PK_SGD_TTR_TRANSACCION; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sgd_ttr_transaccion
    ADD CONSTRAINT "PK_SGD_TTR_TRANSACCION" PRIMARY KEY (sgd_ttr_codigo);


--
-- Name: SGD_TRAD_TIPORAD_CODIGO_INX; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sgd_trad_tiporad
    ADD CONSTRAINT "SGD_TRAD_TIPORAD_CODIGO_INX" PRIMARY KEY (sgd_trad_codigo);


--
-- Name: pk_radicado; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY pqr
    ADD CONSTRAINT pk_radicado PRIMARY KEY (radi_nume_radi);


--
-- Name: pk_radicados; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY radicado
    ADD CONSTRAINT pk_radicados PRIMARY KEY (radi_nume_radi);


--
-- Name: sgd_archivo_central2_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sgd_archivo_central
    ADD CONSTRAINT sgd_archivo_central2_pk PRIMARY KEY (sgd_archivo_id);


--
-- Name: sgd_carp_descripcion_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sgd_carp_descripcion
    ADD CONSTRAINT sgd_carp_descripcion_pk PRIMARY KEY (sgd_carp_depecodi, sgd_carp_tiporad);


--
-- Name: sgd_einv_inventario_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sgd_einv_inventario
    ADD CONSTRAINT sgd_einv_inventario_pk PRIMARY KEY (sgd_einv_codigo);


--
-- Name: sgd_eit_items_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sgd_eit_items
    ADD CONSTRAINT sgd_eit_items_pk PRIMARY KEY (sgd_eit_codigo);


--
-- Name: sgd_eit_items_uk1; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sgd_eit_items
    ADD CONSTRAINT sgd_eit_items_uk1 UNIQUE (sgd_eit_cod_padre, sgd_eit_nombre, sgd_eit_sigla);


--
-- Name: sgd_tma_temas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sgd_tma_temas
    ADD CONSTRAINT sgd_tma_temas_pkey PRIMARY KEY (sgd_tma_codigo);


--
-- Name: sgd_tmd_temadepe_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sgd_tmd_temadepe
    ADD CONSTRAINT sgd_tmd_temadepe_pkey PRIMARY KEY (id);


--
-- Name: usuario_pk2; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pk2 PRIMARY KEY (usua_login);


--
-- Name: usuario_uk3; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_uk3 UNIQUE (usua_codi, depe_codi);


--
-- Name: anex_hist_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX anex_hist_pk ON anexos_historico USING btree (anex_hist_anex_codi, anex_hist_num_ver);


--
-- Name: anex_pk_anex_codigo; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX anex_pk_anex_codigo ON anexos USING btree (anex_codigo);


--
-- Name: anex_pk_anex_tipo_codi; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX anex_pk_anex_tipo_codi ON anexos_tipo USING btree (anex_tipo_codi);


--
-- Name: anexos_idx_001; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX anexos_idx_001 ON anexos USING btree (anex_borrado, sgd_deve_codigo, radi_nume_salida, anex_creador, anex_estado);


--
-- Name: anexos_idx_002; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX anexos_idx_002 ON anexos USING btree (anex_borrado, radi_nume_salida, anex_creador, anex_estado, sgd_deve_codigo);


--
-- Name: ano; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ano ON sgd_archivo_central USING btree (sgd_archivo_year);


--
-- Name: bloqueo; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX bloqueo ON series USING btree (bloq);


--
-- Name: busqueda; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX busqueda ON sgd_archivo_central USING btree (sgd_archivo_demandado, sgd_archivo_demandante, sgd_archivo_orden);


--
-- Name: carpetas_per; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX carpetas_per ON carpeta_per USING btree (codi_carp, depe_codi, usua_codi);


--
-- Name: carpetas_per1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX carpetas_per1 ON carpeta_per USING btree (usua_codi, depe_codi);


--
-- Name: carpetas_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX carpetas_pk ON carpeta USING btree (carp_codi);


--
-- Name: carro; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX carro ON sgd_archivo_central USING btree (sgd_archivo_carro);


--
-- Name: departamento_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX departamento_pk ON departamento USING btree (dpto_codi);


--
-- Name: dependencia_visibilidad_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX dependencia_visibilidad_pk ON dependencia_visibilidad USING btree (codigo_visibilidad);


--
-- Name: hist_consulta; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hist_consulta ON hist_eventos USING btree (radi_nume_radi, hist_fech, depe_codi, usua_codi);


--
-- Name: hist_consulta_archivo; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hist_consulta_archivo ON sgd_archivo_hist USING btree (sgd_archivo_rad, hist_fech, depe_codi, usua_codi);


--
-- Name: hist_tipotrans; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hist_tipotrans ON hist_eventos USING btree (sgd_ttr_codigo);


--
-- Name: hist_tipotrans_archivo; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX hist_tipotrans_archivo ON sgd_archivo_hist USING btree (sgd_ttr_codigo);


--
-- Name: idx_dependencia; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dependencia ON sgd_archivo_central USING btree (sgd_archivo_depe);


--
-- Name: idx_sgd_eanu_codigo; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_sgd_eanu_codigo ON radicado USING btree (sgd_eanu_codigo);


--
-- Name: ind_anex_codigo; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_anex_codigo ON sgd_dir_drecciones USING btree (sgd_anex_codigo);


--
-- Name: ind_anex_depe_codi; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_anex_depe_codi ON anexos USING btree (anex_depe_codi);


--
-- Name: ind_anex_dir_tipo; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_anex_dir_tipo ON anexos USING btree (sgd_dir_tipo);


--
-- Name: ind_anex_estado; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_anex_estado ON anexos USING btree (anex_estado);


--
-- Name: ind_anex_numero; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_anex_numero ON anexos USING btree (anex_numero);


--
-- Name: ind_anex_radi; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_anex_radi ON anexos USING btree (anex_radi_nume);


--
-- Name: ind_anex_radi_sal; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_anex_radi_sal ON anexos USING btree (radi_nume_salida);


--
-- Name: ind_bodega_empresas; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_bodega_empresas ON bodega_empresas USING btree (identificador_empresa);


--
-- Name: ind_dir_ciu_codigo; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_dir_ciu_codigo ON sgd_dir_drecciones USING btree (sgd_ciu_codigo);


--
-- Name: ind_dir_direcc_sgd_esp_codi; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_dir_direcc_sgd_esp_codi ON sgd_dir_drecciones USING btree (sgd_esp_codi);


--
-- Name: ind_exp_radi; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_exp_radi ON sgd_exp_expediente USING btree (radi_nume_radi);


--
-- Name: ind_informado_depe_codi; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_informado_depe_codi ON informados USING btree (depe_codi);


--
-- Name: ind_informado_usua; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_informado_usua ON informados USING btree (usua_codi);


--
-- Name: ind_radi_cuentai; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_radi_cuentai ON radicado USING btree (radi_cuentai);


--
-- Name: ind_radi_depe_actu; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_radi_depe_actu ON radicado USING btree (radi_depe_actu);


--
-- Name: ind_radi_fech_radi; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_radi_fech_radi ON radicado USING btree (radi_fech_radi);


--
-- Name: ind_radi_mrec_codi; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_radi_mrec_codi ON radicado USING btree (mrec_codi);


--
-- Name: ind_radi_mtd_codigo; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_radi_mtd_codigo ON radicado USING btree (sgd_mtd_codigo);


--
-- Name: ind_radi_par_serv; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_radi_par_serv ON radicado USING btree (par_serv_secue);


--
-- Name: ind_radicado_codi_nivel; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_radicado_codi_nivel ON radicado USING btree (codi_nivel);


--
-- Name: ind_radicado_radi_path; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_radicado_radi_path ON radicado USING btree (radi_path);


--
-- Name: ind_radicado_tdoc_codi; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_radicado_tdoc_codi ON radicado USING btree (tdoc_codi);


--
-- Name: ind_rfax_codigo; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_rfax_codigo ON sgd_rfax_reservafax USING btree (sgd_rfax_codigo);


--
-- Name: ind_rfax_fax; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_rfax_fax ON sgd_rfax_reservafax USING btree (sgd_rfax_fax);


--
-- Name: ind_rfax_fech; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_rfax_fech ON sgd_rfax_reservafax USING btree (sgd_rfax_fech);


--
-- Name: ind_rfax_radi_nume_radi; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_rfax_radi_nume_radi ON sgd_rfax_reservafax USING btree (radi_nume_radi);


--
-- Name: ind_sgd_dir_nombre; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_sgd_dir_nombre ON sgd_dir_drecciones USING btree (sgd_dir_nombre);


--
-- Name: ind_sgd_dir_nomremdes; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_sgd_dir_nomremdes ON sgd_dir_drecciones USING btree (sgd_dir_nomremdes);


--
-- Name: ind_sgd_dir_oem_codigo; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_sgd_dir_oem_codigo ON sgd_dir_drecciones USING btree (sgd_oem_codigo);


--
-- Name: ind_sgd_dir_radi_nume; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_sgd_dir_radi_nume ON sgd_dir_drecciones USING btree (radi_nume_radi);


--
-- Name: ind_sgd_doc_fun; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_sgd_doc_fun ON sgd_dir_drecciones USING btree (sgd_doc_fun);


--
-- Name: ind_sgd_tpr_tpdocdescrp; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_sgd_tpr_tpdocdescrp ON sgd_tpr_tpdcumento USING btree (sgd_tpr_descrip);


--
-- Name: ind_sgd_trd_codigo; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ind_sgd_trd_codigo ON sgd_dir_drecciones USING btree (sgd_trd_codigo);


--
-- Name: informado_usuario; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX informado_usuario ON informados USING btree (depe_codi, usua_codi, info_fech);


--
-- Name: municipio_depto_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX municipio_depto_idx ON municipio USING btree (dpto_codi);


--
-- Name: padre; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX padre ON sgd_eit_items USING btree (sgd_eit_cod_padre);


--
-- Name: pk_depe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_depe ON dependencia USING btree (depe_codi);


--
-- Name: pk_dpto_muni; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX pk_dpto_muni ON dependencia USING btree (depe_codi, muni_codi);


--
-- Name: pk_encuesta; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_encuesta ON encuesta USING btree (usua_doc);


--
-- Name: pk_estanulacion; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_estanulacion ON sgd_eanu_estanulacion USING btree (sgd_eanu_codi);


--
-- Name: pk_medio_recepcion; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_medio_recepcion ON medio_recepcion USING btree (mrec_codi);


--
-- Name: pk_municipio; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_municipio ON municipio USING btree (muni_codi, dpto_codi);


--
-- Name: pk_par_serv_servicios; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_par_serv_servicios ON par_serv_servicios USING btree (par_serv_secue);


--
-- Name: pk_peranualdos; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_peranualdos ON sgd_panu_peranulados USING btree (sgd_panu_codi);


--
-- Name: pk_prestamo; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_prestamo ON prestamo USING btree (pres_id);


--
-- Name: pk_radi; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX pk_radi ON pqr USING btree (radi_nume_radi);


--
-- Name: pk_seri; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_seri ON series USING btree (depe_codi, seri_tipo, seri_ano);


--
-- Name: pk_sgd_acm_acusemsg; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_acm_acusemsg ON sgd_acm_acusemsg USING btree (sgd_msg_codi, usua_doc);


--
-- Name: pk_sgd_anar_anexarg; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_anar_anexarg ON sgd_anar_anexarg USING btree (sgd_anar_codi);


--
-- Name: pk_sgd_apli_aplintegra; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_apli_aplintegra ON sgd_apli_aplintegra USING btree (sgd_apli_codi);


--
-- Name: pk_sgd_aplus_plicusua; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_aplus_plicusua ON sgd_aplus_plicusua USING btree (sgd_aplus_codi);


--
-- Name: pk_sgd_argd_argdoc; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_argd_argdoc ON sgd_argd_argdoc USING btree (sgd_argd_codi);


--
-- Name: pk_sgd_camexp_campoexpediente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_camexp_campoexpediente ON sgd_camexp_campoexpediente USING btree (sgd_camexp_codigo);


--
-- Name: pk_sgd_cau_causal; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_cau_causal ON sgd_cau_causal USING btree (sgd_cau_codigo);


--
-- Name: pk_sgd_caux_causales; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_caux_causales ON sgd_caux_causales USING btree (sgd_caux_codigo);


--
-- Name: pk_sgd_ciu_ciudadano; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_ciu_ciudadano ON sgd_ciu_ciudadano USING btree (sgd_ciu_codigo);


--
-- Name: pk_sgd_cob_campobliga; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_cob_campobliga ON sgd_cob_campobliga USING btree (sgd_cob_codi);


--
-- Name: pk_sgd_dcau_causal; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_dcau_causal ON sgd_dcau_causal USING btree (sgd_dcau_codigo);


--
-- Name: pk_sgd_ddca_ddsgrgdo; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_ddca_ddsgrgdo ON sgd_ddca_ddsgrgdo USING btree (sgd_ddca_codigo);


--
-- Name: pk_sgd_deve; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_deve ON sgd_deve_dev_envio USING btree (sgd_deve_codigo);


--
-- Name: pk_sgd_dir; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_dir ON sgd_dir_drecciones USING btree (sgd_dir_codigo);


--
-- Name: pk_sgd_dnufe_docnufe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_dnufe_docnufe ON sgd_dnufe_docnufe USING btree (sgd_dnufe_codi);


--
-- Name: pk_sgd_fenv; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_fenv ON sgd_fenv_frmenvio USING btree (sgd_fenv_codigo);


--
-- Name: pk_sgd_fexp_descrip; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_fexp_descrip ON sgd_fexp_flujoexpedientes USING btree (sgd_fexp_codigo);


--
-- Name: pk_sgd_firrad_firmarads; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_firrad_firmarads ON sgd_firrad_firmarads USING btree (sgd_firrad_id);


--
-- Name: pk_sgd_fun_funciones; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_fun_funciones ON sgd_fun_funciones USING btree (sgd_fun_codigo);


--
-- Name: pk_sgd_hmtd_hismatdoc; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_hmtd_hismatdoc ON sgd_hmtd_hismatdoc USING btree (sgd_hmtd_codigo);


--
-- Name: pk_sgd_mat_matriz; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_mat_matriz ON sgd_mat_matriz USING btree (sgd_mat_codigo);


--
-- Name: pk_sgd_mrd_matrird; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_mrd_matrird ON sgd_mrd_matrird USING btree (sgd_mrd_codigo);


--
-- Name: pk_sgd_msdep_msgdep; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_msdep_msgdep ON sgd_msdep_msgdep USING btree (sgd_msdep_codi);


--
-- Name: pk_sgd_msg_mensaje; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_msg_mensaje ON sgd_msg_mensaje USING btree (sgd_msg_codi);


--
-- Name: pk_sgd_mtd_matriz_doc; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_mtd_matriz_doc ON sgd_mtd_matriz_doc USING btree (sgd_mtd_codigo);


--
-- Name: pk_sgd_not; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_not ON sgd_not_notificacion USING btree (sgd_not_codi);


--
-- Name: pk_sgd_oem_oempresas; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_oem_oempresas ON sgd_oem_oempresas USING btree (sgd_oem_codigo);


--
-- Name: pk_sgd_parexp_paramexpediente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_parexp_paramexpediente ON sgd_parexp_paramexpediente USING btree (sgd_parexp_codigo);


--
-- Name: pk_sgd_pexp_procexpedientes; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_pexp_procexpedientes ON sgd_pexp_procexpedientes USING btree (sgd_pexp_codigo);


--
-- Name: pk_sgd_pnufe_procnumfe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_pnufe_procnumfe ON sgd_pnufe_procnumfe USING btree (sgd_pnufe_codi);


--
-- Name: pk_sgd_pnun_procenum; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_pnun_procenum ON sgd_pnun_procenum USING btree (sgd_pnun_codi);


--
-- Name: pk_sgd_prc_proceso; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_prc_proceso ON sgd_prc_proceso USING btree (sgd_prc_codigo);


--
-- Name: pk_sgd_prd_prcdmentos; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_prd_prcdmentos ON sgd_prd_prcdmentos USING btree (sgd_prd_codigo);


--
-- Name: pk_sgd_rmr_radmasivre; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_rmr_radmasivre ON sgd_rmr_radmasivre USING btree (sgd_rmr_grupo, sgd_rmr_radi);


--
-- Name: pk_sgd_san_sancionados; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_san_sancionados ON sgd_san_sancionados USING btree (sgd_san_ref);


--
-- Name: pk_sgd_sexp_parexp5; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX pk_sgd_sexp_parexp5 ON sgd_sexp_secexpedientes USING btree (sgd_sexp_parexp5);


--
-- Name: pk_sgd_sexp_secexpedientes; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_sexp_secexpedientes ON sgd_sexp_secexpedientes USING btree (sgd_exp_numero);


--
-- Name: pk_sgd_srd_seriesrd; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_srd_seriesrd ON sgd_srd_seriesrd USING btree (sgd_srd_codigo);


--
-- Name: pk_sgd_tdec_tipodecision; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_tdec_tipodecision ON sgd_tdec_tipodecision USING btree (sgd_tdec_codigo);


--
-- Name: pk_sgd_tid_tipdecision; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_tid_tipdecision ON sgd_tid_tipdecision USING btree (sgd_tid_codi);


--
-- Name: pk_sgd_tma_temas; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_tma_temas ON sgd_tma_temas USING btree (sgd_tma_codigo);


--
-- Name: pk_sgd_tme_tipmen; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_tme_tipmen ON sgd_tme_tipmen USING btree (sgd_tme_codi);


--
-- Name: pk_sgd_tpr_tpdcumento; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_tpr_tpdcumento ON sgd_tpr_tpdcumento USING btree (sgd_tpr_codigo);


--
-- Name: pk_sgd_ttr_transaccion; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_sgd_ttr_transaccion ON sgd_ttr_transaccion USING btree (sgd_ttr_codigo);


--
-- Name: pk_tdm_tidomasiva; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX pk_tdm_tidomasiva ON sgd_tidm_tidocmasiva USING btree (sgd_tidm_codi);


--
-- Name: radi_nume_radi; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX radi_nume_radi ON hist_eventos USING btree (radi_nume_radi);


--
-- Name: radicado_archivo; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX radicado_archivo ON sgd_archivo_central USING btree (sgd_archivo_rad);


--
-- Name: radicado_dependencia; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX radicado_dependencia ON radicado USING btree (radi_cuentai, radi_usua_actu, carp_codi);


--
-- Name: radicado_idx_001; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX radicado_idx_001 ON radicado USING btree (radi_nume_radi, tdoc_codi, radi_usua_actu, radi_depe_actu, codi_nivel, radi_fech_radi);


--
-- Name: radicado_idx_003; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX radicado_idx_003 ON radicado USING btree (radi_depe_radi, radi_nume_radi, sgd_eanu_codigo);


--
-- Name: radicado_informados; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX radicado_informados ON informados USING btree (radi_nume_radi);


--
-- Name: radicado_orden; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX radicado_orden ON radicado USING btree (radi_fech_asig, radi_fech_radi, radi_usua_actu, radi_depe_actu, carp_codi);


--
-- Name: radicado_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX radicado_pk ON radicado USING btree (radi_nume_radi);


--
-- Name: sgd_archivo_central_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX sgd_archivo_central_pk ON sgd_archivo_central USING btree (sgd_archivo_id);


--
-- Name: sgd_archivo_rad; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX sgd_archivo_rad ON sgd_archivo_hist USING btree (sgd_archivo_rad);


--
-- Name: sgd_bodega_; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX sgd_bodega_ ON bodega_empresas USING btree (nuir);


--
-- Name: sgd_bodega_are_esp_secue; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX sgd_bodega_are_esp_secue ON bodega_empresas USING btree (are_esp_secue);


--
-- Name: sgd_bodega_nit; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX sgd_bodega_nit ON bodega_empresas USING btree (nit_de_la_empresa);


--
-- Name: sgd_bodega_nombre; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX sgd_bodega_nombre ON bodega_empresas USING btree (nombre_de_la_empresa);


--
-- Name: sgd_bodega_rep_legal; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX sgd_bodega_rep_legal ON bodega_empresas USING btree (nombre_rep_legal);


--
-- Name: sgd_bodega_sigla; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX sgd_bodega_sigla ON bodega_empresas USING btree (sigla_de_la_empresa);


--
-- Name: sgd_buscar_nombre; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX sgd_buscar_nombre ON sgd_ciu_ciudadano USING btree (sgd_ciu_apell1, sgd_ciu_apell2, sgd_ciu_nombre);


--
-- Name: sgd_busq_cedula; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX sgd_busq_cedula ON sgd_ciu_ciudadano USING btree (sgd_ciu_cedula);


--
-- Name: sgd_busq_nit; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX sgd_busq_nit ON sgd_oem_oempresas USING btree (sgd_oem_nit);


--
-- Name: sgd_dir_drecciones_idx_001; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX sgd_dir_drecciones_idx_001 ON sgd_dir_drecciones USING btree (sgd_dir_tipo, radi_nume_radi, sgd_esp_codi);


--
-- Name: sgd_expediente_depe_usua; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX sgd_expediente_depe_usua ON sgd_exp_expediente USING btree (usua_codi, depe_codi);


--
-- Name: sgd_expediente_fecha; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX sgd_expediente_fecha ON sgd_exp_expediente USING btree (sgd_exp_fech);


--
-- Name: sgd_expediente_nume_radi; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX sgd_expediente_nume_radi ON sgd_exp_expediente USING btree (sgd_exp_numero, radi_nume_radi);


--
-- Name: sgd_expediente_usua_doc; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX sgd_expediente_usua_doc ON sgd_exp_expediente USING btree (usua_doc);


--
-- Name: sgd_fars_faristas_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX sgd_fars_faristas_pk ON sgd_fars_faristas USING btree (sgd_fars_codigo);


--
-- Name: sgd_parametro_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX sgd_parametro_pk ON sgd_parametro USING btree (param_nomb, param_codi);


--
-- Name: sgd_tdec_tipodecision_inx1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX sgd_tdec_tipodecision_inx1 ON sgd_tdec_tipodecision USING btree (sgd_tdec_showmenu);


--
-- Name: sgd_trad_tiporad_codigo_inx2; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX sgd_trad_tiporad_codigo_inx2 ON sgd_trad_tiporad USING btree (sgd_trad_codigo);


--
-- Name: sqg_busq_empresa; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX sqg_busq_empresa ON sgd_oem_oempresas USING btree (sgd_oem_oempresa, sgd_oem_sigla);


--
-- Name: tipo_doc_identificacion_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX tipo_doc_identificacion_pk ON tipo_doc_identificacion USING btree (tdid_codi);


--
-- Name: tipo_remitente_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX tipo_remitente_pk ON tipo_remitente USING btree (trte_codi);


--
-- Name: uk_sgd_mat; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX uk_sgd_mat ON sgd_mat_matriz USING btree (depe_codi, sgd_fun_codigo, sgd_prc_codigo, sgd_prd_codigo);


--
-- Name: uk_sgd_mrd_matrird; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX uk_sgd_mrd_matrird ON sgd_mrd_matrird USING btree (depe_codi, sgd_srd_codigo, sgd_sbrd_codigo, sgd_tpr_codigo);


--
-- Name: uk_sgd_rdf_retdocf; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX uk_sgd_rdf_retdocf ON sgd_rdf_retdocf USING btree (radi_nume_radi, depe_codi, sgd_mrd_codigo);


--
-- Name: uk_sgd_sbrd_subserierd; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX uk_sgd_sbrd_subserierd ON sgd_sbrd_subserierd USING btree (sgd_srd_codigo, sgd_sbrd_codigo);


--
-- Name: uk_sgd_srd_descrip; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX uk_sgd_srd_descrip ON sgd_srd_seriesrd USING btree (sgd_srd_descrip);


--
-- Name: usua_doc; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX usua_doc ON usuario USING btree (usua_doc);


--
-- Name: usuario_depe_codi; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX usuario_depe_codi ON usuario USING btree (depe_codi);


--
-- Name: usuario_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX usuario_pk ON usuario USING btree (usua_login);


--
-- Name: usuario_uk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX usuario_uk ON usuario USING btree (usua_codi, depe_codi);


--
-- Name: fk_hist_depe_archivo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_archivo_hist
    ADD CONSTRAINT fk_hist_depe_archivo FOREIGN KEY (depe_codi) REFERENCES dependencia(depe_codi);


--
-- Name: fk_municipi_ref_128_departam; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY municipio
    ADD CONSTRAINT fk_municipi_ref_128_departam FOREIGN KEY (dpto_codi) REFERENCES departamento(dpto_codi);


--
-- Name: sgd_carp_descripcion_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_carp_descripcion
    ADD CONSTRAINT sgd_carp_descripcion_fk1 FOREIGN KEY (sgd_carp_depecodi) REFERENCES dependencia(depe_codi) ON DELETE RESTRICT;


--
-- Name: sgd_carp_descripcion_fk2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_carp_descripcion
    ADD CONSTRAINT sgd_carp_descripcion_fk2 FOREIGN KEY (sgd_carp_tiporad) REFERENCES sgd_trad_tiporad(sgd_trad_codigo) ON DELETE RESTRICT;


--
-- Name: sgd_tmd_temadepe_depe_codi_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_tmd_temadepe
    ADD CONSTRAINT sgd_tmd_temadepe_depe_codi_fkey FOREIGN KEY (depe_codi) REFERENCES dependencia(depe_codi);


--
-- Name: sgd_tmd_temadepe_sgd_tma_codigo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sgd_tmd_temadepe
    ADD CONSTRAINT sgd_tmd_temadepe_sgd_tma_codigo_fkey FOREIGN KEY (sgd_tma_codigo) REFERENCES sgd_tma_temas(sgd_tma_codigo);


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

