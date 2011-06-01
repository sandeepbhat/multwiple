DROP DATABASE "multwipleDB" IF EXISTS;
--
-- PostgreSQL database dump
--

-- Started on 2010-01-11 12:52:34 IST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 1787 (class 1262 OID 16384)
-- Name: multwipleDB; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "multwipleDB" WITH TEMPLATE = template0 ENCODING = 'UTF8'; 


ALTER DATABASE "multwipleDB" OWNER TO postgres;

\connect "multwipleDB"

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 6 (class 2615 OID 16397)
-- Name: main; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA main;


ALTER SCHEMA main OWNER TO postgres;

SET search_path = main, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1500 (class 1259 OID 16400)
-- Dependencies: 1780 6
-- Name: member; Type: TABLE; Schema: main; Owner: postgres; Tablespace: 
--

CREATE TABLE member (
    id integer NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    creation_date date NOT NULL,
    login_date date,
    login_salt text,
    parent_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE main.member OWNER TO postgres;

--
-- TOC entry 1499 (class 1259 OID 16398)
-- Dependencies: 1500 6
-- Name: member_id_seq; Type: SEQUENCE; Schema: main; Owner: postgres
--

CREATE SEQUENCE member_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE main.member_id_seq OWNER TO postgres;

--
-- TOC entry 1792 (class 0 OID 0)
-- Dependencies: 1499
-- Name: member_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: postgres
--

ALTER SEQUENCE member_id_seq OWNED BY member.id;


SET search_path = public, pg_catalog;

--
-- TOC entry 1498 (class 1259 OID 16387)
-- Dependencies: 3
-- Name: users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    login text NOT NULL,
    passwd_salt text NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 1497 (class 1259 OID 16385)
-- Dependencies: 1498 3
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 1794 (class 0 OID 0)
-- Dependencies: 1497
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


SET search_path = main, pg_catalog;

--
-- TOC entry 1779 (class 2604 OID 16409)
-- Dependencies: 1500 1499 1500
-- Name: id; Type: DEFAULT; Schema: main; Owner: postgres
--

ALTER TABLE member ALTER COLUMN id SET DEFAULT nextval('member_id_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- TOC entry 1778 (class 2604 OID 16390)
-- Dependencies: 1498 1497 1498
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


SET search_path = main, pg_catalog;

--
-- TOC entry 1784 (class 2606 OID 16408)
-- Dependencies: 1500 1500
-- Name: m_id_pky; Type: CONSTRAINT; Schema: main; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY member
    ADD CONSTRAINT m_id_pky PRIMARY KEY (id);


SET search_path = public, pg_catalog;

--
-- TOC entry 1782 (class 2606 OID 16395)
-- Dependencies: 1498 1498
-- Name: usr_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT usr_id_pkey PRIMARY KEY (id);


--
-- TOC entry 1788 (class 0 OID 0)
-- Dependencies: 6
-- Name: main; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA main FROM PUBLIC;
REVOKE ALL ON SCHEMA main FROM postgres;
GRANT ALL ON SCHEMA main TO postgres;
GRANT ALL ON SCHEMA main TO PUBLIC;


--
-- TOC entry 1790 (class 0 OID 0)
-- Dependencies: 3
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


SET search_path = main, pg_catalog;

--
-- TOC entry 1791 (class 0 OID 0)
-- Dependencies: 1500
-- Name: member; Type: ACL; Schema: main; Owner: postgres
--

REVOKE ALL ON TABLE member FROM PUBLIC;
REVOKE ALL ON TABLE member FROM postgres;
GRANT ALL ON TABLE member TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE member TO PUBLIC;


--
-- TOC entry 1793 (class 0 OID 0)
-- Dependencies: 1499
-- Name: member_id_seq; Type: ACL; Schema: main; Owner: postgres
--

REVOKE ALL ON SEQUENCE member_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE member_id_seq FROM postgres;
GRANT ALL ON SEQUENCE member_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE member_id_seq TO PUBLIC;


-- Completed on 2010-01-11 12:52:39 IST

--
-- PostgreSQL database dump complete
--

