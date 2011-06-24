DROP DATABASE "multwipleDB";
--
-- PostgreSQL database dump
--

-- Started on 2011-06-24 22:49:04 IST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 1844 (class 1262 OID 24182)
-- Name: multwipleDB; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "multwipleDB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_IN' LC_CTYPE = 'en_IN';


ALTER DATABASE "multwipleDB" OWNER TO postgres;

\connect "multwipleDB"

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 6 (class 2615 OID 24183)
-- Name: main; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA main;


ALTER SCHEMA main OWNER TO postgres;

SET search_path = main, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1520 (class 1259 OID 24184)
-- Dependencies: 6
-- Name: actions; Type: TABLE; Schema: main; Owner: mtwiple_user; Tablespace: 
--

CREATE TABLE actions (
    id integer NOT NULL,
    action text
);


ALTER TABLE main.actions OWNER TO mtwiple_user;

--
-- TOC entry 1521 (class 1259 OID 24190)
-- Dependencies: 1520 6
-- Name: actions_id_seq; Type: SEQUENCE; Schema: main; Owner: mtwiple_user
--

CREATE SEQUENCE actions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE main.actions_id_seq OWNER TO mtwiple_user;

--
-- TOC entry 1848 (class 0 OID 0)
-- Dependencies: 1521
-- Name: actions_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: mtwiple_user
--

ALTER SEQUENCE actions_id_seq OWNED BY actions.id;


--
-- TOC entry 1849 (class 0 OID 0)
-- Dependencies: 1521
-- Name: actions_id_seq; Type: SEQUENCE SET; Schema: main; Owner: mtwiple_user
--

SELECT pg_catalog.setval('actions_id_seq', 1, false);


--
-- TOC entry 1534 (class 1259 OID 24264)
-- Dependencies: 6
-- Name: feeds; Type: TABLE; Schema: main; Owner: mtwiple_user; Tablespace: 
--

CREATE TABLE feeds (
    id integer NOT NULL,
    feed_url text,
    user_id integer,
    group_id integer,
    feed_title text
);


ALTER TABLE main.feeds OWNER TO mtwiple_user;

--
-- TOC entry 1533 (class 1259 OID 24262)
-- Dependencies: 1534 6
-- Name: feeds_id_seq; Type: SEQUENCE; Schema: main; Owner: mtwiple_user
--

CREATE SEQUENCE feeds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE main.feeds_id_seq OWNER TO mtwiple_user;

--
-- TOC entry 1850 (class 0 OID 0)
-- Dependencies: 1533
-- Name: feeds_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: mtwiple_user
--

ALTER SEQUENCE feeds_id_seq OWNED BY feeds.id;


--
-- TOC entry 1851 (class 0 OID 0)
-- Dependencies: 1533
-- Name: feeds_id_seq; Type: SEQUENCE SET; Schema: main; Owner: mtwiple_user
--

SELECT pg_catalog.setval('feeds_id_seq', 1, false);


--
-- TOC entry 1522 (class 1259 OID 24192)
-- Dependencies: 6
-- Name: login_tokens; Type: TABLE; Schema: main; Owner: mtwiple_user; Tablespace: 
--

CREATE TABLE login_tokens (
    id integer NOT NULL,
    token text,
    secret text,
    rawstring text,
    creation_date date,
    group_id integer,
    session text
);


ALTER TABLE main.login_tokens OWNER TO mtwiple_user;

--
-- TOC entry 1523 (class 1259 OID 24198)
-- Dependencies: 1522 6
-- Name: login_tokens_id_seq; Type: SEQUENCE; Schema: main; Owner: mtwiple_user
--

CREATE SEQUENCE login_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE main.login_tokens_id_seq OWNER TO mtwiple_user;

--
-- TOC entry 1852 (class 0 OID 0)
-- Dependencies: 1523
-- Name: login_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: mtwiple_user
--

ALTER SEQUENCE login_tokens_id_seq OWNED BY login_tokens.id;


--
-- TOC entry 1853 (class 0 OID 0)
-- Dependencies: 1523
-- Name: login_tokens_id_seq; Type: SEQUENCE SET; Schema: main; Owner: mtwiple_user
--

SELECT pg_catalog.setval('login_tokens_id_seq', 1, false);


--
-- TOC entry 1524 (class 1259 OID 24200)
-- Dependencies: 6
-- Name: logs; Type: TABLE; Schema: main; Owner: mtwiple_user; Tablespace: 
--

CREATE TABLE logs (
    id integer NOT NULL,
    log_user_id integer,
    log_screen_name text,
    action_id integer,
    log_date date,
    log_data text
);


ALTER TABLE main.logs OWNER TO mtwiple_user;

--
-- TOC entry 1525 (class 1259 OID 24206)
-- Dependencies: 6 1524
-- Name: logs_id_seq; Type: SEQUENCE; Schema: main; Owner: mtwiple_user
--

CREATE SEQUENCE logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE main.logs_id_seq OWNER TO mtwiple_user;

--
-- TOC entry 1854 (class 0 OID 0)
-- Dependencies: 1525
-- Name: logs_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: mtwiple_user
--

ALTER SEQUENCE logs_id_seq OWNED BY logs.id;


--
-- TOC entry 1855 (class 0 OID 0)
-- Dependencies: 1525
-- Name: logs_id_seq; Type: SEQUENCE SET; Schema: main; Owner: mtwiple_user
--

SELECT pg_catalog.setval('logs_id_seq', 1, false);


--
-- TOC entry 1526 (class 1259 OID 24208)
-- Dependencies: 6
-- Name: user_group; Type: TABLE; Schema: main; Owner: mtwiple_user; Tablespace: 
--

CREATE TABLE user_group (
    id integer NOT NULL,
    group_salt text,
    update_interval integer
);


ALTER TABLE main.user_group OWNER TO mtwiple_user;

--
-- TOC entry 1527 (class 1259 OID 24214)
-- Dependencies: 6 1526
-- Name: user_group_id_seq; Type: SEQUENCE; Schema: main; Owner: mtwiple_user
--

CREATE SEQUENCE user_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE main.user_group_id_seq OWNER TO mtwiple_user;

--
-- TOC entry 1856 (class 0 OID 0)
-- Dependencies: 1527
-- Name: user_group_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: mtwiple_user
--

ALTER SEQUENCE user_group_id_seq OWNED BY user_group.id;


--
-- TOC entry 1857 (class 0 OID 0)
-- Dependencies: 1527
-- Name: user_group_id_seq; Type: SEQUENCE SET; Schema: main; Owner: mtwiple_user
--

SELECT pg_catalog.setval('user_group_id_seq', 1, false);


--
-- TOC entry 1528 (class 1259 OID 24216)
-- Dependencies: 6
-- Name: user_tokens; Type: TABLE; Schema: main; Owner: mtwiple_user; Tablespace: 
--

CREATE TABLE user_tokens (
    id integer NOT NULL,
    user_id integer,
    screen_name text,
    token text,
    secret text NOT NULL,
    rawstring text,
    creation_date date,
    login_date date,
    group_id integer NOT NULL,
    home_id bigint,
    direct_id bigint,
    mention_id bigint,
    image_url text
);


ALTER TABLE main.user_tokens OWNER TO mtwiple_user;

--
-- TOC entry 1529 (class 1259 OID 24222)
-- Dependencies: 6 1528
-- Name: user_tokens_id_seq; Type: SEQUENCE; Schema: main; Owner: mtwiple_user
--

CREATE SEQUENCE user_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE main.user_tokens_id_seq OWNER TO mtwiple_user;

--
-- TOC entry 1858 (class 0 OID 0)
-- Dependencies: 1529
-- Name: user_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: mtwiple_user
--

ALTER SEQUENCE user_tokens_id_seq OWNED BY user_tokens.id;


--
-- TOC entry 1859 (class 0 OID 0)
-- Dependencies: 1529
-- Name: user_tokens_id_seq; Type: SEQUENCE SET; Schema: main; Owner: mtwiple_user
--

SELECT pg_catalog.setval('user_tokens_id_seq', 1, false);


SET search_path = public, pg_catalog;

--
-- TOC entry 1530 (class 1259 OID 24224)
-- Dependencies: 7
-- Name: actions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE actions (
    id integer NOT NULL,
    action text
);


ALTER TABLE public.actions OWNER TO postgres;

--
-- TOC entry 1531 (class 1259 OID 24230)
-- Dependencies: 7
-- Name: users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    login text NOT NULL,
    passwd_salt text NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 1532 (class 1259 OID 24236)
-- Dependencies: 7 1531
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
-- TOC entry 1860 (class 0 OID 0)
-- Dependencies: 1532
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- TOC entry 1861 (class 0 OID 0)
-- Dependencies: 1532
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 1, false);


SET search_path = main, pg_catalog;

--
-- TOC entry 1812 (class 2604 OID 24238)
-- Dependencies: 1521 1520
-- Name: id; Type: DEFAULT; Schema: main; Owner: mtwiple_user
--

ALTER TABLE actions ALTER COLUMN id SET DEFAULT nextval('actions_id_seq'::regclass);


--
-- TOC entry 1818 (class 2604 OID 24267)
-- Dependencies: 1534 1533 1534
-- Name: id; Type: DEFAULT; Schema: main; Owner: mtwiple_user
--

ALTER TABLE feeds ALTER COLUMN id SET DEFAULT nextval('feeds_id_seq'::regclass);


--
-- TOC entry 1813 (class 2604 OID 24239)
-- Dependencies: 1523 1522
-- Name: id; Type: DEFAULT; Schema: main; Owner: mtwiple_user
--

ALTER TABLE login_tokens ALTER COLUMN id SET DEFAULT nextval('login_tokens_id_seq'::regclass);


--
-- TOC entry 1814 (class 2604 OID 24240)
-- Dependencies: 1525 1524
-- Name: id; Type: DEFAULT; Schema: main; Owner: mtwiple_user
--

ALTER TABLE logs ALTER COLUMN id SET DEFAULT nextval('logs_id_seq'::regclass);


--
-- TOC entry 1815 (class 2604 OID 24241)
-- Dependencies: 1527 1526
-- Name: id; Type: DEFAULT; Schema: main; Owner: mtwiple_user
--

ALTER TABLE user_group ALTER COLUMN id SET DEFAULT nextval('user_group_id_seq'::regclass);


--
-- TOC entry 1816 (class 2604 OID 24242)
-- Dependencies: 1529 1528
-- Name: id; Type: DEFAULT; Schema: main; Owner: mtwiple_user
--

ALTER TABLE user_tokens ALTER COLUMN id SET DEFAULT nextval('user_tokens_id_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- TOC entry 1817 (class 2604 OID 24243)
-- Dependencies: 1532 1531
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


SET search_path = main, pg_catalog;

--
-- TOC entry 1834 (class 0 OID 24184)
-- Dependencies: 1520
-- Data for Name: actions; Type: TABLE DATA; Schema: main; Owner: mtwiple_user
--

COPY actions (id, action) FROM stdin;
\.


--
-- TOC entry 1841 (class 0 OID 24264)
-- Dependencies: 1534
-- Data for Name: feeds; Type: TABLE DATA; Schema: main; Owner: mtwiple_user
--

COPY feeds (id, feed_url, user_id, group_id, feed_title) FROM stdin;
\.


--
-- TOC entry 1835 (class 0 OID 24192)
-- Dependencies: 1522
-- Data for Name: login_tokens; Type: TABLE DATA; Schema: main; Owner: mtwiple_user
--

COPY login_tokens (id, token, secret, rawstring, creation_date, group_id, session) FROM stdin;
\.


--
-- TOC entry 1836 (class 0 OID 24200)
-- Dependencies: 1524
-- Data for Name: logs; Type: TABLE DATA; Schema: main; Owner: mtwiple_user
--

COPY logs (id, log_user_id, log_screen_name, action_id, log_date, log_data) FROM stdin;
\.


--
-- TOC entry 1837 (class 0 OID 24208)
-- Dependencies: 1526
-- Data for Name: user_group; Type: TABLE DATA; Schema: main; Owner: mtwiple_user
--

COPY user_group (id, group_salt, update_interval) FROM stdin;
\.


--
-- TOC entry 1838 (class 0 OID 24216)
-- Dependencies: 1528
-- Data for Name: user_tokens; Type: TABLE DATA; Schema: main; Owner: mtwiple_user
--

COPY user_tokens (id, user_id, screen_name, token, secret, rawstring, creation_date, login_date, group_id, home_id, direct_id, mention_id, image_url) FROM stdin;
\.


SET search_path = public, pg_catalog;

--
-- TOC entry 1839 (class 0 OID 24224)
-- Dependencies: 1530
-- Data for Name: actions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY actions (id, action) FROM stdin;
\.


--
-- TOC entry 1840 (class 0 OID 24230)
-- Dependencies: 1531
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (id, login, passwd_salt) FROM stdin;
\.


SET search_path = main, pg_catalog;

--
-- TOC entry 1820 (class 2606 OID 24245)
-- Dependencies: 1520 1520
-- Name: actions_key; Type: CONSTRAINT; Schema: main; Owner: mtwiple_user; Tablespace: 
--

ALTER TABLE ONLY actions
    ADD CONSTRAINT actions_key PRIMARY KEY (id);


--
-- TOC entry 1832 (class 2606 OID 24272)
-- Dependencies: 1534 1534
-- Name: feeds_id_pk; Type: CONSTRAINT; Schema: main; Owner: mtwiple_user; Tablespace: 
--

ALTER TABLE ONLY feeds
    ADD CONSTRAINT feeds_id_pk PRIMARY KEY (id);


--
-- TOC entry 1826 (class 2606 OID 24247)
-- Dependencies: 1526 1526
-- Name: grp_pky; Type: CONSTRAINT; Schema: main; Owner: mtwiple_user; Tablespace: 
--

ALTER TABLE ONLY user_group
    ADD CONSTRAINT grp_pky PRIMARY KEY (id);


--
-- TOC entry 1824 (class 2606 OID 24249)
-- Dependencies: 1524 1524
-- Name: logs_key; Type: CONSTRAINT; Schema: main; Owner: mtwiple_user; Tablespace: 
--

ALTER TABLE ONLY logs
    ADD CONSTRAINT logs_key PRIMARY KEY (id);


--
-- TOC entry 1822 (class 2606 OID 24251)
-- Dependencies: 1522 1522
-- Name: ltok_pky; Type: CONSTRAINT; Schema: main; Owner: mtwiple_user; Tablespace: 
--

ALTER TABLE ONLY login_tokens
    ADD CONSTRAINT ltok_pky PRIMARY KEY (id);


--
-- TOC entry 1828 (class 2606 OID 24253)
-- Dependencies: 1528 1528
-- Name: ustok_pky; Type: CONSTRAINT; Schema: main; Owner: mtwiple_user; Tablespace: 
--

ALTER TABLE ONLY user_tokens
    ADD CONSTRAINT ustok_pky PRIMARY KEY (id);


SET search_path = public, pg_catalog;

--
-- TOC entry 1830 (class 2606 OID 24255)
-- Dependencies: 1531 1531
-- Name: usr_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT usr_id_pkey PRIMARY KEY (id);


SET search_path = main, pg_catalog;

--
-- TOC entry 1833 (class 2606 OID 24256)
-- Dependencies: 1528 1825 1526
-- Name: usr_grp_fky; Type: FK CONSTRAINT; Schema: main; Owner: mtwiple_user
--

ALTER TABLE ONLY user_tokens
    ADD CONSTRAINT usr_grp_fky FOREIGN KEY (group_id) REFERENCES user_group(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1845 (class 0 OID 0)
-- Dependencies: 6
-- Name: main; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA main FROM PUBLIC;
REVOKE ALL ON SCHEMA main FROM postgres;
GRANT ALL ON SCHEMA main TO postgres;
GRANT ALL ON SCHEMA main TO PUBLIC;


--
-- TOC entry 1847 (class 0 OID 0)
-- Dependencies: 7
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2011-06-24 22:49:05 IST

--
-- PostgreSQL database dump complete
--

