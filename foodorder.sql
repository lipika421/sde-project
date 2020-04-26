--
-- PostgreSQL database dump
--

-- Dumped from database version 11.7 (Ubuntu 11.7-0ubuntu0.19.10.1)
-- Dumped by pg_dump version 11.7 (Ubuntu 11.7-0ubuntu0.19.10.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cart; Type: TABLE; Schema: public; Owner: sarthak
--

CREATE TABLE public.cart (
    id integer NOT NULL,
    name character varying(120) NOT NULL,
    price integer NOT NULL
);


ALTER TABLE public.cart OWNER TO sarthak;

--
-- Name: cart_id_seq; Type: SEQUENCE; Schema: public; Owner: sarthak
--

CREATE SEQUENCE public.cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cart_id_seq OWNER TO sarthak;

--
-- Name: cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarthak
--

ALTER SEQUENCE public.cart_id_seq OWNED BY public.cart.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: sarthak
--

CREATE TABLE public.products (
    id integer NOT NULL,
    prodname_ character varying(120),
    prodprice_ integer,
    managerid_ integer
);


ALTER TABLE public.products OWNER TO sarthak;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: sarthak
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO sarthak;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarthak
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: sarthak
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    username_ character varying(120),
    email_ character varying(120),
    password_ character varying(120),
    address_ character varying(250),
    usertype_ character varying(120),
    restname_ character varying(120)
);


ALTER TABLE public."user" OWNER TO sarthak;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: sarthak
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO sarthak;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sarthak
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: cart id; Type: DEFAULT; Schema: public; Owner: sarthak
--

ALTER TABLE ONLY public.cart ALTER COLUMN id SET DEFAULT nextval('public.cart_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: sarthak
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: sarthak
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Data for Name: cart; Type: TABLE DATA; Schema: public; Owner: sarthak
--

COPY public.cart (id, name, price) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: sarthak
--

COPY public.products (id, prodname_, prodprice_, managerid_) FROM stdin;
2	Hot Wings	190	2
3	Rice Bowl	250	2
4	Zinger Box	210	2
5	Chicken Sausage Pizza	260	3
6	Chicken Barbeque Pizza	210	3
7	Chciken Peri Peri Pizza	310	3
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: sarthak
--

COPY public."user" (id, username_, email_, password_, address_, usertype_, restname_) FROM stdin;
1	Sarthak Johnson	sarthakjohnsonprasad@gmail.com	sarthakjp	SDS 322	Customer	
2	Ashish Gokarnkar	ashugok@gmail.com	bisleri	SDS 327	Restaurant Manager	KFC
3	Parth Paradkar	parth.paradkar@gmail.com	gsoc2020	SDS 323	Restaurant Manager	Pizza Hut
4	Person 1	person1@gmail.com	person1	Salt Lake	Delivery Person	
5	Person 2	person2@gmail.com	person2	New Kolkata	Delivery Person	
6	Person 3	person3@gmail.com	person3	Ichapur	Delivery Person	
7	Person 4	person4@gmail.com	person4	Barrackpore	Delivery Person	
\.


--
-- Name: cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarthak
--

SELECT pg_catalog.setval('public.cart_id_seq', 1, false);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarthak
--

SELECT pg_catalog.setval('public.products_id_seq', 7, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sarthak
--

SELECT pg_catalog.setval('public.user_id_seq', 7, true);


--
-- Name: cart cart_pkey; Type: CONSTRAINT; Schema: public; Owner: sarthak
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: sarthak
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: user user_email__key; Type: CONSTRAINT; Schema: public; Owner: sarthak
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email__key UNIQUE (email_);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: sarthak
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: products products_managerid__fkey; Type: FK CONSTRAINT; Schema: public; Owner: sarthak
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_managerid__fkey FOREIGN KEY (managerid_) REFERENCES public."user"(id);


--
-- PostgreSQL database dump complete
--

