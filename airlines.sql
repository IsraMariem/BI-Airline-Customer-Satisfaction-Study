--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

-- Started on 2024-01-21 16:55:35

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

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4933 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 16559)
-- Name: aircraft; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aircraft (
    aircraft_code character varying(5) NOT NULL,
    model character varying(50),
    range integer
);


ALTER TABLE public.aircraft OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16556)
-- Name: customers_satisfaction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers_satisfaction (
    passenger_id character varying(20) NOT NULL,
    satisfaction character varying(12),
    gender character varying(10),
    customer_type character varying(20),
    age integer,
    fare_conditions character varying(10),
    flight_distance integer,
    seat_comfort integer,
    seat_no character varying(5),
    departure_arrival_time_convenient integer,
    food_and_drink integer,
    gate_location integer,
    inflight_wifi_service integer,
    inflight_entertainment integer,
    online_support integer,
    ease_of_online_booking integer,
    on_board_service integer,
    leg_room_service integer,
    baggage_handling integer,
    checkin_service integer,
    cleanliness integer,
    online_boarding integer,
    departure_delay_in_minutes integer,
    arrival_delay_in_minutes integer,
    flight_id integer
);


ALTER TABLE public.customers_satisfaction OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17293)
-- Name: dim_aircraft; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_aircraft (
    aircraft_code character varying(255),
    model character varying(255) NOT NULL,
    range integer
);


ALTER TABLE public.dim_aircraft OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17313)
-- Name: dim_customersatisfaction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_customersatisfaction (
    passenger_id character varying NOT NULL,
    satisfaction character varying(255),
    gender character varying(255),
    customer_type character varying(255),
    age integer
);


ALTER TABLE public.dim_customersatisfaction OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17287)
-- Name: dim_flight; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_flight (
    flight_id integer NOT NULL,
    aircraft_code character varying(255),
    flight_distance integer
);


ALTER TABLE public.dim_flight OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17286)
-- Name: dim_flight_flight_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_flight_flight_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_flight_flight_id_seq OWNER TO postgres;

--
-- TOC entry 4934 (class 0 OID 0)
-- Dependencies: 223
-- Name: dim_flight_flight_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_flight_flight_id_seq OWNED BY public.dim_flight.flight_id;


--
-- TOC entry 222 (class 1259 OID 17272)
-- Name: dim_passenger; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_passenger (
    passenger_id character varying NOT NULL,
    satisfaction character varying(255),
    gender character varying(255),
    customer_type character varying(255),
    age integer
);


ALTER TABLE public.dim_passenger OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 17307)
-- Name: dim_seat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_seat (
    aircraft_code character varying(255),
    seat_no character varying(255),
    fare_conditions character varying(255)
);


ALTER TABLE public.dim_seat OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17551)
-- Name: fact_airlines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fact_airlines (
    passenger_id character varying NOT NULL,
    satisfaction character varying(50),
    gender character varying(50),
    customer_type character varying(50),
    age integer,
    fare_conditions character varying(50),
    flight_distance integer,
    seat_comfort integer,
    seat_no character varying(5),
    departure_arrival_time_convenient integer,
    food_and_drink integer,
    gate_location integer,
    inflight_wifi_service integer,
    inflight_entertainment integer,
    online_support integer,
    ease_of_online_booking integer,
    onboard_service integer,
    leg_room_service integer,
    baggage_handling integer,
    checkin_service integer,
    cleanliness integer,
    online_boarding integer,
    departure_delay_minutes integer,
    arrival_delay_minutes integer,
    aircraft_code character varying(5),
    model character varying(255),
    range integer,
    flight_id integer,
    ticket_price numeric(10,2)
);


ALTER TABLE public.fact_airlines OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16572)
-- Name: flights; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flights (
    flight_id integer NOT NULL,
    aircraft_code character varying(5)
);


ALTER TABLE public.flights OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16580)
-- Name: seats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seats (
    aircraft_code character varying(5),
    seat_no character varying(5),
    fare_conditions character varying(20)
);


ALTER TABLE public.seats OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16588)
-- Name: ticket_prices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ticket_prices (
    flight_id integer,
    fare_conditions character varying(20),
    ticket_price integer
);


ALTER TABLE public.ticket_prices OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16591)
-- Name: tickets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tickets (
    ticket_no bigint NOT NULL,
    book_ref character varying(10),
    passenger_id character varying(20)
);


ALTER TABLE public.tickets OWNER TO postgres;

--
-- TOC entry 4733 (class 2604 OID 17290)
-- Name: dim_flight flight_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_flight ALTER COLUMN flight_id SET DEFAULT nextval('public.dim_flight_flight_id_seq'::regclass);


--
-- TOC entry 4916 (class 0 OID 16559)
-- Dependencies: 217
-- Data for Name: aircraft; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aircraft (aircraft_code, model, range) FROM stdin;
773	Boeing 777-300	11100
763	Boeing 767-300	7900
SU9	Sukhoi Superjet-100	3000
320	Airbus A320-200	5700
321	Airbus A321-200	5600
319	Airbus A319-100	6700
733	Boeing 737-300	4200
CN1	Cessna 208 Caravan	1200
CR2	Bombardier CRJ-200	2700
\.


--
-- TOC entry 4915 (class 0 OID 16556)
-- Dependencies: 216
-- Data for Name: customers_satisfaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers_satisfaction (passenger_id, satisfaction, gender, customer_type, age, fare_conditions, flight_distance, seat_comfort, seat_no, departure_arrival_time_convenient, food_and_drink, gate_location, inflight_wifi_service, inflight_entertainment, online_support, ease_of_online_booking, on_board_service, leg_room_service, baggage_handling, checkin_service, cleanliness, online_boarding, departure_delay_in_minutes, arrival_delay_in_minutes, flight_id) FROM stdin;
8149604011	satisfied	Female	Loyal Customer	59	Economy	1470	4	2A	4	4	4	5	4	4	4	4	4	4	5	4	3	7	0	\N
8499420203	dissatisfied	Female	disloyal Customer	22	Business	1771	1	2C	1	1	4	4	1	5	4	3	4	3	1	4	4	0	0	\N
1011752484	satisfied	Male	Loyal Customer	55	Business	3657	0	2D	5	0	2	4	5	4	4	4	4	4	3	4	3	12	8	\N
4849400049	satisfied	Female	Loyal Customer	41	Comfort	1796	0	2F	4	0	1	2	4	5	3	3	3	3	5	3	3	0	0	\N
6615976589	dissatisfied	Male	Loyal Customer	42	Comfort	1709	2	3A	3	3	3	2	2	2	2	4	4	4	1	3	2	0	0	\N
2021652719	dissatisfied	Male	Loyal Customer	36	Economy	3035	3	3C	2	2	2	1	4	4	3	3	2	3	4	3	3	48	38	\N
817363231	dissatisfied	Male	disloyal Customer	28	Business	1904	1	3D	2	2	2	2	2	1	2	1	5	1	4	5	2	0	0	\N
2883989356	satisfied	Female	Loyal Customer	58	Business	2496	5	3F	5	5	5	4	5	4	3	3	4	3	5	3	5	61	102	\N
3097995546	satisfied	Male	Loyal Customer	54	Economy	3260	5	4A	5	5	5	2	5	4	4	4	4	4	4	4	4	1	0	\N
6866920231	dissatisfied	Female	Loyal Customer	25	Business	3640	2	4C	4	2	4	2	2	2	2	4	4	1	4	3	2	86	63	\N
6030369450	satisfied	Female	Loyal Customer	32	Business	1465	4	4D	4	4	4	5	5	5	5	3	5	5	3	4	5	36	81	\N
8675588663	dissatisfied	Female	Loyal Customer	52	Economy	812	3	4F	4	4	4	3	4	4	3	3	3	3	3	3	3	0	0	\N
764728785	satisfied	Female	disloyal Customer	29	Business	2773	4	5A	4	4	3	1	4	1	1	4	5	4	5	4	1	0	0	\N
8954972101	satisfied	Male	Loyal Customer	56	Comfort	55	3	5C	3	3	3	4	5	5	4	4	4	4	3	4	3	0	0	\N
6772748756	satisfied	Female	Loyal Customer	57	Business	1099	2	5D	2	5	2	4	5	4	4	4	5	4	4	4	4	0	0	\N
7364216524	satisfied	Female	Loyal Customer	57	Economy	728	3	5F	3	3	3	2	5	5	4	4	4	4	5	4	3	4	0	\N
3635182357	satisfied	Female	Loyal Customer	48	Economy	339	5	6A	5	1	5	3	3	1	5	5	5	5	2	5	3	0	0	\N
8252507584	satisfied	Male	Loyal Customer	23	Comfort	2074	1	6B	1	1	1	1	2	1	1	4	1	5	5	1	1	0	3	\N
1026982766	dissatisfied	Female	Loyal Customer	49	Business	491	1	6C	2	2	2	5	3	3	1	1	1	1	2	1	2	0	0	\N
7107950192	satisfied	Male	disloyal Customer	28	Economy	2161	5	6D	5	5	3	1	5	1	1	3	3	4	3	5	1	0	0	\N
4765014996	dissatisfied	Male	Loyal Customer	36	Business	2095	1	6E	5	1	3	1	1	1	1	4	3	4	3	5	1	0	4	\N
3342145536	satisfied	Male	Loyal Customer	41	Business	3553	0	6F	0	0	3	2	4	4	2	2	5	5	1	2	2	23	19	\N
1745349	satisfied	Male	Loyal Customer	16	Comfort	1675	4	7A	4	4	4	5	5	3	5	4	3	4	1	2	5	0	0	\N
7273175330	dissatisfied	Male	Loyal Customer	66	Economy	1031	1	7B	1	1	1	1	1	1	1	1	3	4	4	3	1	0	0	\N
1370120631	dissatisfied	Male	Loyal Customer	58	Economy	1878	3	7C	1	1	1	3	3	3	3	1	4	4	2	4	3	43	46	\N
5559553314	satisfied	Female	Loyal Customer	47	Economy	499	3	7D	3	3	3	2	5	4	4	4	4	4	4	4	5	47	36	\N
6544483657	satisfied	Male	Loyal Customer	61	Economy	2338	4	7E	4	4	4	3	4	3	3	4	2	4	5	5	3	0	0	\N
7011596158	dissatisfied	Male	Loyal Customer	47	Business	3112	1	7F	5	5	5	2	4	4	1	1	1	1	4	1	1	0	0	\N
6772891759	satisfied	Female	Loyal Customer	53	Comfort	2102	4	8A	4	4	4	2	4	5	4	4	4	4	4	4	4	0	0	\N
8116659266	dissatisfied	Male	Loyal Customer	48	Business	2241	2	8B	4	3	1	3	3	3	3	3	5	4	3	5	3	0	0	\N
3542318601	satisfied	Female	Loyal Customer	59	Comfort	1682	3	8C	3	3	3	5	4	5	3	3	2	3	5	3	3	2	0	\N
8511999561	satisfied	Female	Loyal Customer	13	Comfort	2696	5	8D	5	5	5	4	5	5	4	4	4	4	5	4	3	0	0	\N
630169679	dissatisfied	Male	disloyal Customer	49	Economy	910	2	8E	4	2	4	1	2	1	1	1	3	4	1	4	1	0	0	\N
85303617	satisfied	Male	Loyal Customer	58	Comfort	2119	2	8F	2	2	2	3	4	5	5	5	5	4	4	5	5	0	0	\N
8080870126	satisfied	Female	Loyal Customer	51	Comfort	959	4	9A	4	4	4	3	4	5	4	4	4	4	3	4	5	2	0	\N
3755842338	dissatisfied	Female	disloyal Customer	23	Business	1574	1	9B	1	1	3	4	1	4	4	2	5	4	2	4	4	22	24	\N
2295465854	satisfied	Female	Loyal Customer	49	Comfort	3599	1	9C	1	1	1	4	5	4	5	5	5	5	3	5	4	0	0	\N
4245607929	dissatisfied	Female	Loyal Customer	20	Comfort	2170	2	9D	5	5	5	2	3	2	2	2	4	3	4	4	2	8	2	\N
7859943808	dissatisfied	Female	disloyal Customer	39	Business	2144	1	9E	1	1	3	3	1	3	3	1	3	4	3	3	3	1	0	\N
2765289085	satisfied	Female	Loyal Customer	48	Economy	3825	5	9F	5	5	5	5	3	1	4	4	4	3	4	4	1	0	5	\N
4278618557	satisfied	Male	Loyal Customer	24	Economy	2594	1	10A	1	1	1	5	5	5	5	3	2	4	2	5	5	0	0	\N
5657976071	satisfied	Female	Loyal Customer	43	Comfort	852	1	10B	1	1	1	4	4	4	4	3	3	5	4	5	4	0	0	\N
9384205645	dissatisfied	Male	Loyal Customer	49	Business	2917	2	10C	5	2	4	3	2	3	3	3	5	3	4	4	3	0	0	\N
544834528	dissatisfied	Male	Loyal Customer	23	Comfort	1884	4	10D	4	2	2	5	2	5	5	4	2	4	4	4	5	1	11	\N
6365326222	dissatisfied	Male	disloyal Customer	20	Economy	2071	1	10E	1	1	3	1	1	1	1	4	4	4	4	4	1	26	10	\N
7686012334	satisfied	Male	Loyal Customer	30	Comfort	1533	5	10F	2	5	5	5	5	5	5	1	3	1	2	1	5	0	0	\N
1564396952	dissatisfied	Male	Loyal Customer	77	Economy	1660	3	11A	3	4	3	3	2	2	3	3	3	3	3	3	4	0	0	\N
2279938743	dissatisfied	Male	Loyal Customer	36	Economy	1681	2	11B	3	3	3	5	4	3	2	2	2	2	3	2	3	20	12	\N
8140620813	satisfied	Female	Loyal Customer	44	Economy	232	5	17D	4	5	4	5	5	5	4	4	5	4	4	4	4	0	0	\N
9257239781	dissatisfied	Male	disloyal Customer	36	Economy	1846	2	17E	2	2	3	2	2	2	2	2	5	4	4	4	2	36	35	\N
5829268568	satisfied	Male	Loyal Customer	80	Comfort	1278	5	17F	3	3	3	5	5	5	5	3	5	3	5	2	5	0	0	\N
7140936574	dissatisfied	Male	Loyal Customer	46	Comfort	4288	3	18A	5	2	5	2	3	2	1	3	4	4	2	1	2	168	201	\N
6055541445	satisfied	Female	Loyal Customer	35	Economy	385	2	18B	2	3	2	2	5	5	4	4	4	4	4	4	5	0	0	\N
6856343851	dissatisfied	Female	Loyal Customer	61	Comfort	371	3	18C	1	1	1	4	3	3	3	3	3	3	3	3	2	0	36	\N
1989394243	satisfied	Female	Loyal Customer	61	Business	353	4	18D	4	4	4	3	5	5	5	5	5	5	5	5	3	0	0	\N
7497108600	dissatisfied	Male	Loyal Customer	44	Comfort	2051	1	18E	0	1	5	1	5	5	4	2	5	5	5	5	5	83	142	\N
5324130395	satisfied	Male	Loyal Customer	21	Economy	3527	5	18F	5	5	5	3	3	3	5	3	4	3	3	5	3	54	49	\N
6259021260	dissatisfied	Male	disloyal Customer	57	Economy	1560	3	19A	0	3	1	1	3	1	1	2	3	3	5	3	1	0	0	\N
6849694832	satisfied	Male	Loyal Customer	58	Comfort	2824	5	19B	5	5	5	3	5	5	4	4	4	4	5	4	4	0	0	\N
9542445779	dissatisfied	Male	Loyal Customer	25	Economy	1876	4	19C	5	4	3	4	4	5	4	3	2	4	1	4	4	82	70	\N
2536676370	satisfied	Female	Loyal Customer	62	Economy	959	2	19D	2	2	2	2	5	5	4	4	4	4	4	4	5	0	0	\N
3392878429	dissatisfied	Male	Loyal Customer	42	Comfort	1951	4	20E	5	4	1	2	4	2	2	3	1	3	5	5	2	0	0	\N
207310663	satisfied	Male	Loyal Customer	47	Economy	3835	4	20F	5	4	4	4	4	4	5	4	5	5	4	4	4	933	920	\N
6808774590	dissatisfied	Female	disloyal Customer	29	Economy	1859	1	21A	0	1	4	5	1	5	5	5	2	4	5	2	5	3	5	\N
5582658715	dissatisfied	Male	Loyal Customer	9	Economy	5397	3	21B	3	3	3	3	3	3	3	2	4	3	3	2	3	8	19	\N
8109611094	satisfied	Male	Loyal Customer	80	Comfort	2727	5	21C	5	5	5	4	4	4	5	5	5	5	4	5	4	0	0	\N
2489626224	dissatisfied	Male	disloyal Customer	32	Comfort	1565	3	21D	3	3	3	2	3	2	2	5	2	4	3	4	2	0	0	\N
2811332014	satisfied	Female	Loyal Customer	55	Business	309	1	21E	1	1	1	2	4	4	5	5	5	5	3	5	5	0	0	\N
7198591092	satisfied	Female	Loyal Customer	43	Economy	1730	3	21F	3	3	3	2	4	4	5	5	5	5	5	5	3	1	8	\N
3262369338	satisfied	Male	Loyal Customer	52	Economy	2135	1	1A	1	1	1	5	4	4	5	5	5	5	3	5	5	0	0	\N
4128658175	dissatisfied	Female	disloyal Customer	17	Comfort	1451	1	1C	3	1	3	3	1	3	3	5	3	3	5	3	3	10	4	\N
6709734767	satisfied	Female	Loyal Customer	40	Comfort	2285	5	1D	5	5	5	2	2	2	3	2	5	4	2	4	2	211	213	\N
326266595	dissatisfied	Female	Loyal Customer	44	Business	3265	3	1F	4	4	4	1	4	3	3	3	3	3	1	3	4	0	0	\N
2215922557	satisfied	Male	Loyal Customer	41	Economy	1144	1	2A	1	4	1	4	4	5	5	5	5	5	4	5	3	0	0	\N
2290450397	satisfied	Male	Loyal Customer	41	Comfort	2466	5	2C	5	5	5	4	4	4	5	5	5	5	5	5	4	0	0	\N
2467774707	satisfied	Female	Loyal Customer	57	Economy	429	5	2D	5	3	5	1	2	1	4	4	4	4	1	4	3	0	0	\N
7650555895	dissatisfied	Male	Loyal Customer	51	Economy	3549	1	2F	1	1	1	1	4	3	1	1	1	1	4	1	1	0	7	\N
5364307705	satisfied	Female	Loyal Customer	40	Comfort	2789	3	3A	3	4	3	4	4	5	4	4	5	4	3	4	4	36	42	\N
1115708092	satisfied	Male	Loyal Customer	43	Business	3020	1	3C	1	1	1	5	5	5	4	4	4	4	5	4	3	55	54	\N
7066161500	dissatisfied	Male	Loyal Customer	54	Economy	4882	2	3D	3	5	5	3	2	4	2	1	4	3	4	2	4	326	317	\N
6903458379	satisfied	Female	Loyal Customer	45	Comfort	684	2	3F	2	1	2	2	4	4	4	4	4	4	3	4	4	0	0	\N
2651489583	satisfied	Female	Loyal Customer	54	Comfort	864	4	4A	4	4	4	4	4	4	4	5	2	5	5	5	4	13	0	\N
5534060462	dissatisfied	Male	Loyal Customer	25	Economy	3205	1	4C	4	1	3	2	1	2	2	4	2	3	1	4	2	14	8	\N
1527165464	dissatisfied	Female	Loyal Customer	29	Business	3842	1	4D	3	3	3	1	1	1	1	1	3	4	4	4	1	0	0	\N
1051084909	satisfied	Female	Loyal Customer	37	Comfort	2326	5	4F	5	5	5	5	4	4	5	5	5	5	3	5	3	25	28	\N
8616037931	satisfied	Female	Loyal Customer	26	Economy	1809	3	5A	5	3	3	5	5	5	5	3	3	5	3	4	5	128	126	\N
8557326046	satisfied	Female	Loyal Customer	70	Economy	233	0	5C	0	0	3	3	1	3	2	2	2	2	3	2	1	35	40	\N
1662000481	dissatisfied	Male	Loyal Customer	34	Business	1950	2	5D	3	3	3	4	3	3	2	2	2	2	3	2	3	90	90	\N
2432012911	dissatisfied	Male	Loyal Customer	64	Economy	3893	1	5F	4	1	3	1	2	2	5	4	3	4	2	4	2	16	40	\N
6723926887	dissatisfied	Male	Loyal Customer	46	Business	3100	1	6A	5	1	3	2	1	2	2	5	4	2	4	3	2	0	0	\N
3608388798	dissatisfied	Female	disloyal Customer	40	Comfort	1857	3	6B	3	3	3	5	3	5	5	1	3	5	1	1	5	0	0	\N
7140268929	satisfied	Female	Loyal Customer	54	Comfort	1779	1	6C	1	1	1	5	3	5	4	4	4	4	5	4	3	0	3	\N
8851001440	satisfied	Male	Loyal Customer	28	Business	5106	3	6D	3	4	3	5	5	5	5	3	2	4	4	5	5	41	22	\N
3802843058	dissatisfied	Male	Loyal Customer	11	Economy	1838	2	6E	5	2	2	2	2	2	2	3	4	5	3	5	2	9	1	\N
7953226769	dissatisfied	Male	Loyal Customer	43	Business	1380	4	6F	3	3	3	4	4	4	4	1	2	2	3	3	4	0	0	\N
4046519379	satisfied	Female	Loyal Customer	54	Economy	3624	1	7A	1	1	1	5	4	4	2	2	2	2	3	2	4	0	7	\N
7906253170	satisfied	Female	Loyal Customer	17	Comfort	1557	4	7B	4	1	4	4	4	4	4	3	3	3	1	1	4	0	0	\N
3499600919	dissatisfied	Female	Loyal Customer	25	Business	2183	1	7C	3	4	4	1	1	2	1	1	3	4	4	3	1	1	7	\N
7634557379	dissatisfied	Male	Loyal Customer	47	Economy	1561	4	7D	4	4	3	5	4	5	5	3	2	5	3	5	5	0	0	\N
3040999771	dissatisfied	Male	Loyal Customer	64	Economy	2384	1	7E	1	1	1	3	2	3	1	1	1	1	4	1	4	3	0	\N
\.


--
-- TOC entry 4924 (class 0 OID 17293)
-- Dependencies: 225
-- Data for Name: dim_aircraft; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_aircraft (aircraft_code, model, range) FROM stdin;
773	Boeing 777-300	11100
763	Boeing 767-300	7900
SU9	Sukhoi Superjet-100	3000
320	Airbus A320-200	5700
321	Airbus A321-200	5600
319	Airbus A319-100	6700
733	Boeing 737-300	4200
CN1	Cessna 208 Caravan	1200
CR2	Bombardier CRJ-200	2700
\.


--
-- TOC entry 4926 (class 0 OID 17313)
-- Dependencies: 227
-- Data for Name: dim_customersatisfaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_customersatisfaction (passenger_id, satisfaction, gender, customer_type, age) FROM stdin;
8149604011	satisfied	Female	Loyal Customer	59
8499420203	dissatisfied	Female	disloyal Customer	22
1011752484	satisfied	Male	Loyal Customer	55
4849400049	satisfied	Female	Loyal Customer	41
6615976589	dissatisfied	Male	Loyal Customer	42
2021652719	dissatisfied	Male	Loyal Customer	36
817363231	dissatisfied	Male	disloyal Customer	28
2883989356	satisfied	Female	Loyal Customer	58
3097995546	satisfied	Male	Loyal Customer	54
6866920231	dissatisfied	Female	Loyal Customer	25
6030369450	satisfied	Female	Loyal Customer	32
8675588663	dissatisfied	Female	Loyal Customer	52
764728785	satisfied	Female	disloyal Customer	29
8954972101	satisfied	Male	Loyal Customer	56
6772748756	satisfied	Female	Loyal Customer	57
7364216524	satisfied	Female	Loyal Customer	57
3635182357	satisfied	Female	Loyal Customer	48
8252507584	satisfied	Male	Loyal Customer	23
1026982766	dissatisfied	Female	Loyal Customer	49
7107950192	satisfied	Male	disloyal Customer	28
4765014996	dissatisfied	Male	Loyal Customer	36
3342145536	satisfied	Male	Loyal Customer	41
1745349	satisfied	Male	Loyal Customer	16
7273175330	dissatisfied	Male	Loyal Customer	66
1370120631	dissatisfied	Male	Loyal Customer	58
5559553314	satisfied	Female	Loyal Customer	47
6544483657	satisfied	Male	Loyal Customer	61
7011596158	dissatisfied	Male	Loyal Customer	47
6772891759	satisfied	Female	Loyal Customer	53
8116659266	dissatisfied	Male	Loyal Customer	48
3542318601	satisfied	Female	Loyal Customer	59
8511999561	satisfied	Female	Loyal Customer	13
630169679	dissatisfied	Male	disloyal Customer	49
85303617	satisfied	Male	Loyal Customer	58
8080870126	satisfied	Female	Loyal Customer	51
3755842338	dissatisfied	Female	disloyal Customer	23
2295465854	satisfied	Female	Loyal Customer	49
4245607929	dissatisfied	Female	Loyal Customer	20
7859943808	dissatisfied	Female	disloyal Customer	39
2765289085	satisfied	Female	Loyal Customer	48
4278618557	satisfied	Male	Loyal Customer	24
5657976071	satisfied	Female	Loyal Customer	43
9384205645	dissatisfied	Male	Loyal Customer	49
544834528	dissatisfied	Male	Loyal Customer	23
6365326222	dissatisfied	Male	disloyal Customer	20
7686012334	satisfied	Male	Loyal Customer	30
1564396952	dissatisfied	Male	Loyal Customer	77
2279938743	dissatisfied	Male	Loyal Customer	36
8140620813	satisfied	Female	Loyal Customer	44
9257239781	dissatisfied	Male	disloyal Customer	36
5829268568	satisfied	Male	Loyal Customer	80
7140936574	dissatisfied	Male	Loyal Customer	46
6055541445	satisfied	Female	Loyal Customer	35
6856343851	dissatisfied	Female	Loyal Customer	61
1989394243	satisfied	Female	Loyal Customer	61
7497108600	dissatisfied	Male	Loyal Customer	44
5324130395	satisfied	Male	Loyal Customer	21
6259021260	dissatisfied	Male	disloyal Customer	57
6849694832	satisfied	Male	Loyal Customer	58
9542445779	dissatisfied	Male	Loyal Customer	25
2536676370	satisfied	Female	Loyal Customer	62
3392878429	dissatisfied	Male	Loyal Customer	42
207310663	satisfied	Male	Loyal Customer	47
6808774590	dissatisfied	Female	disloyal Customer	29
5582658715	dissatisfied	Male	Loyal Customer	9
8109611094	satisfied	Male	Loyal Customer	80
2489626224	dissatisfied	Male	disloyal Customer	32
2811332014	satisfied	Female	Loyal Customer	55
7198591092	satisfied	Female	Loyal Customer	43
3262369338	satisfied	Male	Loyal Customer	52
4128658175	dissatisfied	Female	disloyal Customer	17
6709734767	satisfied	Female	Loyal Customer	40
326266595	dissatisfied	Female	Loyal Customer	44
2215922557	satisfied	Male	Loyal Customer	41
2290450397	satisfied	Male	Loyal Customer	41
2467774707	satisfied	Female	Loyal Customer	57
7650555895	dissatisfied	Male	Loyal Customer	51
5364307705	satisfied	Female	Loyal Customer	40
1115708092	satisfied	Male	Loyal Customer	43
7066161500	dissatisfied	Male	Loyal Customer	54
6903458379	satisfied	Female	Loyal Customer	45
2651489583	satisfied	Female	Loyal Customer	54
5534060462	dissatisfied	Male	Loyal Customer	25
1527165464	dissatisfied	Female	Loyal Customer	29
1051084909	satisfied	Female	Loyal Customer	37
8616037931	satisfied	Female	Loyal Customer	26
8557326046	satisfied	Female	Loyal Customer	70
1662000481	dissatisfied	Male	Loyal Customer	34
2432012911	dissatisfied	Male	Loyal Customer	64
6723926887	dissatisfied	Male	Loyal Customer	46
3608388798	dissatisfied	Female	disloyal Customer	40
7140268929	satisfied	Female	Loyal Customer	54
8851001440	satisfied	Male	Loyal Customer	28
3802843058	dissatisfied	Male	Loyal Customer	11
7953226769	dissatisfied	Male	Loyal Customer	43
4046519379	satisfied	Female	Loyal Customer	54
7906253170	satisfied	Female	Loyal Customer	17
3499600919	dissatisfied	Female	Loyal Customer	25
7634557379	dissatisfied	Male	Loyal Customer	47
3040999771	dissatisfied	Male	Loyal Customer	64
\.


--
-- TOC entry 4923 (class 0 OID 17287)
-- Dependencies: 224
-- Data for Name: dim_flight; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_flight (flight_id, aircraft_code, flight_distance) FROM stdin;
13113	319	\N
29272	CR2	\N
5502	763	\N
23695	SU9	\N
27580	CR2	\N
24705	CR2	\N
23780	733	\N
30625	CR2	\N
16837	CN1	\N
24836	CN1	\N
39	CR2	\N
19807	321	\N
\.


--
-- TOC entry 4921 (class 0 OID 17272)
-- Dependencies: 222
-- Data for Name: dim_passenger; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_passenger (passenger_id, satisfaction, gender, customer_type, age) FROM stdin;
8149604011	satisfied	Female	Loyal Customer	59
8499420203	dissatisfied	Female	disloyal Customer	22
1011752484	satisfied	Male	Loyal Customer	55
4849400049	satisfied	Female	Loyal Customer	41
6615976589	dissatisfied	Male	Loyal Customer	42
2021652719	dissatisfied	Male	Loyal Customer	36
817363231	dissatisfied	Male	disloyal Customer	28
2883989356	satisfied	Female	Loyal Customer	58
3097995546	satisfied	Male	Loyal Customer	54
6866920231	dissatisfied	Female	Loyal Customer	25
6030369450	satisfied	Female	Loyal Customer	32
8675588663	dissatisfied	Female	Loyal Customer	52
764728785	satisfied	Female	disloyal Customer	29
8954972101	satisfied	Male	Loyal Customer	56
6772748756	satisfied	Female	Loyal Customer	57
7364216524	satisfied	Female	Loyal Customer	57
3635182357	satisfied	Female	Loyal Customer	48
8252507584	satisfied	Male	Loyal Customer	23
1026982766	dissatisfied	Female	Loyal Customer	49
7107950192	satisfied	Male	disloyal Customer	28
4765014996	dissatisfied	Male	Loyal Customer	36
3342145536	satisfied	Male	Loyal Customer	41
1745349	satisfied	Male	Loyal Customer	16
7273175330	dissatisfied	Male	Loyal Customer	66
1370120631	dissatisfied	Male	Loyal Customer	58
5559553314	satisfied	Female	Loyal Customer	47
6544483657	satisfied	Male	Loyal Customer	61
7011596158	dissatisfied	Male	Loyal Customer	47
6772891759	satisfied	Female	Loyal Customer	53
8116659266	dissatisfied	Male	Loyal Customer	48
3542318601	satisfied	Female	Loyal Customer	59
8511999561	satisfied	Female	Loyal Customer	13
630169679	dissatisfied	Male	disloyal Customer	49
85303617	satisfied	Male	Loyal Customer	58
8080870126	satisfied	Female	Loyal Customer	51
3755842338	dissatisfied	Female	disloyal Customer	23
2295465854	satisfied	Female	Loyal Customer	49
4245607929	dissatisfied	Female	Loyal Customer	20
7859943808	dissatisfied	Female	disloyal Customer	39
2765289085	satisfied	Female	Loyal Customer	48
4278618557	satisfied	Male	Loyal Customer	24
5657976071	satisfied	Female	Loyal Customer	43
9384205645	dissatisfied	Male	Loyal Customer	49
544834528	dissatisfied	Male	Loyal Customer	23
6365326222	dissatisfied	Male	disloyal Customer	20
7686012334	satisfied	Male	Loyal Customer	30
1564396952	dissatisfied	Male	Loyal Customer	77
2279938743	dissatisfied	Male	Loyal Customer	36
8140620813	satisfied	Female	Loyal Customer	44
9257239781	dissatisfied	Male	disloyal Customer	36
5829268568	satisfied	Male	Loyal Customer	80
7140936574	dissatisfied	Male	Loyal Customer	46
6055541445	satisfied	Female	Loyal Customer	35
6856343851	dissatisfied	Female	Loyal Customer	61
1989394243	satisfied	Female	Loyal Customer	61
7497108600	dissatisfied	Male	Loyal Customer	44
5324130395	satisfied	Male	Loyal Customer	21
6259021260	dissatisfied	Male	disloyal Customer	57
6849694832	satisfied	Male	Loyal Customer	58
9542445779	dissatisfied	Male	Loyal Customer	25
2536676370	satisfied	Female	Loyal Customer	62
3392878429	dissatisfied	Male	Loyal Customer	42
207310663	satisfied	Male	Loyal Customer	47
6808774590	dissatisfied	Female	disloyal Customer	29
5582658715	dissatisfied	Male	Loyal Customer	9
8109611094	satisfied	Male	Loyal Customer	80
2489626224	dissatisfied	Male	disloyal Customer	32
2811332014	satisfied	Female	Loyal Customer	55
7198591092	satisfied	Female	Loyal Customer	43
3262369338	satisfied	Male	Loyal Customer	52
4128658175	dissatisfied	Female	disloyal Customer	17
6709734767	satisfied	Female	Loyal Customer	40
326266595	dissatisfied	Female	Loyal Customer	44
2215922557	satisfied	Male	Loyal Customer	41
2290450397	satisfied	Male	Loyal Customer	41
2467774707	satisfied	Female	Loyal Customer	57
7650555895	dissatisfied	Male	Loyal Customer	51
5364307705	satisfied	Female	Loyal Customer	40
1115708092	satisfied	Male	Loyal Customer	43
7066161500	dissatisfied	Male	Loyal Customer	54
6903458379	satisfied	Female	Loyal Customer	45
2651489583	satisfied	Female	Loyal Customer	54
5534060462	dissatisfied	Male	Loyal Customer	25
1527165464	dissatisfied	Female	Loyal Customer	29
1051084909	satisfied	Female	Loyal Customer	37
8616037931	satisfied	Female	Loyal Customer	26
8557326046	satisfied	Female	Loyal Customer	70
1662000481	dissatisfied	Male	Loyal Customer	34
2432012911	dissatisfied	Male	Loyal Customer	64
6723926887	dissatisfied	Male	Loyal Customer	46
3608388798	dissatisfied	Female	disloyal Customer	40
7140268929	satisfied	Female	Loyal Customer	54
8851001440	satisfied	Male	Loyal Customer	28
3802843058	dissatisfied	Male	Loyal Customer	11
7953226769	dissatisfied	Male	Loyal Customer	43
4046519379	satisfied	Female	Loyal Customer	54
7906253170	satisfied	Female	Loyal Customer	17
3499600919	dissatisfied	Female	Loyal Customer	25
7634557379	dissatisfied	Male	Loyal Customer	47
3040999771	dissatisfied	Male	Loyal Customer	64
\.


--
-- TOC entry 4925 (class 0 OID 17307)
-- Dependencies: 226
-- Data for Name: dim_seat; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_seat (aircraft_code, seat_no, fare_conditions) FROM stdin;
733	2A	Business
320	2C	Business
CN1	2D	Business
321	2F	Business
733	3A	Business
SU9	3C	Business
733	3D	Business
CN1	3F	Comfort
321	4A	Business
320	4C	Business
CN1	4D	Business
CN1	4F	Business
SU9	5A	Business
319	5C	Comfort
321	5D	Business
763	5F	Business
CN1	6A	Business
319	6B	Business
763	6C	Business
321	6D	Business
773	6E	Business
319	6F	Business
CR2	7A	Business
773	7B	Business
SU9	7C	Business
733	7D	Business
320	7E	Comfort
CR2	7F	Business
SU9	8A	Business
321	8B	Comfort
SU9	8C	Business
733	8D	Business
321	8F	Business
CR2	9A	Business
733	9B	Comfort
763	9C	Business
320	9D	Business
CR2	9E	Business
763	9F	Comfort
CR2	10A	Business
321	10B	Business
763	10C	Business
320	10D	Business
733	10E	Business
CN1	10F	Business
SU9	11A	Business
773	11B	Business
320	17D	Business
763	17E	Economy
CN1	17F	Economy
320	18A	Economy
763	18B	Economy
319	18C	Economy
319	18D	Economy
320	18E	Comfort
319	18F	Economy
763	19A	Economy
763	19B	Economy
320	19C	Economy
CN1	19D	Comfort
733	20E	Economy
CR2	20F	Economy
CN1	21A	Economy
321	21B	Economy
763	21C	Economy
321	21D	Economy
CN1	21E	Comfort
CR2	21F	Economy
CR2	1A	Economy
773	1C	Economy
CR2	1D	Economy
733	1F	Economy
CR2	2A	Economy
CN1	2C	Economy
773	2D	Economy
CN1	8E	Economy
CN1	2F	Economy
SU9	3A	Economy
773	3C	Economy
CN1	3D	Economy
SU9	3F	Economy
SU9	4A	Economy
773	4C	Economy
321	4D	Economy
733	4F	Economy
CR2	5A	Economy
733	5C	Economy
CR2	5D	Economy
CN1	5F	Economy
763	6A	Economy
773	6B	Comfort
733	6C	Economy
733	6D	Economy
CN1	6E	Economy
321	6F	Economy
SU9	7A	Economy
CN1	7B	Comfort
319	7C	Comfort
SU9	7D	Economy
773	7E	Comfort
\.


--
-- TOC entry 4927 (class 0 OID 17551)
-- Dependencies: 228
-- Data for Name: fact_airlines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fact_airlines (passenger_id, satisfaction, gender, customer_type, age, fare_conditions, flight_distance, seat_comfort, seat_no, departure_arrival_time_convenient, food_and_drink, gate_location, inflight_wifi_service, inflight_entertainment, online_support, ease_of_online_booking, onboard_service, leg_room_service, baggage_handling, checkin_service, cleanliness, online_boarding, departure_delay_minutes, arrival_delay_minutes, aircraft_code, model, range, flight_id, ticket_price) FROM stdin;
\.


--
-- TOC entry 4917 (class 0 OID 16572)
-- Dependencies: 218
-- Data for Name: flights; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flights (flight_id, aircraft_code) FROM stdin;
13113	319
29272	CR2
5502	763
23695	SU9
27580	CR2
24705	CR2
23780	733
30625	CR2
16837	CN1
24836	CN1
39	CR2
19807	321
\.


--
-- TOC entry 4918 (class 0 OID 16580)
-- Dependencies: 219
-- Data for Name: seats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.seats (aircraft_code, seat_no, fare_conditions) FROM stdin;
733	2A	Business
320	2C	Business
CN1	2D	Business
321	2F	Business
733	3A	Business
SU9	3C	Business
733	3D	Business
CN1	3F	Comfort
321	4A	Business
320	4C	Business
CN1	4D	Business
CN1	4F	Business
SU9	5A	Business
319	5C	Comfort
321	5D	Business
763	5F	Business
CN1	6A	Business
319	6B	Business
763	6C	Business
321	6D	Business
773	6E	Business
319	6F	Business
CR2	7A	Business
773	7B	Business
SU9	7C	Business
733	7D	Business
320	7E	Comfort
CR2	7F	Business
SU9	8A	Business
321	8B	Comfort
SU9	8C	Business
733	8D	Business
321	8F	Business
CR2	9A	Business
733	9B	Comfort
763	9C	Business
320	9D	Business
CR2	9E	Business
763	9F	Comfort
CR2	10A	Business
321	10B	Business
763	10C	Business
320	10D	Business
733	10E	Business
CN1	10F	Business
SU9	11A	Business
773	11B	Business
320	17D	Business
763	17E	Economy
CN1	17F	Economy
320	18A	Economy
763	18B	Economy
319	18C	Economy
319	18D	Economy
320	18E	Comfort
319	18F	Economy
763	19A	Economy
763	19B	Economy
320	19C	Economy
CN1	19D	Comfort
733	20E	Economy
CR2	20F	Economy
CN1	21A	Economy
321	21B	Economy
763	21C	Economy
321	21D	Economy
CN1	21E	Comfort
CR2	21F	Economy
CR2	1A	Economy
773	1C	Economy
CR2	1D	Economy
733	1F	Economy
CR2	2A	Economy
CN1	2C	Economy
773	2D	Economy
CN1	8E	Economy
CN1	2F	Economy
SU9	3A	Economy
773	3C	Economy
CN1	3D	Economy
SU9	3F	Economy
SU9	4A	Economy
773	4C	Economy
321	4D	Economy
733	4F	Economy
CR2	5A	Economy
733	5C	Economy
CR2	5D	Economy
CN1	5F	Economy
763	6A	Economy
773	6B	Comfort
733	6C	Economy
733	6D	Economy
CN1	6E	Economy
321	6F	Economy
SU9	7A	Economy
CN1	7B	Comfort
319	7C	Comfort
SU9	7D	Economy
773	7E	Comfort
\.


--
-- TOC entry 4919 (class 0 OID 16588)
-- Dependencies: 220
-- Data for Name: ticket_prices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ticket_prices (flight_id, fare_conditions, ticket_price) FROM stdin;
13113	Business	42100
29272	Business	42100
13113	Business	42100
5502	Business	42100
23695	Business	42100
27580	Comfort	23900
24705	Comfort	23900
23780	Comfort	23900
13113	Comfort	23900
30625	Comfort	23900
16837	Comfort	23900
13113	Comfort	23900
13113	Comfort	23900
23695	Comfort	23900
29272	Comfort	23900
16837	Comfort	23900
16837	Comfort	23900
24836	Comfort	23900
39	Economy	14000
29272	Economy	14000
27580	Economy	14000
23780	Economy	14000
23780	Economy	14000
13113	Economy	14000
27580	Economy	14000
16837	Economy	14000
23780	Economy	14000
24705	Economy	14000
5502	Economy	15400
24705	Economy	14000
13113	Economy	14000
27580	Economy	14000
29272	Economy	14000
39	Economy	14000
39	Economy	14000
30625	Economy	14000
30625	Economy	14000
23695	Economy	14000
16837	Economy	14000
23695	Economy	14000
5502	Economy	14000
16837	Economy	14000
16837	Economy	14000
24836	Economy	14000
23780	Economy	14000
39	Economy	14000
19807	Economy	14000
16837	Economy	14000
13113	Economy	14000
30625	Economy	14000
19807	Economy	14000
39	Economy	14000
5502	Economy	14000
27580	Economy	14000
19807	Economy	14000
24836	Economy	14000
16837	Economy	14000
30625	Economy	14000
27580	Economy	14000
30625	Economy	14000
24705	Economy	14000
30625	Economy	14000
24836	Economy	14000
16837	Economy	14000
23695	Economy	14000
30625	Economy	14000
19807	Economy	15400
27580	Economy	15400
19807	Economy	14000
24836	Economy	14000
30625	Economy	14000
16837	Economy	14000
24836	Economy	14000
24836	Economy	14000
13113	Economy	14000
16837	Economy	14000
13113	Economy	14000
23780	Economy	14000
30625	Economy	14000
29272	Economy	14000
30625	Economy	14000
39	Economy	14000
19807	Economy	14000
39	Economy	14000
30625	Economy	14000
16837	Economy	14000
23695	Economy	14000
23780	Economy	14000
24705	Economy	14000
16837	Economy	14000
24836	Economy	14000
39	Economy	14000
24836	Business	9800
23780	Business	9800
19807	Business	9800
5502	Business	9800
13113	Business	9800
13113	Business	9800
19807	Economy	3300
24705	Economy	3300
\.


--
-- TOC entry 4920 (class 0 OID 16591)
-- Dependencies: 221
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tickets (ticket_no, book_ref, passenger_id) FROM stdin;
5432000987	06B046	8149 604011
5432000988	06B046	8499 420203
5432000989	E170C3	1011 752484
5432000990	E170C3	4849 400049
5432000991	F313DD	6615 976589
5432000992	F313DD	2021 652719
5432000993	F313DD	0817 363231
5432000994	CCC5CB	2883 989356
5432000995	CCC5CB	3097 995546
5432000996	1FB1E4	6866 920231
5432000997	DE3EA6	6030 369450
5432000998	4B75D1	8675 588663
5432000999	9E60AA	0764 728785
5432001000	69DAD1	8954 972101
5432001001	69DAD1	6772 748756
5432001002	69DAD1	7364 216524
5432001003	08A2A5	3635 182357
5432001004	08A2A5	8252 507584
5432001005	C2CAB7	1026 982766
5432001006	C6DA66	7107 950192
5432001007	C6DA66	4765 014996
5432001008	3EFFCA	3342 145536
5432001009	7E0F14	0001 745349
5432001010	63126E	7273 175330
5432001011	285BC5	1370 120631
5432001012	232788	5559 553314
5432001013	EE82FC	6544 483657
5432001014	C3B60B	7011 596158
5432001015	C3B60B	6772 891759
5432001016	7DC7C4	8116 659266
5432001017	7DC7C4	3542 318601
5432001018	36AA7A	8511 999561
5432001019	F11350	0630 169679
5432001020	82DB02	0085 303617
5432001021	82DB02	8080 870126
5432001022	572A29	3755 842338
5432001023	572A29	2295 465854
5432001024	572A29	4245 607929
5432001025	31F31A	7859 943808
5432001026	F5F784	2765 289085
5432001027	F5F784	4278 618557
5432001028	598886	5657 976071
5432001029	598886	9384 205645
5432001030	18C1D5	0544 834528
5432001031	EA4481	6365 326222
5432001032	EA4481	7686 012334
5432001033	94A438	1564 396952
5432001034	0C3F23	2279 938743
5432001035	0C3F23	8140 620813
5432001036	F1AF5B	9257 239781
5432001037	2EAC25	5829 268568
5432001038	7C4EB0	7140 936574
5432001039	47F326	6055 541445
5432001040	47F326	6856 343851
5432001041	750FC5	1989 394243
5432001042	750FC5	7497 108600
5432001043	4109DE	5324 130395
5432001044	D067BC	6259 021260
5432001045	D067BC	6849 694832
5432001046	FE0198	9542 445779
5432001047	FE0198	2536 676370
5432001048	EA9B0F	3392 878429
5432001049	6D004A	0207 310663
5432001050	6D004A	6808 774590
5432001051	8E6BB3	5582 658715
5432001052	8E6BB3	8109 611094
5432001053	D8094E	2489 626224
5432001054	7E76A9	2811 332014
5432001055	4A1A3A	7198 591092
5432001056	90FF45	3262 369338
5432001057	FDE044	4128 658175
5432001058	FDE044	6709 734767
5432001059	88411C	0326 266595
5432001060	D0B9CE	2215 922557
5432001061	D0B9CE	2290 450397
5432001062	D0B9CE	2467 774707
5432001063	ACCA92	7650 555895
5432001064	4FAEB6	5364 307705
5432001065	EC1E8B	1115 708092
5432001066	EC1E8B	7066 161500
5432001067	717CED	6903 458379
5432001068	717CED	2651 489583
5432001069	5C9140	5534 060462
5432001070	AA2140	1527 165464
5432001071	4DC130	1051 084909
5432001072	378E67	8616 037931
5432001073	7B4620	8557 326046
5432001074	7327C3	1662 000481
5432001075	7327C3	2432 012911
5432001076	B0EEAB	6723 926887
5432001077	9C6646	3608 388798
5432001078	9C6646	7140 268929
5432001079	9C6646	8851 001440
5432001080	12C67A	3802 843058
5432002040	763A73	7953 226769
5432002041	460AAE	4046 519379
5432002042	29182D	7906 253170
5432002043	E5546D	3499 600919
5432002044	BE9453	7634 557379
5432002045	BE9453	3040 999771
\.


--
-- TOC entry 4935 (class 0 OID 0)
-- Dependencies: 223
-- Name: dim_flight_flight_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_flight_flight_id_seq', 1, false);


--
-- TOC entry 4737 (class 2606 OID 16563)
-- Name: aircraft aircraft_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aircraft
    ADD CONSTRAINT aircraft_pkey PRIMARY KEY (aircraft_code);


--
-- TOC entry 4735 (class 2606 OID 17392)
-- Name: customers_satisfaction customers_satisfaction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers_satisfaction
    ADD CONSTRAINT customers_satisfaction_pkey PRIMARY KEY (passenger_id);


--
-- TOC entry 4755 (class 2606 OID 17299)
-- Name: dim_aircraft dim_aircraft_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_aircraft
    ADD CONSTRAINT dim_aircraft_pkey PRIMARY KEY (model);


--
-- TOC entry 4757 (class 2606 OID 17319)
-- Name: dim_customersatisfaction dim_customersatisfaction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_customersatisfaction
    ADD CONSTRAINT dim_customersatisfaction_pkey PRIMARY KEY (passenger_id);


--
-- TOC entry 4753 (class 2606 OID 17292)
-- Name: dim_flight dim_flight_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_flight
    ADD CONSTRAINT dim_flight_pkey PRIMARY KEY (flight_id);


--
-- TOC entry 4751 (class 2606 OID 17278)
-- Name: dim_passenger dim_passenger_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_passenger
    ADD CONSTRAINT dim_passenger_pkey PRIMARY KEY (passenger_id);


--
-- TOC entry 4759 (class 2606 OID 17557)
-- Name: fact_airlines fact_airlines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_airlines
    ADD CONSTRAINT fact_airlines_pkey PRIMARY KEY (passenger_id);


--
-- TOC entry 4739 (class 2606 OID 17123)
-- Name: flights flights_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flights
    ADD CONSTRAINT flights_pkey PRIMARY KEY (flight_id);


--
-- TOC entry 4741 (class 2606 OID 16660)
-- Name: flights flights_unique_flight_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flights
    ADD CONSTRAINT flights_unique_flight_id UNIQUE (flight_id);


--
-- TOC entry 4745 (class 2606 OID 16595)
-- Name: tickets tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (ticket_no);


--
-- TOC entry 4743 (class 2606 OID 17125)
-- Name: flights unique_flight_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flights
    ADD CONSTRAINT unique_flight_id UNIQUE (flight_id);


--
-- TOC entry 4747 (class 2606 OID 17145)
-- Name: tickets unique_passenger_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT unique_passenger_id UNIQUE (passenger_id);


--
-- TOC entry 4749 (class 2606 OID 17141)
-- Name: tickets unique_ticket_no; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT unique_ticket_no UNIQUE (ticket_no);


--
-- TOC entry 4769 (class 2606 OID 17568)
-- Name: fact_airlines fact_airlines_aircraft_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_airlines
    ADD CONSTRAINT fact_airlines_aircraft_code_fkey FOREIGN KEY (aircraft_code) REFERENCES public.aircraft(aircraft_code);


--
-- TOC entry 4770 (class 2606 OID 17563)
-- Name: fact_airlines fact_airlines_flight_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_airlines
    ADD CONSTRAINT fact_airlines_flight_id_fkey FOREIGN KEY (flight_id) REFERENCES public.flights(flight_id);


--
-- TOC entry 4771 (class 2606 OID 17558)
-- Name: fact_airlines fact_airlines_passenger_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact_airlines
    ADD CONSTRAINT fact_airlines_passenger_id_fkey FOREIGN KEY (passenger_id) REFERENCES public.customers_satisfaction(passenger_id);


--
-- TOC entry 4760 (class 2606 OID 17112)
-- Name: customers_satisfaction fk_customers_satisfaction_flights; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers_satisfaction
    ADD CONSTRAINT fk_customers_satisfaction_flights FOREIGN KEY (flight_id) REFERENCES public.flights(flight_id);


--
-- TOC entry 4761 (class 2606 OID 17117)
-- Name: flights fk_flights_aircraft; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flights
    ADD CONSTRAINT fk_flights_aircraft FOREIGN KEY (aircraft_code) REFERENCES public.aircraft(aircraft_code);


--
-- TOC entry 4762 (class 2606 OID 17126)
-- Name: flights fk_flights_aircraft_data; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flights
    ADD CONSTRAINT fk_flights_aircraft_data FOREIGN KEY (aircraft_code) REFERENCES public.aircraft(aircraft_code);


--
-- TOC entry 4767 (class 2606 OID 17151)
-- Name: tickets fk_other_table_tickets; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT fk_other_table_tickets FOREIGN KEY (passenger_id) REFERENCES public.tickets(passenger_id);


--
-- TOC entry 4765 (class 2606 OID 17156)
-- Name: ticket_prices fk_ticket_price_flights; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket_prices
    ADD CONSTRAINT fk_ticket_price_flights FOREIGN KEY (flight_id) REFERENCES public.flights(flight_id);


--
-- TOC entry 4766 (class 2606 OID 17133)
-- Name: ticket_prices fk_ticketflights_flights; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket_prices
    ADD CONSTRAINT fk_ticketflights_flights FOREIGN KEY (flight_id) REFERENCES public.flights(flight_id);


--
-- TOC entry 4768 (class 2606 OID 17146)
-- Name: tickets fk_tickets; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT fk_tickets FOREIGN KEY (ticket_no) REFERENCES public.tickets(ticket_no);


--
-- TOC entry 4763 (class 2606 OID 16575)
-- Name: flights flights_aircraft_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flights
    ADD CONSTRAINT flights_aircraft_code_fkey FOREIGN KEY (aircraft_code) REFERENCES public.aircraft(aircraft_code);


--
-- TOC entry 4764 (class 2606 OID 16583)
-- Name: seats seats_aircraft_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seats
    ADD CONSTRAINT seats_aircraft_code_fkey FOREIGN KEY (aircraft_code) REFERENCES public.aircraft(aircraft_code);


-- Completed on 2024-01-21 16:55:35

--
-- PostgreSQL database dump complete
--

