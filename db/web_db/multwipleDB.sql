DROP DATABASE "multwipleDB";
--
-- PostgreSQL database dump
--

-- Started on 2010-07-27 10:40:41 UTC

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 1834 (class 1262 OID 16538)
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
-- TOC entry 6 (class 2615 OID 16539)
-- Name: main; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA main;


ALTER SCHEMA main OWNER TO postgres;

SET search_path = main, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1525 (class 1259 OID 24597)
-- Dependencies: 6
-- Name: actions; Type: TABLE; Schema: main; Owner: mtwiple_user; Tablespace: 
--

CREATE TABLE actions (
    id integer NOT NULL,
    action text
);


ALTER TABLE main.actions OWNER TO mtwiple_user;

--
-- TOC entry 1526 (class 1259 OID 24603)
-- Dependencies: 6 1525
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
-- TOC entry 1838 (class 0 OID 0)
-- Dependencies: 1526
-- Name: actions_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: mtwiple_user
--

ALTER SEQUENCE actions_id_seq OWNED BY actions.id;


--
-- TOC entry 1839 (class 0 OID 0)
-- Dependencies: 1526
-- Name: actions_id_seq; Type: SEQUENCE SET; Schema: main; Owner: mtwiple_user
--

SELECT pg_catalog.setval('actions_id_seq', 22, true);


--
-- TOC entry 1516 (class 1259 OID 16540)
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
-- TOC entry 1517 (class 1259 OID 16546)
-- Dependencies: 6 1516
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
-- TOC entry 1840 (class 0 OID 0)
-- Dependencies: 1517
-- Name: login_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: mtwiple_user
--

ALTER SEQUENCE login_tokens_id_seq OWNED BY login_tokens.id;


--
-- TOC entry 1841 (class 0 OID 0)
-- Dependencies: 1517
-- Name: login_tokens_id_seq; Type: SEQUENCE SET; Schema: main; Owner: mtwiple_user
--

SELECT pg_catalog.setval('login_tokens_id_seq', 573, true);


--
-- TOC entry 1527 (class 1259 OID 24605)
-- Dependencies: 6
-- Name: logs; Type: TABLE; Schema: main; Owner: mtwiple_user; Tablespace: 
--

CREATE TABLE logs (
    id integer NOT NULL,
    log_user_id integer,
    log_screen_name text,
    action integer,
    log_date date
);


ALTER TABLE main.logs OWNER TO mtwiple_user;

--
-- TOC entry 1528 (class 1259 OID 24611)
-- Dependencies: 6 1527
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
-- TOC entry 1842 (class 0 OID 0)
-- Dependencies: 1528
-- Name: logs_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: mtwiple_user
--

ALTER SEQUENCE logs_id_seq OWNED BY logs.id;


--
-- TOC entry 1843 (class 0 OID 0)
-- Dependencies: 1528
-- Name: logs_id_seq; Type: SEQUENCE SET; Schema: main; Owner: mtwiple_user
--

SELECT pg_catalog.setval('logs_id_seq', 288, true);


--
-- TOC entry 1518 (class 1259 OID 16548)
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
-- TOC entry 1519 (class 1259 OID 16554)
-- Dependencies: 1518 6
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
-- TOC entry 1844 (class 0 OID 0)
-- Dependencies: 1519
-- Name: user_group_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: mtwiple_user
--

ALTER SEQUENCE user_group_id_seq OWNED BY user_group.id;


--
-- TOC entry 1845 (class 0 OID 0)
-- Dependencies: 1519
-- Name: user_group_id_seq; Type: SEQUENCE SET; Schema: main; Owner: mtwiple_user
--

SELECT pg_catalog.setval('user_group_id_seq', 181, true);


--
-- TOC entry 1520 (class 1259 OID 16556)
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
-- TOC entry 1521 (class 1259 OID 16562)
-- Dependencies: 6 1520
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
-- TOC entry 1846 (class 0 OID 0)
-- Dependencies: 1521
-- Name: user_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: mtwiple_user
--

ALTER SEQUENCE user_tokens_id_seq OWNED BY user_tokens.id;


--
-- TOC entry 1847 (class 0 OID 0)
-- Dependencies: 1521
-- Name: user_tokens_id_seq; Type: SEQUENCE SET; Schema: main; Owner: mtwiple_user
--

SELECT pg_catalog.setval('user_tokens_id_seq', 253, true);


SET search_path = public, pg_catalog;

--
-- TOC entry 1524 (class 1259 OID 24591)
-- Dependencies: 7
-- Name: actions; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE actions (
    id integer NOT NULL,
    action text
);


ALTER TABLE public.actions OWNER TO postgres;

--
-- TOC entry 1522 (class 1259 OID 16564)
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
-- TOC entry 1523 (class 1259 OID 16570)
-- Dependencies: 7 1522
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
-- TOC entry 1848 (class 0 OID 0)
-- Dependencies: 1523
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- TOC entry 1849 (class 0 OID 0)
-- Dependencies: 1523
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 1, false);


SET search_path = main, pg_catalog;

--
-- TOC entry 1810 (class 2604 OID 24613)
-- Dependencies: 1526 1525
-- Name: id; Type: DEFAULT; Schema: main; Owner: mtwiple_user
--

ALTER TABLE actions ALTER COLUMN id SET DEFAULT nextval('actions_id_seq'::regclass);


--
-- TOC entry 1806 (class 2604 OID 16572)
-- Dependencies: 1517 1516
-- Name: id; Type: DEFAULT; Schema: main; Owner: mtwiple_user
--

ALTER TABLE login_tokens ALTER COLUMN id SET DEFAULT nextval('login_tokens_id_seq'::regclass);


--
-- TOC entry 1811 (class 2604 OID 24614)
-- Dependencies: 1528 1527
-- Name: id; Type: DEFAULT; Schema: main; Owner: mtwiple_user
--

ALTER TABLE logs ALTER COLUMN id SET DEFAULT nextval('logs_id_seq'::regclass);


--
-- TOC entry 1807 (class 2604 OID 16573)
-- Dependencies: 1519 1518
-- Name: id; Type: DEFAULT; Schema: main; Owner: mtwiple_user
--

ALTER TABLE user_group ALTER COLUMN id SET DEFAULT nextval('user_group_id_seq'::regclass);


--
-- TOC entry 1808 (class 2604 OID 16574)
-- Dependencies: 1521 1520
-- Name: id; Type: DEFAULT; Schema: main; Owner: mtwiple_user
--

ALTER TABLE user_tokens ALTER COLUMN id SET DEFAULT nextval('user_tokens_id_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- TOC entry 1809 (class 2604 OID 16575)
-- Dependencies: 1523 1522
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


SET search_path = main, pg_catalog;

--
-- TOC entry 1830 (class 0 OID 24597)
-- Dependencies: 1525
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
-- TOC entry 1825 (class 0 OID 16540)
-- Dependencies: 1516
-- Data for Name: login_tokens; Type: TABLE DATA; Schema: main; Owner: mtwiple_user
--

COPY login_tokens (id, token, secret, rawstring, creation_date, group_id, session) FROM stdin;
178	lJHeXzhK9yJO8FosT8PLM00zEG791bMYaAZ3rfXc44	UrBbYUOg6yIi4oLMDXI4SOBkq6oc0pN8ALyL8Oi0	oauth_token=lJHeXzhK9yJO8FosT8PLM00zEG791bMYaAZ3rfXc44&oauth_token_secret=UrBbYUOg6yIi4oLMDXI4SOBkq6oc0pN8ALyL8Oi0&oauth_callback_confirmed=true	2010-07-01	0	
56	UtS9H8kgsiriIKMZadZaVKfxeej9RMYmbW9nsRJ8	iCyDoyYZdR6weUfZk4u341ZtFEEj7Qs4GitGcLftAE	oauth_token=UtS9H8kgsiriIKMZadZaVKfxeej9RMYmbW9nsRJ8&oauth_token_secret=iCyDoyYZdR6weUfZk4u341ZtFEEj7Qs4GitGcLftAE&oauth_callback_confirmed=true	2010-06-25	0	
61	JicxISMUNJAg0NzGukOzYSKWJLq3JbyeHknm9y7V8	X5umtW6Jd0SAuElsbrSWcYq1196vdleTOghZJg2wkA	oauth_token=JicxISMUNJAg0NzGukOzYSKWJLq3JbyeHknm9y7V8&oauth_token_secret=X5umtW6Jd0SAuElsbrSWcYq1196vdleTOghZJg2wkA&oauth_callback_confirmed=true	2010-06-26	0	
62	rkzdlJRNP4tmMGvKOgv4aHCWdhaQiIDKVNWfqXJkZRs	O7imqFMZIw3HtGDMMnF6WkUAGrYZSbiyA2hm5nKFBX4	oauth_token=rkzdlJRNP4tmMGvKOgv4aHCWdhaQiIDKVNWfqXJkZRs&oauth_token_secret=O7imqFMZIw3HtGDMMnF6WkUAGrYZSbiyA2hm5nKFBX4&oauth_callback_confirmed=true	2010-06-26	0	
63	W8Ksdr9C78DJSe2oBM88dkJ2JrXxZfMmCCS8C5jmlQ	vn2212ACD1CbtwTgGgiiLHTrHZQKUosVHY6EJ1qC50c	oauth_token=W8Ksdr9C78DJSe2oBM88dkJ2JrXxZfMmCCS8C5jmlQ&oauth_token_secret=vn2212ACD1CbtwTgGgiiLHTrHZQKUosVHY6EJ1qC50c&oauth_callback_confirmed=true	2010-06-26	0	
68	yNhBBtuG1vqDsPE0N0bL3ehwlwNEaXt69rVkX6Rrb8	zLgtf9tAe8GlU2p3f58Ey5uzZXrRLSL7qJyvhg26zh4	oauth_token=yNhBBtuG1vqDsPE0N0bL3ehwlwNEaXt69rVkX6Rrb8&oauth_token_secret=zLgtf9tAe8GlU2p3f58Ey5uzZXrRLSL7qJyvhg26zh4&oauth_callback_confirmed=true	2010-06-26	0	
69	eek4ejY1kzdHy8aOvYazjjmk3vQiAJav3lzz38pz4Q	s4iLjUsMmxn2k0wiVTr0Rp6DTLoMbw3grtR4TmYDI	oauth_token=eek4ejY1kzdHy8aOvYazjjmk3vQiAJav3lzz38pz4Q&oauth_token_secret=s4iLjUsMmxn2k0wiVTr0Rp6DTLoMbw3grtR4TmYDI&oauth_callback_confirmed=true	2010-06-26	0	
70	J3kk28vWX9BASxdTdOM0Jxgkzukm38cR2riIgUtOHw	wE1NAdFTK2Zpi0ABNbCHBlpPMXX9VHomZ3QNDLC1o	oauth_token=J3kk28vWX9BASxdTdOM0Jxgkzukm38cR2riIgUtOHw&oauth_token_secret=wE1NAdFTK2Zpi0ABNbCHBlpPMXX9VHomZ3QNDLC1o&oauth_callback_confirmed=true	2010-06-26	0	
72	w0ccis8oY9UMdlG20cETQhHMTHhJ2Go3RDMoZMdIE	ruidHIxdJnmYJ36Tfvuhkb4E1JeCEWF3hIRnm46Uc	oauth_token=w0ccis8oY9UMdlG20cETQhHMTHhJ2Go3RDMoZMdIE&oauth_token_secret=ruidHIxdJnmYJ36Tfvuhkb4E1JeCEWF3hIRnm46Uc&oauth_callback_confirmed=true	2010-06-26	0	
73	Re5ReZXfOpuXBltuqP2rHGIHaXhv2rFYVEEZsMzEo	5NoA1g9TVbryjuoGcNfXs2Tc3FDIFFyyLdenG7mcQ	oauth_token=Re5ReZXfOpuXBltuqP2rHGIHaXhv2rFYVEEZsMzEo&oauth_token_secret=5NoA1g9TVbryjuoGcNfXs2Tc3FDIFFyyLdenG7mcQ&oauth_callback_confirmed=true	2010-06-26	0	
77	2u0oJYGOFuDvG7IvCKuASu8lrfKoPz7gx4DjooAFs	EiHWZ2yJdKO3dT7eBNLL4Y1jYxcXVkyB3cMzGcER9h8	oauth_token=2u0oJYGOFuDvG7IvCKuASu8lrfKoPz7gx4DjooAFs&oauth_token_secret=EiHWZ2yJdKO3dT7eBNLL4Y1jYxcXVkyB3cMzGcER9h8&oauth_callback_confirmed=true	2010-06-27	0	
78	sJNdotDrSYTzPN2AihrOqqsdfhjLMYXrVf8N8P2CM	n2DpSnaQhNHFbN0QeCN4DrVtpjDopmbV83HDzCPFY	oauth_token=sJNdotDrSYTzPN2AihrOqqsdfhjLMYXrVf8N8P2CM&oauth_token_secret=n2DpSnaQhNHFbN0QeCN4DrVtpjDopmbV83HDzCPFY&oauth_callback_confirmed=true	2010-06-27	0	
80	KRKQbJTBnCwF16rBYt34ZRdDSLOfmt9hoaX5XOyU	8lo1nKGgxOdVtpzQhAd9X2MqGcAQM756thaFSnBkyM	oauth_token=KRKQbJTBnCwF16rBYt34ZRdDSLOfmt9hoaX5XOyU&oauth_token_secret=8lo1nKGgxOdVtpzQhAd9X2MqGcAQM756thaFSnBkyM&oauth_callback_confirmed=true	2010-06-27	38	657c72a5abe375b884c446dc7f10f4fe96568717d1ef755c5fd7ac766893e44
81	dguT32T0Eeo2LmqrM7XeyjcbCerOcnaxQHhp6JZwDow	TvphV8SfkP8ugNl4piIiFIlrId8w0RvJRWP5gP1lDzM	oauth_token=dguT32T0Eeo2LmqrM7XeyjcbCerOcnaxQHhp6JZwDow&oauth_token_secret=TvphV8SfkP8ugNl4piIiFIlrId8w0RvJRWP5gP1lDzM&oauth_callback_confirmed=true	2010-06-27	0	
82	PDkQhA2nsjCMStDISY4tvsgAL0h2YHAREQZ1xwXK6NI	wz8kCDtaSffV5zuTDtXJD5LorQe7orvbwD7mZJbSrfI	oauth_token=PDkQhA2nsjCMStDISY4tvsgAL0h2YHAREQZ1xwXK6NI&oauth_token_secret=wz8kCDtaSffV5zuTDtXJD5LorQe7orvbwD7mZJbSrfI&oauth_callback_confirmed=true	2010-06-27	0	
83	bNGCdCiqkKhGAtjfHx7wRe8xNpeX4ZAgrA84r0fAhA4	XHmrzH8KCZq3nlew7Dqjv1DZVCwBl7fygzKc6JGPfk	oauth_token=bNGCdCiqkKhGAtjfHx7wRe8xNpeX4ZAgrA84r0fAhA4&oauth_token_secret=XHmrzH8KCZq3nlew7Dqjv1DZVCwBl7fygzKc6JGPfk&oauth_callback_confirmed=true	2010-06-27	0	
85	EhuViihZmhSUnoqmxGOtqffuEsEpRStbtU4U9q02gg	gW6HVTinm6zUH3tF9J7UmMlJfEFe0CClHseDVBzMg	oauth_token=EhuViihZmhSUnoqmxGOtqffuEsEpRStbtU4U9q02gg&oauth_token_secret=gW6HVTinm6zUH3tF9J7UmMlJfEFe0CClHseDVBzMg&oauth_callback_confirmed=true	2010-06-27	0	
86	Qm670SCZSw05XJ9H47puOynYDDhZYyshEVolA8dBc	PsDypd63inutOg0ezmMHyckCYWOInJxb60E4MorGt4	oauth_token=Qm670SCZSw05XJ9H47puOynYDDhZYyshEVolA8dBc&oauth_token_secret=PsDypd63inutOg0ezmMHyckCYWOInJxb60E4MorGt4&oauth_callback_confirmed=true	2010-06-27	0	
87	LztUpsL18hT64YMnFpZ7hXdacVmY0M3GQaxXNFxl3M	zr1y9u9hJaSUhWPmrsx1rzPom3m0kZBqqP7S4RC5GI	oauth_token=LztUpsL18hT64YMnFpZ7hXdacVmY0M3GQaxXNFxl3M&oauth_token_secret=zr1y9u9hJaSUhWPmrsx1rzPom3m0kZBqqP7S4RC5GI&oauth_callback_confirmed=true	2010-06-27	0	
88	fVimyN6QDLRSbc6JVGOPBzFb8hzuSx1AGidDOsjj4	WJSsAoUrVj3KpcgdlDM3X07UwcqtG7rgduZiTRcFyYo	oauth_token=fVimyN6QDLRSbc6JVGOPBzFb8hzuSx1AGidDOsjj4&oauth_token_secret=WJSsAoUrVj3KpcgdlDM3X07UwcqtG7rgduZiTRcFyYo&oauth_callback_confirmed=true	2010-06-27	0	
90	8IQRCKxRlNvyfZIYG70Q4f0JYWxDl6ohOzijN2Cvk	Z0Dr1w4mw6Iufp9MH7ZDaOmnwfpmqeF59Hm4TYIU8	oauth_token=8IQRCKxRlNvyfZIYG70Q4f0JYWxDl6ohOzijN2Cvk&oauth_token_secret=Z0Dr1w4mw6Iufp9MH7ZDaOmnwfpmqeF59Hm4TYIU8&oauth_callback_confirmed=true	2010-06-27	0	
91	x7A3h5pK62lOEWZ9qpMSJ93tF8ejRVhicji6BBu3EQ	oZDzxKivdzD74zWwufhYpk1hl8pyj2YpyBWOns9e3Qs	oauth_token=x7A3h5pK62lOEWZ9qpMSJ93tF8ejRVhicji6BBu3EQ&oauth_token_secret=oZDzxKivdzD74zWwufhYpk1hl8pyj2YpyBWOns9e3Qs&oauth_callback_confirmed=true	2010-06-27	0	
94	vJol8Hc3I3I11wzslXFE4HaF5FI3ogpvsouzosQRTvY	GvV5pEFLhcKebgBKKUYypFpJvb559waY9j2ozh0KSdA	oauth_token=vJol8Hc3I3I11wzslXFE4HaF5FI3ogpvsouzosQRTvY&oauth_token_secret=GvV5pEFLhcKebgBKKUYypFpJvb559waY9j2ozh0KSdA&oauth_callback_confirmed=true	2010-06-27	0	
95	YJ71Y4SXQJw7wuXMrUmFXfyXpmXYnzCzpmPLpu1CM	HO5lPofjvIoqlbZzy9v1eWSY3qgys17NGG3KGSHCws	oauth_token=YJ71Y4SXQJw7wuXMrUmFXfyXpmXYnzCzpmPLpu1CM&oauth_token_secret=HO5lPofjvIoqlbZzy9v1eWSY3qgys17NGG3KGSHCws&oauth_callback_confirmed=true	2010-06-28	0	
96	uh204Y6yd2r3OzcYpoPsVeYIt7tZdJafbwvmI9Hqq3E	TXMeo1SJ1EE8LksdJHsg1KyuNnTwgIH4B771UpCY	oauth_token=uh204Y6yd2r3OzcYpoPsVeYIt7tZdJafbwvmI9Hqq3E&oauth_token_secret=TXMeo1SJ1EE8LksdJHsg1KyuNnTwgIH4B771UpCY&oauth_callback_confirmed=true	2010-06-28	0	
97	o3bINS0vexKGkjUuGxZRgC0hAediYWLfutoteoPoj4	Frb46bTWF5FfHouSxigiq0PGbwYaY9IdPnMS4mC02QI	oauth_token=o3bINS0vexKGkjUuGxZRgC0hAediYWLfutoteoPoj4&oauth_token_secret=Frb46bTWF5FfHouSxigiq0PGbwYaY9IdPnMS4mC02QI&oauth_callback_confirmed=true	2010-06-28	0	
99	IdKPKasKENACpL825rwnUpXv7QNap29IKDMdUAlG1Ww	eNP1va90iIqMxQTZTCVItJ7Gdh3P8IpovaDCtS2GGdw	oauth_token=IdKPKasKENACpL825rwnUpXv7QNap29IKDMdUAlG1Ww&oauth_token_secret=eNP1va90iIqMxQTZTCVItJ7Gdh3P8IpovaDCtS2GGdw&oauth_callback_confirmed=true	2010-06-28	42	55927512f3aaf3dffdf5de3955c8f5a5b3a551610d82463c1f8f2f6bfc239c
100	V2uZEjNoVG8yOckyKQoTihGJGxYFHjvXFao6wcElzQ	yeGOwwb2zNbdWkJh178e8r6WtDltsBBf1Eps9zHLgw	oauth_token=V2uZEjNoVG8yOckyKQoTihGJGxYFHjvXFao6wcElzQ&oauth_token_secret=yeGOwwb2zNbdWkJh178e8r6WtDltsBBf1Eps9zHLgw&oauth_callback_confirmed=true	2010-06-28	0	
179	WlNSu5TRMb5w2gklAv6TaXzs5pK3L7XQOqb9k8dgY	P6XluhZq59hlwzaBTH3TsGzWJbpzkeOcNk3ADKsPL4	oauth_token=WlNSu5TRMb5w2gklAv6TaXzs5pK3L7XQOqb9k8dgY&oauth_token_secret=P6XluhZq59hlwzaBTH3TsGzWJbpzkeOcNk3ADKsPL4&oauth_callback_confirmed=true	2010-07-01	0	
102	CgaGY3GNR9Bc17dsDKmWU0Ul0QQHBHXHtBuxNOmZmTw	5NxPQSCLiIPe73E3AbDG1FTcSd3EnqpY9kRGRi4	oauth_token=CgaGY3GNR9Bc17dsDKmWU0Ul0QQHBHXHtBuxNOmZmTw&oauth_token_secret=5NxPQSCLiIPe73E3AbDG1FTcSd3EnqpY9kRGRi4&oauth_callback_confirmed=true	2010-06-28	0	
103	ICL1M47JN8sLhwYuQaoZPTmbQDE4M1QiGR6RYBWY1g	g6GA5GmbxUp7LGm110fnGzRDWiSljeC3sIPiFkTM	oauth_token=ICL1M47JN8sLhwYuQaoZPTmbQDE4M1QiGR6RYBWY1g&oauth_token_secret=g6GA5GmbxUp7LGm110fnGzRDWiSljeC3sIPiFkTM&oauth_callback_confirmed=true	2010-06-28	0	
106	7L2I1wqyY0M5eVs4OOBIeJpvzA9Lj7sZE6gvxUJUc1g	X98uyucAq9FdSvdLVGuDgshvffPXW858GfxptxCW4w	oauth_token=7L2I1wqyY0M5eVs4OOBIeJpvzA9Lj7sZE6gvxUJUc1g&oauth_token_secret=X98uyucAq9FdSvdLVGuDgshvffPXW858GfxptxCW4w&oauth_callback_confirmed=true	2010-06-28	26	36f85cbcc4c7c94e1ba6e83c4229b539f7d7439ac6087e61e8f38bdfb0874c
108	H29upI8ttTMMlwBs5AGrOuL7QtitxpaevEO7B8S5O4	NJVhlJuL4ow8z5Y2rv5T984AMT1XPeWyrSupNu4HdQ	oauth_token=H29upI8ttTMMlwBs5AGrOuL7QtitxpaevEO7B8S5O4&oauth_token_secret=NJVhlJuL4ow8z5Y2rv5T984AMT1XPeWyrSupNu4HdQ&oauth_callback_confirmed=true	2010-06-28	0	
109	DkTXSB17SQr4IkNRq04fw3vGXWKSw0DVAmfveXlgLwI	N2tg5Zkuzi8T2hN3xK1HToz1auCqsdoCY0MxmXRpY	oauth_token=DkTXSB17SQr4IkNRq04fw3vGXWKSw0DVAmfveXlgLwI&oauth_token_secret=N2tg5Zkuzi8T2hN3xK1HToz1auCqsdoCY0MxmXRpY&oauth_callback_confirmed=true	2010-06-28	0	
110	Y4kN48mDyG49Ia6DetDYqtZjuvWOcsaumdPi0UFE	rzdqmEizGOgzZGPdoyeT1mxNWmdOrCU0dNxJTOHDig	oauth_token=Y4kN48mDyG49Ia6DetDYqtZjuvWOcsaumdPi0UFE&oauth_token_secret=rzdqmEizGOgzZGPdoyeT1mxNWmdOrCU0dNxJTOHDig&oauth_callback_confirmed=true	2010-06-28	0	
111	jaxCed9pLI7ZTEPxr0NSWHpGWMRQyYcynPDtfurlKE	4N4Wb8xsdSUpehNcbbmjEw1XhfcXe5GAIfziTeYVjs	oauth_token=jaxCed9pLI7ZTEPxr0NSWHpGWMRQyYcynPDtfurlKE&oauth_token_secret=4N4Wb8xsdSUpehNcbbmjEw1XhfcXe5GAIfziTeYVjs&oauth_callback_confirmed=true	2010-06-28	0	
112	EbFQoyuLvp4x3uoFPlK48y6wZdau0AGPseWESq8Cy0	IRoSLCIAx4ZgDGEp6ymKYKFVVlIIkvAk97mk37u4P8	oauth_token=EbFQoyuLvp4x3uoFPlK48y6wZdau0AGPseWESq8Cy0&oauth_token_secret=IRoSLCIAx4ZgDGEp6ymKYKFVVlIIkvAk97mk37u4P8&oauth_callback_confirmed=true	2010-06-28	0	
113	yzc2zzp7OcUvUDrqH81EtqV3khi94QOu8ZAVpBpDA	TGKuccTU7G8LvTcaASZG3qlEIuP5ANbf0SMEeJ0eQ	oauth_token=yzc2zzp7OcUvUDrqH81EtqV3khi94QOu8ZAVpBpDA&oauth_token_secret=TGKuccTU7G8LvTcaASZG3qlEIuP5ANbf0SMEeJ0eQ&oauth_callback_confirmed=true	2010-06-28	0	
114	fY34BFmrbA4UwX3OZs9eo0eTzwiQdwRObmJAC84TE	YPqGeCqKRspHlxYqix2FmPi3KJcxsAlzkzamTlGTMZ4	oauth_token=fY34BFmrbA4UwX3OZs9eo0eTzwiQdwRObmJAC84TE&oauth_token_secret=YPqGeCqKRspHlxYqix2FmPi3KJcxsAlzkzamTlGTMZ4&oauth_callback_confirmed=true	2010-06-28	0	
115	7TUvA8LE5Lt2IzOrqIsMGtlBOzUwiVPzAWb5JXCpM	uTV4F04IsSWIUZJOJ5NUP3XKlzWTGDMZnUECVXcriY	oauth_token=7TUvA8LE5Lt2IzOrqIsMGtlBOzUwiVPzAWb5JXCpM&oauth_token_secret=uTV4F04IsSWIUZJOJ5NUP3XKlzWTGDMZnUECVXcriY&oauth_callback_confirmed=true	2010-06-29	0	
116	nYTaLMZh1EjoTEoIYGQoBVghVSACgR20ugm3ABvQ	rpcMUOg1BToiQW1fRgd0oqkwOJFA4LimYj7jHz9je8	oauth_token=nYTaLMZh1EjoTEoIYGQoBVghVSACgR20ugm3ABvQ&oauth_token_secret=rpcMUOg1BToiQW1fRgd0oqkwOJFA4LimYj7jHz9je8&oauth_callback_confirmed=true	2010-06-29	0	
117	Gdv4eY9rbqTQqgUnL3iyBUom0kmo4kcZWIBf2vQp1Zo	lIwihNNJubkwUdYSLYcb1DEz2V8NV6D7x5dhYDCs88	oauth_token=Gdv4eY9rbqTQqgUnL3iyBUom0kmo4kcZWIBf2vQp1Zo&oauth_token_secret=lIwihNNJubkwUdYSLYcb1DEz2V8NV6D7x5dhYDCs88&oauth_callback_confirmed=true	2010-06-29	0	
118	m9KVRB57mgh7MCWYGuM94YYgusgyxY5LfxDMlw0mGM	JLBB5hzcgwKLJ6DDJBtI6xdPeh7xe9XtIypRrReT30	oauth_token=m9KVRB57mgh7MCWYGuM94YYgusgyxY5LfxDMlw0mGM&oauth_token_secret=JLBB5hzcgwKLJ6DDJBtI6xdPeh7xe9XtIypRrReT30&oauth_callback_confirmed=true	2010-06-29	0	
119	DBlWTS5dy46mitYIkdqGs42xDYiOEXRI5zX3oLSNWE	EQmGLD6tvOePxeKOEexGDgBun3nrQiLWW0ZDoQ74w	oauth_token=DBlWTS5dy46mitYIkdqGs42xDYiOEXRI5zX3oLSNWE&oauth_token_secret=EQmGLD6tvOePxeKOEexGDgBun3nrQiLWW0ZDoQ74w&oauth_callback_confirmed=true	2010-06-29	0	
120	SPOkfkf5AyfnF9hdXF0A5oSWdLZS3d1YaLuONK5ToXs	bKTngSFrwwQQB6oTT3Y0zjYPYlHKlJ6CSM03iqNl2UA	oauth_token=SPOkfkf5AyfnF9hdXF0A5oSWdLZS3d1YaLuONK5ToXs&oauth_token_secret=bKTngSFrwwQQB6oTT3Y0zjYPYlHKlJ6CSM03iqNl2UA&oauth_callback_confirmed=true	2010-06-29	0	
121	aD8u3xDd9g33CyWW4BNNfq2idCR7kHiulbaeIemo	UUtSLrLDW7wQeceC7GNzVz5DTH8vIVL1LUGjghP1zQ	oauth_token=aD8u3xDd9g33CyWW4BNNfq2idCR7kHiulbaeIemo&oauth_token_secret=UUtSLrLDW7wQeceC7GNzVz5DTH8vIVL1LUGjghP1zQ&oauth_callback_confirmed=true	2010-06-29	0	
122	hbOPcYZ8Ho00T4GyI0MiSg9Qwd5ONHkEDdCTlBjQUo	N2SOKFAsA0ZQvEiabYRygjvOzlQRt9K8B4NIOrY	oauth_token=hbOPcYZ8Ho00T4GyI0MiSg9Qwd5ONHkEDdCTlBjQUo&oauth_token_secret=N2SOKFAsA0ZQvEiabYRygjvOzlQRt9K8B4NIOrY&oauth_callback_confirmed=true	2010-06-29	0	
126	XfQTiUc9ia0AXCLgqVgSluRv8RoN1vYG85joKvmhzg	MKdw1Y9jybtqZI1RulIq5Lmlxgyr3jRtBEVSc6Uxlr4	oauth_token=XfQTiUc9ia0AXCLgqVgSluRv8RoN1vYG85joKvmhzg&oauth_token_secret=MKdw1Y9jybtqZI1RulIq5Lmlxgyr3jRtBEVSc6Uxlr4&oauth_callback_confirmed=true	2010-06-29	0	
131	ADoEr5M7yNfsBSUFVNgQGxK9V4kpBOWlgu41XFwEII	3YA7itKBfPPoAFdNxSBBDpHWMTOaEzTltMAV649WlY	oauth_token=ADoEr5M7yNfsBSUFVNgQGxK9V4kpBOWlgu41XFwEII&oauth_token_secret=3YA7itKBfPPoAFdNxSBBDpHWMTOaEzTltMAV649WlY&oauth_callback_confirmed=true	2010-06-29	0	
132	7nAHmvkp4rCpkZUYBvs2AtHhod6imrqrPRMapW4ZIU	GajAkHqHHFRbD2notYtg9gfulKW3O9vfRoABQC2LLo	oauth_token=7nAHmvkp4rCpkZUYBvs2AtHhod6imrqrPRMapW4ZIU&oauth_token_secret=GajAkHqHHFRbD2notYtg9gfulKW3O9vfRoABQC2LLo&oauth_callback_confirmed=true	2010-06-29	0	
134	wszzkRUoXVPLE4u77cvD6NtLk0rRCZV4Js7lFbubVWQ	8sGVNNknHaPpRwCiqcV1x1ausniNJoRR08JGDHlmgg	oauth_token=wszzkRUoXVPLE4u77cvD6NtLk0rRCZV4Js7lFbubVWQ&oauth_token_secret=8sGVNNknHaPpRwCiqcV1x1ausniNJoRR08JGDHlmgg&oauth_callback_confirmed=true	2010-06-30	0	
140	F9wZUp3cvtXggFa6EMTsFGLTmNd3rg9CadkUTY	UgVIT5ShxFebxxVXW1B1R5tU7bHCJ9OsTfErAAkCY8	oauth_token=F9wZUp3cvtXggFa6EMTsFGLTmNd3rg9CadkUTY&oauth_token_secret=UgVIT5ShxFebxxVXW1B1R5tU7bHCJ9OsTfErAAkCY8&oauth_callback_confirmed=true	2010-06-30	50	5a42b8e56786786bd27fef7096c5657e0e08c1113f31820a95920fbbcf24
143	uyCz6wlXthVZP2xyDUeNkUR71PhXIgtZeKHqhEoPFg	SSBLPSdZnDYZKScYralqH9nsuHTRxRRcku7j2kuMFc	oauth_token=uyCz6wlXthVZP2xyDUeNkUR71PhXIgtZeKHqhEoPFg&oauth_token_secret=SSBLPSdZnDYZKScYralqH9nsuHTRxRRcku7j2kuMFc&oauth_callback_confirmed=true	2010-06-30	0	
147	uIc6ebu1cL7rGEjmoz7L4aRKAaqp8KBkgwTxeDzA	0jAXIpjBUjwrypO8GQXebK1Gyfoj3Y4zKLLzCfl0	oauth_token=uIc6ebu1cL7rGEjmoz7L4aRKAaqp8KBkgwTxeDzA&oauth_token_secret=0jAXIpjBUjwrypO8GQXebK1Gyfoj3Y4zKLLzCfl0&oauth_callback_confirmed=true	2010-06-30	0	
150	FlMCDsEQ7o4SOSvhZm3ahmu0BupU1z5w5nkT7KgE	RUPs7da0KI2gRP9nmHvQyFokQHodoSgYX1ZdlhPT9io	oauth_token=FlMCDsEQ7o4SOSvhZm3ahmu0BupU1z5w5nkT7KgE&oauth_token_secret=RUPs7da0KI2gRP9nmHvQyFokQHodoSgYX1ZdlhPT9io&oauth_callback_confirmed=true	2010-06-30	0	
151	VlvjeCzqDjINUd5z7gj57qTzfWBvWy3jlWKvNGYUY	MXaYH4NMwCn5NGw0RlvntNkyWHQcF85tAbPwAWm6L8	oauth_token=VlvjeCzqDjINUd5z7gj57qTzfWBvWy3jlWKvNGYUY&oauth_token_secret=MXaYH4NMwCn5NGw0RlvntNkyWHQcF85tAbPwAWm6L8&oauth_callback_confirmed=true	2010-06-30	0	
415	WkJNpPcTWnD1PXVzyriiplDLvdLdaOUKvToXsSWwdE	CTgGQ081qTCjUroROg8AdGthz7nkckUsQ8mb6Ls	oauth_token=WkJNpPcTWnD1PXVzyriiplDLvdLdaOUKvToXsSWwdE&oauth_token_secret=CTgGQ081qTCjUroROg8AdGthz7nkckUsQ8mb6Ls&oauth_callback_confirmed=true	2010-07-08	35	bcf1db413bed1d8b0761cadba99669d943e3ca28d33e92aa7abc8e718d272b1
153	Vs5GkmGEuTnXwuVRVcm9GHxyC8vGtRYFyR7nhoigOXs	fLZEJXayoEIVJ7kxvQkfNQSVldwuLhK1bMgamdglBA	oauth_token=Vs5GkmGEuTnXwuVRVcm9GHxyC8vGtRYFyR7nhoigOXs&oauth_token_secret=fLZEJXayoEIVJ7kxvQkfNQSVldwuLhK1bMgamdglBA&oauth_callback_confirmed=true	2010-06-30	56	722edaf496813f611f5df8b27f549cdbdd9a5173483d6dc51491b796ae5099
154	NzjEbNVKoefxykkoYtIS7XGAVL6X5r05hdePpInac	bPqnGbr64T2PZ9rCsrxpzuXTRbvL7X9zyPJzmQWaKvU	oauth_token=NzjEbNVKoefxykkoYtIS7XGAVL6X5r05hdePpInac&oauth_token_secret=bPqnGbr64T2PZ9rCsrxpzuXTRbvL7X9zyPJzmQWaKvU&oauth_callback_confirmed=true	2010-06-30	0	
316	Lu7L1k0bF0Ks45ycI0fOxzj4qw0TuOcuReycT2jUzY	Av24lVWxgGKvN2YpCA6WfOL21l0d1J9Jc9LPZq8G9ag	oauth_token=Lu7L1k0bF0Ks45ycI0fOxzj4qw0TuOcuReycT2jUzY&oauth_token_secret=Av24lVWxgGKvN2YpCA6WfOL21l0d1J9Jc9LPZq8G9ag&oauth_callback_confirmed=true	2010-07-07	0	
158	D1kcrVmAFexQxyLGUjHxbE4Z8H89W0lbX758cdTomo	R1J3OOiufg2JAYNgVkVaZBo0NoVf9g5cQnN7XA3xuQ	oauth_token=D1kcrVmAFexQxyLGUjHxbE4Z8H89W0lbX758cdTomo&oauth_token_secret=R1J3OOiufg2JAYNgVkVaZBo0NoVf9g5cQnN7XA3xuQ&oauth_callback_confirmed=true	2010-06-30	0	
159	FuPEPCBzDxOcjCFLj9lv8lKAYMScqqti2IyrDlVdmDg	xC8HYmfPoyshNDKapYzDbFU8H5tbntHGvC5iG5l64	oauth_token=FuPEPCBzDxOcjCFLj9lv8lKAYMScqqti2IyrDlVdmDg&oauth_token_secret=xC8HYmfPoyshNDKapYzDbFU8H5tbntHGvC5iG5l64&oauth_callback_confirmed=true	2010-06-30	0	
160	jsuq25CP9mBazIunonxPsePquV0E3JcQET4Q38HSQ	eA8OoVHmBqGqEN94K0kBrEWtJqIZ4D36xs1wwXPfgV4	oauth_token=jsuq25CP9mBazIunonxPsePquV0E3JcQET4Q38HSQ&oauth_token_secret=eA8OoVHmBqGqEN94K0kBrEWtJqIZ4D36xs1wwXPfgV4&oauth_callback_confirmed=true	2010-06-30	0	
161	ZjFQT47dg0jXSjLeqw2Oh4z7AdHEnWbQy4bjKC4ac2s	fmxDAcC8LN63f4m9qgQvxDIw9eS3XNoT5YSiqSGsi8	oauth_token=ZjFQT47dg0jXSjLeqw2Oh4z7AdHEnWbQy4bjKC4ac2s&oauth_token_secret=fmxDAcC8LN63f4m9qgQvxDIw9eS3XNoT5YSiqSGsi8&oauth_callback_confirmed=true	2010-06-30	0	
163	Nx0xs3C8AXZqC0Cd0k1XFMRgd9MfSjTlbtkQ9hlCJM	0lwvOxcCU8HlFofOWETVLmqhNDSp0AdBf39SiA0E	oauth_token=Nx0xs3C8AXZqC0Cd0k1XFMRgd9MfSjTlbtkQ9hlCJM&oauth_token_secret=0lwvOxcCU8HlFofOWETVLmqhNDSp0AdBf39SiA0E&oauth_callback_confirmed=true	2010-06-30	57	46964c21467a18cf9a7b2b2c4f9c461df515f823ef88ae4301a3289e79e2a
328	eDYptUQxCWr3fNAxiQcASv3UWn93gwNmGXfsvXZ2Q	e5piHx4CHZnUjcrDE1xMtTXVbN0v2qOmdX04m5LLs	oauth_token=eDYptUQxCWr3fNAxiQcASv3UWn93gwNmGXfsvXZ2Q&oauth_token_secret=e5piHx4CHZnUjcrDE1xMtTXVbN0v2qOmdX04m5LLs&oauth_callback_confirmed=true	2010-07-07	0	
166	bigh0RlMVVjiyyTDnAhQIiRgLDDDN7F5mjpetGHTg	rrPe2blAfaakfyAcTfpNCOVcodZEYNy7QyDkJbFJxA	oauth_token=bigh0RlMVVjiyyTDnAhQIiRgLDDDN7F5mjpetGHTg&oauth_token_secret=rrPe2blAfaakfyAcTfpNCOVcodZEYNy7QyDkJbFJxA&oauth_callback_confirmed=true	2010-06-30	57	46964c21467a18cf9a7b2b2c4f9c461df515f823ef88ae4301a3289e79e2a
433	kokg8H6fZXdpAKO6358GA4gKEwWPswcPHL78BnpN64k	kih1A2Uoc9KdI9jELgHiO7RF4Rnk8x2nMGHIWtx4Sw	oauth_token=kokg8H6fZXdpAKO6358GA4gKEwWPswcPHL78BnpN64k&oauth_token_secret=kih1A2Uoc9KdI9jELgHiO7RF4Rnk8x2nMGHIWtx4Sw&oauth_callback_confirmed=true	2010-07-08	0	
340	vLyZTMClrHRTBdmiPrSiW6xgDwaEQpCBUiIRgYUVDw	jB6pt4rhDnVqu27U3Zfc152YrE27cA34TrZ7p1Xk	oauth_token=vLyZTMClrHRTBdmiPrSiW6xgDwaEQpCBUiIRgYUVDw&oauth_token_secret=jB6pt4rhDnVqu27U3Zfc152YrE27cA34TrZ7p1Xk&oauth_callback_confirmed=true	2010-07-07	118	84569d98a9131d9a89532bec2c935e1175392b8309fd7e2e3b0473045a5bf6
170	2ACrOjKW3zytLDLUYT1neRyQq4LMppKe8QMfTCjt8	rvluDUCmkmxI4mamDxq6WRVn5rHf3AzTmzkmuYRVf4	oauth_token=2ACrOjKW3zytLDLUYT1neRyQq4LMppKe8QMfTCjt8&oauth_token_secret=rvluDUCmkmxI4mamDxq6WRVn5rHf3AzTmzkmuYRVf4&oauth_callback_confirmed=true	2010-07-01	0	
190	x7lT0w0yD5GtVDgJGKkMX0Xlu5nSKQmbEWhWhwXhFk	oXqJ0zk5KQ95XETMjB1LuB8skKIcynAWKxwOtRWFY	oauth_token=x7lT0w0yD5GtVDgJGKkMX0Xlu5nSKQmbEWhWhwXhFk&oauth_token_secret=oXqJ0zk5KQ95XETMjB1LuB8skKIcynAWKxwOtRWFY&oauth_callback_confirmed=true	2010-07-01	0	
439	Nny7WHxlz7o3W92rBLieZuBW6lmyucRFsmdYyTW97Y	UTI6iPb1PvOPAP6x7uvsvDgwWrXOA478OBgbG1fv0	oauth_token=Nny7WHxlz7o3W92rBLieZuBW6lmyucRFsmdYyTW97Y&oauth_token_secret=UTI6iPb1PvOPAP6x7uvsvDgwWrXOA478OBgbG1fv0&oauth_callback_confirmed=true	2010-07-08	0	
193	JIxb9wnoCaHG2x2KAMpXBS6v37zc5OhS1yHAYHjVNw	oUUGUggjbt1vLbz8CoKZI1EqFHILb8coChzDCutxyg	oauth_token=JIxb9wnoCaHG2x2KAMpXBS6v37zc5OhS1yHAYHjVNw&oauth_token_secret=oUUGUggjbt1vLbz8CoKZI1EqFHILb8coChzDCutxyg&oauth_callback_confirmed=true	2010-07-01	68	9f49cd7ded209165be9975a79d27b182f04f849768982f7e6afd7576a4796e0
175	gU7Mpyr8pjF5xFwv7m08PoBte9cwL0u3v5Qq4BEXWI	aw80DYDkSlhMbnuV4potKhkVApYy1gusjeE3UuOZ7js	oauth_token=gU7Mpyr8pjF5xFwv7m08PoBte9cwL0u3v5Qq4BEXWI&oauth_token_secret=aw80DYDkSlhMbnuV4potKhkVApYy1gusjeE3UuOZ7js&oauth_callback_confirmed=true	2010-07-01	62	129f8019fa20fa94e0db6deb78be55f5b0669301133429cca6bef501557d6
194	HQL5rSR5XIrevtkTa8FTkl8oZYBiDwLuttvk3lcGCM	bYxmVMXLlez99QgBcPpIQ1bQltsZdW6YS81FEsQTw	oauth_token=HQL5rSR5XIrevtkTa8FTkl8oZYBiDwLuttvk3lcGCM&oauth_token_secret=bYxmVMXLlez99QgBcPpIQ1bQltsZdW6YS81FEsQTw&oauth_callback_confirmed=true	2010-07-01	0	
195	WpV9GtHhC8fZq2gjdC9uGxWEfceock9eEnb6ZabU1bU	e6hdS8PTMyD4OU3KDgSU5AK6tt40ypyjbvAVwx5rzHo	oauth_token=WpV9GtHhC8fZq2gjdC9uGxWEfceock9eEnb6ZabU1bU&oauth_token_secret=e6hdS8PTMyD4OU3KDgSU5AK6tt40ypyjbvAVwx5rzHo&oauth_callback_confirmed=true	2010-07-01	0	
442	9oNkwoYKodJCFMUOnL5wnqhBYko7m9fEUcIrn2Vu0vg	8Z029mT7vZE66oAVMXVbpnYw5tlA260HfE33KhQ	oauth_token=9oNkwoYKodJCFMUOnL5wnqhBYko7m9fEUcIrn2Vu0vg&oauth_token_secret=8Z029mT7vZE66oAVMXVbpnYw5tlA260HfE33KhQ&oauth_callback_confirmed=true	2010-07-10	78	8c1c25b83f27ca92ef87c0726a8e56ae43eecf889cd3e7fcce6aa6c6a1a27d5b
370	nht5kePiY6iHasD2O53HU2L5NvVOdFtNbyJgnu8W8	5Ge0LqR0Emx29aN19ay2aOjUXmt4CqSzpSRu2Bal8	oauth_token=nht5kePiY6iHasD2O53HU2L5NvVOdFtNbyJgnu8W8&oauth_token_secret=5Ge0LqR0Emx29aN19ay2aOjUXmt4CqSzpSRu2Bal8&oauth_callback_confirmed=true	2010-07-07	0	
373	UcaxxVhwLtfOjfNt12qWeIig4MPoU2HRZJkhWfKVg	VjRCq2pQoROtl4TA8gTOumdReNZB3b48Gsq704qx8g	oauth_token=UcaxxVhwLtfOjfNt12qWeIig4MPoU2HRZJkhWfKVg&oauth_token_secret=VjRCq2pQoROtl4TA8gTOumdReNZB3b48Gsq704qx8g&oauth_callback_confirmed=true	2010-07-07	0	
382	7NhqqPkODGGw6gyVs8z9fYT64RsCYilrFybVGbjNE	wC4lNKTCgkKtayqpyZNQxw6xIYGC4rNDSvxvA3bbM	oauth_token=7NhqqPkODGGw6gyVs8z9fYT64RsCYilrFybVGbjNE&oauth_token_secret=wC4lNKTCgkKtayqpyZNQxw6xIYGC4rNDSvxvA3bbM&oauth_callback_confirmed=true	2010-07-07	134	ce11619e540ccceb0517eb203d9f2d4c4af89145ccfe28185cad4b2aa833
388	iUdLesBuOm4Kb0juPw7WwCelLOsdppawhLfwrkPwhw	Msa1alfU5Y0MHLqwngcxnUW6UNAqMYdkAO2W1KkZyYo	oauth_token=iUdLesBuOm4Kb0juPw7WwCelLOsdppawhLfwrkPwhw&oauth_token_secret=Msa1alfU5Y0MHLqwngcxnUW6UNAqMYdkAO2W1KkZyYo&oauth_callback_confirmed=true	2010-07-07	0	
400	7g5LERi7AimmDk0BULOcUkJ3Z6rTihPPFU3wV5mIg	nRZPiFrmZbRcjq0kyeRZ5gAcQN09ltsmpPI4ch9g	oauth_token=7g5LERi7AimmDk0BULOcUkJ3Z6rTihPPFU3wV5mIg&oauth_token_secret=nRZPiFrmZbRcjq0kyeRZ5gAcQN09ltsmpPI4ch9g&oauth_callback_confirmed=true	2010-07-08	139	a126744944835aca4148dfb325e894231dd78d23b38ba6bbe42a9efaa961eb6e
196	EgrJnrpbQpJCb8BspWkJjZkawDA0gdR8TIUnIDvIOM	Tk59CsCVWg8LR3GA5tt5y6qqfZcMXsEAfdjoh7RQQ	oauth_token=EgrJnrpbQpJCb8BspWkJjZkawDA0gdR8TIUnIDvIOM&oauth_token_secret=Tk59CsCVWg8LR3GA5tt5y6qqfZcMXsEAfdjoh7RQQ&oauth_callback_confirmed=true	2010-07-01	0	
197	jvYo1MJNbeRTd9iGIujXY751gY80auXcD3zygdZjo8	pf7CsRN1vVdkxjSwL20dFIpJPlU94lfOYnxeqOFZQM	oauth_token=jvYo1MJNbeRTd9iGIujXY751gY80auXcD3zygdZjo8&oauth_token_secret=pf7CsRN1vVdkxjSwL20dFIpJPlU94lfOYnxeqOFZQM&oauth_callback_confirmed=true	2010-07-02	0	
198	lvx6PN64GPiPsIBpRbIzdfQ35uje97fcWyiKZqxrdk	jHAJfzstTej50o5VI3pLIlc7qwoBWxPfoZSxk1iAX4	oauth_token=lvx6PN64GPiPsIBpRbIzdfQ35uje97fcWyiKZqxrdk&oauth_token_secret=jHAJfzstTej50o5VI3pLIlc7qwoBWxPfoZSxk1iAX4&oauth_callback_confirmed=true	2010-07-02	0	
199	n8jJCwG3No5TRG2xYCHz4ggJhjhK5sX5lHZvPvdnlPw	odKfzRUTIwBJsiEzt84Wxz4SrFONrZxa15hlRNQQI	oauth_token=n8jJCwG3No5TRG2xYCHz4ggJhjhK5sX5lHZvPvdnlPw&oauth_token_secret=odKfzRUTIwBJsiEzt84Wxz4SrFONrZxa15hlRNQQI&oauth_callback_confirmed=true	2010-07-02	0	
200	ua8q8Zv128ih52psTzYMHpyQSbyZa6KjqWK85S2g	C5Mm1VyxE8gTcL87klZsfLIuLUXtc0Zk7HhEa4Ge8	oauth_token=ua8q8Zv128ih52psTzYMHpyQSbyZa6KjqWK85S2g&oauth_token_secret=C5Mm1VyxE8gTcL87klZsfLIuLUXtc0Zk7HhEa4Ge8&oauth_callback_confirmed=true	2010-07-02	0	
202	YYyIVgkQzmmIokixdsz24mlwe53uguctAgvoMgvSkg0	q5YlGTDHXTlnPiWZUM4hdSZJWZxuLjvP61P1en4fBg	oauth_token=YYyIVgkQzmmIokixdsz24mlwe53uguctAgvoMgvSkg0&oauth_token_secret=q5YlGTDHXTlnPiWZUM4hdSZJWZxuLjvP61P1en4fBg&oauth_callback_confirmed=true	2010-07-02	0	
207	4Y47353XEirVREJJHsRr0he4MC37WCFpRm0e6qRHRio	NaXpfosieeBj9onTQjNmHms136rBvQ372QoRvShQ	oauth_token=4Y47353XEirVREJJHsRr0he4MC37WCFpRm0e6qRHRio&oauth_token_secret=NaXpfosieeBj9onTQjNmHms136rBvQ372QoRvShQ&oauth_callback_confirmed=true	2010-07-02	0	
208	HiygMwGc4gM0g6vhF9QrqtC77zKngAHaiGIwi7kyDTA	jOz6d4eWrRkheaOMETGLa2sTwLQ9lnutnp71G1hztA	oauth_token=HiygMwGc4gM0g6vhF9QrqtC77zKngAHaiGIwi7kyDTA&oauth_token_secret=jOz6d4eWrRkheaOMETGLa2sTwLQ9lnutnp71G1hztA&oauth_callback_confirmed=true	2010-07-02	0	
209	UUP4Z3LJNL8oM7d8npPJ8jjwWg8WbGr9NIgT1ZHr8	qSTzHm7Ae9xvtkDgoWAvTNV39bNPU7F7N9fNlHLk24	oauth_token=UUP4Z3LJNL8oM7d8npPJ8jjwWg8WbGr9NIgT1ZHr8&oauth_token_secret=qSTzHm7Ae9xvtkDgoWAvTNV39bNPU7F7N9fNlHLk24&oauth_callback_confirmed=true	2010-07-02	0	
212	Y4b4wNMYfu0fertTLq32vX94dtPd7Cbqawl99QTpU	QaLmwLNbEjlStiUB47Ic8Fp7mc9UrgAdUOe3f2Hars	oauth_token=Y4b4wNMYfu0fertTLq32vX94dtPd7Cbqawl99QTpU&oauth_token_secret=QaLmwLNbEjlStiUB47Ic8Fp7mc9UrgAdUOe3f2Hars&oauth_callback_confirmed=true	2010-07-02	72	74ec718231774174ea7a5aa02992d6b2135dc61eedc775923eb66d5825e
213	ffkFSLgmTDlpKvfYfVwiFKTIymIhVXH5qCpTyHB24	e5k5XkkKCSYpDZeRdVypy0x3LpX5ecYHXHN79YHJN4	oauth_token=ffkFSLgmTDlpKvfYfVwiFKTIymIhVXH5qCpTyHB24&oauth_token_secret=e5k5XkkKCSYpDZeRdVypy0x3LpX5ecYHXHN79YHJN4&oauth_callback_confirmed=true	2010-07-02	72	74ec718231774174ea7a5aa02992d6b2135dc61eedc775923eb66d5825e
214	5SkY1PUmAp4r54H6mtPpcwtjYaDnqJF4oxu8eHbp8	8Yqul4LzxUfdpLLnRmjwT6alQREgWwY2xHdlGYwx3qU	oauth_token=5SkY1PUmAp4r54H6mtPpcwtjYaDnqJF4oxu8eHbp8&oauth_token_secret=8Yqul4LzxUfdpLLnRmjwT6alQREgWwY2xHdlGYwx3qU&oauth_callback_confirmed=true	2010-07-02	33	4a38fe8631aaa5baa324cc6e507b52b85196a39ef6b4177398bc872ac95f
215	T3ujkH3lHGPCaZ2ZGqWY7jmwhIwHuq30dgxPJZOYf4	UafaZjEI0Higs2IajekUzzjmGyXVwbIDcQAYi0cSOk	oauth_token=T3ujkH3lHGPCaZ2ZGqWY7jmwhIwHuq30dgxPJZOYf4&oauth_token_secret=UafaZjEI0Higs2IajekUzzjmGyXVwbIDcQAYi0cSOk&oauth_callback_confirmed=true	2010-07-02	0	
217	ciEFhV9vEPq8F4Wo3K5n6I2Ag0cpy2SOCbEFa7yrJM	eDtuMZCEQaSPUcpDDhb3foXpgRA7nFexsU3v4HePY	oauth_token=ciEFhV9vEPq8F4Wo3K5n6I2Ag0cpy2SOCbEFa7yrJM&oauth_token_secret=eDtuMZCEQaSPUcpDDhb3foXpgRA7nFexsU3v4HePY&oauth_callback_confirmed=true	2010-07-02	0	
218	KFWh3niSIbzMB3vpQS85SgERsWIBi7lI1EqNkNHKg	S8v4z5EcY7cEmqXngmNWrndANyo2z5SZCzfBIlo	oauth_token=KFWh3niSIbzMB3vpQS85SgERsWIBi7lI1EqNkNHKg&oauth_token_secret=S8v4z5EcY7cEmqXngmNWrndANyo2z5SZCzfBIlo&oauth_callback_confirmed=true	2010-07-03	0	
219	uhZlGokQzFADbNtJGzodHA0HiTepSGYpd0KW42RN4E	hz6bP8WUVIUuCYhgBJPRxG91ms63uULack6aDls	oauth_token=uhZlGokQzFADbNtJGzodHA0HiTepSGYpd0KW42RN4E&oauth_token_secret=hz6bP8WUVIUuCYhgBJPRxG91ms63uULack6aDls&oauth_callback_confirmed=true	2010-07-03	0	
221	hNao6b9wZlrZnLLhy2Rruu9uQA6WtnEs0lnxXGVw	aDvtmpAICwA0XhenDYN1VwPQTq1ZTuHOH0nEvF04Y	oauth_token=hNao6b9wZlrZnLLhy2Rruu9uQA6WtnEs0lnxXGVw&oauth_token_secret=aDvtmpAICwA0XhenDYN1VwPQTq1ZTuHOH0nEvF04Y&oauth_callback_confirmed=true	2010-07-03	0	
222	vM6Nz1p55rhMEEbdAIIEbyb7QI8du2DfnU6eHFPIzpo	JZ2lMSTiOC7mXl6T2QUaCpL3zUlufdEDtGgRjwexbw	oauth_token=vM6Nz1p55rhMEEbdAIIEbyb7QI8du2DfnU6eHFPIzpo&oauth_token_secret=JZ2lMSTiOC7mXl6T2QUaCpL3zUlufdEDtGgRjwexbw&oauth_callback_confirmed=true	2010-07-03	0	
223	piKDZFNakTSgkXfrOC6OJhuh4SsqaYuEgHgpqeC4Dtw	bEiqqjyYbsHSCzlN3EXRd8AmPbRx30S1qm7RmW75yQ	oauth_token=piKDZFNakTSgkXfrOC6OJhuh4SsqaYuEgHgpqeC4Dtw&oauth_token_secret=bEiqqjyYbsHSCzlN3EXRd8AmPbRx30S1qm7RmW75yQ&oauth_callback_confirmed=true	2010-07-03	0	
225	Z7mRW9G4oB7w7cBfFdCXdzUKVSRqwU62J2ejYlDOp0	dd3XZM4HxPHgM3Dm5PG5r97ihGnIjDsebM2nFjU8lI	oauth_token=Z7mRW9G4oB7w7cBfFdCXdzUKVSRqwU62J2ejYlDOp0&oauth_token_secret=dd3XZM4HxPHgM3Dm5PG5r97ihGnIjDsebM2nFjU8lI&oauth_callback_confirmed=true	2010-07-03	0	
226	CGCmwnW2MTFc55MYirzZscMWrnI0K3P8FE8LMixLY	0BLKlmrSIG1Fp5ktG1LgdHCzfhFOg1rL4vVZPvNQg	oauth_token=CGCmwnW2MTFc55MYirzZscMWrnI0K3P8FE8LMixLY&oauth_token_secret=0BLKlmrSIG1Fp5ktG1LgdHCzfhFOg1rL4vVZPvNQg&oauth_callback_confirmed=true	2010-07-03	0	
227	ZXwXZUwYqU2rlT5Ybg8cIsvqruh39UDxmKnbXbvOT4	9OQf98kBe5NWhg45oSweKBpjVrABpKRTTC2JCCdmxg	oauth_token=ZXwXZUwYqU2rlT5Ybg8cIsvqruh39UDxmKnbXbvOT4&oauth_token_secret=9OQf98kBe5NWhg45oSweKBpjVrABpKRTTC2JCCdmxg&oauth_callback_confirmed=true	2010-07-03	0	
230	kdPBNfNcoAv2KH1Nb4BHxR8SUswyj4DGedX8DNcy4	TspOZR5jzdnrVbeD9NyBGjSyh9mEUWoSKQTG5sRqGWE	oauth_token=kdPBNfNcoAv2KH1Nb4BHxR8SUswyj4DGedX8DNcy4&oauth_token_secret=TspOZR5jzdnrVbeD9NyBGjSyh9mEUWoSKQTG5sRqGWE&oauth_callback_confirmed=true	2010-07-03	0	
231	841HcTkmW8PDz1yCopcFyABbayeE4nxnlFPPiFlQgeM	UCxKiS9O1e4ijSOUEbKykbyTPlr6NqO298REZ17cK0	oauth_token=841HcTkmW8PDz1yCopcFyABbayeE4nxnlFPPiFlQgeM&oauth_token_secret=UCxKiS9O1e4ijSOUEbKykbyTPlr6NqO298REZ17cK0&oauth_callback_confirmed=true	2010-07-04	0	
233	1RbbpB3NGJUmyVNFQYeWkJxGPTvyFBVfwFSYCgXiU	ii3IfE6XVEbcrMJi5aqVbzeKtpNDvTwSZeCflulEcw	oauth_token=1RbbpB3NGJUmyVNFQYeWkJxGPTvyFBVfwFSYCgXiU&oauth_token_secret=ii3IfE6XVEbcrMJi5aqVbzeKtpNDvTwSZeCflulEcw&oauth_callback_confirmed=true	2010-07-04	0	
234	bSgd2rysXU1rsNZQOavaKjk4fMHg7c8kJaoZkjr6M	Ym1WUUxdc6GgSPm6lESr4ybFilrzDsUaGCe7gPI2E	oauth_token=bSgd2rysXU1rsNZQOavaKjk4fMHg7c8kJaoZkjr6M&oauth_token_secret=Ym1WUUxdc6GgSPm6lESr4ybFilrzDsUaGCe7gPI2E&oauth_callback_confirmed=true	2010-07-04	0	
236	jeb4es1Do9eHn2ftHeDmYqG6cTVk1zPK2YifWVzWBmo	UyujdKVrtuvpqL6efEiMQn4UzLh4FpemEKjE8eMPo5c	oauth_token=jeb4es1Do9eHn2ftHeDmYqG6cTVk1zPK2YifWVzWBmo&oauth_token_secret=UyujdKVrtuvpqL6efEiMQn4UzLh4FpemEKjE8eMPo5c&oauth_callback_confirmed=true	2010-07-04	0	
237	XY5a8t6o9CUO7xCCGEYkOTLXVIBo0AcTRkRy5KgUc	kQCldDm2VMfXj8ryGfV5gqgSwM1uKnhdbf5qPo2MkM	oauth_token=XY5a8t6o9CUO7xCCGEYkOTLXVIBo0AcTRkRy5KgUc&oauth_token_secret=kQCldDm2VMfXj8ryGfV5gqgSwM1uKnhdbf5qPo2MkM&oauth_callback_confirmed=true	2010-07-04	0	
238	7Bhn7mCjoKE2wwgtznEluJArGwmSSmfoXFchJm1vxE	wVa6MSrhMlU2UGH8pULmPJq4KJrXhFPNDCDRqWhAM8	oauth_token=7Bhn7mCjoKE2wwgtznEluJArGwmSSmfoXFchJm1vxE&oauth_token_secret=wVa6MSrhMlU2UGH8pULmPJq4KJrXhFPNDCDRqWhAM8&oauth_callback_confirmed=true	2010-07-04	0	
314	AHzLkpxiaRincNXL2ShaepeJKeIzjADp0S1cSapqo	czHbgSAUcJIORX6fqBVGAPP4ZONOZgAhLu3WPyJiKtI	oauth_token=AHzLkpxiaRincNXL2ShaepeJKeIzjADp0S1cSapqo&oauth_token_secret=czHbgSAUcJIORX6fqBVGAPP4ZONOZgAhLu3WPyJiKtI&oauth_callback_confirmed=true	2010-07-07	0	
240	gyA4ZQV5asvVs0sS3RSH16Bd9AE698SzHP2vzEXVGQ0	fmXl0TO0qkK5O0RUiYmQWc6igzKoAZNXWi6jaYAFg8	oauth_token=gyA4ZQV5asvVs0sS3RSH16Bd9AE698SzHP2vzEXVGQ0&oauth_token_secret=fmXl0TO0qkK5O0RUiYmQWc6igzKoAZNXWi6jaYAFg8&oauth_callback_confirmed=true	2010-07-04	0	
242	e8EPuQvpaO3I9pcq3W4IsZlqX8q4LvaWzCNEJjKElA	UqZYUMAZB004EUW2XAVX2LQpegxLLT3uyWxUEPrE	oauth_token=e8EPuQvpaO3I9pcq3W4IsZlqX8q4LvaWzCNEJjKElA&oauth_token_secret=UqZYUMAZB004EUW2XAVX2LQpegxLLT3uyWxUEPrE&oauth_callback_confirmed=true	2010-07-04	81	322b9f357e659917781769a24625491bb4cd90484e50b5c6104a2935718f8542
244	ExW6sPyi7MG1b1chxRXdaMxPuC1vCeQPAzvfARmizs	zfKSTnbd5iVbvdTugFY99w81K6Jt7p5aJqYHNAVymQ	oauth_token=ExW6sPyi7MG1b1chxRXdaMxPuC1vCeQPAzvfARmizs&oauth_token_secret=zfKSTnbd5iVbvdTugFY99w81K6Jt7p5aJqYHNAVymQ&oauth_callback_confirmed=true	2010-07-05	0	
245	kyz15vmA2jmAIYj4dAOdto9wJ0q4Vy49RE6J1jTHS0	gNV06cggpnIqLL7cB8ikZ2ev0RUZ8nP88qVQm2czM	oauth_token=kyz15vmA2jmAIYj4dAOdto9wJ0q4Vy49RE6J1jTHS0&oauth_token_secret=gNV06cggpnIqLL7cB8ikZ2ev0RUZ8nP88qVQm2czM&oauth_callback_confirmed=true	2010-07-05	0	
249	3EIV6Lap7HmjRX4Ej591PgerbKNQV9SPb0Rn2ctUz0	zaJpiztdYg34RElAFTwwvWDsBHVK8IgEH1i4bySc8	oauth_token=3EIV6Lap7HmjRX4Ej591PgerbKNQV9SPb0Rn2ctUz0&oauth_token_secret=zaJpiztdYg34RElAFTwwvWDsBHVK8IgEH1i4bySc8&oauth_callback_confirmed=true	2010-07-05	82	55dfb6a878b6e7b07e2f1f6bc1df3bfa9da3ae5f3af8b662a81cac869c4
252	mCravD4nSDEZred7AHiFmNXoKzeAyNhqynVWQ1WmUaM	kdAFSE59km015QEACsRu4TPQMV8N41x6BeUX6Lmfd0	oauth_token=mCravD4nSDEZred7AHiFmNXoKzeAyNhqynVWQ1WmUaM&oauth_token_secret=kdAFSE59km015QEACsRu4TPQMV8N41x6BeUX6Lmfd0&oauth_callback_confirmed=true	2010-07-05	0	
253	FgaZNrD4E1r5VMMnR9KD4GQbkjesFzroq44rQL8ME	BPAShMjhuupynDR4Jre4LF1t59EF74I6qM2E	oauth_token=FgaZNrD4E1r5VMMnR9KD4GQbkjesFzroq44rQL8ME&oauth_token_secret=BPAShMjhuupynDR4Jre4LF1t59EF74I6qM2E&oauth_callback_confirmed=true	2010-07-05	0	
437	FyHXeCA1kZYIyRKlhld865tq4aYTZidKqaAhUktqk	t3NlIQmoqQOYNFbbBb7xfJs6Wzey6IY0xpMLw8Xsw	oauth_token=FyHXeCA1kZYIyRKlhld865tq4aYTZidKqaAhUktqk&oauth_token_secret=t3NlIQmoqQOYNFbbBb7xfJs6Wzey6IY0xpMLw8Xsw&oauth_callback_confirmed=true	2010-07-08	147	fa4ea078f95ba8c90b03ad05361d320d7473bbabad159c7fabb2e3fd673552
440	oS9zVmjm71CUx3Xjz2tLxAKagwZs4UxFKQU5WQF0Kw	tMP6wxp1ExjHqJxnNIrl3yP0UwGbgajl0BXlly8TFFM	oauth_token=oS9zVmjm71CUx3Xjz2tLxAKagwZs4UxFKQU5WQF0Kw&oauth_token_secret=tMP6wxp1ExjHqJxnNIrl3yP0UwGbgajl0BXlly8TFFM&oauth_callback_confirmed=true	2010-07-09	0	
257	SXC9nLV74SRvUYKQDSCbVdK96wIikrmfgzF7XOgHRWc	6Vol9sdennEIwh1cnONuwsLDfGZgiOvRnU3dwgONvY0	oauth_token=SXC9nLV74SRvUYKQDSCbVdK96wIikrmfgzF7XOgHRWc&oauth_token_secret=6Vol9sdennEIwh1cnONuwsLDfGZgiOvRnU3dwgONvY0&oauth_callback_confirmed=true	2010-07-06	85	a0ceb67b81b622721bcd1268c4bdad7bee2589762bb5da6ac5556dd689e119
259	iPHUD8JM2VXKH42OdHQ2UMH5MQMVakNc7QJb5M3ngaw	PJ7GywbvzgPv4kMvw24UbFcdbx9eSQyEpPOINme5gE	oauth_token=iPHUD8JM2VXKH42OdHQ2UMH5MQMVakNc7QJb5M3ngaw&oauth_token_secret=PJ7GywbvzgPv4kMvw24UbFcdbx9eSQyEpPOINme5gE&oauth_callback_confirmed=true	2010-07-06	86	a96167c7c804bd5d391e8864a963fbdd2e1aa7b1f3dce703240dc33cb0da
261	Wh48dWXcEleps859uWMcYCJGkhD26E3sfpUVh8Xk	vFeCuWX767d1peO3UFTqAphNVtaJpn277iWkF3Rawg	oauth_token=Wh48dWXcEleps859uWMcYCJGkhD26E3sfpUVh8Xk&oauth_token_secret=vFeCuWX767d1peO3UFTqAphNVtaJpn277iWkF3Rawg&oauth_callback_confirmed=true	2010-07-06	86	a96167c7c804bd5d391e8864a963fbdd2e1aa7b1f3dce703240dc33cb0da
262	PyyHCwGRe6SaJxAInIOtjNShoOMwMTigRPeoERD1Rs	vZrwKivSoV79LcA9EqcEqvZSdhXkGFVJKFHC6kwSSE	oauth_token=PyyHCwGRe6SaJxAInIOtjNShoOMwMTigRPeoERD1Rs&oauth_token_secret=vZrwKivSoV79LcA9EqcEqvZSdhXkGFVJKFHC6kwSSE&oauth_callback_confirmed=true	2010-07-06	86	a96167c7c804bd5d391e8864a963fbdd2e1aa7b1f3dce703240dc33cb0da
368	KGNeRHUR86Gb2O7APT9ZLVUussayu43ywrBAjsSbZg0	DHC0uyeoUNTOefOXGNEp1YP9OoNg0do8CRcf6AXAQg	oauth_token=KGNeRHUR86Gb2O7APT9ZLVUussayu43ywrBAjsSbZg0&oauth_token_secret=DHC0uyeoUNTOefOXGNEp1YP9OoNg0do8CRcf6AXAQg&oauth_callback_confirmed=true	2010-07-07	0	
270	bclBrXw49VaSNMVmq3Hlp746S15QupXejH9V7agC0	YX5VrYxqgDExWMsc1c4bHOiGHRg70DQlQo97vlngbsc	oauth_token=bclBrXw49VaSNMVmq3Hlp746S15QupXejH9V7agC0&oauth_token_secret=YX5VrYxqgDExWMsc1c4bHOiGHRg70DQlQo97vlngbsc&oauth_callback_confirmed=true	2010-07-06	90	ed731f879a34fa7b0be584039f7f6fb71fbdcbb94b96655f60d66ca326f29
380	scNhk5sevepLUPipqUbxZrLDXz0zI7kT17OXM6nnQ	UywOIWarOE5sLF5hhyE9EAmoEkQU1DlYc5oDAjynN7U	oauth_token=scNhk5sevepLUPipqUbxZrLDXz0zI7kT17OXM6nnQ&oauth_token_secret=UywOIWarOE5sLF5hhyE9EAmoEkQU1DlYc5oDAjynN7U&oauth_callback_confirmed=true	2010-07-07	0	
389	A0Xv2HQa7Pjz2sfVMlPuZM6Q4XLSS62dSQ4MHoykQ	K72jPn6dd9lnSyvKM0FEc5cNxHwpNM6AB706FufKU	oauth_token=A0Xv2HQa7Pjz2sfVMlPuZM6Q4XLSS62dSQ4MHoykQ&oauth_token_secret=K72jPn6dd9lnSyvKM0FEc5cNxHwpNM6AB706FufKU&oauth_callback_confirmed=true	2010-07-07	0	
404	O1liYVpmbADlaU6aQLVeUjRgY0NFc5erMI88i6DZtMc	x43gJaQoMNs3zqNNkSiZWcmJZq0x9kbe5af2EybQk	oauth_token=O1liYVpmbADlaU6aQLVeUjRgY0NFc5erMI88i6DZtMc&oauth_token_secret=x43gJaQoMNs3zqNNkSiZWcmJZq0x9kbe5af2EybQk&oauth_callback_confirmed=true	2010-07-08	140	219348f1ce2e4dea1de8e8e5c782c386bbaab1fcb86361317a0b2b894bcf
282	dW5IXqqajevj420yuORHYu8f55wbnlOvT3mfhsW1s8	wAzo6c1Akl4e8oCXeAr49uC4ZxqluB5I7XdQdz4A	oauth_token=dW5IXqqajevj420yuORHYu8f55wbnlOvT3mfhsW1s8&oauth_token_secret=wAzo6c1Akl4e8oCXeAr49uC4ZxqluB5I7XdQdz4A&oauth_callback_confirmed=true	2010-07-07	0	
407	fmRxuktUtMCTzJs72ZdHZhzr9RnJsWK1xTVmCDJ21wc	O7geaRBavhiyLF2xkq0pAtWS75B2hILtIOARNdb4xg	oauth_token=fmRxuktUtMCTzJs72ZdHZhzr9RnJsWK1xTVmCDJ21wc&oauth_token_secret=O7geaRBavhiyLF2xkq0pAtWS75B2hILtIOARNdb4xg&oauth_callback_confirmed=true	2010-07-08	0	
284	6sdKTeFll5283Z1XkcmyYhSfQkJmfPIAlagoCp3Y	IpzvOXd6KbUQLULE9VS6Bb6kvl3BC3c2qlnXrGD68w	oauth_token=6sdKTeFll5283Z1XkcmyYhSfQkJmfPIAlagoCp3Y&oauth_token_secret=IpzvOXd6KbUQLULE9VS6Bb6kvl3BC3c2qlnXrGD68w&oauth_callback_confirmed=true	2010-07-07	0	
285	YRatT3Ym8NCZGAvALvVXEq6aa4Yxohm1YLOK5PE	ZDEcYk5AmMOdR3e1F9cMSL10esuDFoW7grl47cJ2Vcs	oauth_token=YRatT3Ym8NCZGAvALvVXEq6aa4Yxohm1YLOK5PE&oauth_token_secret=ZDEcYk5AmMOdR3e1F9cMSL10esuDFoW7grl47cJ2Vcs&oauth_callback_confirmed=true	2010-07-07	94	104fe6d364cf68cfd9fdc3dded91222287a6937b334ba982049da126e7d8f
410	DamySaU33QVXLsOV2BHgtYcSzzo0PQmFd8fgpTZ1so	0JuJglUhurk3BQ4AxDD27UOPjXLENTNDAFgrgxJ1JYw	oauth_token=DamySaU33QVXLsOV2BHgtYcSzzo0PQmFd8fgpTZ1so&oauth_token_secret=0JuJglUhurk3BQ4AxDD27UOPjXLENTNDAFgrgxJ1JYw&oauth_callback_confirmed=true	2010-07-08	141	fd8c21e0c32927d7d365ebe8354f63ea1f2a255e7e229c82b36340c31d7eea75
315	h05AkSJ7yyqTUaDMNerWzYZKd3KO2nGl89C8iNGuTE	3wlBsJeBk5mOdn5NnrdpLixw8TmUSttlMYeMfv1cDI	oauth_token=h05AkSJ7yyqTUaDMNerWzYZKd3KO2nGl89C8iNGuTE&oauth_token_secret=3wlBsJeBk5mOdn5NnrdpLixw8TmUSttlMYeMfv1cDI&oauth_callback_confirmed=true	2010-07-07	0	
318	SpzeoeWzEunhyQl5XtrRJqdwCyafuWasiLCIk1t2l0	xgY8T5M3MErdk5o9IFJ1KIzd0lM4eMW9Zmt9OSEFgg	oauth_token=SpzeoeWzEunhyQl5XtrRJqdwCyafuWasiLCIk1t2l0&oauth_token_secret=xgY8T5M3MErdk5o9IFJ1KIzd0lM4eMW9Zmt9OSEFgg&oauth_callback_confirmed=true	2010-07-07	0	
324	FOJLxVl1lupcX02928RAWrL6XAMSecSCety07oAqJ2I	SkyzJhoPa1EHuXf2d8x1cvGel2LRyqh0T6G7jug3RUc	oauth_token=FOJLxVl1lupcX02928RAWrL6XAMSecSCety07oAqJ2I&oauth_token_secret=SkyzJhoPa1EHuXf2d8x1cvGel2LRyqh0T6G7jug3RUc&oauth_callback_confirmed=true	2010-07-07	0	
572	rdMxdtlav5fiy6qHlgkccTRDjq2C0bxE5df4cB6oY0I	BPeraKWn565y13cdImkQXH93NxUfP0RYoDgzn94	oauth_token=rdMxdtlav5fiy6qHlgkccTRDjq2C0bxE5df4cB6oY0I&oauth_token_secret=BPeraKWn565y13cdImkQXH93NxUfP0RYoDgzn94&oauth_callback_confirmed=true	2010-07-26	32	fda4144e672f3e1edf88092bf5e6c2fca01fd9d368b55f7c629702a135452
426	thcla8buoRh129UWrTScBZ7C1RcTaNgTFyD5v9ABjMc	1Yb7NjTa89nAfg0yhiyAiQ6sUC7tRMadqGl4ozUFbqA	oauth_token=thcla8buoRh129UWrTScBZ7C1RcTaNgTFyD5v9ABjMc&oauth_token_secret=1Yb7NjTa89nAfg0yhiyAiQ6sUC7tRMadqGl4ozUFbqA&oauth_callback_confirmed=true	2010-07-08	145	bc9f8df2d81d4f69cf57a3e94d48dfe98e7bd15dfaddeac2c1b083ef34b0a5ee
293	pRpIerIacXGthgeJrHWlz52brJ0j0psWC6PIy6cqUA	FqAZCnekACIKoaGTnXpC7hagGjlBT6XbtTUJvTjo0	oauth_token=pRpIerIacXGthgeJrHWlz52brJ0j0psWC6PIy6cqUA&oauth_token_secret=FqAZCnekACIKoaGTnXpC7hagGjlBT6XbtTUJvTjo0&oauth_callback_confirmed=true	2010-07-07	0	
345	7ltbEvhZn2Z9eZQ4HvtqHqcZZvix831fY21Pb4yhSk	pHzIxUw1MGCVmkpLGjJvt7lna5s5AoZCaNvUyOZ3dI	oauth_token=7ltbEvhZn2Z9eZQ4HvtqHqcZZvix831fY21Pb4yhSk&oauth_token_secret=pHzIxUw1MGCVmkpLGjJvt7lna5s5AoZCaNvUyOZ3dI&oauth_callback_confirmed=true	2010-07-07	102	2c91b44cd933c745b470a9be1f9be7e93a28ddf2aaf598901d8723a1453
348	urfzmhObym8iFYAKzXe3xDeQjh0MUfBrv2gNHl1HGQ	6LQUa57sI4CBNrUeiZMRCBw6zGSntP134kfIIjqmdPE	oauth_token=urfzmhObym8iFYAKzXe3xDeQjh0MUfBrv2gNHl1HGQ&oauth_token_secret=6LQUa57sI4CBNrUeiZMRCBw6zGSntP134kfIIjqmdPE&oauth_callback_confirmed=true	2010-07-07	120	13c781847d9fe6edb66557d5ac1713bec6858e355641c0f8343cf880a2b6056
351	fHYSs1jKDG1iDFqoX7HkuxjHZCZ7A4gv4hrffDCA	jL6zVbzXCx7bagmvjWRxgC7AoqFHgiFFHsS0YdTNnXY	oauth_token=fHYSs1jKDG1iDFqoX7HkuxjHZCZ7A4gv4hrffDCA&oauth_token_secret=jL6zVbzXCx7bagmvjWRxgC7AoqFHgiFFHsS0YdTNnXY&oauth_callback_confirmed=true	2010-07-07	102	2c91b44cd933c745b470a9be1f9be7e93a28ddf2aaf598901d8723a1453
441	lrU0o1RosKIbG0KfuchqJb7NMyMIpfAlh197NbeRg	NTAidRTI2Jj7SnpOI6Ghw4R4kJfPMBqZUkmPHO4WYA	oauth_token=lrU0o1RosKIbG0KfuchqJb7NMyMIpfAlh197NbeRg&oauth_token_secret=NTAidRTI2Jj7SnpOI6Ghw4R4kJfPMBqZUkmPHO4WYA&oauth_callback_confirmed=true	2010-07-09	0	
302	KNpQRHFeX8fiFHuPwVAQnB1QvrZXZT4ipAOxtDeCqwk	ex7fzeuXa0QdKXcgcbYk8VzhFqwS5O99UZm0efzrvs	oauth_token=KNpQRHFeX8fiFHuPwVAQnB1QvrZXZT4ipAOxtDeCqwk&oauth_token_secret=ex7fzeuXa0QdKXcgcbYk8VzhFqwS5O99UZm0efzrvs&oauth_callback_confirmed=true	2010-07-07	0	
445	rlbNw7GcyjVOaWv2G7rPOw7JWcrx9QZFcDXBKvuxQiw	cjxt49naITL4RPLodtj7KP9ziyFg0lGBKjPNS8xTvY	oauth_token=rlbNw7GcyjVOaWv2G7rPOw7JWcrx9QZFcDXBKvuxQiw&oauth_token_secret=cjxt49naITL4RPLodtj7KP9ziyFg0lGBKjPNS8xTvY&oauth_callback_confirmed=true	2010-07-10	93	b31f335d68847632b14fbfdc1ad70fb31a92ea885f839a97b3fbed3c1973b
369	pd1G8NwEN6nwtW30dQzlu6qNYNrUXg8ED0DvSaEjvkk	bUcpjIEfM7vxVn3f0Ef0ArzCRRZPRmdfUQTymAcGxWM	oauth_token=pd1G8NwEN6nwtW30dQzlu6qNYNrUXg8ED0DvSaEjvkk&oauth_token_secret=bUcpjIEfM7vxVn3f0Ef0ArzCRRZPRmdfUQTymAcGxWM&oauth_callback_confirmed=true	2010-07-07	130	892c773d8b28e79ef755cdc1778bced724b801b8938c418d8f8af8da83d9f
307	cA1E3gcJ84ZLf4ZwQsNnilsxuepykzVgErpDXLk	GRxBrSgFyib9K1D542651CFpeffDlzNhTdCj36Kno8	oauth_token=cA1E3gcJ84ZLf4ZwQsNnilsxuepykzVgErpDXLk&oauth_token_secret=GRxBrSgFyib9K1D542651CFpeffDlzNhTdCj36Kno8&oauth_callback_confirmed=true	2010-07-07	102	2c91b44cd933c745b470a9be1f9be7e93a28ddf2aaf598901d8723a1453
448	w8br6bBrrNITBAQaAyj9hyMe3horST94yUHjnyxxcM	JRyECFZwWG6Ad4XdpUNiDVlGXUmsHOoL5rWlujJLwU	oauth_token=w8br6bBrrNITBAQaAyj9hyMe3horST94yUHjnyxxcM&oauth_token_secret=JRyECFZwWG6Ad4XdpUNiDVlGXUmsHOoL5rWlujJLwU&oauth_callback_confirmed=true	2010-07-10	0	
375	qlvadIOmmY1sswdgyagNM6Ad1wMoevSeiE7xWkY	SNjGX1kGL3tp0UBvuoRqsncMExWNn5pG8GYtFPSMKrE	oauth_token=qlvadIOmmY1sswdgyagNM6Ad1wMoevSeiE7xWkY&oauth_token_secret=SNjGX1kGL3tp0UBvuoRqsncMExWNn5pG8GYtFPSMKrE&oauth_callback_confirmed=true	2010-07-07	102	2c91b44cd933c745b470a9be1f9be7e93a28ddf2aaf598901d8723a1453
449	VmQkrNtlHXrN52bQg12AX4Bro0eamR1Opy7FYmMzoQ	HBtpP9kM9DlB48IQdhdYiwyI5b5O17m0ne01tycU0	oauth_token=VmQkrNtlHXrN52bQg12AX4Bro0eamR1Opy7FYmMzoQ&oauth_token_secret=HBtpP9kM9DlB48IQdhdYiwyI5b5O17m0ne01tycU0&oauth_callback_confirmed=true	2010-07-10	0	
450	EXYf8j3jezAPhpkc91KPyWAPAdqrksYHLRqGIuG3M24	yIP08flRkzRlnOHvoa82VvC4fjKYsRZwWaJAGzgQboc	oauth_token=EXYf8j3jezAPhpkc91KPyWAPAdqrksYHLRqGIuG3M24&oauth_token_secret=yIP08flRkzRlnOHvoa82VvC4fjKYsRZwWaJAGzgQboc&oauth_callback_confirmed=true	2010-07-10	0	
384	Kt0t2qbm1pQSzgKuoDll2rlXwxoZVEwNKU4DX0WfXjY	GrINfH7wjkeDJmPYJ6iOvUnNvIZ0jwSVX7D9Gvz6sA	oauth_token=Kt0t2qbm1pQSzgKuoDll2rlXwxoZVEwNKU4DX0WfXjY&oauth_token_secret=GrINfH7wjkeDJmPYJ6iOvUnNvIZ0jwSVX7D9Gvz6sA&oauth_callback_confirmed=true	2010-07-07	135	c465cb26b2643f2e87bf75eb7e88fc59e7ecd622a6c39fa428c956271f3e35d
452	Y6QTzyKJezEkQhhXOVsUldxLA6eQwsB0XnYfAD7OZs	RnRr1sRbiErso9xqLfsRWxKtSQuOG50yabW21IotUs	oauth_token=Y6QTzyKJezEkQhhXOVsUldxLA6eQwsB0XnYfAD7OZs&oauth_token_secret=RnRr1sRbiErso9xqLfsRWxKtSQuOG50yabW21IotUs&oauth_callback_confirmed=true	2010-07-10	0	
453	Gs39QpBRe6oYAytlCLIRvEigweKnNjFkPTCWzSnVTY	XbVltGz2L2CfGKlnltd0nJ7BAVrlUiifS9XZ3Yu91go	oauth_token=Gs39QpBRe6oYAytlCLIRvEigweKnNjFkPTCWzSnVTY&oauth_token_secret=XbVltGz2L2CfGKlnltd0nJ7BAVrlUiifS9XZ3Yu91go&oauth_callback_confirmed=true	2010-07-10	0	
393	E5Wqrex9iPiZxvjrft2IVqFDasWZJEL9jbaNOncgVMo	qmEvmeLsLvliaCTiYItc5ej0HFDVEete9zpQYGlTY	oauth_token=E5Wqrex9iPiZxvjrft2IVqFDasWZJEL9jbaNOncgVMo&oauth_token_secret=qmEvmeLsLvliaCTiYItc5ej0HFDVEete9zpQYGlTY&oauth_callback_confirmed=true	2010-07-07	100	d0b343fbb45772a0b060b2f7ff4596e98f67f1ee4e4359c90c1d5812ac3c81
454	GZ08N79CwmFhemtH4rNNZBkNZg9c1Z0q8Tb4MHASJ0Q	dVIIB5ox8ipWSKD8qrRTGawTY5zQo1ueyDO8gTE2s	oauth_token=GZ08N79CwmFhemtH4rNNZBkNZg9c1Z0q8Tb4MHASJ0Q&oauth_token_secret=dVIIB5ox8ipWSKD8qrRTGawTY5zQo1ueyDO8gTE2s&oauth_callback_confirmed=true	2010-07-10	0	
456	iqXEVZlLTE9OLMLjPDMOehhhdADieqzc4pESRHQtF8	KkNhAPkjiVftEV7OW4LHnjLUVfz2UOzLy4eQLSguFa4	oauth_token=iqXEVZlLTE9OLMLjPDMOehhhdADieqzc4pESRHQtF8&oauth_token_secret=KkNhAPkjiVftEV7OW4LHnjLUVfz2UOzLy4eQLSguFa4&oauth_callback_confirmed=true	2010-07-10	0	
457	vE3ck660Lc7f0FoO65w3W3b3Hh1xaTK3rzn3mku7DI	wWqd81oA1g7j65tdMCPR8uUgNCeUmBzdPag9MEKVAhY	oauth_token=vE3ck660Lc7f0FoO65w3W3b3Hh1xaTK3rzn3mku7DI&oauth_token_secret=wWqd81oA1g7j65tdMCPR8uUgNCeUmBzdPag9MEKVAhY&oauth_callback_confirmed=true	2010-07-10	0	
570	AYj13uC91MM5pXQdgdRpGsUPhLlBLHpIpYewQ1NlI	NuZI6U6oFbiJlU1vzbcXRxN0Fyjrd60Vkx9pDzS0	oauth_token=AYj13uC91MM5pXQdgdRpGsUPhLlBLHpIpYewQ1NlI&oauth_token_secret=NuZI6U6oFbiJlU1vzbcXRxN0Fyjrd60Vkx9pDzS0&oauth_callback_confirmed=true	2010-07-26	32	fda4144e672f3e1edf88092bf5e6c2fca01fd9d368b55f7c629702a135452
459	KoL9BRoqK2AMkApMvzFzFP3TNxEfQnQNpMrGHMZJhbA	TrtUmMirjf13U9fFekS0N76MwGyYBolDOxxHnNhxg	oauth_token=KoL9BRoqK2AMkApMvzFzFP3TNxEfQnQNpMrGHMZJhbA&oauth_token_secret=TrtUmMirjf13U9fFekS0N76MwGyYBolDOxxHnNhxg&oauth_callback_confirmed=true	2010-07-10	151	5bad4a7ed82d859026eb7be5db949a54592a1a8eb5dfb4c6bdf13d7df77fd
460	XZY9TmBVAUQFEOBlWzOAaWhn6lTIVE0W0yov6MD4	tp58UF7fwnSlBytgF7mojXSF9V2GjaapY9OJYzj0Il4	oauth_token=XZY9TmBVAUQFEOBlWzOAaWhn6lTIVE0W0yov6MD4&oauth_token_secret=tp58UF7fwnSlBytgF7mojXSF9V2GjaapY9OJYzj0Il4&oauth_callback_confirmed=true	2010-07-11	0	
461	1hljsbo3ybBc8lNT2ZjesIcGMcTJh5tPXdvtK8Nc	9uMCE1KJvZF1DXQfI7au9cyPjM6HAHOtLxeGHCf0jGw	oauth_token=1hljsbo3ybBc8lNT2ZjesIcGMcTJh5tPXdvtK8Nc&oauth_token_secret=9uMCE1KJvZF1DXQfI7au9cyPjM6HAHOtLxeGHCf0jGw&oauth_callback_confirmed=true	2010-07-11	0	
465	cspnoEmyBFu7eqtNCsNXD0vmV3e3fYCUHppQYmEHEY	NRYVXPuvrR9se91B2ACcVXtT8d6jO5D0gIcw	oauth_token=cspnoEmyBFu7eqtNCsNXD0vmV3e3fYCUHppQYmEHEY&oauth_token_secret=NRYVXPuvrR9se91B2ACcVXtT8d6jO5D0gIcw&oauth_callback_confirmed=true	2010-07-13	93	b31f335d68847632b14fbfdc1ad70fb31a92ea885f839a97b3fbed3c1973b
466	LKVAhNweDwRzv6gWlZnRndX1jJ8SLArcG3hDkQGhYY	k43uSIqZ0QPMGolSHjchvRFKck5OHAsC9jKigmA	oauth_token=LKVAhNweDwRzv6gWlZnRndX1jJ8SLArcG3hDkQGhYY&oauth_token_secret=k43uSIqZ0QPMGolSHjchvRFKck5OHAsC9jKigmA&oauth_callback_confirmed=true	2010-07-13	93	b31f335d68847632b14fbfdc1ad70fb31a92ea885f839a97b3fbed3c1973b
467	d9bvhq9JxtJSxNzWOu9nTYtbDtlIdRtKBBuxkcqM	vedDeGJVdB5XagmeADLpYRmuAx8j7uzIl46rOY8vQc	oauth_token=d9bvhq9JxtJSxNzWOu9nTYtbDtlIdRtKBBuxkcqM&oauth_token_secret=vedDeGJVdB5XagmeADLpYRmuAx8j7uzIl46rOY8vQc&oauth_callback_confirmed=true	2010-07-13	93	b31f335d68847632b14fbfdc1ad70fb31a92ea885f839a97b3fbed3c1973b
469	D7HHSYwjJTMGTxs6Fr4AiHrkTFRsPMPqx42q0Qc6Ac	dyjhoaO6WzWZe6fd9LF4kg3lnjTHlWLU7qhD02dK5k	oauth_token=D7HHSYwjJTMGTxs6Fr4AiHrkTFRsPMPqx42q0Qc6Ac&oauth_token_secret=dyjhoaO6WzWZe6fd9LF4kg3lnjTHlWLU7qhD02dK5k&oauth_callback_confirmed=true	2010-07-13	31	d0297e875a8eea559890bbe37db6a6adf4a1236afbf75de3daa1f0abe371b7
471	ywOOR1widWb8aTB4bOBGVrZOdrxPjx6fZRP6FT68	iLtNNe59piwD2qJAGNgzXdnw2ybDvvDgpEsZ7v6Sro	oauth_token=ywOOR1widWb8aTB4bOBGVrZOdrxPjx6fZRP6FT68&oauth_token_secret=iLtNNe59piwD2qJAGNgzXdnw2ybDvvDgpEsZ7v6Sro&oauth_callback_confirmed=true	2010-07-13	152	ed168892348fc3fcf21bbe7628945b569fd49cb12bf1314325a4a5186bf5a
473	AGRcSUmbK9xM91eQL3D7oF1aKvoaKcqRcQesMGmM	UYHS5lwF62iUzZJvXHOvMkNYOcDY4HlnzeX6EYgj1cE	oauth_token=AGRcSUmbK9xM91eQL3D7oF1aKvoaKcqRcQesMGmM&oauth_token_secret=UYHS5lwF62iUzZJvXHOvMkNYOcDY4HlnzeX6EYgj1cE&oauth_callback_confirmed=true	2010-07-13	0	
474	hXQnx6QHQVrFPAwFkOOcki56UOKIYW24Z9rxPakYc	W7nFjPiNSKtjzaEJXbMhyC7W1qMDcktlDi9f4LLSxQ	oauth_token=hXQnx6QHQVrFPAwFkOOcki56UOKIYW24Z9rxPakYc&oauth_token_secret=W7nFjPiNSKtjzaEJXbMhyC7W1qMDcktlDi9f4LLSxQ&oauth_callback_confirmed=true	2010-07-14	0	
475	onYoITyPLHVnRFadCxtRULDyWPnyAhBbih68JwKU	xQ5n3PUVmsyTSNIOkke8zu7pmZzQF94yxM2lTUHQ	oauth_token=onYoITyPLHVnRFadCxtRULDyWPnyAhBbih68JwKU&oauth_token_secret=xQ5n3PUVmsyTSNIOkke8zu7pmZzQF94yxM2lTUHQ&oauth_callback_confirmed=true	2010-07-14	0	
478	zDuEBHLtgycaLVBATtjPjo60UTcA1HhLkPmTdLh3E	nzogw5RSKbvwNfjSb9YPQqrFSUrSmVbAkj2D18dmM	oauth_token=zDuEBHLtgycaLVBATtjPjo60UTcA1HhLkPmTdLh3E&oauth_token_secret=nzogw5RSKbvwNfjSb9YPQqrFSUrSmVbAkj2D18dmM&oauth_callback_confirmed=true	2010-07-14	0	
479	jS7QmEMEBdRFiBg44y4sJ0cqf6rhQijN3nJD1BCrBo	rsAi97mXhSbnk9ps3Odbxy304nyCqO3TxEXIkejIDg8	oauth_token=jS7QmEMEBdRFiBg44y4sJ0cqf6rhQijN3nJD1BCrBo&oauth_token_secret=rsAi97mXhSbnk9ps3Odbxy304nyCqO3TxEXIkejIDg8&oauth_callback_confirmed=true	2010-07-14	0	
480	mbpGLoMKrgZvHU6ZvM9PyMeXuqZgHz97iytCUD24MhM	kNPmeQGtb8pFSYm0eR9ySqDu6fhWRL1k37J0r5n9A	oauth_token=mbpGLoMKrgZvHU6ZvM9PyMeXuqZgHz97iytCUD24MhM&oauth_token_secret=kNPmeQGtb8pFSYm0eR9ySqDu6fhWRL1k37J0r5n9A&oauth_callback_confirmed=true	2010-07-14	0	
483	B07sCxicdrSpHhgTufg3F0oX8QX3xWTG7IcMVaoMums	yfAHgevgaPA1ljmVl3u3fiUc8HzwmuU5scCFIspE	oauth_token=B07sCxicdrSpHhgTufg3F0oX8QX3xWTG7IcMVaoMums&oauth_token_secret=yfAHgevgaPA1ljmVl3u3fiUc8HzwmuU5scCFIspE&oauth_callback_confirmed=true	2010-07-14	0	
484	YwgKFYv0NYC2CrMM06eSHw56qM6F1mqv0DPXBbMuXio	ixAtNL68Ahzf5ipddRQDqVe7iUUis49Byl3bcZiUM	oauth_token=YwgKFYv0NYC2CrMM06eSHw56qM6F1mqv0DPXBbMuXio&oauth_token_secret=ixAtNL68Ahzf5ipddRQDqVe7iUUis49Byl3bcZiUM&oauth_callback_confirmed=true	2010-07-14	0	
485	c9mEpQQU3RLlU2jag2aROFaQ2mLdQJH9nm1EFI0D4	VJmBfBDFb4mUqON9Zn4RXhpgPkrYNm4RLptBhsv05o	oauth_token=c9mEpQQU3RLlU2jag2aROFaQ2mLdQJH9nm1EFI0D4&oauth_token_secret=VJmBfBDFb4mUqON9Zn4RXhpgPkrYNm4RLptBhsv05o&oauth_callback_confirmed=true	2010-07-14	0	
486	o62voHif1oayY2n1Oe2HKarQqGHxfH8TA5vOaAIs	KYBPPFcVUjdRKdlM6AvaufZ8JBzikN7F4xYDxKAPRs	oauth_token=o62voHif1oayY2n1Oe2HKarQqGHxfH8TA5vOaAIs&oauth_token_secret=KYBPPFcVUjdRKdlM6AvaufZ8JBzikN7F4xYDxKAPRs&oauth_callback_confirmed=true	2010-07-14	0	
487	Cb2tYag3A2R1cm2yFMKTrXRfCWgKP3rTPGvrdpQco	hM2kDDpheUEDtUo7aINt0QPHMpkl1nuvhL06g6du8I	oauth_token=Cb2tYag3A2R1cm2yFMKTrXRfCWgKP3rTPGvrdpQco&oauth_token_secret=hM2kDDpheUEDtUo7aINt0QPHMpkl1nuvhL06g6du8I&oauth_callback_confirmed=true	2010-07-14	0	
488	0Z6wjIZzufprv44sS4PVNLiq73Gv2pZAUADKR1Evyc	BrjcEeG6LMA4OtWQDSBUtht3Xvk9gNU6j8grnIdMGQ8	oauth_token=0Z6wjIZzufprv44sS4PVNLiq73Gv2pZAUADKR1Evyc&oauth_token_secret=BrjcEeG6LMA4OtWQDSBUtht3Xvk9gNU6j8grnIdMGQ8&oauth_callback_confirmed=true	2010-07-14	0	
493	qPf1CVvGbS3oo17snOXX8NXaEVISXPPCootgGdCyc	qqDDhLxjjRDzD8xLlzv7Om7c4MqSYnkVXSr8YxfCV0U	oauth_token=qPf1CVvGbS3oo17snOXX8NXaEVISXPPCootgGdCyc&oauth_token_secret=qqDDhLxjjRDzD8xLlzv7Om7c4MqSYnkVXSr8YxfCV0U&oauth_callback_confirmed=true	2010-07-14	156	d7b3c83816fdcda82e79e8c32fb794d469db17be3c5d281c39c73c8a733dbe2
494	uxHT0v6OOc7GWoizafu6CvWJuLgZLiy1IA1vSmu1vio	AIgZkfMIlbjvIKyv7ZHGlWdbQNqwBmEJCXvAZKlcR6Y	oauth_token=uxHT0v6OOc7GWoizafu6CvWJuLgZLiy1IA1vSmu1vio&oauth_token_secret=AIgZkfMIlbjvIKyv7ZHGlWdbQNqwBmEJCXvAZKlcR6Y&oauth_callback_confirmed=true	2010-07-15	0	
496	n1Q8Z31pipTTkzlGYYqxn7Q9k9quxmaEvu6XKnKHWo	5HsDfM8ocZiF8AWFFx7U8jZGorHZBjrIebOD081HOA	oauth_token=n1Q8Z31pipTTkzlGYYqxn7Q9k9quxmaEvu6XKnKHWo&oauth_token_secret=5HsDfM8ocZiF8AWFFx7U8jZGorHZBjrIebOD081HOA&oauth_callback_confirmed=true	2010-07-15	157	575bbd306f121691b9af883dfd70d2403e04112b7b47f2610c4e7525507e2c
571	EahbIyI8YohWt0XoQrMx22gtUZeXSi2dnauCpS8	cxyYMDnC4tLRYxqHrzbRIKMnjT96lZeetzniQ6JCk	oauth_token=EahbIyI8YohWt0XoQrMx22gtUZeXSi2dnauCpS8&oauth_token_secret=cxyYMDnC4tLRYxqHrzbRIKMnjT96lZeetzniQ6JCk&oauth_callback_confirmed=true	2010-07-26	32	fda4144e672f3e1edf88092bf5e6c2fca01fd9d368b55f7c629702a135452
500	kCcyWvnEa8Xfjd2yunZY6JY7dfSIPB0o54B2WsYgJZc	AEcUefgoPAW3IbrIzXniigZkODoqq3DIodc4Js1y890	oauth_token=kCcyWvnEa8Xfjd2yunZY6JY7dfSIPB0o54B2WsYgJZc&oauth_token_secret=AEcUefgoPAW3IbrIzXniigZkODoqq3DIodc4Js1y890&oauth_callback_confirmed=true	2010-07-15	158	4254c793ca47bf9283faac9cae434ccd467df3d242f16501998c74c98b3a8dd
503	2CFZlgQ2CwrfkbcjUFBGiVmwlRabJmbcV6OJRLBmQY	qkZCVZ9D4Tr99055iUANqsCA7CCqrljy9TL9ccWU	oauth_token=2CFZlgQ2CwrfkbcjUFBGiVmwlRabJmbcV6OJRLBmQY&oauth_token_secret=qkZCVZ9D4Tr99055iUANqsCA7CCqrljy9TL9ccWU&oauth_callback_confirmed=true	2010-07-15	0	
504	vXhGPgge3rVHpmsO8fBsxqjYRFob3on2EQGh3I1RYg	iSDlhfYCTDp6XpvVojp2dvzoNnvTBuopyJKn2js3nnY	oauth_token=vXhGPgge3rVHpmsO8fBsxqjYRFob3on2EQGh3I1RYg&oauth_token_secret=iSDlhfYCTDp6XpvVojp2dvzoNnvTBuopyJKn2js3nnY&oauth_callback_confirmed=true	2010-07-15	0	
505	zPYgIg2nJWuNr8kuJqNNBSaZJR1iYFWAkFupLV9rRM	iib2ANHrvqmhGcv98CQAbyXm2iiFWacoNbAowW3boM	oauth_token=zPYgIg2nJWuNr8kuJqNNBSaZJR1iYFWAkFupLV9rRM&oauth_token_secret=iib2ANHrvqmhGcv98CQAbyXm2iiFWacoNbAowW3boM&oauth_callback_confirmed=true	2010-07-15	0	
506	FAICszLZYPvpxI0Dku5i09T1m7tNXBDPbrCnxmIzjM	y2wNJvEanP9JabLBm148eaIEz9gnKn4IGC4jPz203s0	oauth_token=FAICszLZYPvpxI0Dku5i09T1m7tNXBDPbrCnxmIzjM&oauth_token_secret=y2wNJvEanP9JabLBm148eaIEz9gnKn4IGC4jPz203s0&oauth_callback_confirmed=true	2010-07-15	0	
507	LTmLda7jvQgYP400Ekz1ZdwT8ItE8hZt7sS64dShA	52MTSRMPVoX4C3XF7R0pPCk9DBWtR9GrebPyUd7j8s	oauth_token=LTmLda7jvQgYP400Ekz1ZdwT8ItE8hZt7sS64dShA&oauth_token_secret=52MTSRMPVoX4C3XF7R0pPCk9DBWtR9GrebPyUd7j8s&oauth_callback_confirmed=true	2010-07-15	0	
508	LrrtCOCwGWKudaePEjeVq1PeqpqAcFZddZpRi1rP8	lU9bQO7dTbq0hvnscHBxxHlSgJAiaeQNkA00TF6l9e8	oauth_token=LrrtCOCwGWKudaePEjeVq1PeqpqAcFZddZpRi1rP8&oauth_token_secret=lU9bQO7dTbq0hvnscHBxxHlSgJAiaeQNkA00TF6l9e8&oauth_callback_confirmed=true	2010-07-15	0	
509	QtLAqwT4gvDc8dpdYeuzvIWpt2gjsDTKhLyHxgqHlKw	ez2p4G5A0jxjTDZtTnevwzX8ZGLDukiFLHBXIdNLnY	oauth_token=QtLAqwT4gvDc8dpdYeuzvIWpt2gjsDTKhLyHxgqHlKw&oauth_token_secret=ez2p4G5A0jxjTDZtTnevwzX8ZGLDukiFLHBXIdNLnY&oauth_callback_confirmed=true	2010-07-15	0	
512	LhYm4fnpB2OjeUNwocmBqIBGK5gzXxDo1aqLKnWz0	eucvZjYdSgHz3GzSeUOxa02yd5Z0YNdh8A8a0TflGS8	oauth_token=LhYm4fnpB2OjeUNwocmBqIBGK5gzXxDo1aqLKnWz0&oauth_token_secret=eucvZjYdSgHz3GzSeUOxa02yd5Z0YNdh8A8a0TflGS8&oauth_callback_confirmed=true	2010-07-15	0	
513	d3oTPpYXEf5bLlATY1GY38a3ecSHA6cXzK6e6Azbhdo	IPXnBHeEJ5U2FKNB3mCMpahovfnJmaAx562NUwkOU	oauth_token=d3oTPpYXEf5bLlATY1GY38a3ecSHA6cXzK6e6Azbhdo&oauth_token_secret=IPXnBHeEJ5U2FKNB3mCMpahovfnJmaAx562NUwkOU&oauth_callback_confirmed=true	2010-07-15	0	
514	xv3zJYzjN5TDYAu4T2oJsmCv9rstTe4vDTnXMN0s	uEHHegdDUySxFkNOUjzXvP5TQnySecR6KW2qYV2t2k	oauth_token=xv3zJYzjN5TDYAu4T2oJsmCv9rstTe4vDTnXMN0s&oauth_token_secret=uEHHegdDUySxFkNOUjzXvP5TQnySecR6KW2qYV2t2k&oauth_callback_confirmed=true	2010-07-15	0	
516	UDA2ib8dLsjMy6RqWEUbQf9HZBvY9GV40NiYtfxSBzs	9ORWIIX3nFTupLf5bJLidc5ZJa0OH0Fg6WdnyQ6lUg	oauth_token=UDA2ib8dLsjMy6RqWEUbQf9HZBvY9GV40NiYtfxSBzs&oauth_token_secret=9ORWIIX3nFTupLf5bJLidc5ZJa0OH0Fg6WdnyQ6lUg&oauth_callback_confirmed=true	2010-07-15	0	
518	ZDXLSlus1lJCsjrVO2jaaakU8uy0PyMrNqYUgMVq3Q	GleZJ4d7AG1SAMmTaTPlNdej0AuLB6mUG09sY7UZMw	oauth_token=ZDXLSlus1lJCsjrVO2jaaakU8uy0PyMrNqYUgMVq3Q&oauth_token_secret=GleZJ4d7AG1SAMmTaTPlNdej0AuLB6mUG09sY7UZMw&oauth_callback_confirmed=true	2010-07-15	163	5ffb7fe2db25b169e6fa6f551551775c373340dbe5ae78e3f757adcb316fb
519	5ezPvfPQ6REQDMwr7NAMGiEsFpfuzFyEvQoRoFZ2LNw	TKj7VNl837pn50Oeif7LpTCQDQuUX5M1rY8TjDOtU	oauth_token=5ezPvfPQ6REQDMwr7NAMGiEsFpfuzFyEvQoRoFZ2LNw&oauth_token_secret=TKj7VNl837pn50Oeif7LpTCQDQuUX5M1rY8TjDOtU&oauth_callback_confirmed=true	2010-07-15	163	5ffb7fe2db25b169e6fa6f551551775c373340dbe5ae78e3f757adcb316fb
520	tdzQU52kiykHvTBoNsaY0B5kNhBYfheIsYcpy1OEUo	ap3hEA5eGYaZFyoqDPajqLS5A0wVJUOFoLe7BXjVc	oauth_token=tdzQU52kiykHvTBoNsaY0B5kNhBYfheIsYcpy1OEUo&oauth_token_secret=ap3hEA5eGYaZFyoqDPajqLS5A0wVJUOFoLe7BXjVc&oauth_callback_confirmed=true	2010-07-15	0	
526	nTThwyehwF93hHpkPQgNazlSJW6HhCRK7cr49J5Jc	CfX5jvPRsqWYCT0474zOcL06wbV4um4zNa5CrnjvCjM	oauth_token=nTThwyehwF93hHpkPQgNazlSJW6HhCRK7cr49J5Jc&oauth_token_secret=CfX5jvPRsqWYCT0474zOcL06wbV4um4zNa5CrnjvCjM&oauth_callback_confirmed=true	2010-07-16	165	def35836cb25e4eb450c083b2d26a6afc2efa2415b0a95fa47397b647b687
527	CC6cPHPqOHr0baYisCnZCSx3W57XYX5TjrDhJifWQ	bmfVnMEp1gGsMJAY1j1NQmWt0iSciDDuboxNK73IM8	oauth_token=CC6cPHPqOHr0baYisCnZCSx3W57XYX5TjrDhJifWQ&oauth_token_secret=bmfVnMEp1gGsMJAY1j1NQmWt0iSciDDuboxNK73IM8&oauth_callback_confirmed=true	2010-07-16	0	
530	Yrzo2skeLYDiWpuxD61RRMi9sN4OtzbKcYLRoDakrs	G9HW3UGEgdBV96hrD6qLpnL6PmUEiJcmKw4SGej4Ia4	oauth_token=Yrzo2skeLYDiWpuxD61RRMi9sN4OtzbKcYLRoDakrs&oauth_token_secret=G9HW3UGEgdBV96hrD6qLpnL6PmUEiJcmKw4SGej4Ia4&oauth_callback_confirmed=true	2010-07-16	0	
531	h5XzC2EGW8kowiKPMmKvu1upqM3s58YjTjNtwglO48M	4P83DMJThTziqnTlxZhXsyjMTDgtQrhMfjgOghBvk	oauth_token=h5XzC2EGW8kowiKPMmKvu1upqM3s58YjTjNtwglO48M&oauth_token_secret=4P83DMJThTziqnTlxZhXsyjMTDgtQrhMfjgOghBvk&oauth_callback_confirmed=true	2010-07-16	0	
532	2EMAV731YxRcf0LhaWWcRdiwvGiPXdG1ocMPsWG7z4	ZVt4LkXsg4NQWwr7Obpy4vBBVpw7TxOLHLvnRRHfQg	oauth_token=2EMAV731YxRcf0LhaWWcRdiwvGiPXdG1ocMPsWG7z4&oauth_token_secret=ZVt4LkXsg4NQWwr7Obpy4vBBVpw7TxOLHLvnRRHfQg&oauth_callback_confirmed=true	2010-07-16	0	
533	bPoJTs4b6iwKbRjwJZKpClvk64JNBQ2htLcCNDSapQ	GLW676Toxc8VtgBXzRuG6IzEUORGjkFMnimtf9ZEuY	oauth_token=bPoJTs4b6iwKbRjwJZKpClvk64JNBQ2htLcCNDSapQ&oauth_token_secret=GLW676Toxc8VtgBXzRuG6IzEUORGjkFMnimtf9ZEuY&oauth_callback_confirmed=true	2010-07-16	0	
542	bNUsoyZiOXZmi9jLZSfh0rPOkKqOJ7GuPusU8Wh6Jo	hahGnlvvSaZk21VBcz5wrD3kIPRytKBWTXhGtFqehs	oauth_token=bNUsoyZiOXZmi9jLZSfh0rPOkKqOJ7GuPusU8Wh6Jo&oauth_token_secret=hahGnlvvSaZk21VBcz5wrD3kIPRytKBWTXhGtFqehs&oauth_callback_confirmed=true	2010-07-17	0	
\.


--
-- TOC entry 1831 (class 0 OID 24605)
-- Dependencies: 1527
-- Data for Name: logs; Type: TABLE DATA; Schema: main; Owner: mtwiple_user
--

COPY logs (id, log_user_id, log_screen_name, action, log_date) FROM stdin;
1	37	multwiple	16	2010-07-12
2	0	New User	12	2010-07-12
3	0	New User	12	2010-07-12
4	178	multwiple_test	11	2010-07-12
5	178	multwiple_test	3	2010-07-12
6	178	multwiple_test	5	2010-07-12
7	178	multwiple_test	20	2010-07-12
8	178	multwiple_test	21	2010-07-12
9	178	multwiple_test	21	2010-07-12
10	178	multwiple_test	13	2010-07-12
11	35	ammubhai	17	2010-07-12
12	37	multwiple	16	2010-07-12
13	36	spundhan	16	2010-07-12
14	0	New User	12	2010-07-12
15	208	SagarHugar	11	2010-07-12
16	208	SagarHugar	20	2010-07-12
17	208	SagarHugar	6	2010-07-12
18	208	SagarHugar	4	2010-07-12
19	208	SagarHugar	5	2010-07-12
20	0	New User	12	2010-07-12
21	208	SagarHugar	13	2010-07-12
22	0	New User	12	2010-07-12
23	209	SagarHugar	11	2010-07-12
24	35	ammubhai	14	2010-07-12
25	37	multwiple	16	2010-07-12
26	37	multwiple	1	2010-07-12
27	112	null	1	2010-07-12
28	0	New User	12	2010-07-12
29	210	VKabdulnasir	11	2010-07-12
30	210	VKabdulnasir	20	2010-07-12
31	0	New User	12	2010-07-12
32	41	h_r_j	5	2010-07-12
33	41	h_r_j	20	2010-07-12
34	41	h_r_j	21	2010-07-12
35	0	New User	12	2010-07-12
36	0	New User	12	2010-07-12
37	0	New User	12	2010-07-12
38	38	devikang	11	2010-07-12
39	38	devikang	5	2010-07-12
40	38	devikang	6	2010-07-12
41	38	devikang	7	2010-07-12
42	38	devikang	20	2010-07-12
43	38	devikang	21	2010-07-12
44	38	devikang	21	2010-07-12
45	38	devikang	21	2010-07-12
46	38	devikang	21	2010-07-12
47	38	devikang	21	2010-07-12
48	0	New User	12	2010-07-12
49	0	New User	12	2010-07-12
50	0	New User	12	2010-07-12
51	169	lgnaperso	1	2010-07-12
52	0	New User	12	2010-07-12
53	0	New User	12	2010-07-12
54	211	nabikhan24	11	2010-07-12
55	211	nabikhan24	20	2010-07-12
56	211	nabikhan24	16	2010-07-12
57	211	nabikhan24	7	2010-07-12
58	211	nabikhan24	6	2010-07-12
59	211	nabikhan24	20	2010-07-12
60	211	nabikhan24	20	2010-07-12
61	211	nabikhan24	20	2010-07-12
62	211	nabikhan24	20	2010-07-12
63	211	nabikhan24	20	2010-07-12
64	211	nabikhan24	15	2010-07-12
65	211	nabikhan24	4	2010-07-12
66	211	nabikhan24	4	2010-07-12
67	211	nabikhan24	5	2010-07-12
68	211	nabikhan24	5	2010-07-12
69	211	nabikhan24	5	2010-07-12
70	0	New User	12	2010-07-12
71	104	tweettestlab	22	2010-07-12
72	104	tweettestlab	16	2010-07-12
73	0	New User	12	2010-07-12
74	212	bhadur_varma	11	2010-07-12
75	0	New User	12	2010-07-12
76	0	New User	12	2010-07-12
77	0	New User	12	2010-07-12
78	0	New User	12	2010-07-12
79	213	multwiple_test	11	2010-07-12
80	213	multwiple_test	8	2010-07-12
81	213	multwiple_test	13	2010-07-12
82	0	New User	12	2010-07-12
83	214	WorldArtGallery	11	2010-07-12
84	0	New User	12	2010-07-12
85	215	GetMeInfo	11	2010-07-12
86	0	New User	12	2010-07-12
87	215	GetMeInfo	7	2010-07-12
88	215	GetMeInfo	20	2010-07-12
89	0	New User	12	2010-07-12
90	0	New User	12	2010-07-12
91	215	GetMeInfo	21	2010-07-12
92	0	New User	12	2010-07-12
93	215	GetMeInfo	8	2010-07-12
94	0	New User	12	2010-07-12
95	216	sandeepabhat	11	2010-07-12
96	214	WorldArtGallery	16	2010-07-12
97	214	WorldArtGallery	21	2010-07-12
98	214	WorldArtGallery	21	2010-07-12
99	214	WorldArtGallery	22	2010-07-12
100	214	WorldArtGallery	21	2010-07-12
101	216	sandeepabhat	21	2010-07-12
102	214	WorldArtGallery	21	2010-07-12
103	216	sandeepabhat	14	2010-07-12
104	216	sandeepabhat	14	2010-07-12
105	215	GetMeInfo	4	2010-07-12
106	215	GetMeInfo	5	2010-07-12
107	216	sandeepabhat	21	2010-07-12
108	216	sandeepabhat	21	2010-07-12
109	216	sandeepabhat	21	2010-07-12
110	216	sandeepabhat	21	2010-07-12
111	216	sandeepabhat	21	2010-07-12
112	216	sandeepabhat	21	2010-07-12
113	216	sandeepabhat	21	2010-07-12
114	214	WorldArtGallery	13	2010-07-12
115	216	sandeepabhat	21	2010-07-12
116	216	sandeepabhat	21	2010-07-12
117	216	sandeepabhat	21	2010-07-12
118	216	sandeepabhat	21	2010-07-12
119	216	sandeepabhat	21	2010-07-12
120	216	sandeepabhat	1	2010-07-12
121	216	sandeepabhat	1	2010-07-12
122	216	sandeepabhat	21	2010-07-12
123	216	sandeepabhat	1	2010-07-12
124	216	sandeepabhat	1	2010-07-12
125	216	sandeepabhat	21	2010-07-12
126	216	sandeepabhat	21	2010-07-12
127	216	sandeepabhat	21	2010-07-12
128	216	sandeepabhat	21	2010-07-12
129	216	sandeepabhat	21	2010-07-12
130	216	sandeepabhat	21	2010-07-12
131	216	sandeepabhat	21	2010-07-12
132	216	sandeepabhat	21	2010-07-12
133	216	sandeepabhat	21	2010-07-12
134	216	sandeepabhat	21	2010-07-12
135	46	prabhakarcsengg	6	2010-07-12
136	216	sandeepabhat	21	2010-07-12
137	216	sandeepabhat	21	2010-07-12
138	216	sandeepabhat	21	2010-07-12
139	216	sandeepabhat	21	2010-07-12
140	216	sandeepabhat	21	2010-07-12
141	216	sandeepabhat	21	2010-07-12
142	216	sandeepabhat	21	2010-07-12
143	216	sandeepabhat	21	2010-07-12
144	216	sandeepabhat	21	2010-07-12
145	216	sandeepabhat	21	2010-07-12
146	216	sandeepabhat	21	2010-07-12
147	216	sandeepabhat	21	2010-07-12
148	216	sandeepabhat	21	2010-07-12
149	216	sandeepabhat	21	2010-07-12
150	216	sandeepabhat	21	2010-07-12
151	216	sandeepabhat	21	2010-07-12
152	216	sandeepabhat	21	2010-07-12
153	216	sandeepabhat	21	2010-07-12
154	216	sandeepabhat	21	2010-07-12
155	216	sandeepabhat	21	2010-07-12
156	216	sandeepabhat	21	2010-07-12
157	216	sandeepabhat	21	2010-07-12
158	216	sandeepabhat	21	2010-07-12
159	216	sandeepabhat	21	2010-07-12
160	216	sandeepabhat	21	2010-07-12
161	216	sandeepabhat	1	2010-07-12
162	216	sandeepabhat	21	2010-07-12
163	216	sandeepabhat	1	2010-07-12
164	216	sandeepabhat	1	2010-07-12
165	216	sandeepabhat	21	2010-07-12
166	216	sandeepabhat	1	2010-07-12
167	216	sandeepabhat	1	2010-07-12
168	216	sandeepabhat	14	2010-07-12
169	216	sandeepabhat	1	2010-07-12
170	216	sandeepabhat	1	2010-07-12
171	216	sandeepabhat	21	2010-07-12
172	216	sandeepabhat	21	2010-07-12
173	216	sandeepabhat	21	2010-07-12
174	216	sandeepabhat	21	2010-07-12
175	216	sandeepabhat	21	2010-07-12
176	216	sandeepabhat	21	2010-07-12
177	216	sandeepabhat	21	2010-07-12
178	216	sandeepabhat	21	2010-07-12
179	216	sandeepabhat	1	2010-07-12
180	216	sandeepabhat	21	2010-07-12
181	216	sandeepabhat	1	2010-07-12
182	216	sandeepabhat	1	2010-07-12
183	216	sandeepabhat	21	2010-07-12
184	216	sandeepabhat	21	2010-07-12
185	216	sandeepabhat	21	2010-07-12
186	216	sandeepabhat	21	2010-07-12
187	216	sandeepabhat	21	2010-07-12
188	216	sandeepabhat	21	2010-07-12
189	216	sandeepabhat	21	2010-07-12
190	216	sandeepabhat	21	2010-07-12
191	216	sandeepabhat	21	2010-07-12
192	216	sandeepabhat	21	2010-07-12
193	216	sandeepabhat	21	2010-07-12
194	216	sandeepabhat	21	2010-07-12
195	216	sandeepabhat	21	2010-07-12
196	216	sandeepabhat	21	2010-07-12
197	216	sandeepabhat	21	2010-07-12
198	216	sandeepabhat	21	2010-07-12
199	216	sandeepabhat	21	2010-07-12
200	0	New User	12	2010-07-12
201	35	ammubhai	11	2010-07-12
202	216	sandeepabhat	21	2010-07-12
203	216	sandeepabhat	21	2010-07-12
204	216	sandeepabhat	21	2010-07-12
205	216	sandeepabhat	21	2010-07-12
206	38	devikang	7	2010-07-12
207	0	New User	12	2010-07-12
208	0	New User	12	2010-07-12
209	217	GetMeInfo	11	2010-07-12
210	217	GetMeInfo	13	2010-07-12
211	0	New User	12	2010-07-12
212	35	ammubhai	1	2010-07-12
213	216	sandeepabhat	21	2010-07-12
214	216	sandeepabhat	20	2010-07-12
215	216	sandeepabhat	21	2010-07-12
216	216	sandeepabhat	21	2010-07-12
217	216	sandeepabhat	21	2010-07-12
218	216	sandeepabhat	21	2010-07-12
219	216	sandeepabhat	21	2010-07-12
220	216	sandeepabhat	21	2010-07-12
221	216	sandeepabhat	21	2010-07-12
222	216	sandeepabhat	21	2010-07-12
223	216	sandeepabhat	21	2010-07-12
224	216	sandeepabhat	21	2010-07-12
225	216	sandeepabhat	8	2010-07-12
226	216	sandeepabhat	21	2010-07-12
227	216	sandeepabhat	1	2010-07-12
228	216	sandeepabhat	21	2010-07-12
229	216	sandeepabhat	21	2010-07-12
230	216	sandeepabhat	21	2010-07-12
231	216	sandeepabhat	21	2010-07-12
232	35	ammubhai	22	2010-07-12
233	35	ammubhai	16	2010-07-12
234	0	New User	12	2010-07-12
235	37	multwiple	16	2010-07-12
236	37	multwiple	16	2010-07-12
237	216	sandeepabhat	1	2010-07-12
238	216	sandeepabhat	1	2010-07-12
239	37	multwiple	16	2010-07-12
240	37	multwiple	16	2010-07-12
241	216	sandeepabhat	21	2010-07-12
242	0	New User	12	2010-07-12
243	216	sandeepabhat	21	2010-07-12
244	216	sandeepabhat	8	2010-07-12
245	216	sandeepabhat	21	2010-07-12
246	35	ammubhai	15	2010-07-12
247	35	ammubhai	15	2010-07-12
248	35	ammubhai	15	2010-07-12
249	35	ammubhai	21	2010-07-12
250	216	sandeepabhat	1	2010-07-12
251	37	multwiple	21	2010-07-12
252	37	multwiple	1	2010-07-12
253	216	sandeepabhat	6	2010-07-12
254	37	multwiple	21	2010-07-12
255	37	multwiple	21	2010-07-12
256	37	multwiple	14	2010-07-12
257	37	multwiple	8	2010-07-12
258	37	multwiple	2	2010-07-12
259	37	multwiple	14	2010-07-12
260	37	multwiple	8	2010-07-12
261	37	multwiple	21	2010-07-12
262	37	multwiple	2	2010-07-12
263	37	multwiple	21	2010-07-12
264	216	sandeepabhat	21	2010-07-12
265	37	multwiple	21	2010-07-12
266	37	multwiple	21	2010-07-12
267	37	multwiple	21	2010-07-12
268	216	sandeepabhat	21	2010-07-12
269	37	multwiple	21	2010-07-12
270	37	multwiple	1	2010-07-12
271	37	multwiple	21	2010-07-12
272	37	ammubhai	21	2010-07-12
273	37	multwiple	14	2010-07-12
274	216	sandeepabhat	21	2010-07-12
275	37	multwiple	14	2010-07-12
276	216	sandeepabhat	21	2010-07-12
277	0	New User	12	2010-07-12
278	218	multwiple_test	11	2010-07-12
279	218	multwiple_test	21	2010-07-12
280	218	multwiple_test	14	2010-07-12
281	218	multwiple_test	13	2010-07-12
282	218	multwiple_test	21	2010-07-12
283	218	multwiple_test	21	2010-07-12
284	216	sandeepabhat	21	2010-07-12
285	0	New User	12	2010-07-12
286	219	thapliyalachary	11	2010-07-12
287	216	sandeepabhat	21	2010-07-12
288	216	sandeepabhat	21	2010-07-12
\.


--
-- TOC entry 1826 (class 0 OID 16548)
-- Dependencies: 1518
-- Data for Name: user_group; Type: TABLE DATA; Schema: main; Owner: mtwiple_user
--

COPY user_group (id, group_salt, update_interval) FROM stdin;
23	228dc2724a36b9f3e5a8f357692a774b081656ab3257e7c5bc690faf12eee88	1
24	6925b1506c5178de587cad027aadc747b5875798133418887d97beb9d7d91b	1
25	360d174303ba6ab6d82f1c8775b3eb4dd3a38522720ad4a21f359f444ca79f3	5
27	efce1d638978de2ca8bba3d5aff81e66a4f186be279285658445b41128a9ec1	1
28	d2529af50e2d5d95b70e41ba0d22c434eb9e56faebe8bfc7134c49f65e	1
29	ff439c261823d22bb3399b53825e3e04669c325d5b5ba1b3dac8706f5e74	1
30	f89766de7ae5b4441ab8d1d9adbd7689d3df3c3e73c83c65b3ef874dab4b	1
32	fda4144e672f3e1edf88092bf5e6c2fca01fd9d368b55f7c629702a135452	1
33	4a38fe8631aaa5baa324cc6e507b52b85196a39ef6b4177398bc872ac95f	1
34	511e584e71dfdbab3cd3dfcf3fffa5dd195f88321c59ac74266fe548a4495	1
35	bcf1db413bed1d8b0761cadba99669d943e3ca28d33e92aa7abc8e718d272b1	1
36	9564c78b356a7c1be87db993275f28d635a74b8165fff3bffc0dcb31162f5	1
37	f840a14caaa9f2b9606ac27898136443703c94988e1138e214234a9810ddc82f	1
38	657c72a5abe375b884c446dc7f10f4fe96568717d1ef755c5fd7ac766893e44	1
39	e9e6ecbaa454ce859fa6b3d5314e254881cf73b173b696a5984e8719fb8a50	1
40	57892d99f7024c22ec7ab2ade2bcfb1138baebb504aee4f218cc3a01badb1fe	1
41	9e5a134534eb622e6d4fadbe6adde11ebe5811e370eaf6d9e752fb12a5c7f5c2	1
42	55927512f3aaf3dffdf5de3955c8f5a5b3a551610d82463c1f8f2f6bfc239c	1
43	a33d423fb26eaea57943f9ac1f8cf0b47e9515c23e01f6d4768cc45af93768c	1
44	39ebde8afbd01e56587e58b466bfa615caa704e38f8188c5d309cf02094f5fa	1
45	924765f4f2c94bfb8b5fce1b16e73e892657475b1fedb1bad7103eaa307ffc	1
26	36f85cbcc4c7c94e1ba6e83c4229b539f7d7439ac6087e61e8f38bdfb0874c	2
46	9cf7c9bff2e4db9b32f6c83b4b29b96597b0e2542a987726885b97d3316145ae	1
47	6f81b6983d645212659d1578ad886298fead2edfb72cc151dfb9dde3dabcdc	1
48	2c1cb0ab7f7fcb96546bdd9ed188cef38117ccc76e91ffc6ca0c01e0d942	1
49	bd1c35faa675443b19ccb96f62823a67cdb299b7dbd3b2aec14768395c2bcc	1
50	5a42b8e56786786bd27fef7096c5657e0e08c1113f31820a95920fbbcf24	1
51	affb6ca8eee3c55f48f45ce556e2040548f742e4dbb87165b3f8e30c5cf8610	1
52	acf2ab7ca873189f0bfc3f52f0dddae45b278923fabf53c6af75895d6926	1
53	315be8af3b4ffa5e679e84e4fde3f3ad478ac727282392e4fb83fd8b616f12c	1
54	4137f097ff3a5fee189d32a98f4637ea57709938209468321473f65af46280	1
55	3c537d2ae9ef8a4f8ae8ff57261deecfafd7bd4ff473c933d2a874547cd9	1
56	722edaf496813f611f5df8b27f549cdbdd9a5173483d6dc51491b796ae5099	1
57	46964c21467a18cf9a7b2b2c4f9c461df515f823ef88ae4301a3289e79e2a	1
58	db75f8f8dc8b254efdb132761caceb2455393c97bc6390ec2dc4d03a89917ce	1
59	4d7d4f2c5af7a96a339a9021bebe6633b5953ee411fefffde22a44d5764b51	1
60	553c2669f289f9b8075726ef725647578698128c74e4c8a717c239f7632c42	1
61	5739ee328b11ee690d0573f56f5436d4a4b524c1f1e2f6ee71d91c909a75da	1
62	129f8019fa20fa94e0db6deb78be55f5b0669301133429cca6bef501557d6	1
63	c03bafe77983a6bf83652ae98c8df34ded12e31640ae8612bb9834ab97673d	1
64	fdabaf8b2ab9d7618c6b756d35ee5c78ce1901381a8f93c6325b1eb792827b4	1
65	0f317ee8ae68cf0d9cd2354b9adc28de5b0b3a87ae47d9bcb2bb4e2ccb6	1
66	308726f1c305c73edaa2362a1ddad324e67ff52c360f4ea7889ab113f75b8	1
67	2dec74e294c999d672238ad32af9a9d1814f91324b30678062d5b7dda5ef2e	1
68	9f49cd7ded209165be9975a79d27b182f04f849768982f7e6afd7576a4796e0	1
69	cc55d56b7cab1edfa155cbf77ef87cdec279f136bb31682311ca0b986952b	1
70	bf65c3689c5ea28875882e645dc6d0f35f7efffd0ac5bb1d82183561bde5	1
71	7a853c826981e0dda925e086f5272d2a9189115e25fe777c733d13057c31e59	1
72	74ec718231774174ea7a5aa02992d6b2135dc61eedc775923eb66d5825e	1
73	2ed782354213fa29a2b86b1a038d24cdf2e8860f88f912cab828de79f73b20	1
74	dd3934681fb6568711502d5b267fb5ec64c6c755b28cecb46bb0ae5f6ecf902a	1
75	2c5da96b99c4f014d9b238e443f8d9e3b7671676333d941974168a66697cb9	1
76	5e31e0858b732075d299f415f912fae989eb8b2b34d4dd675292096e42429	1
77	1ba99f16b3f1af1d53d7fe83192fa3e09e95afb611988a2afb26c76997d5a53	1
79	3662e43b6794719b7f1cc59e593d529e55bc222f669b647e471cd11922b8c3d	1
80	c580a97e509f7b76c99d80337b3134a7dc735b71c70157b8b81cfc7bfde3fc	1
81	322b9f357e659917781769a24625491bb4cd90484e50b5c6104a2935718f8542	1
82	55dfb6a878b6e7b07e2f1f6bc1df3bfa9da3ae5f3af8b662a81cac869c4	1
83	9f3d6ac82858b6e57e53ddb538eef55eaa79e94897a6c74b4f9553fc4ad41c	1
84	fda97aefbb01c977d182d3b99e59d33b8e1324522f1a952ff9cc41808a8f	1
85	a0ceb67b81b622721bcd1268c4bdad7bee2589762bb5da6ac5556dd689e119	1
86	a96167c7c804bd5d391e8864a963fbdd2e1aa7b1f3dce703240dc33cb0da	2
87	39be52ef4c75728b19bf29ddeb9cc984d2c0c58f3718e554ee244d01442cea0	1
88	3f9dcde4fda75fdd81fdb148d40daa15711ff1a2311a135f8b793f5c946598	1
89	9819ce6368bc635f02084eb08efc57bfd57ad28181fbb5f29c15efcce	1
90	ed731f879a34fa7b0be584039f7f6fb71fbdcbb94b96655f60d66ca326f29	1
91	9910c43436984ec07460d6a0df57f16949e6a1af2b3cb9abc69f28399d3324	1
92	8f755192265ee2dfacbe20c056cbc3396ff6a94ddfbdb5fbba5dd6b5f4bbf3a5	1
94	104fe6d364cf68cfd9fdc3dded91222287a6937b334ba982049da126e7d8f	1
95	2098667bdc861247afc6e87ef3369b265d85e7f63984236e65e76cb8415c47	1
96	f13ecb558ea80f2177931edc43dcd8d3e79c4d106eb25dfde7d33c573410d5	1
97	8f8cfd9bedee4b2f73fb5a71d40a4f4da526e9e942b7c83a54add71f778092	1
98	cf4ab6bc29ca3ba17e6d7ccc94bad5925d486aff66586f847b17b57037e7	1
99	b35fc02c3249e7eb52227b5f1395f911f2c7821c06c34fba414114e605d3588	1
100	d0b343fbb45772a0b060b2f7ff4596e98f67f1ee4e4359c90c1d5812ac3c81	1
101	492d8f726d58894f1dc4234ecc9640de179db8253a3ea92d45ec7e55c5f97f9	1
102	2c91b44cd933c745b470a9be1f9be7e93a28ddf2aaf598901d8723a1453	1
93	b31f335d68847632b14fbfdc1ad70fb31a92ea885f839a97b3fbed3c1973b	5
31	d0297e875a8eea559890bbe37db6a6adf4a1236afbf75de3daa1f0abe371b7	5
103	90401b86fc2d8226e6e222ef217fdcbe5e3a1e8f36bd65305f3efe6b5542b8f0	1
104	94e3333d5b693823b66ab40dc67593b87698eca7e3dad1f3b163a4775973dc	1
105	1914bdf28a711f1a3e9a0fe5dbeadf5b16f63ba3f593da73abc94ea61eb12a	1
106	6557c8d5f4b37d76d48eb567b0d0c7de7442a2604773be5f5b61dbad05b33	1
107	5328428e7e437404bfd452b27deed5e63750f8c88c7a3ef8fcae1251af3	1
108	99ec89a7aad3436c95e3ed4d41afa644aa75f59b13ace4d50d14683e396104a	1
109	0901b325c3fd19e114f991cd0bc2cfcd1d7764d4057b1cc074edc97051d19f	1
110	1aafbb4d8822f292be9a62e4f2a6874c5f3ba1c4a93c52998ab194aa89aab6b	1
111	ef6e233849c195d182a97ff16d722bba8c4aa918b3edce1fadf24f3a95559f8	1
112	e340c1e74349a8df9e5ae1ba5997e2dbee9e0ee4d6072dcde341b759a6aa6b7	1
113	cc1590bad4f729a4dcf0a95fe61b78e8eff0276794243ab57bf2f0b6cd1c89	1
114	8e46492b99cf91f0c4cc286a5fde43d5f2f0d745e957ce15833a2218db4b	1
115	b97f3644ad6fbe43a4f28e3486aab22d5f65dec1110325399876a251c3ef4d0	1
116	8bc077bddabac92b25fc54dc4bbb97a5bd6356abda72b5ce9f4b5cb476fa461b	1
117	c5abff161ba05642311b2bd91e17022b1997be0b254f1e48b2ea16fc86c1c6	1
118	84569d98a9131d9a89532bec2c935e1175392b8309fd7e2e3b0473045a5bf6	1
119	52726f5b95ec9b7d31f4ee7963b6ce225286418768cbd1943520ac0974775	1
120	13c781847d9fe6edb66557d5ac1713bec6858e355641c0f8343cf880a2b6056	1
121	cd44e02f6eeb3d8aeb5f4e9733b12fc6b460a3cca3d49f6f3f56a77c210fc18	1
122	1070b3d236b38e53bb15a34bab811f3bf5aab6cad7bfcf7a5b3f7a39427b73c4	1
123	5315a66d7efc65783e73cd8f1d483fe8fb33e5877938adaa634f9f33bee87c	1
124	6aed3ba2f8ff261e2a5e2186d292d62e9e70b368dabcd776ce7ecf8e22c619	1
125	8055bc4d7137a531e96cc9deb410991e75e605dc8fc1e9aff52ed36ade292a	1
126	5527878c8ec51893fc4dab5eb8b2a4f21f8aa1f287abaee64e19262ad13e5	1
127	ac2ad3d4f2f439895a2dcca81b99f3ba6066b3c031fde98b1e178cd504197c2	1
128	bf6d83e797ea1767d16fed4ed76e1b1e384c4b26d1c5aba4deaadbb5b645	1
129	a778eeb2ea167891d3b22747f99fd8f6cdd4df2fad1e5e3f8326d3dc0b42f62	1
130	892c773d8b28e79ef755cdc1778bced724b801b8938c418d8f8af8da83d9f	1
131	c3b6fd3324afbd935ef5481afdac717590982e9e8b95c0b0763cb131f04dd1	1
132	c0c5789f019876f21155f88e8f1bd2c5d9ee5614ea87797bd13f7cfc2abb27	1
133	b4f19c54f2172b65dfbdf96c8e779460ea6d8e1e412e7e928d2bf8450a0707d	1
134	ce11619e540ccceb0517eb203d9f2d4c4af89145ccfe28185cad4b2aa833	1
135	c465cb26b2643f2e87bf75eb7e88fc59e7ecd622a6c39fa428c956271f3e35d	1
136	97a1d718a84373a9f1132d7cbc6c62a2834a0221e17fc6f1d63b013441489e0	1
137	c2f4e3c5d686e16f7e13e9c5cc737cb4b7a595eafc4a4883cc019e4ce849177	1
138	64208ed36a3a58ca1982eaf61cf822cdd0f35e258267c9c54d0a25eae36	1
139	a126744944835aca4148dfb325e894231dd78d23b38ba6bbe42a9efaa961eb6e	2
140	219348f1ce2e4dea1de8e8e5c782c386bbaab1fcb86361317a0b2b894bcf	5
141	fd8c21e0c32927d7d365ebe8354f63ea1f2a255e7e229c82b36340c31d7eea75	1
78	8c1c25b83f27ca92ef87c0726a8e56ae43eecf889cd3e7fcce6aa6c6a1a27d5b	5
142	83561699bec2507be82df562f5a5223f13d46b90be4f7878dacc8da926977a	1
143	8bfa101e5e44a2a8aebc316aff474ec92c65bbb642c196880f964e0c4fb4736	1
144	679e1a333e99acc1cc81fb5f2caaf75a1725b3b7c0d7a613281d3b81c72df	1
145	bc9f8df2d81d4f69cf57a3e94d48dfe98e7bd15dfaddeac2c1b083ef34b0a5ee	1
146	a159b4b45fcbfbab35bbf794ce9cb35a12e979d550465f7219f2251dccef9	1
147	fa4ea078f95ba8c90b03ad05361d320d7473bbabad159c7fabb2e3fd673552	1
148	62f1e792dce7dfab8647aa4b383df5b6d5ab4dc9d6d64cd7992f77a4fe15c3	1
149	c613d811cd42e694887272939432e5bc379768e3d3b56bf3eae2ac3e0b193f2	1
150	6c25e0242662ccad6f48fa497b1746e038c3aa643b1766fb0902a72fcbe	1
151	5bad4a7ed82d859026eb7be5db949a54592a1a8eb5dfb4c6bdf13d7df77fd	1
152	ed168892348fc3fcf21bbe7628945b569fd49cb12bf1314325a4a5186bf5a	1
153	9b60c6ffb76c10dfb48f31fc5c74ad7b66e34a3a8b974e291f4635fee4d37a2	1
154	b723aaffabcd34658a66b9e5aa1032244b34716bf157e86321875c4c9e6cbf	1
155	836f15941697ce7dce48bdd88648a333aadeefd8b459e1177a3f9e18201173	1
156	d7b3c83816fdcda82e79e8c32fb794d469db17be3c5d281c39c73c8a733dbe2	1
157	575bbd306f121691b9af883dfd70d2403e04112b7b47f2610c4e7525507e2c	1
158	4254c793ca47bf9283faac9cae434ccd467df3d242f16501998c74c98b3a8dd	1
159	28125995d5a26ef69cbc6b5fd9f9edfcc2ef6d2527c674e6c197d7336194d	1
160	e0c3801416fd3387af470c1ed67cc938349cf5da12dedb135e3ec84bf74	1
161	41c1f5fbebfb93bc84e18e539352c7d95594a8841dd2fc7bbca693994cbf17	2
162	7e6d564f45629bd77eb44ba827470a6c42f699c1a4f95080919f72a81b766	1
163	5ffb7fe2db25b169e6fa6f551551775c373340dbe5ae78e3f757adcb316fb	1
164	b44e68ba6517ed46e7bec7caa4b22232f873910af961bc3ad6121aadb255fa	1
165	def35836cb25e4eb450c083b2d26a6afc2efa2415b0a95fa47397b647b687	1
166	78555ff8a24cec9d146a79f8fb0277548639815e41c938e89b15845cf76fa0	1
167	cf86dbf00f512458d70fcfbf794e4f930e849d037c2db6827d347f313492a	1
168	8157c28f63748b8267f25370c451a3c33a659ee1bc56442efca117544dad9	1
169	b46429c8bfe2e982a40dadca6696265b4db9631371a61cd8c27a644d39597ad	1
170	3dd4ce28432e2189e6d866ce5ed0adb42420f7693d4e9e236091e92dbef9041	1
171	226a75a870bdea66987b602459c293d877a41cce4b318c751e61ff453d180db	1
172	643cac6f373b8a5c739ebc84f1a1a0239565a4c710fe58a25373294a64c23aa6	1
173	9f9a9f426ceb8088bef8b5653a1e7299d435dc9f878993dcfd4d7842e657b	1
174	f5e850ad48cb182d4c744cf1216b6ac212192fdfac4bfd0763d8c8c3f96f13	1
175	cb3ff89c2a7b92a2365c8d4832c252afdc40cd62433d63ee7f42bc465a79a49	1
176	cce7b98dec43708da6b22f64880e8fd98977e698cee5d889870f22629f667c	1
177	cdb122c2a355a0d020a964575c5e34c41c92554f7a5933e22bb4a3a44c55fb67	1
178	ed2830bdc202cc7544213de49f33393581172a7bcf0e44d68b044e221c49	1
179	87dca944f4917fa60cbd72482183bf6877b1714be29a4aed080f88ccfa78b5d	1
180	dff2f8c3543d8b1660f0faf1d8557778e8ee951bb8ed1f5f1b14175451d8d0	1
181	def4cad68a60562d8a74102e993410883afd1ba5c8e43cc6616a1a825c5faaa	1
\.


--
-- TOC entry 1827 (class 0 OID 16556)
-- Dependencies: 1520
-- Data for Name: user_tokens; Type: TABLE DATA; Schema: main; Owner: mtwiple_user
--

COPY user_tokens (id, user_id, screen_name, token, secret, rawstring, creation_date, login_date, group_id, home_id, direct_id, mention_id, image_url) FROM stdin;
39	85746938	dins_twit	85746938-0oY3BLyKL3cKfH3AHVnqMCvzyIgubdptt3KYqiDhW	isvBpp9Mi6MyDIbARRKWtWwyPzVMt4LrLkB0Ezzkco	oauth_token=85746938-0oY3BLyKL3cKfH3AHVnqMCvzyIgubdptt3KYqiDhW&oauth_token_secret=isvBpp9Mi6MyDIbARRKWtWwyPzVMt4LrLkB0Ezzkco&user_id=85746938&screen_name=dins_twit	2010-06-21	2010-06-21	28	0	0	0	http://s.twimg.com/a/1276896641/images/default_profile_4_normal.png
40	84324343	manjurh	84324343-I0qNEM7NE15J4iFqkSWa98BIa0mKQw96nAeMEIiam	u84hsfhRVIP6juHCyo8Rx0wtitwzFydlHedX0mM	oauth_token=84324343-I0qNEM7NE15J4iFqkSWa98BIa0mKQw96nAeMEIiam&oauth_token_secret=u84hsfhRVIP6juHCyo8Rx0wtitwzFydlHedX0mM&user_id=84324343&screen_name=manjurh	2010-06-19	2010-06-19	27	16517259413	0	6037631637	http://a3.twimg.com/profile_images/484528139/manj-1_normal.jpg
219	166456052	thapliyalachary	166456052-xguirw6wJmYtt9gyGKPBuzOtZpF2gTbrRbpt04BT	6HyyHtVcnTPz4srZxPwf3S686fKfQGVLQPa88mXbIA	oauth_token=166456052-xguirw6wJmYtt9gyGKPBuzOtZpF2gTbrRbpt04BT&oauth_token_secret=6HyyHtVcnTPz4srZxPwf3S686fKfQGVLQPa88mXbIA&user_id=166456052&screen_name=thapliyalachary	2010-07-14	2010-07-14	153	0	0	0	
35	19844568	ammubhai	19844568-hJsHeBrEyf7usnWQRrBQTi5mRcIuroZijRpUPZ3pf	oj43a4WyJgJALFwipDp1YWw1SKGLNw3rXd4yD1X0VRM	oauth_token=19844568-hJsHeBrEyf7usnWQRrBQTi5mRcIuroZijRpUPZ3pf&oauth_token_secret=oj43a4WyJgJALFwipDp1YWw1SKGLNw3rXd4yD1X0VRM&user_id=19844568&screen_name=ammubhai	2010-06-18	2010-06-18	23	19496286278	1352312865	19069171432	http://a3.twimg.com/profile_images/229923275/profile_normal.png
41	42674117	h_r_j	42674117-psEQw8Gd7kUFYdEWepBmDfRiC0g6u0LUj0J8SBEWA	PeydUmywOQ1zlSZe5P7Br1ZVNBbKfM4zbCeisS3FA	oauth_token=42674117-psEQw8Gd7kUFYdEWepBmDfRiC0g6u0LUj0J8SBEWA&oauth_token_secret=PeydUmywOQ1zlSZe5P7Br1ZVNBbKfM4zbCeisS3FA&user_id=42674117&screen_name=h_r_j	2010-06-21	2010-06-21	29	18096136823	0	17545289925	http://s.twimg.com/a/1276197224/images/default_profile_3_normal.png
37	104190338	multwiple	104190338-a5xOy1OCUPdeNlExuRMJHaxzJhx8slvIeCgZWDOt	d2FT2dcwUOyrITMobhBtWc9YukZ5LuJ5pEMzjWmg4i0	oauth_token=104190338-a5xOy1OCUPdeNlExuRMJHaxzJhx8slvIeCgZWDOt&oauth_token_secret=d2FT2dcwUOyrITMobhBtWc9YukZ5LuJ5pEMzjWmg4i0&user_id=104190338&screen_name=multwiple	2010-06-18	2010-06-18	23	19494660876	0	18663333460	http://a3.twimg.com/profile_images/670864215/favicon_normal.png
54	160241073	emanulo	160241073-oLCJiNA1sCM8YjxJRrgqdFo7U3aBTUsLX65oz1bj	mxSOHWnSlyqm538YY8mPmyRgt7tV4uf7zpDIw3MJc	oauth_token=160241073-oLCJiNA1sCM8YjxJRrgqdFo7U3aBTUsLX65oz1bj&oauth_token_secret=mxSOHWnSlyqm538YY8mPmyRgt7tV4uf7zpDIw3MJc&user_id=160241073&screen_name=emanulo	2010-06-27	2010-06-27	39	0	0	0	http://s.twimg.com/a/1277506381/images/default_profile_6_normal.png
36	36632186	spundhan	36632186-r0UFAG31QUO0dgD2YvrrxxQVGr8lxNWa2qmF5MsRO	7wRczwlO2StDDOBOsCOyWGdVPrQ6xo8GpMmq4XZQV0	oauth_token=36632186-r0UFAG31QUO0dgD2YvrrxxQVGr8lxNWa2qmF5MsRO&oauth_token_secret=7wRczwlO2StDDOBOsCOyWGdVPrQ6xo8GpMmq4XZQV0&user_id=36632186&screen_name=spundhan	2010-06-18	2010-06-18	23	19484335343	0	16449831658	http://a1.twimg.com/profile_images/888439810/spundhan_icon_normal.png
38	119436989	devikang	119436989-HvvviOcoNijYOzcWORtzlE8G3wAjaibVWKbilfLO	Q8N9XCE1zj7ofVnF4oWZ4upf4N0KmkPqmKWsvqWmY	oauth_token=119436989-HvvviOcoNijYOzcWORtzlE8G3wAjaibVWKbilfLO&oauth_token_secret=Q8N9XCE1zj7ofVnF4oWZ4upf4N0KmkPqmKWsvqWmY&user_id=119436989&screen_name=devikang	2010-06-18	2010-06-18	25	19575743105	0	16449647038	http://a3.twimg.com/profile_images/730068583/dev_normal.jpg
55	79835345	imandex	79835345-yrsgERrJ7J78Lc9x5rZCGSY1zHPBILk6ASLeCOQ0R	i37vvvI7dUYA8DbqCJDB3DaP5v1zUvJX8GknwD5c	oauth_token=79835345-yrsgERrJ7J78Lc9x5rZCGSY1zHPBILk6ASLeCOQ0R&oauth_token_secret=i37vvvI7dUYA8DbqCJDB3DaP5v1zUvJX8GknwD5c&user_id=79835345&screen_name=imandex	2010-06-27	2010-06-27	40	18679016082	1359724262	18137151322	http://a1.twimg.com/profile_images/951902440/littkehaji_normal.JPG
51	108715925	cyndyboliver	108715925-SV6oxNvIQ7d4rjAgafamEBJgScpAMkCJyAYBTd4q	6jj3NTMNZTu3zGgI62sOgDpPK3ZrcLFXj9kBThMrX7o	oauth_token=108715925-SV6oxNvIQ7d4rjAgafamEBJgScpAMkCJyAYBTd4q&oauth_token_secret=6jj3NTMNZTu3zGgI62sOgDpPK3ZrcLFXj9kBThMrX7o&user_id=108715925&screen_name=cyndyboliver	2010-06-26	2010-06-26	37	0	0	0	http://s.twimg.com/a/1276711174/images/default_profile_3_normal.png
48	19255222	frkshnwa	19255222-0U8v6AYYjQdjt7Xt6elgebRgNysiQ8TBXcXY2JTNo	TaNk3EBxgDnTc3iwtpX3a2UGvNF3FDnaJ8l1uQ14Y	oauth_token=19255222-0U8v6AYYjQdjt7Xt6elgebRgNysiQ8TBXcXY2JTNo&oauth_token_secret=TaNk3EBxgDnTc3iwtpX3a2UGvNF3FDnaJ8l1uQ14Y&user_id=19255222&screen_name=frkshnwa	2010-06-26	2010-06-26	34	17098720158	0	0	http://s.twimg.com/a/1277506381/images/default_profile_0_normal.png
52	156004299	waytogocarol	156004299-8MUijYFaCPfMoZRdGi2k0nvmqUkV9mUmeiY19T7t	apXLJMBFyHk3m7daZEZGP4QMbZiWuYX6T1dXxMoWI	oauth_token=156004299-8MUijYFaCPfMoZRdGi2k0nvmqUkV9mUmeiY19T7t&oauth_token_secret=apXLJMBFyHk3m7daZEZGP4QMbZiWuYX6T1dXxMoWI&user_id=156004299&screen_name=waytogocarol	2010-06-27	2010-06-27	38	0	0	0	http://s.twimg.com/a/1277506381/images/default_profile_3_normal.png
50	158057214	bdkki1USA	158057214-oUwFCzTNxgW6u96Pl9Wt1v6ODrPHdIuhNwmW5IgS	4BofQAPhofVNiWEaNGG3jfNSVGC2JYg3r0SwoCMc7VQ	oauth_token=158057214-oUwFCzTNxgW6u96Pl9Wt1v6ODrPHdIuhNwmW5IgS&oauth_token_secret=4BofQAPhofVNiWEaNGG3jfNSVGC2JYg3r0SwoCMc7VQ&user_id=158057214&screen_name=bdkki1USA	2010-06-26	2010-06-26	36	16823987481	0	0	http://s.twimg.com/a/1277506381/images/default_profile_0_normal.png
57	94259704	beedictator	94259704-Kh8nOx2j9ApQkQ4FkkVJitAVseTe64nm6L7qUu51g	qXmqnJUluXUQWoymekh20qox8APKnlAikHOLlec4	oauth_token=94259704-Kh8nOx2j9ApQkQ4FkkVJitAVseTe64nm6L7qUu51g&oauth_token_secret=qXmqnJUluXUQWoymekh20qox8APKnlAikHOLlec4&user_id=94259704&screen_name=beedictator	2010-06-28	2010-06-28	42	0	0	0	http://a1.twimg.com/profile_images/997779494/23076_1613528131_4368_n_normal.jpg
56	157864686	msseducshun	157864686-8rOSne368cC424d36owu8dVzFrmPTVl5wmlLSbkQ	49nqFP2r0qfsYO0JElXbDSBwmIo0T48H1urSjGrSCE8	oauth_token=157864686-8rOSne368cC424d36owu8dVzFrmPTVl5wmlLSbkQ&oauth_token_secret=49nqFP2r0qfsYO0JElXbDSBwmIo0T48H1urSjGrSCE8&user_id=157864686&screen_name=msseducshun	2010-06-27	2010-06-27	41	17203853480	1283924188	0	http://s.twimg.com/a/1277334364/images/default_profile_0_normal.png
220	158040727	vengi12	158040727-L6BWWv2VNzlOL5yUxc8U8Vk06MMZbNLKUkCQDuZN	Uj5hGrQhcXqaLxj0wxr9mq8iHR4Bneo0HspmVOgNoI	oauth_token=158040727-L6BWWv2VNzlOL5yUxc8U8Vk06MMZbNLKUkCQDuZN&oauth_token_secret=Uj5hGrQhcXqaLxj0wxr9mq8iHR4Bneo0HspmVOgNoI&user_id=158040727&screen_name=vengi12	2010-07-14	2010-07-14	154	0	0	0	http://s.twimg.com/a/1279056489/images/default_profile_5_normal.png
58	70622276	ditamarstev	70622276-s1aFleFQJXqBVBa6ZEyELjvkzj5mkt4qkQ18zZpM	o99d6HqIMV4hp0fsPNZEYYJpfOvdn2q5PLcfUN28	oauth_token=70622276-s1aFleFQJXqBVBa6ZEyELjvkzj5mkt4qkQ18zZpM&oauth_token_secret=o99d6HqIMV4hp0fsPNZEYYJpfOvdn2q5PLcfUN28&user_id=70622276&screen_name=ditamarstev	2010-06-28	2010-06-28	43	0	0	0	http://a1.twimg.com/profile_images/448155008/dieta_n_prend_normal.jpg
73	120393406	honey_luv76	120393406-VIYGv39WKJroCvg9z1tczP0enZTXGQDsWDWs7Z2b	oiiidNSmfBf0dKkeHNgTDWGs1LRXhEH7U5K19CGtJU	oauth_token=120393406-VIYGv39WKJroCvg9z1tczP0enZTXGQDsWDWs7Z2b&oauth_token_secret=oiiidNSmfBf0dKkeHNgTDWGs1LRXhEH7U5K19CGtJU&user_id=120393406&screen_name=honey_luv76	2010-06-30	2010-06-30	56	0	0	0	http://a3.twimg.com/profile_images/846234017/twitterProfilePhoto_normal.jpg
61	160659105	DLSPD	160659105-0AF1luxkas8sRYULiGWzMOVOPY1hFN8wmKI3l0Go	vbFpISJEs6ltlslSj6gIhRogwZMNGsbDWByzn0BR0	oauth_token=160659105-0AF1luxkas8sRYULiGWzMOVOPY1hFN8wmKI3l0Go&oauth_token_secret=vbFpISJEs6ltlslSj6gIhRogwZMNGsbDWByzn0BR0&user_id=160659105&screen_name=DLSPD	2010-06-28	2010-06-28	45	0	0	0	http://s.twimg.com/a/1277748195/images/default_profile_5_normal.png
60	39427850	Tams389	39427850-zaHz3MDwBJws5KSv0pIK3u1gO5W1aM2zLnZCeP5zz	KVnb5BZ7OvfHLgm9nMWboHA2BZzIR3tJIhSbLgaKtQ	oauth_token=39427850-zaHz3MDwBJws5KSv0pIK3u1gO5W1aM2zLnZCeP5zz&oauth_token_secret=KVnb5BZ7OvfHLgm9nMWboHA2BZzIR3tJIhSbLgaKtQ&user_id=39427850&screen_name=Tams389	2010-06-28	2010-06-28	44	0	0	0	http://a3.twimg.com/profile_images/982610993/CloTi4_normal.jpg
70	161147359	JulietaCelesia	161147359-eVoLNdyYHCoP98AnH1kLrF3mAYUOIubIYzrXm4KK	3dUoCkPw68W4oQJar9lAAnwq44m8M3v9i6UZUeSVpNA	oauth_token=161147359-eVoLNdyYHCoP98AnH1kLrF3mAYUOIubIYzrXm4KK&oauth_token_secret=3dUoCkPw68W4oQJar9lAAnwq44m8M3v9i6UZUeSVpNA&user_id=161147359&screen_name=JulietaCelesia	2010-06-30	2010-06-30	53	0	0	0	http://s.twimg.com/a/1277848219/images/default_profile_2_normal.png
63	71991974	dannyfirmansyah	71991974-KX4POuwodRtnLAbMh1iI8J94wFYAP01xTlbcMcd2A	avYhzBhlWOk2Qn6leLKRAdVAhCwCmxPnY9Dz0oGbZQQ	oauth_token=71991974-KX4POuwodRtnLAbMh1iI8J94wFYAP01xTlbcMcd2A&oauth_token_secret=avYhzBhlWOk2Qn6leLKRAdVAhCwCmxPnY9Dz0oGbZQQ&user_id=71991974&screen_name=dannyfirmansyah	2010-06-29	2010-06-29	46	0	0	0	http://a1.twimg.com/profile_images/963354388/31488_1286006681550_1571667451_30625127_7904923_n_normal.jpg
71	160932535	jasolyns	160932535-9ukmnXzvq6nYDbnCm4MN1DSrVRZNQaHK2lJVfnNA	Xqzgpi145l45i6qOFEQLySO1WAfdFKqkAfsSQPkL6Y	oauth_token=160932535-9ukmnXzvq6nYDbnCm4MN1DSrVRZNQaHK2lJVfnNA&oauth_token_secret=Xqzgpi145l45i6qOFEQLySO1WAfdFKqkAfsSQPkL6Y&user_id=160932535&screen_name=jasolyns	2010-06-30	2010-06-30	54	0	0	0	http://s.twimg.com/a/1277848219/images/default_profile_1_normal.png
68	151725994	politicalsplash	151725994-nbu10hq8t1o8WFbL2EAynIVDGtMFe29fZ4uwvepY	64a6m7bnYtpvv4aGlfU2ZIf6dowHEd34JK0TlJV0Dl4	oauth_token=151725994-nbu10hq8t1o8WFbL2EAynIVDGtMFe29fZ4uwvepY&oauth_token_secret=64a6m7bnYtpvv4aGlfU2ZIf6dowHEd34JK0TlJV0Dl4&user_id=151725994&screen_name=politicalsplash	2010-06-30	2010-06-30	51	17391688724	0	16488371999	http://a1.twimg.com/profile_images/1000204654/Screen_shot_2010-06-17_at_5.00.36_PM_normal.png
64	152777550	Monalisha84	152777550-eVoMpSo3na6WCAtBnSv5xEIVhQxiEjrkefGHVj8U	qokpCrosWsGVz3aHbNJlfDjTkq20fHxPG79msvbX0	oauth_token=152777550-eVoMpSo3na6WCAtBnSv5xEIVhQxiEjrkefGHVj8U&oauth_token_secret=qokpCrosWsGVz3aHbNJlfDjTkq20fHxPG79msvbX0&user_id=152777550&screen_name=Monalisha84	2010-06-29	2010-06-29	47	17215172913	0	0	http://a3.twimg.com/profile_images/968917771/mona_normal.png
65	59190805	biLy_doank	59190805-qjWioSIRKLbCiGL01qmdM8j0FASrbu1x4DZL0bkvM	ZCTqTZ4N8e3usPTAYmqpQw3FqhBnpevXhCSCFdPGNGA	oauth_token=59190805-qjWioSIRKLbCiGL01qmdM8j0FASrbu1x4DZL0bkvM&oauth_token_secret=ZCTqTZ4N8e3usPTAYmqpQw3FqhBnpevXhCSCFdPGNGA&user_id=59190805&screen_name=biLy_doank	2010-06-29	2010-06-29	48	0	0	0	http://a1.twimg.com/profile_images/1029145698/auk_z_normal.jpg
66	120551353	aFiEdZ_	120551353-WnKsHb1Xae07WoM91f7s50cyWRAyti2rlfazPOje	f6NojgfNVzooUkOYrzG5BygBJsE2wZLp0xGahBZAPGk	oauth_token=120551353-WnKsHb1Xae07WoM91f7s50cyWRAyti2rlfazPOje&oauth_token_secret=f6NojgfNVzooUkOYrzG5BygBJsE2wZLp0xGahBZAPGk&user_id=120551353&screen_name=aFiEdZ_	2010-06-29	2010-06-29	49	0	0	0	http://a3.twimg.com/profile_images/1026138253/21042010_003__normal.jpg
69	43961670	DJESCO1NONLY	43961670-O9gU0sOcYz6X8eMXqKcbzslMhNT4m44uj9hLCdyJm	9JNvn4CDT1QGAMzpV2WikB7wXHcgW9wNo4aN24kqE	oauth_token=43961670-O9gU0sOcYz6X8eMXqKcbzslMhNT4m44uj9hLCdyJm&oauth_token_secret=9JNvn4CDT1QGAMzpV2WikB7wXHcgW9wNo4aN24kqE&user_id=43961670&screen_name=DJESCO1NONLY	2010-06-30	2010-06-30	52	17380856864	0	0	http://s.twimg.com/a/1277848219/images/default_profile_4_normal.png
67	65834532	SiscaOlice	65834532-l0WLoN9MdwyICvRDOlYpWPB17uouNkAHE3OVuyB9w	n2HypKe5ZBSAIcnZNtLhWmtCEyY0hPDLTtRc4b8	oauth_token=65834532-l0WLoN9MdwyICvRDOlYpWPB17uouNkAHE3OVuyB9w&oauth_token_secret=n2HypKe5ZBSAIcnZNtLhWmtCEyY0hPDLTtRc4b8&user_id=65834532&screen_name=SiscaOlice	2010-06-30	2010-06-30	50	0	0	0	http://a1.twimg.com/profile_images/731385620/25865_1261072484933_1173326681_30617486_7368496_n_normal.jpg
72	123187454	jessicapatricee	123187454-hevoEcSUKrSJhBJD4sWCQV2WpEqeNzJgXLGDms28	5xK5hj3HD5pZ87P6nBXlUdAFfAGf3b25BuWZVwpgRmw	oauth_token=123187454-hevoEcSUKrSJhBJD4sWCQV2WpEqeNzJgXLGDms28&oauth_token_secret=5xK5hj3HD5pZ87P6nBXlUdAFfAGf3b25BuWZVwpgRmw&user_id=123187454&screen_name=jessicapatricee	2010-06-30	2010-06-30	55	0	0	0	http://a1.twimg.com/profile_images/949028478/DSC02283_normal.JPG
76	58006296	chonelho	58006296-bBWoVvy4ebZ97leI0DST4UYjUqPgWlqni39Xi8c	mVg9t7tgnGvLSsHK3Vb306wQN8FRT3bGqk3YeZqHW8	oauth_token=58006296-bBWoVvy4ebZ97leI0DST4UYjUqPgWlqni39Xi8c&oauth_token_secret=mVg9t7tgnGvLSsHK3Vb306wQN8FRT3bGqk3YeZqHW8&user_id=58006296&screen_name=chonelho	2010-06-30	2010-06-30	58	0	0	0	http://a1.twimg.com/profile_images/1031792866/funny_normal.png
75	161467035	oscarpapichulo	161467035-n0uV9Ek4HcdY9Wct72W9PVweV8qYYoDU8nLQNYw0	PCl8FwANZDNoydisz8T6qfpjzyhHLNjGoXSD3rFaevE	oauth_token=161467035-n0uV9Ek4HcdY9Wct72W9PVweV8qYYoDU8nLQNYw0&oauth_token_secret=PCl8FwANZDNoydisz8T6qfpjzyhHLNjGoXSD3rFaevE&user_id=161467035&screen_name=oscarpapichulo	2010-06-30	2010-06-30	57	0	0	0	http://s.twimg.com/a/1277934004/images/default_profile_2_normal.png
77	88133880	fadiahAS	88133880-SexsBTzyT2PFm0ZR8aGIztSlgrjuYFECVL3wlXYha	l7MxEaauIA38Crc7Bol6iYeElU4yH8ZckxR8ql3A4	oauth_token=88133880-SexsBTzyT2PFm0ZR8aGIztSlgrjuYFECVL3wlXYha&oauth_token_secret=l7MxEaauIA38Crc7Bol6iYeElU4yH8ZckxR8ql3A4&user_id=88133880&screen_name=fadiahAS	2010-07-01	2010-07-01	59	0	0	0	http://a3.twimg.com/profile_images/1028335773/Screenshot0017_normal.jpg
78	122085241	tawaret727	122085241-Zp7MVDXjLqYgufPiMGABke3CvYOTVS0OMJcIi4fH	o0M7f39SbmR35oDX04xs6I8B3xXsYhAZ8F9vgXuw	oauth_token=122085241-Zp7MVDXjLqYgufPiMGABke3CvYOTVS0OMJcIi4fH&oauth_token_secret=o0M7f39SbmR35oDX04xs6I8B3xXsYhAZ8F9vgXuw&user_id=122085241&screen_name=tawaret727	2010-07-01	2010-07-01	60	0	0	0	http://s.twimg.com/a/1277771427/images/default_profile_5_normal.png
79	161564722	wa_andi	161564722-5rdmZktXYzY9LGQBjbga7vI6Y3d09lMybz9Pah76	tMycnEZCfEJjJejVTRKw2tveg1M6x0VPxGaLxmikM	oauth_token=161564722-5rdmZktXYzY9LGQBjbga7vI6Y3d09lMybz9Pah76&oauth_token_secret=tMycnEZCfEJjJejVTRKw2tveg1M6x0VPxGaLxmikM&user_id=161564722&screen_name=wa_andi	2010-07-01	2010-07-01	61	17469397669	0	0	http://s.twimg.com/a/1277934004/images/default_profile_4_normal.png
93	119003823	dwi_nasution	119003823-N5dlsZrYQDjbHmlUvlmS02KRNvbDOiZix2DjA9sV	0kcUIYOj8rACNspjzFus4oH79vs6GngoQQ6Iw5xcU	oauth_token=119003823-N5dlsZrYQDjbHmlUvlmS02KRNvbDOiZix2DjA9sV&oauth_token_secret=0kcUIYOj8rACNspjzFus4oH79vs6GngoQQ6Iw5xcU&user_id=119003823&screen_name=dwi_nasution	2010-07-02	2010-07-02	70	0	0	0	http://a3.twimg.com/profile_images/1043972113/Baby_bear___normal.jpg
94	117944793	BrendaSinyal	117944793-4xQphxBs8iCeysdQMUjI4yTVirE5TRtd521tZzqW	aEzWMq2k1BQ115kVWbCOCwTw7wwBMyiLWvrJFhlExs	oauth_token=117944793-4xQphxBs8iCeysdQMUjI4yTVirE5TRtd521tZzqW&oauth_token_secret=aEzWMq2k1BQ115kVWbCOCwTw7wwBMyiLWvrJFhlExs&user_id=117944793&screen_name=BrendaSinyal	2010-07-02	2010-07-02	71	0	0	0	http://a3.twimg.com/profile_images/856942469/brnd_normal.jpg
86	4026821	kitch	4026821-MYlClSURHPlrMLqAz5CoeNVRdsR1XvGGnCC2sLLQRL	VvlamxUYVNCD00T0luAAgBq6qRDjbZKW5Jl92mfvrQ	oauth_token=4026821-MYlClSURHPlrMLqAz5CoeNVRdsR1XvGGnCC2sLLQRL&oauth_token_secret=VvlamxUYVNCD00T0luAAgBq6qRDjbZKW5Jl92mfvrQ&user_id=4026821&screen_name=kitch	2010-07-01	2010-07-01	65	17497553153	1300298358	17495648561	http://a1.twimg.com/profile_images/627340586/jakehat_normal.jpg
89	153357733	tita_BubbleguM	153357733-PU2FQT24OR3DfAZCSQ5deDMzRFM1vxpzkfDoupon	AzzXx4k10wiWKxCSF9lMxVXUP4likkLQHg1hA1pYGo	oauth_token=153357733-PU2FQT24OR3DfAZCSQ5deDMzRFM1vxpzkfDoupon&oauth_token_secret=AzzXx4k10wiWKxCSF9lMxVXUP4likkLQHg1hA1pYGo&user_id=153357733&screen_name=tita_BubbleguM	2010-07-01	2010-07-01	68	0	0	0	http://a1.twimg.com/profile_images/1033860866/Kitten_in_garden_kitten_MIL56051edit_normal.jpg
88	111562479	vhiefrd	111562479-gNia0gxWuSR9zzbNG29IgRzC07btzJIvBhIr0BtG	ANY2z5byUALiTqKCPcwniyJvVMoakXa0CQi0PUPU	oauth_token=111562479-gNia0gxWuSR9zzbNG29IgRzC07btzJIvBhIr0BtG&oauth_token_secret=ANY2z5byUALiTqKCPcwniyJvVMoakXa0CQi0PUPU&user_id=111562479&screen_name=vhiefrd	2010-07-01	2010-07-01	67	0	0	0	http://a1.twimg.com/profile_images/864491802/b_normal.jpg
221	154793218	rajeshb1350	154793218-DQKRdGnrRb3QW8NZikTOeDZpomT8lWdC9m8CS36Q	BWQiaajsw3cU7s43jPBfDVdClQubivx98Cq0TrY4gI	oauth_token=154793218-DQKRdGnrRb3QW8NZikTOeDZpomT8lWdC9m8CS36Q&oauth_token_secret=BWQiaajsw3cU7s43jPBfDVdClQubivx98Cq0TrY4gI&user_id=154793218&screen_name=rajeshb1350	2010-07-14	2010-07-14	155	0	0	0	http://s.twimg.com/a/1279056489/images/default_profile_6_normal.png
81	123823600	kharissull	123823600-svwEiu5A3V4XNYFuwEN5l5Mw8S83nhhGehcE1j6R	KWGymN0IHgMTSw3bmJ49eV51uY2mBNb7tNlWAru4Y	oauth_token=123823600-svwEiu5A3V4XNYFuwEN5l5Mw8S83nhhGehcE1j6R&oauth_token_secret=KWGymN0IHgMTSw3bmJ49eV51uY2mBNb7tNlWAru4Y&user_id=123823600&screen_name=kharissull	2010-07-01	2010-07-01	63	0	0	0	http://a1.twimg.com/profile_images/963561542/kharissa_normal.jpg
80	86721280	cecelmo	86721280-41lgHxyNYNfv4MUR2s2hHWv2s7PXseuGH7rEXNrR4	SwUCMI3BYiWfMcTD7saldl96PttZ8RqZlB1OtAvoio	oauth_token=86721280-41lgHxyNYNfv4MUR2s2hHWv2s7PXseuGH7rEXNrR4&oauth_token_secret=SwUCMI3BYiWfMcTD7saldl96PttZ8RqZlB1OtAvoio&user_id=86721280&screen_name=cecelmo	2010-07-01	2010-07-01	62	17474452796	1277315343	17473847424	http://a1.twimg.com/profile_images/1016364682/IMG_0121_normal.JPG
84	1754761	ocell	1754761-Bz2dYbMRgmKtSUBXPPfENHkhCgcnk3vcjafr5NCZI	VSjLyo766zz0xUJuwApoBWB5lT80dFNrpcYiWlDY	oauth_token=1754761-Bz2dYbMRgmKtSUBXPPfENHkhCgcnk3vcjafr5NCZI&oauth_token_secret=VSjLyo766zz0xUJuwApoBWB5lT80dFNrpcYiWlDY&user_id=1754761&screen_name=ocell	2010-07-01	2010-07-01	64	17583514527	1301778657	17579233917	
95	100222042	lindastut	100222042-oiqnikCYZ337Q8o7TRXAhbpcZ6t8rd50xI5aBJqi	H4nus0BGxR4VvIhybqKiQ98tL0BaoxlaPyrbVroN0g	oauth_token=100222042-oiqnikCYZ337Q8o7TRXAhbpcZ6t8rd50xI5aBJqi&oauth_token_secret=H4nus0BGxR4VvIhybqKiQ98tL0BaoxlaPyrbVroN0g&user_id=100222042&screen_name=lindastut	2010-07-02	2010-07-02	72	0	0	0	http://a1.twimg.com/profile_images/1038848242/35718_1406581096350_1587113958_31000945_7296457_n_normal.jpg
87	14676612	jraak	14676612-OUbpyTqehXvWXXe9G1pvZMxFmL8Yq5CYpbCQKVsMJ	9AA8oXo5VoPbOPuy6OwHfAp9geHjGWEXxxTvCkIEYzM	oauth_token=14676612-OUbpyTqehXvWXXe9G1pvZMxFmL8Yq5CYpbCQKVsMJ&oauth_token_secret=9AA8oXo5VoPbOPuy6OwHfAp9geHjGWEXxxTvCkIEYzM&user_id=14676612&screen_name=jraak	2010-07-01	2010-07-01	66	17499343840	1248945833	17495713010	http://a1.twimg.com/profile_images/534249916/Small_Profile_Pic_normal.JPG
90	161920325	drmemozek	161920325-5HQiuSa6QyCJQmaZ9foSuXyNJGFtRbhwBCkfDg7A	wGCqPImAePbYiWv5fKzgHSWsNSOlu3R1zMOlOGOqa00	oauth_token=161920325-5HQiuSa6QyCJQmaZ9foSuXyNJGFtRbhwBCkfDg7A&oauth_token_secret=wGCqPImAePbYiWv5fKzgHSWsNSOlu3R1zMOlOGOqa00&user_id=161920325&screen_name=drmemozek	2010-07-02	2010-07-02	69	0	0	0	http://s.twimg.com/a/1278021155/images/default_profile_0_normal.png
85	160606399	decreative	160606399-o4Y2nLyVDjaEEWNwwkqMyrD0xI4wUOIRNpIxWEPK	XSaYxp6vPJTjRuwjhPiyQTCCrpSpJVlfK26BAUUBNl4	oauth_token=160606399-o4Y2nLyVDjaEEWNwwkqMyrD0xI4wUOIRNpIxWEPK&oauth_token_secret=XSaYxp6vPJTjRuwjhPiyQTCCrpSpJVlfK26BAUUBNl4&user_id=160606399&screen_name=decreative	2010-07-01	2010-07-01	64	17575559212	0	17296804710	http://a3.twimg.com/profile_images/1032986949/de_logo_trans_corners_normal.png
96	156669772	sairytheblue	156669772-X4g5UrhutW5wP41gt7IEmzpn0yOx9YZGw4etXgOg	1rjB8nnA9THAlfrxOCLMPFaL0IDOS3ymst7d0pSrk	oauth_token=156669772-X4g5UrhutW5wP41gt7IEmzpn0yOx9YZGw4etXgOg&oauth_token_secret=1rjB8nnA9THAlfrxOCLMPFaL0IDOS3ymst7d0pSrk&user_id=156669772&screen_name=sairytheblue	2010-07-02	2010-07-02	73	17602644068	1298235258	0	http://a3.twimg.com/profile_images/999124103/sairy_pic_2_normal.jpg
97	162230831	ladikillasuwoop	162230831-UTGgnUwNJ9Jeci1PDHLLN3FsSRvkAe15jVHFQP5e	FXpVaCfe7pavMR8xCaWg2h5GUyGK9wXT39hesAk	oauth_token=162230831-UTGgnUwNJ9Jeci1PDHLLN3FsSRvkAe15jVHFQP5e&oauth_token_secret=FXpVaCfe7pavMR8xCaWg2h5GUyGK9wXT39hesAk&user_id=162230831&screen_name=ladikillasuwoop	2010-07-03	2010-07-03	74	17617331632	0	0	http://s.twimg.com/a/1278021155/images/default_profile_0_normal.png
98	158469372	lil_bob3	158469372-PYPIV2eAx95X1kVL4PNcMTYMUdmZr2qpQCgX3Qil	XwdHY43CN7ddJ3TEncBTvlXGL1d6bUHFeHPGRVv3g	oauth_token=158469372-PYPIV2eAx95X1kVL4PNcMTYMUdmZr2qpQCgX3Qil&oauth_token_secret=XwdHY43CN7ddJ3TEncBTvlXGL1d6bUHFeHPGRVv3g&user_id=158469372&screen_name=lil_bob3	2010-07-03	2010-07-03	75	0	0	0	http://a1.twimg.com/profile_images/1028332954/oscar_normal.jpg
99	66670906	CLNEE	66670906-1QfsimpXQxN29lwIGemOPXU80dCLXlTzikaE0qWl7	gMZTkYjvEGE3wCGrC1Hz7oz9DGp1NFDIw2eILsAxPc	oauth_token=66670906-1QfsimpXQxN29lwIGemOPXU80dCLXlTzikaE0qWl7&oauth_token_secret=gMZTkYjvEGE3wCGrC1Hz7oz9DGp1NFDIw2eILsAxPc&user_id=66670906&screen_name=CLNEE	2010-07-03	2010-07-03	76	0	0	0	http://a3.twimg.com/profile_images/1047203343/tyrfid_normal.png
110	15999232	allaboutnortel	15999232-et9OxGzNNuWsqUm634VM9fK3BzjlH4WKoWJNcMSv8	JkO8XkynSyd5V6YLifM6gALIp0RwzUuCSaB850	oauth_token=15999232-et9OxGzNNuWsqUm634VM9fK3BzjlH4WKoWJNcMSv8&oauth_token_secret=JkO8XkynSyd5V6YLifM6gALIp0RwzUuCSaB850&user_id=15999232&screen_name=allaboutnortel	2010-07-06	2010-07-06	81	18217385057	625292526	7847452126	http://a1.twimg.com/profile_images/71080042/Mark_s_New_Photo_normal.png
100	121174507	Kimberleyoffic	121174507-5vDHjXuLc0eEAWU9cnFTH5RbILQJF3dwT50msHo	jtBYgKIVh5oYh73QNyHZlGAXBhSbjVJslehjGg9mA	oauth_token=121174507-5vDHjXuLc0eEAWU9cnFTH5RbILQJF3dwT50msHo&oauth_token_secret=jtBYgKIVh5oYh73QNyHZlGAXBhSbjVJslehjGg9mA&user_id=121174507&screen_name=Kimberleyoffic	2010-07-03	2010-07-03	77	17682492217	1312358529	17681419927	http://a3.twimg.com/profile_images/1011304053/oki_normal.bmp
112	18061128	zipdadoda	18061128-mbMAWplYShG1tRWXyqtetY8Jy0Y7xX1cSS2C41OtP	IHkHAAnySnwRXjNpUz9w7REQZavGvZQgUEWeQGYW8	oauth_token=18061128-mbMAWplYShG1tRWXyqtetY8Jy0Y7xX1cSS2C41OtP&oauth_token_secret=IHkHAAnySnwRXjNpUz9w7REQZavGvZQgUEWeQGYW8&user_id=18061128&screen_name=zipdadoda	2010-07-06	2010-07-06	86	19605349666	1007491285	17948921093	http://a3.twimg.com/profile_images/67144865/me_normal.jpg
102	158288525	ggaurav_kumar	158288525-5Df8qcADeeYvkvQGDiIYeXuE51rG7gepUxal2rKv	niM2B6XcDWZDbP8m6k5RBNGTUdMf3wlw0Lb5qt0gGA	oauth_token=158288525-5Df8qcADeeYvkvQGDiIYeXuE51rG7gepUxal2rKv&oauth_token_secret=niM2B6XcDWZDbP8m6k5RBNGTUdMf3wlw0Lb5qt0gGA&user_id=158288525&screen_name=ggaurav_kumar	2010-07-04	2010-07-04	79	0	0	0	http://s.twimg.com/a/1278188204/images/default_profile_3_normal.png
103	23533418	ChaplainJohn200	23533418-VhKKzzPpmHwHpGOBTl0m2logdjDMNm1KGu4yOmJfi	p3rfPvY0VHLPoYHGsV6Rf3e7uqRPkSilR3C62Tx4zA	oauth_token=23533418-VhKKzzPpmHwHpGOBTl0m2logdjDMNm1KGu4yOmJfi&oauth_token_secret=p3rfPvY0VHLPoYHGsV6Rf3e7uqRPkSilR3C62Tx4zA&user_id=23533418&screen_name=ChaplainJohn200	2010-07-04	2010-07-04	80	17650917809	0	0	http://s.twimg.com/a/1278188204/images/default_profile_6_normal.png
119	73401275	dmatoronto	73401275-hXXeNkFYrNtiKWNnrIM7PAvDebn6hBuplhTbHx4L2	8vKkZIMcF37NZsawj9E8OKpUKjWUdB8nQ7qYvLVY	oauth_token=73401275-hXXeNkFYrNtiKWNnrIM7PAvDebn6hBuplhTbHx4L2&oauth_token_secret=8vKkZIMcF37NZsawj9E8OKpUKjWUdB8nQ7qYvLVY&user_id=73401275&screen_name=dmatoronto	2010-07-06	2010-07-06	89	18142199994	1133593511	18043245760	http://a3.twimg.com/profile_images/785077235/dmat2010tiny_normal.jpg
107	163010653	Sj_1202	163010653-kB5lF6RSU2ExcvKKj5cG8QEozAbAW3PGbwBENQzK	GLyM7tT5pJpYBnaZbBBC4V4bXRFEcYDGx52vxQevy8	oauth_token=163010653-kB5lF6RSU2ExcvKKj5cG8QEozAbAW3PGbwBENQzK&oauth_token_secret=GLyM7tT5pJpYBnaZbBBC4V4bXRFEcYDGx52vxQevy8&user_id=163010653&screen_name=Sj_1202	2010-07-05	2010-07-05	82	17649434742	0	0	http://s.twimg.com/a/1278188204/images/default_profile_1_normal.png
108	156855983	johnsonparmar	156855983-vU2dsMeYNWL8mmyc8nUUm5ByRKRzPSTobP2o6uva	7lhlv3CtxKYVRCCrczRaJnrkHytOKmTqXhxhXy20QYA	oauth_token=156855983-vU2dsMeYNWL8mmyc8nUUm5ByRKRzPSTobP2o6uva&oauth_token_secret=7lhlv3CtxKYVRCCrczRaJnrkHytOKmTqXhxhXy20QYA&user_id=156855983&screen_name=johnsonparmar	2010-07-05	2010-07-05	83	0	0	0	http://s.twimg.com/a/1276896641/images/default_profile_4_normal.png
111	124736486	webragacs	124736486-nxxjvx4TmrvKJho9eH7lW3QtW69vWzshjzjUuwkF	QVJ0e90mHIsO2xFQN2O9qaC93LEZ6b3FYVp5G3s	oauth_token=124736486-nxxjvx4TmrvKJho9eH7lW3QtW69vWzshjzjUuwkF&oauth_token_secret=QVJ0e90mHIsO2xFQN2O9qaC93LEZ6b3FYVp5G3s&user_id=124736486&screen_name=webragacs	2010-07-06	2010-07-06	85	17861816442	0	11873733448	http://a1.twimg.com/profile_images/763838418/webragacs-twitter-logo_normal.png
109	156350020	amazingbizz	156350020-Hl1MKV0yPZsunsNVgBft17cIRF8UdBuPlUfwh1vF	d67551zisjTO5UqCSYZuKk8r7lBU8YY16I2L0BzQk	oauth_token=156350020-Hl1MKV0yPZsunsNVgBft17cIRF8UdBuPlUfwh1vF&oauth_token_secret=d67551zisjTO5UqCSYZuKk8r7lBU8YY16I2L0BzQk&user_id=156350020&screen_name=amazingbizz	2010-07-05	2010-07-05	84	17780651871	1313529433	17477119191	http://a1.twimg.com/profile_images/996413496/DOG2_S__normal.JPG
104	62032555	tweettestlab	62032555-ZOo8eAGoOVOH3vtZl1BJMHke0ZPclwyRzxderSbaK	9VMdNkuEjsQheerCJQHIb0UcHxgago9GbfKT8OQrs	oauth_token=62032555-ZOo8eAGoOVOH3vtZl1BJMHke0ZPclwyRzxderSbaK&oauth_token_secret=9VMdNkuEjsQheerCJQHIb0UcHxgago9GbfKT8OQrs&user_id=62032555&screen_name=tweettestlab	2010-07-04	2010-07-04	81	18217245094	999564234	17948921093	http://s.twimg.com/a/1278188204/images/default_profile_4_normal.png
115	16616344	angelaleuschen	16616344-PG1QADsnBHRVMLLgCbucYZanSAXbT3V8M7Ym8Ikml	8RJsqJOAvlPk2sE5fzneHKYaLQVKH7cyY54TlOwXmY	oauth_token=16616344-PG1QADsnBHRVMLLgCbucYZanSAXbT3V8M7Ym8Ikml&oauth_token_secret=8RJsqJOAvlPk2sE5fzneHKYaLQVKH7cyY54TlOwXmY&user_id=16616344&screen_name=angelaleuschen	2010-07-06	2010-07-06	88	0	0	0	http://a1.twimg.com/profile_images/294788244/Angela_062409_normal.jpg
114	16257815	dartiss	16257815-L9gpRNL2TtfzgEtOpadJJvO2XNoDFgDYftC6mBbg	jgkRNO5tR6dLAb0zi6XU0XIPSv3QdfXBB7RIEiL4Row	oauth_token=16257815-L9gpRNL2TtfzgEtOpadJJvO2XNoDFgDYftC6mBbg&oauth_token_secret=jgkRNO5tR6dLAb0zi6XU0XIPSv3QdfXBB7RIEiL4Row&user_id=16257815&screen_name=dartiss	2010-07-06	2010-07-06	87	17868425800	1167358401	17776846153	http://a3.twimg.com/profile_images/691236955/twitterProfilePhoto_normal.jpg
116	88942270	Driveway_Living	88942270-pnb3j46SZcWeFgCYc6LzNl1KpsLaIBfW2h1HQWt6s	z6SBUhrGGujnJ0K2fpiavkcYAleZjACkvi1ial72M	oauth_token=88942270-pnb3j46SZcWeFgCYc6LzNl1KpsLaIBfW2h1HQWt6s&oauth_token_secret=z6SBUhrGGujnJ0K2fpiavkcYAleZjACkvi1ial72M&user_id=88942270&screen_name=Driveway_Living	2010-07-06	2010-07-06	88	0	0	0	http://a1.twimg.com/profile_images/576317574/profile-pic_normal.jpg
105	11095692	markevans	11095692-tmod2bRzNtdK0EzD1uuk5AkDYWViFCjyx6oNCcQM	UGOsr8RXy0QEIhMjOmPkOC5nSinZpXPTz1iQktjik	oauth_token=11095692-tmod2bRzNtdK0EzD1uuk5AkDYWViFCjyx6oNCcQM&oauth_token_secret=UGOsr8RXy0QEIhMjOmPkOC5nSinZpXPTz1iQktjik&user_id=11095692&screen_name=markevans	2010-07-04	2010-07-04	81	18217680929	1323919464	18194899988	http://a1.twimg.com/profile_images/566752320/ME_Consulting_Logo_normal.jpg
136	26605963	dijica	26605963-E6DkqzbSh6C3gCIxtVTiQU3gLqf3Y1sFwtZRNxU8	7CjKqcOzRJYpEajUOvC7KfrkdgQNjubEVTP7HJt0YVA	oauth_token=26605963-E6DkqzbSh6C3gCIxtVTiQU3gLqf3Y1sFwtZRNxU8&oauth_token_secret=7CjKqcOzRJYpEajUOvC7KfrkdgQNjubEVTP7HJt0YVA&user_id=26605963&screen_name=dijica	2010-07-07	2010-07-07	101	18110872584	1330859435	18073689881	http://a3.twimg.com/profile_images/951356075/Izvor_1_normal.jpg
113	87696887	EnactTimsLaw	87696887-9ZamLcscBBLo40cAYGuJgg9xeHvIAcFOKrW9t1Z3E	KNkhsfiip4xY9Vw3tBppVaevvF9tYt2YjGBV8hpBaE	oauth_token=87696887-9ZamLcscBBLo40cAYGuJgg9xeHvIAcFOKrW9t1Z3E&oauth_token_secret=KNkhsfiip4xY9Vw3tBppVaevvF9tYt2YjGBV8hpBaE&user_id=87696887&screen_name=EnactTimsLaw	2010-07-06	2010-07-06	86	18191378660	0	0	http://a1.twimg.com/profile_images/510725060/timthumb.php_normal.jpeg
144	53929368	sleydesu	53929368-DFPksBZpG9EfxcpBYNWVFGmZKdhLnfcrleMGneghb	glvDW6lZEdvU40E03CdxwgmVzdjNwtVh6jswaeCh0ds	oauth_token=53929368-DFPksBZpG9EfxcpBYNWVFGmZKdhLnfcrleMGneghb&oauth_token_secret=glvDW6lZEdvU40E03CdxwgmVzdjNwtVh6jswaeCh0ds&user_id=53929368&screen_name=sleydesu	2010-07-07	2010-07-07	107	17956444967	1319841912	17956348759	http://a1.twimg.com/profile_images/951342738/IMG_0133w_normal.jpg
118	8634872	onedegree	8634872-iQng6Cs20YYp83BvLPFE9KSOteUeKHp8AxnDXBMoMg	0JIwCzQL3taZsGaboW1fWXceIilubzu38fBad15BjA	oauth_token=8634872-iQng6Cs20YYp83BvLPFE9KSOteUeKHp8AxnDXBMoMg&oauth_token_secret=0JIwCzQL3taZsGaboW1fWXceIilubzu38fBad15BjA&user_id=8634872&screen_name=onedegree	2010-07-06	2010-07-06	89	18142199994	1333605854	18142051688	http://a1.twimg.com/profile_images/97178206/onedegree-bullseye-250x250_normal.jpg
222	157292846	jojowar0011	157292846-ULORXypZMq7TZr4dGelSmAV9yqFEZsYp7CJ9kj1Z	X9O2N79S95uj6DPLSEnBiuvNVFbzYPo6gmdRr5M8	oauth_token=157292846-ULORXypZMq7TZr4dGelSmAV9yqFEZsYp7CJ9kj1Z&oauth_token_secret=X9O2N79S95uj6DPLSEnBiuvNVFbzYPo6gmdRr5M8&user_id=157292846&screen_name=jojowar0011	2010-07-14	2010-07-14	156	16546034865	0	0	http://s.twimg.com/a/1279056489/images/default_profile_4_normal.png
122	16488147	imadnaffa	16488147-x7QvxJFTWlqYcQx4G0q4wjl3ZFi3GziJDQfPujTd9	ldI0Z2R7tLxuR31XGLf4WGL8ErzHtq0hWlfDuigNF8	oauth_token=16488147-x7QvxJFTWlqYcQx4G0q4wjl3ZFi3GziJDQfPujTd9&oauth_token_secret=ldI0Z2R7tLxuR31XGLf4WGL8ErzHtq0hWlfDuigNF8&user_id=16488147&screen_name=imadnaffa	2010-07-06	2010-07-06	91	17901718979	1322851258	17898708582	http://a1.twimg.com/profile_images/756218800/imad_blue_shirt-greenborder3_normal.jpg
121	75476281	ihateyourbook	75476281-0t3rIF738EdCL6ZmWsDQx0AwBOWkUwqUP1Biupp1v	DOfUdLZdA5TjwRO4ERmbFBnJPPC1IJ0muilnER0ow	oauth_token=75476281-0t3rIF738EdCL6ZmWsDQx0AwBOWkUwqUP1Biupp1v&oauth_token_secret=DOfUdLZdA5TjwRO4ERmbFBnJPPC1IJ0muilnER0ow&user_id=75476281&screen_name=ihateyourbook	2010-07-06	2010-07-06	90	17884681727	1121815381	16027318944	http://a3.twimg.com/profile_images/773723705/ih8yb_normal.jpg
223	164966521	swikriiti	164966521-JcQkmH6ulb6nrvJZaSufbGTHYREgx66wptAEbrBZ	zRHAQQs2myTdethNAmzetJxb62M8Di48Om2vECheOI	oauth_token=164966521-JcQkmH6ulb6nrvJZaSufbGTHYREgx66wptAEbrBZ&oauth_token_secret=zRHAQQs2myTdethNAmzetJxb62M8Di48Om2vECheOI&user_id=164966521&screen_name=swikriiti	2010-07-15	2010-07-15	157	0	0	0	http://s.twimg.com/a/1279056489/images/default_profile_6_normal.png
120	15815628	retroblique	15815628-LOwUEAy1EXdg2zJ6LCIQ5LhaYOO8954LMjpkkGX5Z	IXDtjMJ7aCnTkQzq1ZSCGvfmozYFXvdCpTplhhq4MY	oauth_token=15815628-LOwUEAy1EXdg2zJ6LCIQ5LhaYOO8954LMjpkkGX5Z&oauth_token_secret=IXDtjMJ7aCnTkQzq1ZSCGvfmozYFXvdCpTplhhq4MY&user_id=15815628&screen_name=retroblique	2010-07-06	2010-07-06	90	17884748410	1317527007	17773841365	http://a3.twimg.com/profile_images/82476937/oktember_normal.jpg
123	34154031	imad_naffa	34154031-uwa5PInEvpNtag75FuIPKIg8bPzadRuOhfmC89JrA	2OuamStQXUmmtmCseBVQ7SiTRRdUJT7ieTT8dxQ	oauth_token=34154031-uwa5PInEvpNtag75FuIPKIg8bPzadRuOhfmC89JrA&oauth_token_secret=2OuamStQXUmmtmCseBVQ7SiTRRdUJT7ieTT8dxQ&user_id=34154031&screen_name=imad_naffa	2010-07-06	2010-07-06	91	17902317685	0	17900645259	http://a3.twimg.com/profile_images/1056271637/imad_blue_shirt-greenborder3_normal.jpg
124	125947358	twifoncom	125947358-NDWiiGKO0zFvcmORmP1MLb7z5yGcqqY0nvZU1Poh	PhqhZm0E3XMxI4m1L9z4PeQ14JgAyL0zb7HYt94AlM	oauth_token=125947358-NDWiiGKO0zFvcmORmP1MLb7z5yGcqqY0nvZU1Poh&oauth_token_secret=PhqhZm0E3XMxI4m1L9z4PeQ14JgAyL0zb7HYt94AlM&user_id=125947358&screen_name=twifoncom	2010-07-07	2010-07-07	92	18421904527	1347184574	18421284406	http://a3.twimg.com/profile_images/772161463/twifonicon_normal.gif
125	61960271	websovet	61960271-MzQz8OHcCVMpzxDtLTnb4805Rz9Itir5UtvpfMXSl	NAfU7cyozgEE3AB0XX9BwjOJvYsWI6dnfIc6s5dr8M	oauth_token=61960271-MzQz8OHcCVMpzxDtLTnb4805Rz9Itir5UtvpfMXSl&oauth_token_secret=NAfU7cyozgEE3AB0XX9BwjOJvYsWI6dnfIc6s5dr8M&user_id=61960271&screen_name=websovet	2010-07-07	2010-07-07	92	18421898948	990441756	13297047220	http://a3.twimg.com/profile_images/342347379/kventorbg_normal.jpg
145	33147630	rogetter	33147630-hVN93XskgNUHqGvZcxwHmV7La1svgP07DGtoBpweG	f8rC1ETY9d1EIKR4FUMg9ZANS0ZDRWFR4QxTLH6R1c	oauth_token=33147630-hVN93XskgNUHqGvZcxwHmV7La1svgP07DGtoBpweG&oauth_token_secret=f8rC1ETY9d1EIKR4FUMg9ZANS0ZDRWFR4QxTLH6R1c&user_id=33147630&screen_name=rogetter	2010-07-07	2010-07-07	108	17951576258	1324983824	17950833049	http://a1.twimg.com/profile_images/801716112/polo_normal.jpg
147	38213350	TendAsesores	38213350-AEPE8yj8JkLeR2VsP1uSooQzHflnH8wlG2IPICUf0	DWCPtw7CsYdYiwqLlyv9ZYiLymIEmAI3QAglqZEsvXI	oauth_token=38213350-AEPE8yj8JkLeR2VsP1uSooQzHflnH8wlG2IPICUf0&oauth_token_secret=DWCPtw7CsYdYiwqLlyv9ZYiLymIEmAI3QAglqZEsvXI&user_id=38213350&screen_name=TendAsesores	2010-07-07	2010-07-07	110	17953119282	1323372696	17903883555	http://a3.twimg.com/profile_images/200446571/Tend_Logo_normal.jpg
117	10771292	mose	10771292-5FEqQuUhx6GCvwbC4asjzcj1Ef31YTYaS64Je01E	jMgFKEw8cmy1kDr4XVbWoYFkq9UBvm3rluGleaOWbwE	oauth_token=10771292-5FEqQuUhx6GCvwbC4asjzcj1Ef31YTYaS64Je01E&oauth_token_secret=jMgFKEw8cmy1kDr4XVbWoYFkq9UBvm3rluGleaOWbwE&user_id=10771292&screen_name=mose	2010-07-06	2010-07-06	89	18142208970	1333674610	18134756986	http://a1.twimg.com/profile_images/752882152/nutwitter_normal.jpg
228	98108266	moszart	98108266-c7FrIIIs39sqPj3YX0clnWAOFzCqzOJhtMUZsNaKU	XEdMJXS1tCJ2YDGDSmHppFrLih77Ci8jcD0luRsGpXA	oauth_token=98108266-c7FrIIIs39sqPj3YX0clnWAOFzCqzOJhtMUZsNaKU&oauth_token_secret=XEdMJXS1tCJ2YDGDSmHppFrLih77Ci8jcD0luRsGpXA&user_id=98108266&screen_name=moszart	2010-07-15	2010-07-15	160	18586905962	1341595595	18585392717	http://a2.twimg.com/profile_images/1078802978/twittericon1_normal.jpg
226	166903091	chakradhard7	166903091-xTJaFsgcZvDBclwwVHq7T4L1ure1mObI8Y8QB54I	vYctLw5Ep72LQaAZbTrA7HD0NyRvxpQEXiP6dCW8ek	oauth_token=166903091-xTJaFsgcZvDBclwwVHq7T4L1ure1mObI8Y8QB54I&oauth_token_secret=vYctLw5Ep72LQaAZbTrA7HD0NyRvxpQEXiP6dCW8ek&user_id=166903091&screen_name=chakradhard7	2010-07-15	2010-07-15	158	0	0	0	http://s.twimg.com/a/1279171689/images/default_profile_5_normal.png
229	14300828	wuerzblog	14300828-HYIq2FGMEpBmUZTOU5cm7IBxlA6HP4kKcMBkQmIBc	bOvTz6F6wGh03WRRh5N1O07eH2moMz6D4BGX5d3UwQc	oauth_token=14300828-HYIq2FGMEpBmUZTOU5cm7IBxlA6HP4kKcMBkQmIBc&oauth_token_secret=bOvTz6F6wGh03WRRh5N1O07eH2moMz6D4BGX5d3UwQc&user_id=14300828&screen_name=wuerzblog	2010-07-15	2010-07-15	161	18610401692	1281382859	18592411585	http://a1.twimg.com/profile_images/356842548/kilian_normal.jpg
230	159760688	rinzingsherpa23	159760688-biu172Mb979VnmALyXFwO57sbhLMnXnnua2OsTSi	PfOFadZ0t65FoEdTEuBCo9KWYGicifk7Vo9nB8Y	oauth_token=159760688-biu172Mb979VnmALyXFwO57sbhLMnXnnua2OsTSi&oauth_token_secret=PfOFadZ0t65FoEdTEuBCo9KWYGicifk7Vo9nB8Y&user_id=159760688&screen_name=rinzingsherpa23	2010-07-15	2010-07-15	162	18611786173	0	0	http://a2.twimg.com/profile_images/1025647622/musicbackground1_normal.jpg
127	44752416	SimeonDuncan	44752416-6PQE7jnSLG2Q6hJQqPvSLg4J0Ymf1dNDhnkqKsjQ	XEGjJotiYEwq3hyMU9wEoauwYXq5bAV6VT3dxwmMcPc	oauth_token=44752416-6PQE7jnSLG2Q6hJQqPvSLg4J0Ymf1dNDhnkqKsjQ&oauth_token_secret=XEGjJotiYEwq3hyMU9wEoauwYXq5bAV6VT3dxwmMcPc&user_id=44752416&screen_name=SimeonDuncan	2010-07-07	2010-07-07	94	17934583962	1321686091	17834203288	
129	162259238	mariefrost	162259238-XqV3vNVJpwyYM6DPwMITVDSBbZtxPbKThKT3r90z	Im39JPmdv4ahVz225oPxd2b37mzI6m3xnaSHFl3GgYo	oauth_token=162259238-XqV3vNVJpwyYM6DPwMITVDSBbZtxPbKThKT3r90z&oauth_token_secret=Im39JPmdv4ahVz225oPxd2b37mzI6m3xnaSHFl3GgYo&user_id=162259238&screen_name=mariefrost	2010-07-07	2010-07-07	94	17934581004	1323181422	17934449612	http://a3.twimg.com/profile_images/1046544155/Picture_9_normal.png
130	18635065	donnamct	18635065-QfyGcXQE4KZ9FB49N4JRiEtg6iNtu5K21sKLd4DMS	0IZQbwyVvakZtfLPGQvRnvPXatcYuMDHICvJYRCE	oauth_token=18635065-QfyGcXQE4KZ9FB49N4JRiEtg6iNtu5K21sKLd4DMS&oauth_token_secret=0IZQbwyVvakZtfLPGQvRnvPXatcYuMDHICvJYRCE&user_id=18635065&screen_name=donnamct	2010-07-07	2010-07-07	95	0	0	0	http://a1.twimg.com/profile_images/1056802476/dd5dacbb-eb36-4bdd-a607-5d328d2a7701_normal.png
231	167094040	francisboy12	167094040-KYmveuRu904kAF6j2VQway1DUSefndB9mzGSpWK8	WCdtbjhmZBj0GFOw3ZgEIOwF72nHgaTq4YmPhN3X3E	oauth_token=167094040-KYmveuRu904kAF6j2VQway1DUSefndB9mzGSpWK8&oauth_token_secret=WCdtbjhmZBj0GFOw3ZgEIOwF72nHgaTq4YmPhN3X3E&user_id=167094040&screen_name=francisboy12	2010-07-15	2010-07-15	163	18624317697	0	0	http://s.twimg.com/a/1279171689/images/default_profile_1_normal.png
137	28329614	coachrenk	28329614-DK1ckXsgnSnIVnn8zhhHX6A05ee0bg4Iq2IpkDo0c	Tzcggxm1r12g6fw9NWuabwdL7B4s9ZuFCMAfeV4jKw	oauth_token=28329614-DK1ckXsgnSnIVnn8zhhHX6A05ee0bg4Iq2IpkDo0c&oauth_token_secret=Tzcggxm1r12g6fw9NWuabwdL7B4s9ZuFCMAfeV4jKw&user_id=28329614&screen_name=coachrenk	2010-07-07	2010-07-07	102	18143408098	1176293497	18141170027	http://a3.twimg.com/profile_images/118614231/Shirt_File_normal.png
128	74867596	twit_conway	74867596-ne2t01iqVZQapZZ6mcf9FITwerPpQhpY5zBQBweoE	BWkrmONBWNc0aLMTqOg9YyUUloxKZ1Coe6iWomvIA	oauth_token=74867596-ne2t01iqVZQapZZ6mcf9FITwerPpQhpY5zBQBweoE&oauth_token_secret=BWkrmONBWNc0aLMTqOg9YyUUloxKZ1Coe6iWomvIA&user_id=74867596&screen_name=twit_conway	2010-07-07	2010-07-07	94	17934325145	1284576201	13053345229	http://a1.twimg.com/profile_images/561366758/ceaa684a0a0563f8a08eeedfc748e7b7_normal.jpeg
143	72815507	postmusje	72815507-wN4kcavVTiQFzprmhUbRPBXKnnKYhAxCkzcLP6gYg	x1nyicCV4yLYIgsppVgNJUGaHqfzqwDjMGcqMpL1lI	oauth_token=72815507-wN4kcavVTiQFzprmhUbRPBXKnnKYhAxCkzcLP6gYg&oauth_token_secret=x1nyicCV4yLYIgsppVgNJUGaHqfzqwDjMGcqMpL1lI&user_id=72815507&screen_name=postmusje	2010-07-07	2010-07-07	106	17951256620	1299949722	17250843460	http://a3.twimg.com/profile_images/1058368073/c45dc606-8ac1-45e5-8fcb-b69e201b691a_normal.png
148	18695206	sweetcop95	18695206-SnqWzuISCv3rdMoVMDgMhbzM0YysG9w9WS84xwf3s	3MqORTakY21A6JXaMpZSPTdJPSS5E0DzPfcL79jys	oauth_token=18695206-SnqWzuISCv3rdMoVMDgMhbzM0YysG9w9WS84xwf3s&oauth_token_secret=3MqORTakY21A6JXaMpZSPTdJPSS5E0DzPfcL79jys&user_id=18695206&screen_name=sweetcop95	2010-07-07	2010-07-07	111	19646974885	1406329331	19646394002	http://a3.twimg.com/profile_images/1055256839/123078347_normal.jpg
142	16121125	SpringfieldCVB	16121125-18mq9GfZiYvSCRaZDofgoTIFzqu9R6q7H7hfzCjVI	pYZw5iS7fV6nuMgr7OASKUfv6pwcWxBMT7gN4ByvM	oauth_token=16121125-18mq9GfZiYvSCRaZDofgoTIFzqu9R6q7H7hfzCjVI&oauth_token_secret=pYZw5iS7fV6nuMgr7OASKUfv6pwcWxBMT7gN4ByvM&user_id=16121125&screen_name=SpringfieldCVB	2010-07-07	2010-07-07	105	17951100108	1231276757	17885904326	http://a1.twimg.com/profile_images/911631544/CVB_SmartPhoneIcon512x512_normal.PNG
133	23529772	Raquel_AguilarR	23529772-lJs2wvqcoqVkOh3Y2pB03c9cv9XT0GEU2a4dI6zzQ	yGfshKHtmn6kPIzsyFItGRcVpd909xy1mDtj15bQXI	oauth_token=23529772-lJs2wvqcoqVkOh3Y2pB03c9cv9XT0GEU2a4dI6zzQ&oauth_token_secret=yGfshKHtmn6kPIzsyFItGRcVpd909xy1mDtj15bQXI&user_id=23529772&screen_name=Raquel_AguilarR	2010-07-07	2010-07-07	98	17951024060	1322612747	17904361535	http://a1.twimg.com/profile_images/955369578/rachmum_normal.jpg
132	41589335	danny6114	41589335-43PBGtIeWHI2cD1YfUYjhZBMO9dP5ZEOplM4HdE	o98bohyvzFWvOAZStfv4QWQwRRC60eDjAJDID3Sw	oauth_token=41589335-43PBGtIeWHI2cD1YfUYjhZBMO9dP5ZEOplM4HdE&oauth_token_secret=o98bohyvzFWvOAZStfv4QWQwRRC60eDjAJDID3Sw&user_id=41589335&screen_name=danny6114	2010-07-07	2010-07-07	97	17951136559	1324303579	17950177231	http://a3.twimg.com/profile_images/1050842025/IMG_0402__2__normal.jpg
138	19337814	base_cafe_bar	19337814-9VNnyfOQRRRNEkIMHpDNHjjaiA88iy8Wd3jMj7keH	ej9AQ5lrMJcVzRB3exOzDLX6ZmvnfqLl0D4R3nOrZw	oauth_token=19337814-9VNnyfOQRRRNEkIMHpDNHjjaiA88iy8Wd3jMj7keH&oauth_token_secret=ej9AQ5lrMJcVzRB3exOzDLX6ZmvnfqLl0D4R3nOrZw&user_id=19337814&screen_name=base_cafe_bar	2010-07-07	2010-07-07	103	0	0	0	http://a1.twimg.com/profile_images/1034983908/BASE_Logo_Black_normal.jpg
134	3251241	ReynaldoBrito	3251241-66tmAwt2hWiG8XKjsmoVSSyryxRPqXvQ511l9g3Mo	moCS51fGzr0EuCQUKrkp6WSkrRI1cuSawR51tR4ng	oauth_token=3251241-66tmAwt2hWiG8XKjsmoVSSyryxRPqXvQ511l9g3Mo&oauth_token_secret=moCS51fGzr0EuCQUKrkp6WSkrRI1cuSawR51tR4ng&user_id=3251241&screen_name=ReynaldoBrito	2010-07-07	2010-07-07	99	17951363327	1325208648	17951338072	http://a3.twimg.com/profile_images/1003117227/Twitter_New_normal.jpg
131	150787229	villicus	150787229-kpqoNDJXPTcq08n4PNJ8B3xWjjoQGxADn9KRFP94	tYn0b9EwaX7gmb1rWQcNRfMLPhwP2P4L4uJyjbhyHX4	oauth_token=150787229-kpqoNDJXPTcq08n4PNJ8B3xWjjoQGxADn9KRFP94&oauth_token_secret=tYn0b9EwaX7gmb1rWQcNRfMLPhwP2P4L4uJyjbhyHX4&user_id=150787229&screen_name=villicus	2010-07-07	2010-07-07	96	17954955484	1320594358	0	http://s.twimg.com/a/1278188204/images/default_profile_5_normal.png
150	9268652	djsartin	9268652-feOVvVQETdMjNAOLyIybNvGiHmQ4KVS4YEEsvbu7XJ	BK4j3bvAeKdOfP5eY7phpEWWjsiyQxbxlbeGJgbk	oauth_token=9268652-feOVvVQETdMjNAOLyIybNvGiHmQ4KVS4YEEsvbu7XJ&oauth_token_secret=BK4j3bvAeKdOfP5eY7phpEWWjsiyQxbxlbeGJgbk&user_id=9268652&screen_name=djsartin	2010-07-07	2010-07-07	112	17964675369	875327134	17917641738	http://a1.twimg.com/profile_images/664230038/dj2_normal.jpg
146	57732899	LesNews	57732899-hLNutWZJAzzgp5UCdAhUacrLz3GM7vxxRT6e4wEnA	n4whr0Ghjnr82zc9sIVHHQJRM5Qtl6OsSdKGE6vFY	oauth_token=57732899-hLNutWZJAzzgp5UCdAhUacrLz3GM7vxxRT6e4wEnA&oauth_token_secret=n4whr0Ghjnr82zc9sIVHHQJRM5Qtl6OsSdKGE6vFY&user_id=57732899&screen_name=LesNews	2010-07-07	2010-07-07	109	0	0	0	http://a3.twimg.com/profile_images/1027548695/avatar9_lesnews_normal.jpg
139	132553272	InformacijaRS	132553272-sI4oX4WXCpKgd3Q75QHTBK4x9ercgvuKyxiK3Nuv	DRT6LvbVNCXBmHQQWZusnZTJ2b7U0C9GE6aVLrIRbXM	oauth_token=132553272-sI4oX4WXCpKgd3Q75QHTBK4x9ercgvuKyxiK3Nuv&oauth_token_secret=DRT6LvbVNCXBmHQQWZusnZTJ2b7U0C9GE6aVLrIRbXM&user_id=132553272&screen_name=InformacijaRS	2010-07-07	2010-07-07	101	18110872584	1271748289	17854620458	http://a1.twimg.com/profile_images/820008342/Informacija1_normal.jpg
233	167273995	sanjeevkumarbha	167273995-XIYjhsyqyOhm0Is782dewKLlkPPkDW0jvgBEo6gb	NDwxMR8Y48ZidlDXi2jo0nkUOAy2fjuoWfzpkDuJ7o	oauth_token=167273995-XIYjhsyqyOhm0Is782dewKLlkPPkDW0jvgBEo6gb&oauth_token_secret=NDwxMR8Y48ZidlDXi2jo0nkUOAy2fjuoWfzpkDuJ7o&user_id=167273995&screen_name=sanjeevkumarbha	2010-07-16	2010-07-16	164	0	0	0	http://s.twimg.com/a/1279228556/images/default_profile_0_normal.png
152	11663532	anze_frantar	11663532-NQD588M7CGjwUB0NA9MExeRs7FlZThuzgx8S9T3Yz	EadncKDFWzVA3pxzEq4XOMpTIMXRKOd6MACa9sGLbo	oauth_token=11663532-NQD588M7CGjwUB0NA9MExeRs7FlZThuzgx8S9T3Yz&oauth_token_secret=EadncKDFWzVA3pxzEq4XOMpTIMXRKOd6MACa9sGLbo&user_id=11663532&screen_name=anze_frantar	2010-07-07	2010-07-07	114	17952355987	1300136607	17942554933	http://a1.twimg.com/profile_images/947094490/Snapshot_20100524_2_normal.jpg
149	134182593	cocomovementfan	134182593-zKXFN9CoBuCfg4vehNNWh9aCBPmKa6fqbGLLIgG1	GGLhU2Y3lo6NumNEFmeYWQiESo0RWyQWbCiImJQAM	oauth_token=134182593-zKXFN9CoBuCfg4vehNNWh9aCBPmKa6fqbGLLIgG1&oauth_token_secret=GGLhU2Y3lo6NumNEFmeYWQiESo0RWyQWbCiImJQAM&user_id=134182593&screen_name=cocomovementfan	2010-07-07	2010-07-07	111	19646786038	1373315538	18308370586	http://a3.twimg.com/profile_images/1028710793/125233237_normal.jpg
151	158758989	Thanh_Hoang	158758989-wwvl2aTfu01NYbTazJKV90kqVzxqgag9g8UXPc7Q	byfnIo4LnmLKUCfj8p9bMeb7hNcxn7Gqucb7X7O3Q	oauth_token=158758989-wwvl2aTfu01NYbTazJKV90kqVzxqgag9g8UXPc7Q&oauth_token_secret=byfnIo4LnmLKUCfj8p9bMeb7hNcxn7Gqucb7X7O3Q&user_id=158758989&screen_name=Thanh_Hoang	2010-07-07	2010-07-07	113	17952485661	0	17810349781	http://s.twimg.com/a/1278188204/images/default_profile_4_normal.png
234	167277496	pragativeer	167277496-dbC0RhSgELvGlfS74giVitoI97hC0fAgaCOoJqr7	TpeBqf9Jpx61fY7ucAcajo6axsAxCGfMYjSFuy3WpDE	oauth_token=167277496-dbC0RhSgELvGlfS74giVitoI97hC0fAgaCOoJqr7&oauth_token_secret=TpeBqf9Jpx61fY7ucAcajo6axsAxCGfMYjSFuy3WpDE&user_id=167277496&screen_name=pragativeer	2010-07-16	2010-07-16	165	0	0	0	http://s.twimg.com/a/1279228556/images/default_profile_1_normal.png
235	166964856	RonMohite	166964856-G8tTQikyc7LAnYtZdnl54VU1qzouPbof3KmbieN6	U5MIyfe65mRUfkOt7so2JAkUh3LLU2o1MENc9ApLoYk	oauth_token=166964856-G8tTQikyc7LAnYtZdnl54VU1qzouPbof3KmbieN6&oauth_token_secret=U5MIyfe65mRUfkOt7so2JAkUh3LLU2o1MENc9ApLoYk&user_id=166964856&screen_name=RonMohite	2010-07-16	2010-07-16	166	0	0	0	http://s.twimg.com/a/1279228556/images/default_profile_2_normal.png
236	167286617	vikasgrover68	167286617-DjlvCK2xjUi7yfMLkuzAIixMCSc8MXCOd2RbEu2f	hMtAWfgb7X7s9ElxJ3AlX2QbO4tBJacshFKy3UhTs	oauth_token=167286617-DjlvCK2xjUi7yfMLkuzAIixMCSc8MXCOd2RbEu2f&oauth_token_secret=hMtAWfgb7X7s9ElxJ3AlX2QbO4tBJacshFKy3UhTs&user_id=167286617&screen_name=vikasgrover68	2010-07-16	2010-07-16	167	0	0	0	http://s.twimg.com/a/1279228556/images/default_profile_1_normal.png
237	167310918	SUSHIL311085	167310918-v6z9G8D9Pg4wMkWrlW7xm7LDl9L46KcH61t5OvP0	bvqze7WSB0LfuK4d48WCJ9wNWZmlsALNg1u1ezp1XrU	oauth_token=167310918-v6z9G8D9Pg4wMkWrlW7xm7LDl9L46KcH61t5OvP0&oauth_token_secret=bvqze7WSB0LfuK4d48WCJ9wNWZmlsALNg1u1ezp1XrU&user_id=167310918&screen_name=SUSHIL311085	2010-07-16	2010-07-16	168	0	0	0	http://s.twimg.com/a/1279228556/images/default_profile_5_normal.png
135	41363894	vanfranco	41363894-4cdd77WT2iycCaWLEqiwsSRUNSl9lrLWudz8SvRdu	VxvF3EX7CJE5OztevPXw9AYFHKhCJgmwT3H8Aj1Wek	oauth_token=41363894-4cdd77WT2iycCaWLEqiwsSRUNSl9lrLWudz8SvRdu&oauth_token_secret=VxvF3EX7CJE5OztevPXw9AYFHKhCJgmwT3H8Aj1Wek&user_id=41363894&screen_name=vanfranco	2010-07-07	2010-07-07	100	17984449498	1321368508	17979021914	http://a3.twimg.com/profile_images/1016713989/885e0011-c141-496b-8180-4b140c2646c0_normal.png
141	797280	winson	797280-h1rGlxIgi6krcjvlP6jcjwRTMcjJjqO0zclO42IKc	2l8eYSJ6kg6z19xKTuh3dLTKQNGyH5stlVvQ3g9po	oauth_token=797280-h1rGlxIgi6krcjvlP6jcjwRTMcjJjqO0zclO42IKc&oauth_token_secret=2l8eYSJ6kg6z19xKTuh3dLTKQNGyH5stlVvQ3g9po&user_id=797280&screen_name=winson	2010-07-07	2010-07-07	104	17959139309	1315961246	17947841717	http://a1.twimg.com/profile_images/725151920/winson_normal.jpeg
238	167312728	kpoorv	167312728-dVtpGVq8W6YdnixrRpMmH15lqEg3jZpvEJWJsGJX	rrzc1DlkauC4nGjQwuDDbcLD7brIQHH8EA99nFI5Spc	oauth_token=167312728-dVtpGVq8W6YdnixrRpMmH15lqEg3jZpvEJWJsGJX&oauth_token_secret=rrzc1DlkauC4nGjQwuDDbcLD7brIQHH8EA99nFI5Spc&user_id=167312728&screen_name=kpoorv	2010-07-16	2010-07-16	169	18668723226	0	0	http://s.twimg.com/a/1279228556/images/default_profile_2_normal.png
155	89370161	chasqui_ecuador	89370161-OS6VtM8KtcNTLqaN4jmb6Db3bX7SycG8RzsP6fKMZ	HK5tJSTRcwTxq6f8K0fm7ITnWjL28NBliZpy1WkHFw	oauth_token=89370161-OS6VtM8KtcNTLqaN4jmb6Db3bX7SycG8RzsP6fKMZ&oauth_token_secret=HK5tJSTRcwTxq6f8K0fm7ITnWjL28NBliZpy1WkHFw&user_id=89370161&screen_name=chasqui_ecuador	2010-07-07	2010-07-07	117	17956241241	0	17626113873	http://a3.twimg.com/profile_images/967600947/LOGO_OFICIAL_peq_twitter_normal.jpg
243	19643352	martynparker	19643352-dV71Ioib5Yxo32HhFJ2VR9OiXJ0GLWIGQ2uKR7QtV	n57C8TCMtkvmGyVr3xFx4nC1UaJfwGtoXFbXwZLVxI	oauth_token=19643352-dV71Ioib5Yxo32HhFJ2VR9OiXJ0GLWIGQ2uKR7QtV&oauth_token_secret=n57C8TCMtkvmGyVr3xFx4nC1UaJfwGtoXFbXwZLVxI&user_id=19643352&screen_name=martynparker	2010-07-18	2010-07-18	173	18846784342	1357726179	18841777424	http://a3.twimg.com/profile_images/999143699/Twitter_normal.JPG
242	100668469	ofelips	100668469-IwyYpClfanCSH3v6xGs36tYhdFPjJi0puoDV6tIC	902ErulMITIN1EzpayRETzXXk14kCSzPYVSwrvqJpzk	oauth_token=100668469-IwyYpClfanCSH3v6xGs36tYhdFPjJi0puoDV6tIC&oauth_token_secret=902ErulMITIN1EzpayRETzXXk14kCSzPYVSwrvqJpzk&user_id=100668469&screen_name=ofelips	2010-07-18	2010-07-18	172	18824785116	0	18553915229	http://a3.twimg.com/profile_images/966766971/Untitled2_normal.jpg
246	5827362	vijayaguru	5827362-3ABBBc40Ex6nV6xFSxXxTNZViJTnPWRRL5LrmPELM	Q5I7AzujgUyurTi2rG2sVOX2I95m9wNuObNyp5wwdU	oauth_token=5827362-3ABBBc40Ex6nV6xFSxXxTNZViJTnPWRRL5LrmPELM&oauth_token_secret=Q5I7AzujgUyurTi2rG2sVOX2I95m9wNuObNyp5wwdU&user_id=5827362&screen_name=vijayaguru	2010-07-18	2010-07-18	175	18838143679	1157092152	18046578573	http://a2.twimg.com/profile_images/1042109414/ecyu2wwn_normal.gif
244	67592283	iamrenster	67592283-WqIqLOBgIufgmw5v4NjVCD7nF2oJCKXkr8CsrYGTV	etStg6CBbt5DW9UWeS7sBAYMt4i5XIRmPZ8omc6Q	oauth_token=67592283-WqIqLOBgIufgmw5v4NjVCD7nF2oJCKXkr8CsrYGTV&oauth_token_secret=etStg6CBbt5DW9UWeS7sBAYMt4i5XIRmPZ8omc6Q&user_id=67592283&screen_name=iamrenster	2010-07-18	2010-07-18	174	18848293521	1367452488	18838263790	http://a3.twimg.com/profile_images/638807171/rene.jpg_normal.jpg
239	45412308	MyGlobalStyle	45412308-i9MEgulQeJCuvCQmncIJ81yGvo4gi3gKNQWlo31Zg	LfpPLCVOcBR5oyZ4kAfTXIeiYv9M5vTLNVcOvcon9d8	oauth_token=45412308-i9MEgulQeJCuvCQmncIJ81yGvo4gi3gKNQWlo31Zg&oauth_token_secret=LfpPLCVOcBR5oyZ4kAfTXIeiYv9M5vTLNVcOvcon9d8&user_id=45412308&screen_name=MyGlobalStyle	2010-07-16	2010-07-16	170	18885391939	1367387276	18855241815	http://a3.twimg.com/profile_images/584568477/Logo_normal.gif
153	149641075	MikhaLGaga	149641075-vNeQiDNghbRKXG02djBKwCuAwLXI2yVii4Win234	tNIJd53ZZ9M9Oh4J26F8MLUfhmsbX8xR3FjVg5tDG0	oauth_token=149641075-vNeQiDNghbRKXG02djBKwCuAwLXI2yVii4Win234&oauth_token_secret=tNIJd53ZZ9M9Oh4J26F8MLUfhmsbX8xR3FjVg5tDG0&user_id=149641075&screen_name=MikhaLGaga	2010-07-07	2010-07-07	115	0	0	0	http://a1.twimg.com/profile_images/1058051174/_p9p9p9p_normal.jpg
159	163025593	EkoDnevnik	163025593-w8Uy8Q5lcBneYNrWghNTr19GZ7EiBShD0wAY8MBp	e3sODTAWxV4vYa8NxalUy26qpoOiAxNBAY3GC8RrlQo	oauth_token=163025593-w8Uy8Q5lcBneYNrWghNTr19GZ7EiBShD0wAY8MBp&oauth_token_secret=e3sODTAWxV4vYa8NxalUy26qpoOiAxNBAY3GC8RrlQo&user_id=163025593&screen_name=EkoDnevnik	2010-07-07	2010-07-07	118	18916224953	1351040290	17782983790	http://a1.twimg.com/profile_images/1052037042/eko1_normal.jpg
247	1756721	fernandojohann	1756721-k8JTuadxSAVvghnENH1A3tGaO6tzeOSpbp5pcPMUO8	L9gRZVETNDVnGBXrKxoWX2TfRIOqEMMQ4DElaopSrcY	oauth_token=1756721-k8JTuadxSAVvghnENH1A3tGaO6tzeOSpbp5pcPMUO8&oauth_token_secret=L9gRZVETNDVnGBXrKxoWX2TfRIOqEMMQ4DElaopSrcY&user_id=1756721&screen_name=fernandojohann	2010-07-18	2010-07-18	176	18935311478	1359197615	18933631062	http://a2.twimg.com/profile_images/1072891658/avatar2010_normal.JPG
154	143319414	SMediaButterfly	143319414-JfCNF4brhNFLcPYtQTBos5pFnc8JtIIDAe8hR1FK	LrpmV3rbaGrQQnnRC4DucNShbt2PpFeCjeujJkGx6cg	oauth_token=143319414-JfCNF4brhNFLcPYtQTBos5pFnc8JtIIDAe8hR1FK&oauth_token_secret=LrpmV3rbaGrQQnnRC4DucNShbt2PpFeCjeujJkGx6cg&user_id=143319414&screen_name=SMediaButterfly	2010-07-07	2010-07-07	116	0	0	0	
166	16532346	TweeterPan	16532346-fIG230Ac7BMowgfAWpCgEoNBZIDpzW8VNtpn47KEQ	LpczoQy9Ind8MWqUEpKArHbNKuth7I9MG0HbFxd0	oauth_token=16532346-fIG230Ac7BMowgfAWpCgEoNBZIDpzW8VNtpn47KEQ&oauth_token_secret=LpczoQy9Ind8MWqUEpKArHbNKuth7I9MG0HbFxd0&user_id=16532346&screen_name=TweeterPan	2010-07-07	2010-07-07	123	17955860176	1321474074	17948650652	http://a1.twimg.com/profile_images/1014472080/P1020936bis_normal.jpg
156	36331941	Dnevnik_si	36331941-VglREFx7HdZmh2wDPb8ZZE0C49VqtUetZU7qP4Hym	YDYnxe89zm1g0wkZdv8hhDtkaslIIiStHystvBQd8I	oauth_token=36331941-VglREFx7HdZmh2wDPb8ZZE0C49VqtUetZU7qP4Hym&oauth_token_secret=YDYnxe89zm1g0wkZdv8hhDtkaslIIiStHystvBQd8I&user_id=36331941&screen_name=Dnevnik_si	2010-07-07	2010-07-07	118	18916171369	988068156	18338100086	http://a1.twimg.com/profile_images/259957920/d_normal.jpg
171	43301263	SalesArmyKnife	43301263-E5mw7bBJMH47pvjM5HR5UbK3PzLoJA4IBk4roBOCM	Nfi8WXH0ohw0SoMWRmfxSazO1lJe9vVU1xjcV5nCfQs	oauth_token=43301263-E5mw7bBJMH47pvjM5HR5UbK3PzLoJA4IBk4roBOCM&oauth_token_secret=Nfi8WXH0ohw0SoMWRmfxSazO1lJe9vVU1xjcV5nCfQs&user_id=43301263&screen_name=SalesArmyKnife	2010-07-07	2010-07-07	126	0	0	0	http://a1.twimg.com/profile_images/317323098/SAK_Address_Vector_Logo_normal.JPG
157	40712845	carmencristina	40712845-es5m6tBsaqkSHVh6lT1wwKbksYw65gasD7UbzvmCM	4sNBg5DdfcPCcT2PYTEwzggdxNlkSv2Wx5mpqAwlH4	oauth_token=40712845-es5m6tBsaqkSHVh6lT1wwKbksYw65gasD7UbzvmCM&oauth_token_secret=4sNBg5DdfcPCcT2PYTEwzggdxNlkSv2Wx5mpqAwlH4&user_id=40712845&screen_name=carmencristina	2010-07-07	2010-07-07	117	17954492168	1324911904	2659865813	http://a1.twimg.com/profile_images/216173640/27092008_002__normal.jpg
162	163880713	jamz0369	163880713-mXA1lJ3Dx1GY6DIwIRl7mMfqbIf3wpkMsk9AZohg	hDFiK2rsKdhaQLrjmAlN6FZGJSASQgK7nKNx9rVU	oauth_token=163880713-mXA1lJ3Dx1GY6DIwIRl7mMfqbIf3wpkMsk9AZohg&oauth_token_secret=hDFiK2rsKdhaQLrjmAlN6FZGJSASQgK7nKNx9rVU&user_id=163880713&screen_name=jamz0369	2010-07-07	2010-07-07	119	17953995663	0	0	http://a3.twimg.com/profile_images/1058452665/t_0004_normal.jpg
161	124236247	J__Michelle08	124236247-ENso2nsp3hpixULLEWWylDkbP0sQYITQ02xznMW3	BzlbVRUzzpR2IDcIrsxeH7iKr1gYQN3Idl2TUUsxa8	oauth_token=124236247-ENso2nsp3hpixULLEWWylDkbP0sQYITQ02xznMW3&oauth_token_secret=BzlbVRUzzpR2IDcIrsxeH7iKr1gYQN3Idl2TUUsxa8&user_id=124236247&screen_name=J__Michelle08	2010-07-07	2010-07-07	119	17955386640	1323199584	17882395503	http://a3.twimg.com/profile_images/1040692167/TWIT_PIC_RD_MAY_5__2010_normal.jpg
165	117105325	HydroSud	117105325-bagIC5GzW4RoTwuaNtPgdVqxanimzIfVlCFYApp1	yaK7TvbTA5W6jCluoyS2a3t3ojqzSy8ZzuxmZhmIXi4	oauth_token=117105325-bagIC5GzW4RoTwuaNtPgdVqxanimzIfVlCFYApp1&oauth_token_secret=yaK7TvbTA5W6jCluoyS2a3t3ojqzSy8ZzuxmZhmIXi4&user_id=117105325&screen_name=HydroSud	2010-07-07	2010-07-07	122	17877813657	0	17482017908	http://a1.twimg.com/profile_images/717271708/logo_HSD_quadri_cartouche_60px_normal.png
168	98445221	JoelCrest	98445221-YlBogOxWrJHlmmGpG0fpaCyPjEKx4WMxQBggLXfaf	WxJ6ySvUA3icbdA5gee2N0zvTAzg6WybMRmEzvG4	oauth_token=98445221-YlBogOxWrJHlmmGpG0fpaCyPjEKx4WMxQBggLXfaf&oauth_token_secret=WxJ6ySvUA3icbdA5gee2N0zvTAzg6WybMRmEzvG4&user_id=98445221&screen_name=JoelCrest	2010-07-07	2010-07-07	123	17955856868	1322311790	17887885120	http://a3.twimg.com/profile_images/593680985/n1371739543_2536_normal.jpg
163	125334154	DelfGrosso	125334154-JFbM7e7yiRmgufgopTRlSV9jjrrNLBGRlZ06kVHK	2OO4GBpIkun8PKghpHnmKSEeDkxVGW5Xz6bzG6df52c	oauth_token=125334154-JFbM7e7yiRmgufgopTRlSV9jjrrNLBGRlZ06kVHK&oauth_token_secret=2OO4GBpIkun8PKghpHnmKSEeDkxVGW5Xz6bzG6df52c&user_id=125334154&screen_name=DelfGrosso	2010-07-07	2010-07-07	120	17955664195	1300400853	17414970700	http://a1.twimg.com/profile_images/768060100/Delf_Pola_normal.jpg
164	50967988	Yaninho50	50967988-XExnFkd8NBNbyiFanlFIOEhsng2nCNPgDQGRr0g2D	yMCYQ534aP4Zh0fndgLNotcwlU4e9NEPVoDm3rvQTzw	oauth_token=50967988-XExnFkd8NBNbyiFanlFIOEhsng2nCNPgDQGRr0g2D&oauth_token_secret=yMCYQ534aP4Zh0fndgLNotcwlU4e9NEPVoDm3rvQTzw&user_id=50967988&screen_name=Yaninho50	2010-07-07	2010-07-07	121	17955581941	1317684591	17955505860	http://a1.twimg.com/profile_images/767680412/avatar_normal.jpg
167	79601255	lgnap	79601255-L8WyXbWBNGjL0JoIAY7S3G1hpjEe3q77w6ybmHphQ	jukDhlMICJ9bOOaAFxV1tckk2eudCbCeB9Caq2cSw	oauth_token=79601255-L8WyXbWBNGjL0JoIAY7S3G1hpjEe3q77w6ybmHphQ&oauth_token_secret=jukDhlMICJ9bOOaAFxV1tckk2eudCbCeB9Caq2cSw&user_id=79601255&screen_name=lgnap	2010-07-07	2010-07-07	124	19580527263	1404967282	19580099278	http://a3.twimg.com/profile_images/959668939/bfa2c919-fe33-40f8-9de9-d3592564dedb_normal.png
160	43082401	slanaslana	43082401-XLZEqZwtXZCDws8fj0Pl7kVEenijTp7a1Ry0AJTAV	5XxXo053eSfwGoM8sldcxSGWXW8aPbbjyh3fV9Y1o	oauth_token=43082401-XLZEqZwtXZCDws8fj0Pl7kVEenijTp7a1Ry0AJTAV&oauth_token_secret=5XxXo053eSfwGoM8sldcxSGWXW8aPbbjyh3fV9Y1o&user_id=43082401&screen_name=slanaslana	2010-07-07	2010-07-07	118	18915984141	1359934269	17672148120	http://a3.twimg.com/profile_images/689073903/jaz3_normal.jpg
158	162981986	MirkoJOJ	162981986-Cqshk3gKf4Zcu7lzaJc3JZTHrXNaiIC57zDR3SSy	zJiArsUhItP8bMA9d2ZvjWytTO86GzagH5sCstxg	oauth_token=162981986-Cqshk3gKf4Zcu7lzaJc3JZTHrXNaiIC57zDR3SSy&oauth_token_secret=zJiArsUhItP8bMA9d2ZvjWytTO86GzagH5sCstxg&user_id=162981986&screen_name=MirkoJOJ	2010-07-07	2010-07-07	118	18917402886	1364922610	18669401979	http://a1.twimg.com/profile_images/1051735308/mirko_normal.jpg
170	121073630	Yannick_Henrion	121073630-5YhdDQ3J6m7OTB9us44x0E3Uqo0SUFLuPLKUg4k	zhpfV56LfJzrksUR87gk7aUYyu1XaouY1r4m0aVgIMI	oauth_token=121073630-5YhdDQ3J6m7OTB9us44x0E3Uqo0SUFLuPLKUg4k&oauth_token_secret=zhpfV56LfJzrksUR87gk7aUYyu1XaouY1r4m0aVgIMI&user_id=121073630&screen_name=Yannick_Henrion	2010-07-07	2010-07-07	125	17955796932	1257154925	17934718471	http://a3.twimg.com/profile_images/739980287/01_normal.jpg
248	37083331	Mcheloboy	37083331-doexkxFK1PFQpsUbQwbvGrR1MA3kJkzjx1s3QTXZQ	8P2iRsmmlpmpkXjeL2SeIvWpGeD7R3vHiD8EQKMUmw	oauth_token=37083331-doexkxFK1PFQpsUbQwbvGrR1MA3kJkzjx1s3QTXZQ&oauth_token_secret=8P2iRsmmlpmpkXjeL2SeIvWpGeD7R3vHiD8EQKMUmw&user_id=37083331&screen_name=Mcheloboy	2010-07-18	2010-07-18	177	0	0	0	http://a0.twimg.com/profile_images/1056692324/27358_1533240380_631_q_normal.jpg
172	23219551	MattLinseman	23219551-qyJ5lWbZm6evL44qrGxUivmpbUXIYiyxg5BFwMn2g	162FcdroSG9aQ6NJxxVMYMEpO8nK3XU0V894mMJls	oauth_token=23219551-qyJ5lWbZm6evL44qrGxUivmpbUXIYiyxg5BFwMn2g&oauth_token_secret=162FcdroSG9aQ6NJxxVMYMEpO8nK3XU0V894mMJls&user_id=23219551&screen_name=MattLinseman	2010-07-07	2010-07-07	127	17955815357	0	17279944034	http://a1.twimg.com/profile_images/667755630/21565_1287919551517_1036029484_894260_2031789_n_normal.jpg
175	156193412	BP_Info	156193412-0wFqCvZy6LF5NDxgKPQ7WZuxGj71ISKYhaxsB3sI	DtN7XonMmgFNSDF6j22TftyOEEVXjWn5OmhnFr9K0T0	oauth_token=156193412-0wFqCvZy6LF5NDxgKPQ7WZuxGj71ISKYhaxsB3sI&oauth_token_secret=DtN7XonMmgFNSDF6j22TftyOEEVXjWn5OmhnFr9K0T0&user_id=156193412&screen_name=BP_Info	2010-07-07	2010-07-07	129	17957944673	1325577080	17817132399	http://a1.twimg.com/profile_images/995076182/4641405753_aa0a7c1a9f_normal.jpg
182	51147204	SouthCougars	51147204-6RiEYaQoi2iNWtN5IGgBL2tvoBLOaPfZFOShgEBnN	Mon6DhZPRVVKMnWBs0J1cJKGN4ADC4zEE9BbM1m6Q	oauth_token=51147204-6RiEYaQoi2iNWtN5IGgBL2tvoBLOaPfZFOShgEBnN&oauth_token_secret=Mon6DhZPRVVKMnWBs0J1cJKGN4ADC4zEE9BbM1m6Q&user_id=51147204&screen_name=SouthCougars	2010-07-07	2010-07-07	102	10084686622	0	9751659319	http://a1.twimg.com/profile_images/284085704/Cougar_20Head_normal.GIF
174	29957487	Schreikrampf	29957487-5G6UvMZpuC22W8OcMyf1ytWlHKeJPvY00HgUzhUDe	HjvcjDdQ6hIpIHgkrUDgC7dhP4ZH9rJPPrv0XLk64	oauth_token=29957487-5G6UvMZpuC22W8OcMyf1ytWlHKeJPvY00HgUzhUDe&oauth_token_secret=HjvcjDdQ6hIpIHgkrUDgC7dhP4ZH9rJPPrv0XLk64&user_id=29957487&screen_name=Schreikrampf	2010-07-07	2010-07-07	129	17958059609	1324892747	17944593303	http://a1.twimg.com/profile_images/703184370/evil-smiley-face_normal.jpg
179	51594868	abu_xales	51594868-gVFFDklcGccbIVYwsGtTykyFA7o8d7HQiImjCvVE	4uzn9Fs0eRpt9hZ3Wyt4svBRUIIZAJN3UxGdRIHM	oauth_token=51594868-gVFFDklcGccbIVYwsGtTykyFA7o8d7HQiImjCvVE&oauth_token_secret=4uzn9Fs0eRpt9hZ3Wyt4svBRUIIZAJN3UxGdRIHM&user_id=51594868&screen_name=abu_xales	2010-07-07	2010-07-07	132	17961283302	1323124245	17960370022	http://a1.twimg.com/profile_images/990496840/sang_normal.jpg
176	55856459	jeffmaston	55856459-sgpG3FXBVJDDw2PSbIxvoDeY1TMz79MRxONTAqx25	oU1dBfg6j9uE8kSrvFnGNv9FLmUm5pFvMpm4ZX8xEU	oauth_token=55856459-sgpG3FXBVJDDw2PSbIxvoDeY1TMz79MRxONTAqx25&oauth_token_secret=oU1dBfg6j9uE8kSrvFnGNv9FLmUm5pFvMpm4ZX8xEU&user_id=55856459&screen_name=jeffmaston	2010-07-07	2010-07-07	130	0	0	0	http://a1.twimg.com/profile_images/845642362/Jeff_normal.jpg
173	20341187	Palestinebat	20341187-KuepHsLXnoLcjIEP9HELWKfJPzz3Q15ZVZ5OVq0zM	IpVwkugKcYixW1qUtHMG6CKkVY2U062w3IuNAeIiMvU	oauth_token=20341187-KuepHsLXnoLcjIEP9HELWKfJPzz3Q15ZVZ5OVq0zM&oauth_token_secret=IpVwkugKcYixW1qUtHMG6CKkVY2U062w3IuNAeIiMvU&user_id=20341187&screen_name=Palestinebat	2010-07-07	2010-07-07	128	17958311575	1322938542	17946989133	http://a1.twimg.com/profile_images/992522664/untitled_normal.jpg
180	60136186	RenkEnglish3	60136186-c82RCYsY3JQKkPzSptXJQ4lfkd9BPBAE34QKkF80	i3FwSXe0lmaDh3juwbo11RkRGFhD1we3uMfBdHATsLU	oauth_token=60136186-c82RCYsY3JQKkPzSptXJQ4lfkd9BPBAE34QKkF80&oauth_token_secret=i3FwSXe0lmaDh3juwbo11RkRGFhD1we3uMfBdHATsLU&user_id=60136186&screen_name=RenkEnglish3	2010-07-07	2010-07-07	102	8249274130	0	4743807687	http://a1.twimg.com/profile_images/331860872/Cougar_20Head_normal.GIF
177	37185132	Dian5	37185132-CmAX5nWSTlJYdhBhcU6nwoo3neFJ6jdkgdBQlm0Qm	86kQ95Om2UmrjWo7oMaypCsbZ1xDOeTCwZ2eeG75CE	oauth_token=37185132-CmAX5nWSTlJYdhBhcU6nwoo3neFJ6jdkgdBQlm0Qm&oauth_token_secret=86kQ95Om2UmrjWo7oMaypCsbZ1xDOeTCwZ2eeG75CE&user_id=37185132&screen_name=Dian5	2010-07-07	2010-07-07	131	0	0	0	http://a1.twimg.com/profile_images/942596038/Dian5_normal.jpg
181	61696580	RenkEnglish4	61696580-EfheVgYDTtXzM53My7yuX4HWCHq2Oy43FoOJPR4Ka	aUml73FJu0Z6QACOQosLgf5aG27iWq0FYcqgsLRmc	oauth_token=61696580-EfheVgYDTtXzM53My7yuX4HWCHq2Oy43FoOJPR4Ka&oauth_token_secret=aUml73FJu0Z6QACOQosLgf5aG27iWq0FYcqgsLRmc&user_id=61696580&screen_name=RenkEnglish4	2010-07-07	2010-07-07	102	10084686622	0	0	http://s.twimg.com/a/1278188204/images/default_profile_1_normal.png
187	82558890	MissLizEddy	82558890-qdjXkYRGkfbI406cMPWwIqTa9jaeogxMyTpou4fsh	L0qW9TJePCr9Fkbr3OOceI9bs2s4wSAOPslJJh4L1mo	oauth_token=82558890-qdjXkYRGkfbI406cMPWwIqTa9jaeogxMyTpou4fsh&oauth_token_secret=L0qW9TJePCr9Fkbr3OOceI9bs2s4wSAOPslJJh4L1mo&user_id=82558890&screen_name=MissLizEddy	2010-07-07	2010-07-07	136	0	0	0	http://a3.twimg.com/profile_images/829788443/twitterProfilePhoto_normal.jpg
185	121386367	famactive	121386367-YyeKoGA3gM6R1kDykinei91HLpYT8MWJI8N2Obd5	RT412boR8KuA1DcIpiQSrYQIfSdlkQ8DO3VeM9xs4Sk	oauth_token=121386367-YyeKoGA3gM6R1kDykinei91HLpYT8MWJI8N2Obd5&oauth_token_secret=RT412boR8KuA1DcIpiQSrYQIfSdlkQ8DO3VeM9xs4Sk&user_id=121386367&screen_name=famactive	2010-07-07	2010-07-07	134	0	0	0	http://a3.twimg.com/profile_images/767883753/AccueilFamActive_normal.jpg
188	159177795	SneakyLix	159177795-ttWaL8xoP6D6TenRkwCLvndYFr4JrTMo6vPzcx4	qFbgYWlIHkWa05tKQIrgzPNPM1jpfHNu3iVqaUZF6mo	oauth_token=159177795-ttWaL8xoP6D6TenRkwCLvndYFr4JrTMo6vPzcx4&oauth_token_secret=qFbgYWlIHkWa05tKQIrgzPNPM1jpfHNu3iVqaUZF6mo&user_id=159177795&screen_name=SneakyLix	2010-07-07	2010-07-07	136	0	0	0	http://a3.twimg.com/profile_images/1042740139/tumblr_l4up7ywyJc1qakclto1_250_normal.jpg
186	135507578	ALBdeals	135507578-cvXn1kZkxx6Fvin2RIM0vJy3YadCNq1cQGdUOX9F	0HGTQHkfjMNjqkBPYmBYYTXrcpR7xb1YoDOpdlg7cZA	oauth_token=135507578-cvXn1kZkxx6Fvin2RIM0vJy3YadCNq1cQGdUOX9F&oauth_token_secret=0HGTQHkfjMNjqkBPYmBYYTXrcpR7xb1YoDOpdlg7cZA&user_id=135507578&screen_name=ALBdeals	2010-07-07	2010-07-07	135	0	0	0	http://a3.twimg.com/profile_images/842318515/IMG_419_normal.JPG
189	82453823	sak_it_to_her	82453823-UpttCR3dHL6r3fBWRzTzQaadaWyHiHZJFnXh4wpt8	tmEp4tPa0SjkOX5r81Hhr3ubfsb00XRbfUHWtEJizo	oauth_token=82453823-UpttCR3dHL6r3fBWRzTzQaadaWyHiHZJFnXh4wpt8&oauth_token_secret=tmEp4tPa0SjkOX5r81Hhr3ubfsb00XRbfUHWtEJizo&user_id=82453823&screen_name=sak_it_to_her	2010-07-07	2010-07-07	137	0	0	0	http://a1.twimg.com/profile_images/1054337210/d67b1a96-1004-4ec5-a957-684d8c82133f_normal.png
183	1787311	stribs	1787311-1YP8Cs4sFIXQSDw6eOKda07qyqbdGNF2sqRHSFil54	zHigLI3hkUTkMvXoCgUQ0Pd0m22C8BqbMoL6v6xLA	oauth_token=1787311-1YP8Cs4sFIXQSDw6eOKda07qyqbdGNF2sqRHSFil54&oauth_token_secret=zHigLI3hkUTkMvXoCgUQ0Pd0m22C8BqbMoL6v6xLA&user_id=1787311&screen_name=stribs	2010-07-07	2010-07-07	133	17987484983	1318263924	17969162839	http://a1.twimg.com/profile_images/421393734/stribsRed_normal.jpg
192	50120725	lrferrer	50120725-htvkDZb4dyotS4HrlLu2CYepTJ7oyESP2suj1wqME	eJEP7iCyso9SW2dQDnDwipwfaB1cUnFnU0aiC5s	oauth_token=50120725-htvkDZb4dyotS4HrlLu2CYepTJ7oyESP2suj1wqME&oauth_token_secret=eJEP7iCyso9SW2dQDnDwipwfaB1cUnFnU0aiC5s&user_id=50120725&screen_name=lrferrer	2010-07-07	2010-07-07	139	17996076602	1311504024	16619963211	http://a1.twimg.com/profile_images/331378506/Luis_normal.jpg
249	21262699	122moon	21262699-y2uXxUL2UHdjPIulcIzoMd2u8H37YwjT1ICN6ssHP	yHZaSSUwCLqj6lgUiC72r0rAnm1TwOaLxeYUBnusI	oauth_token=21262699-y2uXxUL2UHdjPIulcIzoMd2u8H37YwjT1ICN6ssHP&oauth_token_secret=yHZaSSUwCLqj6lgUiC72r0rAnm1TwOaLxeYUBnusI&user_id=21262699&screen_name=122moon	2010-07-19	2010-07-19	170	18885410545	1368101537	13010694129	http://s.twimg.com/a/1277934004/images/default_profile_3_normal.png
191	7978922	webqualite	7978922-OHGC6BjDnWjhYJaI2p8p0KRUWdUFOhAIIYwLBdzwQA	UEVUOd3jDPaenvGU2Bn7cU73G3mo2mAJ6ZkWTPdKY	oauth_token=7978922-OHGC6BjDnWjhYJaI2p8p0KRUWdUFOhAIIYwLBdzwQA&oauth_token_secret=UEVUOd3jDPaenvGU2Bn7cU73G3mo2mAJ6ZkWTPdKY&user_id=7978922&screen_name=webqualite	2010-07-07	2010-07-07	138	17989034554	1324087380	17985716119	http://a1.twimg.com/profile_images/884905796/1001340274_aa0ab95ba0_o_normal.jpg
140	18122596	dalmatin	18122596-CUc3CWIhrSxrb3Vt5tCR7luub0ssOBKibsZhhHtGc	L9nvpWMo2KncNU7NR31h7IsyMoTGLfxxH9FV1IxZ0	oauth_token=18122596-CUc3CWIhrSxrb3Vt5tCR7luub0ssOBKibsZhhHtGc&oauth_token_secret=L9nvpWMo2KncNU7NR31h7IsyMoTGLfxxH9FV1IxZ0&user_id=18122596&screen_name=dalmatin	2010-07-07	2010-07-07	100	17983964493	1274372263	17946863771	http://a3.twimg.com/profile_images/521463687/twitterProfilePhoto_normal.jpg
190	62036418	sebastjanartic	62036418-QQmHJZ5a9xL4xRs7hd4pNTFVSy46ZudxHr0bPk	BEB5XiW0WurtNK5fWnqHTDQFeqb1is8wp92P5UChU	oauth_token=62036418-QQmHJZ5a9xL4xRs7hd4pNTFVSy46ZudxHr0bPk&oauth_token_secret=BEB5XiW0WurtNK5fWnqHTDQFeqb1is8wp92P5UChU&user_id=62036418&screen_name=sebastjanartic	2010-07-07	2010-07-07	100	17984305392	0	0	http://s.twimg.com/a/1278188204/images/default_profile_3_normal.png
184	157538453	CorporateHuman	157538453-g1P5eG4HcD6GZB2qoAhS3OYZxdsfgNogAjtAn1mn	a1YYoSvYH6P92FyllHLaDLkSwYQEMYgRkHwyiFKIRA	oauth_token=157538453-g1P5eG4HcD6GZB2qoAhS3OYZxdsfgNogAjtAn1mn&oauth_token_secret=a1YYoSvYH6P92FyllHLaDLkSwYQEMYgRkHwyiFKIRA&user_id=157538453&screen_name=CorporateHuman	2010-07-07	2010-07-07	133	18098556961	1300237331	16891251156	http://a3.twimg.com/profile_images/1006533111/davinci_normal.jpg
251	79049896	njhu	79049896-dhUnnkdYIk0HCyrGqBgWaA31lawNZiWCwemXB24C7	twIpp8cqU8VcWur7XS2y3GObmKYVOGXEIqypLUSS4g	oauth_token=79049896-dhUnnkdYIk0HCyrGqBgWaA31lawNZiWCwemXB24C7&oauth_token_secret=twIpp8cqU8VcWur7XS2y3GObmKYVOGXEIqypLUSS4g&user_id=79049896&screen_name=njhu	2010-07-22	2010-07-22	179	19221781874	1387943426	17310606147	http://s.twimg.com/a/1278188204/images/default_profile_2_normal.png
250	49025026	EDUBEAT	49025026-3VazPLh46zVfxGPoYy0bkaBoW9W4DXnoodFrRzCDA	2S75hSFchuYTB8LNQ2G00u7ejk7DhmzvoMhxw858	oauth_token=49025026-3VazPLh46zVfxGPoYy0bkaBoW9W4DXnoodFrRzCDA&oauth_token_secret=2S75hSFchuYTB8LNQ2G00u7ejk7DhmzvoMhxw858&user_id=49025026&screen_name=EDUBEAT	2010-07-21	2010-07-21	178	19454764645	1393947914	19451627033	http://a1.twimg.com/profile_images/1081196553/news_normal.jpg
169	136936275	lgnaperso	136936275-GB6vQU19zsLa8XfglJ1fMBaDQRvqjo0N2lIUqGsk	ESxosWzxhJtD172ZQCuQynhZUdo64Nn6kNQ00Y6XOw	oauth_token=136936275-GB6vQU19zsLa8XfglJ1fMBaDQRvqjo0N2lIUqGsk&oauth_token_secret=ESxosWzxhJtD172ZQCuQynhZUdo64Nn6kNQ00Y6XOw&user_id=136936275&screen_name=lgnaperso	2010-07-07	2010-07-07	124	19574035154	1170705566	18449582938	http://a1.twimg.com/profile_images/850304426/Je_t_aime_ma_puce._C_est_pour_toi_ce_compte_____avec_couleurs_modif__normal.png
252	44556942	sumukh_rooney	44556942-RJfnMBKeUSFabX08vRUUuLphWQpwbu3rjVeJUciqX	GHCG4pX97VESs0ZwdLV3YtzQeHJ9Z4Y32OVgNPtfo	oauth_token=44556942-RJfnMBKeUSFabX08vRUUuLphWQpwbu3rjVeJUciqX&oauth_token_secret=GHCG4pX97VESs0ZwdLV3YtzQeHJ9Z4Y32OVgNPtfo&user_id=44556942&screen_name=sumukh_rooney	2010-07-24	2010-07-24	180	19410268627	0	19410153963	http://a3.twimg.com/profile_images/524153407/5248055_normal.jpg
196	6600442	stlef	6600442-mo5yvmDixoE4wb90unWGl8ubuxjo8kcU72xzF1VPg	D62Ft8Css86bqVEA6Ibq2D8KQiEBJWnZj5yqK0BYE	oauth_token=6600442-mo5yvmDixoE4wb90unWGl8ubuxjo8kcU72xzF1VPg&oauth_token_secret=D62Ft8Css86bqVEA6Ibq2D8KQiEBJWnZj5yqK0BYE&user_id=6600442&screen_name=stlef	2010-07-08	2010-07-08	141	19022957658	1229868458	17622582637	http://a3.twimg.com/profile_images/894780027/CIMG0016__2__normal.jpg
204	161767886	Ovaziya	161767886-dV6b2zfadJ3HpvuVvVnw8vmA5VHeAM4rlnSwrhzA	DsouIn3lcPb8WwMw32aERUOwFw4CTqBGP2yUOwrZEvw	oauth_token=161767886-dV6b2zfadJ3HpvuVvVnw8vmA5VHeAM4rlnSwrhzA&oauth_token_secret=DsouIn3lcPb8WwMw32aERUOwFw4CTqBGP2yUOwrZEvw&user_id=161767886&screen_name=Ovaziya	2010-07-08	2010-07-08	143	17980500626	0	0	http://a1.twimg.com/profile_images/1061001856/___________________normal.jpg
194	110000300	TopFact	110000300-1hBAK2sSIso4dYMRQmQZzi1sHvzs3LHwnRimLNo8	zUzwLM1mM7n2SRn2UslN7KzECmFLyoGuh9r0q24MO2c	oauth_token=110000300-1hBAK2sSIso4dYMRQmQZzi1sHvzs3LHwnRimLNo8&oauth_token_secret=zUzwLM1mM7n2SRn2UslN7KzECmFLyoGuh9r0q24MO2c&user_id=110000300&screen_name=TopFact	2010-07-08	2010-07-08	140	18004272858	0	0	http://a1.twimg.com/profile_images/666203636/Me_in_D.C._2003_not-bad_normal.jpg
193	15274836	DrJeffersnBoggs	15274836-XUSN3z4qjBYzdtTbR2ieVinbNtzZJ4Z7dg13qMP9p	HJ2NpC6AoCShZ4nuCZA6gNyI40euO5Nr5mIs2Xt4Zc	oauth_token=15274836-XUSN3z4qjBYzdtTbR2ieVinbNtzZJ4Z7dg13qMP9p&oauth_token_secret=HJ2NpC6AoCShZ4nuCZA6gNyI40euO5Nr5mIs2Xt4Zc&user_id=15274836&screen_name=DrJeffersnBoggs	2010-07-08	2010-07-08	140	18004666735	1327740089	18003443854	http://a1.twimg.com/profile_images/605221822/My_Photo_normal.jpg
202	15944463	SebastiaanPeter	15944463-fmqSukG9PsCSpUpPyl4gZnQ30EPjATVpgf47IS3lU	uKBRjIlEFCQSlAWN0MLADENyLByMjg6EPpN3eSg	oauth_token=15944463-fmqSukG9PsCSpUpPyl4gZnQ30EPjATVpgf47IS3lU&oauth_token_secret=uKBRjIlEFCQSlAWN0MLADENyLByMjg6EPpN3eSg&user_id=15944463&screen_name=SebastiaanPeter	2010-07-08	2010-07-08	145	18018506877	1307233443	17977571081	http://a3.twimg.com/profile_images/711649123/lubbe_DW_Wirtschaft_478740g_normal.jpg
195	29550498	FamilyOfLove	29550498-r6KeITbNnFn9QcFGjDamfE4a6O1AuxgNACTw2XF6v	A9xznJbT8VUVnGx0TUkffwQIfIQsWyDJYIaeZmjj4	oauth_token=29550498-r6KeITbNnFn9QcFGjDamfE4a6O1AuxgNACTw2XF6v&oauth_token_secret=A9xznJbT8VUVnGx0TUkffwQIfIQsWyDJYIaeZmjj4&user_id=29550498&screen_name=FamilyOfLove	2010-07-08	2010-07-08	140	18010710520	1310497768	18004942961	http://a1.twimg.com/profile_images/139790548/Best.THUMB.g4_normal.jpg
207	164344510	Cougarscoach	164344510-7rdwWB9r2WJNZDxISFUMqDvItIBSwMwSWrEY6k8A	JBQ9caYKxHTKfhClrvqEIG5Vlsl3ZVa78uaSLhPfQ	oauth_token=164344510-7rdwWB9r2WJNZDxISFUMqDvItIBSwMwSWrEY6k8A&oauth_token_secret=JBQ9caYKxHTKfhClrvqEIG5Vlsl3ZVa78uaSLhPfQ&user_id=164344510&screen_name=Cougarscoach	2010-07-08	2010-07-08	102	18138987490	0	0	http://s.twimg.com/a/1278529908/images/default_profile_1_normal.png
205	9673282	VinayakKamat	9673282-sYLdB7WAo2fcMFFqHqsi7UFBdDR7BFggXYskIcr1Q	F6x8aa7IFqlxAJG3fuoVwBdaK23LJi1vscWqtxUvM	oauth_token=9673282-sYLdB7WAo2fcMFFqHqsi7UFBdDR7BFggXYskIcr1Q&oauth_token_secret=F6x8aa7IFqlxAJG3fuoVwBdaK23LJi1vscWqtxUvM&user_id=9673282&screen_name=VinayakKamat	2010-07-08	2010-07-08	146	18038438899	1328400409	18036360300	http://a1.twimg.com/profile_images/780343242/vin_avatar_blue_cartoon_closeup_normal.png
199	104594002	xlopok	104594002-RkRMBcGqxVVPEOWsQhpCDqCTog7zJ3jvw6LNeLRv	8W7WqG94whiRbeKqIVRaArVal1XZvzI7vaa55vkPEY	oauth_token=104594002-RkRMBcGqxVVPEOWsQhpCDqCTog7zJ3jvw6LNeLRv&oauth_token_secret=8W7WqG94whiRbeKqIVRaArVal1XZvzI7vaa55vkPEY&user_id=104594002&screen_name=xlopok	2010-07-08	2010-07-08	143	18028025874	1305445771	17931122674	http://a3.twimg.com/profile_images/701084277/________-1_normal.jpg
198	17505915	abhikulk777	17505915-KbTAVkShVgFO1MI0RXaUGwOlJx67P3gDJIwqBomZo	W2DuyBPxTXI2k1GY9ayEntlphn5ViwgNV30RWgxQqeA	oauth_token=17505915-KbTAVkShVgFO1MI0RXaUGwOlJx67P3gDJIwqBomZo&oauth_token_secret=W2DuyBPxTXI2k1GY9ayEntlphn5ViwgNV30RWgxQqeA&user_id=17505915&screen_name=abhikulk777	2010-07-08	2010-07-08	142	18016100421	1328401353	17962362061	http://a3.twimg.com/profile_images/600005963/My_Profile_pic_-_Abhijeet_normal.JPG
200	114218596	chrisvigneron	114218596-u8Y9Qd21TTo3gjarQqhyXK16rzAhqukSefXJ3GuT	RMIjlUAbxpdfCuJ24dOaFJpPQ1mw5nnVUnYKHsq8o0	oauth_token=114218596-u8Y9Qd21TTo3gjarQqhyXK16rzAhqukSefXJ3GuT&oauth_token_secret=RMIjlUAbxpdfCuJ24dOaFJpPQ1mw5nnVUnYKHsq8o0&user_id=114218596&screen_name=chrisvigneron	2010-07-08	2010-07-08	144	0	0	0	http://a3.twimg.com/profile_images/735722733/DSCF6165_normal.JPG
253	16592421	Jeffnfun631	16592421-mbYbDQJ9BFzDVLqnuZ3mJm0SjeNGIe459uwSQkg0	s81slBa39Y996yfKcq0B1KEExGb4ZNkD6caE2fcEz48	oauth_token=16592421-mbYbDQJ9BFzDVLqnuZ3mJm0SjeNGIe459uwSQkg0&oauth_token_secret=s81slBa39Y996yfKcq0B1KEExGb4ZNkD6caE2fcEz48&user_id=16592421&screen_name=Jeffnfun631	2010-07-27	2010-07-27	181	19622154214	1404869848	19602455993	http://a1.twimg.com/profile_images/820670701/12157_1286703569793_1296271781_861299_4546429_n_normal.jpg
209	146313065	SagarHugar	146313065-AvgEwKZsxI5e2CbitTFn1hIyqE4J6zVUOYhWpysE	D9qBwVYuynsJ134Jvbvcx4Fjswnd6uy51iTwD3dIuY	oauth_token=146313065-AvgEwKZsxI5e2CbitTFn1hIyqE4J6zVUOYhWpysE&oauth_token_secret=D9qBwVYuynsJ134Jvbvcx4Fjswnd6uy51iTwD3dIuY&user_id=146313065&screen_name=SagarHugar	2010-07-10	2010-07-10	148	19596413982	0	19558132830	http://s.twimg.com/a/1278630136/images/default_profile_3_normal.png
206	16112760	coachandrews	16112760-vRVMHp7MmTBQPmL80rsOLhoSULSAwkVbvAWreXbZ9	Tnak4VFAuT7ePpgAF6nbKZiXqlFANlsf9HkRdHDLg	oauth_token=16112760-vRVMHp7MmTBQPmL80rsOLhoSULSAwkVbvAWreXbZ9&oauth_token_secret=Tnak4VFAuT7ePpgAF6nbKZiXqlFANlsf9HkRdHDLg&user_id=16112760&screen_name=coachandrews	2010-07-08	2010-07-08	147	18043134414	0	17460724539	http://a3.twimg.com/profile_images/767348385/card_andrews_2010_normal.JPG
210	146812765	VKabdulnasir	146812765-N8H3QBjCLgqzYb0yZQRWTzIskfkwB0CORgyZaTni	1T9xIpNqYKY6HK8IAlQ1obF3fvMHZ30IiSGQCuIyjU	oauth_token=146812765-N8H3QBjCLgqzYb0yZQRWTzIskfkwB0CORgyZaTni&oauth_token_secret=1T9xIpNqYKY6HK8IAlQ1obF3fvMHZ30IiSGQCuIyjU&user_id=146812765&screen_name=VKabdulnasir	2010-07-10	2010-07-10	149	18182174340	0	0	http://s.twimg.com/a/1278724399/images/default_profile_1_normal.png
211	165124609	nabikhan24	165124609-NLL2o1lfAkb0Wj7dyt8xqC1nqtrca7K6musXdZA4	gLP5LTmvY9MVUav9W3ca5faDh2c4Z9h4aNQtmIWcSsY	oauth_token=165124609-NLL2o1lfAkb0Wj7dyt8xqC1nqtrca7K6musXdZA4&oauth_token_secret=gLP5LTmvY9MVUav9W3ca5faDh2c4Z9h4aNQtmIWcSsY&user_id=165124609&screen_name=nabikhan24	2010-07-10	2010-07-10	150	0	0	0	http://s.twimg.com/a/1278724399/images/default_profile_6_normal.png
212	126927556	bhadur_varma	126927556-Dsb5IEvvBkKs8ExjHaaSsujhs6Az9d5cNVxTeQLM	5pdKyENFydKFeLf3wnoUJJMAbLcXq0jO2t6uMBR3jbY	oauth_token=126927556-Dsb5IEvvBkKs8ExjHaaSsujhs6Az9d5cNVxTeQLM&oauth_token_secret=5pdKyENFydKFeLf3wnoUJJMAbLcXq0jO2t6uMBR3jbY&user_id=126927556&screen_name=bhadur_varma	2010-07-10	2010-07-10	151	0	0	0	http://s.twimg.com/a/1278724399/images/default_profile_0_normal.png
216	92895763	sandeepabhat	92895763-58PGMegkZtqmdbYEmEfpLX8aNHcBS0OcgyzC5qaGE	HpZdhVTlMeARaBPgAuY3VBpsVc5KzB4TYXE76SC0	oauth_token=92895763-58PGMegkZtqmdbYEmEfpLX8aNHcBS0OcgyzC5qaGE&oauth_token_secret=HpZdhVTlMeARaBPgAuY3VBpsVc5KzB4TYXE76SC0&user_id=92895763&screen_name=sandeepabhat	2010-07-13	2010-07-13	93	19632714549	1214957404	19421747410	http://a1.twimg.com/profile_images/545859214/sandie_normal.png
\.


SET search_path = public, pg_catalog;

--
-- TOC entry 1829 (class 0 OID 24591)
-- Dependencies: 1524
-- Data for Name: actions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY actions (id, action) FROM stdin;
\.


--
-- TOC entry 1828 (class 0 OID 16564)
-- Dependencies: 1522
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (id, login, passwd_salt) FROM stdin;
\.


SET search_path = main, pg_catalog;

--
-- TOC entry 1821 (class 2606 OID 24616)
-- Dependencies: 1525 1525
-- Name: actions_key; Type: CONSTRAINT; Schema: main; Owner: mtwiple_user; Tablespace: 
--

ALTER TABLE ONLY actions
    ADD CONSTRAINT actions_key PRIMARY KEY (id);


--
-- TOC entry 1815 (class 2606 OID 16577)
-- Dependencies: 1518 1518
-- Name: grp_pky; Type: CONSTRAINT; Schema: main; Owner: mtwiple_user; Tablespace: 
--

ALTER TABLE ONLY user_group
    ADD CONSTRAINT grp_pky PRIMARY KEY (id);


--
-- TOC entry 1823 (class 2606 OID 24618)
-- Dependencies: 1527 1527
-- Name: logs_key; Type: CONSTRAINT; Schema: main; Owner: mtwiple_user; Tablespace: 
--

ALTER TABLE ONLY logs
    ADD CONSTRAINT logs_key PRIMARY KEY (id);


--
-- TOC entry 1813 (class 2606 OID 16579)
-- Dependencies: 1516 1516
-- Name: ltok_pky; Type: CONSTRAINT; Schema: main; Owner: mtwiple_user; Tablespace: 
--

ALTER TABLE ONLY login_tokens
    ADD CONSTRAINT ltok_pky PRIMARY KEY (id);


--
-- TOC entry 1817 (class 2606 OID 16581)
-- Dependencies: 1520 1520
-- Name: ustok_pky; Type: CONSTRAINT; Schema: main; Owner: mtwiple_user; Tablespace: 
--

ALTER TABLE ONLY user_tokens
    ADD CONSTRAINT ustok_pky PRIMARY KEY (id);


SET search_path = public, pg_catalog;

--
-- TOC entry 1819 (class 2606 OID 16583)
-- Dependencies: 1522 1522
-- Name: usr_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT usr_id_pkey PRIMARY KEY (id);


SET search_path = main, pg_catalog;

--
-- TOC entry 1824 (class 2606 OID 16584)
-- Dependencies: 1518 1520 1814
-- Name: usr_grp_fky; Type: FK CONSTRAINT; Schema: main; Owner: mtwiple_user
--

ALTER TABLE ONLY user_tokens
    ADD CONSTRAINT usr_grp_fky FOREIGN KEY (group_id) REFERENCES user_group(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1835 (class 0 OID 0)
-- Dependencies: 6
-- Name: main; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA main FROM PUBLIC;
REVOKE ALL ON SCHEMA main FROM postgres;
GRANT ALL ON SCHEMA main TO postgres;
GRANT ALL ON SCHEMA main TO PUBLIC;


--
-- TOC entry 1837 (class 0 OID 0)
-- Dependencies: 7
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2010-07-27 10:40:47 UTC

--
-- PostgreSQL database dump complete
--

