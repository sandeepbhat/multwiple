--
-- PostgreSQL database dump
--

-- Started on 2010-01-11 12:52:39 IST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = main, pg_catalog;

--
-- TOC entry 1789 (class 0 OID 0)
-- Dependencies: 1499
-- Name: member_id_seq; Type: SEQUENCE SET; Schema: main; Owner: postgres
--

SELECT pg_catalog.setval('member_id_seq', 5, true);


SET search_path = public, pg_catalog;

--
-- TOC entry 1790 (class 0 OID 0)
-- Dependencies: 1497
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 1, false);


SET search_path = main, pg_catalog;

--
-- TOC entry 1786 (class 0 OID 16400)
-- Dependencies: 1500
-- Data for Name: member; Type: TABLE DATA; Schema: main; Owner: postgres
--

COPY member (id, username, password, creation_date, login_date, login_salt, parent_id) FROM stdin;
5	ameet	chiller	2009-12-31	2010-01-02	1b1073eba457327386203d75f6cf3ebff1b596c9eedabac2b4d9ac5d0f4a8ff	2
2	ammubhai	asdf	2009-12-26	2010-01-02	1b1073eba457327386203d75f6cf3ebff1b596c9eedabac2b4d9ac5d0f4a8ff	2
\.


SET search_path = public, pg_catalog;

--
-- TOC entry 1785 (class 0 OID 16387)
-- Dependencies: 1498
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (id, login, passwd_salt) FROM stdin;
\.


-- Completed on 2010-01-11 12:52:43 IST

--
-- PostgreSQL database dump complete
--

