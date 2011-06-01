DROP DATABASE "multwipleDB";
--
-- PostgreSQL database dump
--

-- Started on 2010-07-15 21:37:40 IST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 1829 (class 1262 OID 50260)
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
-- TOC entry 6 (class 2615 OID 50261)
-- Name: main; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA main;


ALTER SCHEMA main OWNER TO postgres;

SET search_path = main, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1513 (class 1259 OID 50262)
-- Dependencies: 6
-- Name: actions; Type: TABLE; Schema: main; Owner: mtwiple_user; Tablespace: 
--

CREATE TABLE actions (
    id integer NOT NULL,
    action text
);


ALTER TABLE main.actions OWNER TO mtwiple_user;

--
-- TOC entry 1514 (class 1259 OID 50268)
-- Dependencies: 6 1513
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
-- TOC entry 1833 (class 0 OID 0)
-- Dependencies: 1514
-- Name: actions_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: mtwiple_user
--

ALTER SEQUENCE actions_id_seq OWNED BY actions.id;


--
-- TOC entry 1834 (class 0 OID 0)
-- Dependencies: 1514
-- Name: actions_id_seq; Type: SEQUENCE SET; Schema: main; Owner: mtwiple_user
--

SELECT pg_catalog.setval('actions_id_seq', 22, true);


--
-- TOC entry 1515 (class 1259 OID 50270)
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
-- TOC entry 1516 (class 1259 OID 50276)
-- Dependencies: 1515 6
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
-- TOC entry 1835 (class 0 OID 0)
-- Dependencies: 1516
-- Name: login_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: mtwiple_user
--

ALTER SEQUENCE login_tokens_id_seq OWNED BY login_tokens.id;


--
-- TOC entry 1836 (class 0 OID 0)
-- Dependencies: 1516
-- Name: login_tokens_id_seq; Type: SEQUENCE SET; Schema: main; Owner: mtwiple_user
--

SELECT pg_catalog.setval('login_tokens_id_seq', 88, true);


--
-- TOC entry 1517 (class 1259 OID 50278)
-- Dependencies: 6
-- Name: logs; Type: TABLE; Schema: main; Owner: mtwiple_user; Tablespace: 
--

CREATE TABLE logs (
    id integer NOT NULL,
    log_user_id integer,
    log_screen_name text,
    action_id integer,
    log_date date
);


ALTER TABLE main.logs OWNER TO mtwiple_user;

--
-- TOC entry 1518 (class 1259 OID 50284)
-- Dependencies: 6 1517
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
-- TOC entry 1837 (class 0 OID 0)
-- Dependencies: 1518
-- Name: logs_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: mtwiple_user
--

ALTER SEQUENCE logs_id_seq OWNED BY logs.id;


--
-- TOC entry 1838 (class 0 OID 0)
-- Dependencies: 1518
-- Name: logs_id_seq; Type: SEQUENCE SET; Schema: main; Owner: mtwiple_user
--

SELECT pg_catalog.setval('logs_id_seq', 160, true);


--
-- TOC entry 1519 (class 1259 OID 50286)
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
-- TOC entry 1520 (class 1259 OID 50292)
-- Dependencies: 6 1519
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
-- TOC entry 1839 (class 0 OID 0)
-- Dependencies: 1520
-- Name: user_group_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: mtwiple_user
--

ALTER SEQUENCE user_group_id_seq OWNED BY user_group.id;


--
-- TOC entry 1840 (class 0 OID 0)
-- Dependencies: 1520
-- Name: user_group_id_seq; Type: SEQUENCE SET; Schema: main; Owner: mtwiple_user
--

SELECT pg_catalog.setval('user_group_id_seq', 27, true);


--
-- TOC entry 1521 (class 1259 OID 50294)
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
-- TOC entry 1522 (class 1259 OID 50300)
-- Dependencies: 1521 6
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
-- TOC entry 1841 (class 0 OID 0)
-- Dependencies: 1522
-- Name: user_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: mtwiple_user
--

ALTER SEQUENCE user_tokens_id_seq OWNED BY user_tokens.id;


--
-- TOC entry 1842 (class 0 OID 0)
-- Dependencies: 1522
-- Name: user_tokens_id_seq; Type: SEQUENCE SET; Schema: main; Owner: mtwiple_user
--

SELECT pg_catalog.setval('user_tokens_id_seq', 56, true);


SET search_path = public, pg_catalog;

--
-- TOC entry 1523 (class 1259 OID 50302)
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
-- TOC entry 1524 (class 1259 OID 50308)
-- Dependencies: 7 1523
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
-- TOC entry 1843 (class 0 OID 0)
-- Dependencies: 1524
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- TOC entry 1844 (class 0 OID 0)
-- Dependencies: 1524
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 1, false);


SET search_path = main, pg_catalog;

--
-- TOC entry 1802 (class 2604 OID 50310)
-- Dependencies: 1514 1513
-- Name: id; Type: DEFAULT; Schema: main; Owner: mtwiple_user
--

ALTER TABLE actions ALTER COLUMN id SET DEFAULT nextval('actions_id_seq'::regclass);


--
-- TOC entry 1803 (class 2604 OID 50311)
-- Dependencies: 1516 1515
-- Name: id; Type: DEFAULT; Schema: main; Owner: mtwiple_user
--

ALTER TABLE login_tokens ALTER COLUMN id SET DEFAULT nextval('login_tokens_id_seq'::regclass);


--
-- TOC entry 1804 (class 2604 OID 50312)
-- Dependencies: 1518 1517
-- Name: id; Type: DEFAULT; Schema: main; Owner: mtwiple_user
--

ALTER TABLE logs ALTER COLUMN id SET DEFAULT nextval('logs_id_seq'::regclass);


--
-- TOC entry 1805 (class 2604 OID 50313)
-- Dependencies: 1520 1519
-- Name: id; Type: DEFAULT; Schema: main; Owner: mtwiple_user
--

ALTER TABLE user_group ALTER COLUMN id SET DEFAULT nextval('user_group_id_seq'::regclass);


--
-- TOC entry 1806 (class 2604 OID 50314)
-- Dependencies: 1522 1521
-- Name: id; Type: DEFAULT; Schema: main; Owner: mtwiple_user
--

ALTER TABLE user_tokens ALTER COLUMN id SET DEFAULT nextval('user_tokens_id_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- TOC entry 1807 (class 2604 OID 50315)
-- Dependencies: 1524 1523
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


SET search_path = main, pg_catalog;

--
-- TOC entry 1821 (class 0 OID 50262)
-- Dependencies: 1513
-- Data for Name: actions; Type: TABLE DATA; Schema: main; Owner: mtwiple_user
--

COPY actions (id, action) FROM stdin;
1	Follow URL
2	Follow User
3	Get Favorites
4	Get Followers
5	Get Following
6	Get RT by User
7	Get RT to User
8	Get User Information
9	Mark Favorite
10	Unmark Favorite
11	Added New Account
12	Sign In With Twitter
13	Save Settings
14	RT Without Comment
15	Direct Message
16	Tweet
17	RT With Comment
18	Unfollow User
19	Delete User
20	Get Trends
21	Search Tweets
22	URL Shortener
\.


--
-- TOC entry 1822 (class 0 OID 50270)
-- Dependencies: 1515
-- Data for Name: login_tokens; Type: TABLE DATA; Schema: main; Owner: mtwiple_user
--

COPY login_tokens (id, token, secret, rawstring, creation_date, group_id, session) FROM stdin;
\.


--
-- TOC entry 1823 (class 0 OID 50278)
-- Dependencies: 1517
-- Data for Name: logs; Type: TABLE DATA; Schema: main; Owner: mtwiple_user
--

COPY logs (id, log_user_id, log_screen_name, action_id, log_date) FROM stdin;
\.


--
-- TOC entry 1824 (class 0 OID 50286)
-- Dependencies: 1519
-- Data for Name: user_group; Type: TABLE DATA; Schema: main; Owner: mtwiple_user
--

COPY user_group (id, group_salt, update_interval) FROM stdin;
\.


--
-- TOC entry 1825 (class 0 OID 50294)
-- Dependencies: 1521
-- Data for Name: user_tokens; Type: TABLE DATA; Schema: main; Owner: mtwiple_user
--

COPY user_tokens (id, user_id, screen_name, token, secret, rawstring, creation_date, login_date, group_id, home_id, direct_id, mention_id, image_url) FROM stdin;
\.


SET search_path = public, pg_catalog;

--
-- TOC entry 1826 (class 0 OID 50302)
-- Dependencies: 1523
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (id, login, passwd_salt) FROM stdin;
\.


SET search_path = main, pg_catalog;

--
-- TOC entry 1809 (class 2606 OID 50317)
-- Dependencies: 1513 1513
-- Name: actions_key; Type: CONSTRAINT; Schema: main; Owner: mtwiple_user; Tablespace: 
--

ALTER TABLE ONLY actions
    ADD CONSTRAINT actions_key PRIMARY KEY (id);


--
-- TOC entry 1815 (class 2606 OID 50319)
-- Dependencies: 1519 1519
-- Name: grp_pky; Type: CONSTRAINT; Schema: main; Owner: mtwiple_user; Tablespace: 
--

ALTER TABLE ONLY user_group
    ADD CONSTRAINT grp_pky PRIMARY KEY (id);


--
-- TOC entry 1813 (class 2606 OID 50321)
-- Dependencies: 1517 1517
-- Name: logs_key; Type: CONSTRAINT; Schema: main; Owner: mtwiple_user; Tablespace: 
--

ALTER TABLE ONLY logs
    ADD CONSTRAINT logs_key PRIMARY KEY (id);


--
-- TOC entry 1811 (class 2606 OID 50323)
-- Dependencies: 1515 1515
-- Name: ltok_pky; Type: CONSTRAINT; Schema: main; Owner: mtwiple_user; Tablespace: 
--

ALTER TABLE ONLY login_tokens
    ADD CONSTRAINT ltok_pky PRIMARY KEY (id);


--
-- TOC entry 1817 (class 2606 OID 50325)
-- Dependencies: 1521 1521
-- Name: ustok_pky; Type: CONSTRAINT; Schema: main; Owner: mtwiple_user; Tablespace: 
--

ALTER TABLE ONLY user_tokens
    ADD CONSTRAINT ustok_pky PRIMARY KEY (id);


SET search_path = public, pg_catalog;

--
-- TOC entry 1819 (class 2606 OID 50327)
-- Dependencies: 1523 1523
-- Name: usr_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT usr_id_pkey PRIMARY KEY (id);


SET search_path = main, pg_catalog;

--
-- TOC entry 1820 (class 2606 OID 50328)
-- Dependencies: 1814 1519 1521
-- Name: usr_grp_fky; Type: FK CONSTRAINT; Schema: main; Owner: mtwiple_user
--

ALTER TABLE ONLY user_tokens
    ADD CONSTRAINT usr_grp_fky FOREIGN KEY (group_id) REFERENCES user_group(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1830 (class 0 OID 0)
-- Dependencies: 6
-- Name: main; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA main FROM PUBLIC;
REVOKE ALL ON SCHEMA main FROM postgres;
GRANT ALL ON SCHEMA main TO postgres;
GRANT ALL ON SCHEMA main TO PUBLIC;


--
-- TOC entry 1832 (class 0 OID 0)
-- Dependencies: 7
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2010-07-15 21:37:41 IST

--
-- PostgreSQL database dump complete
--

