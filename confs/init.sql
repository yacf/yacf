--
-- PostgreSQL database dump
--

-- Dumped from database version 12.1 (Debian 12.1-1.pgdg100+1)
-- Dumped by pg_dump version 12.1 (Debian 12.1-1.pgdg100+1)

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

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO django;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO django;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO django;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO django;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO django;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO django;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO django;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO django;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO django;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO django;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO django;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO django;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: categories_category; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.categories_category (
    id integer NOT NULL,
    name character varying(25) NOT NULL,
    description character varying(1000) NOT NULL,
    hidden boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.categories_category OWNER TO django;

--
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_category_id_seq OWNER TO django;

--
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories_category.id;


--
-- Name: categories_category_logs; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.categories_category_logs (
    id integer NOT NULL,
    category_id integer NOT NULL,
    log_id integer NOT NULL
);


ALTER TABLE public.categories_category_logs OWNER TO django;

--
-- Name: categories_category_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.categories_category_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_category_logs_id_seq OWNER TO django;

--
-- Name: categories_category_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.categories_category_logs_id_seq OWNED BY public.categories_category_logs.id;


--
-- Name: challenges_challenge; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.challenges_challenge (
    id integer NOT NULL,
    name character varying(25) NOT NULL,
    description character varying(1000) NOT NULL,
    points integer NOT NULL,
    encoded boolean NOT NULL,
    hidden boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.challenges_challenge OWNER TO django;

--
-- Name: challenges_challenge_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.challenges_challenge_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.challenges_challenge_id_seq OWNER TO django;

--
-- Name: challenges_challenge_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.challenges_challenge_id_seq OWNED BY public.challenges_challenge.id;


--
-- Name: challenges_flag; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.challenges_flag (
    id integer NOT NULL,
    value character varying(100) NOT NULL,
    algorithm_id integer,
    challenge_id integer NOT NULL
);


ALTER TABLE public.challenges_flag OWNER TO django;

--
-- Name: challenges_flag_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.challenges_flag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.challenges_flag_id_seq OWNER TO django;

--
-- Name: challenges_flag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.challenges_flag_id_seq OWNED BY public.challenges_flag.id;


--
-- Name: challenges_hash; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.challenges_hash (
    id integer NOT NULL,
    value character varying(10) NOT NULL
);


ALTER TABLE public.challenges_hash OWNER TO django;

--
-- Name: challenges_hash_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.challenges_hash_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.challenges_hash_id_seq OWNER TO django;

--
-- Name: challenges_hash_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.challenges_hash_id_seq OWNED BY public.challenges_hash.id;


--
-- Name: challenges_hint; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.challenges_hint (
    id integer NOT NULL,
    title character varying(25) NOT NULL,
    description character varying(1000) NOT NULL,
    hidden boolean NOT NULL,
    challenge_id integer NOT NULL
);


ALTER TABLE public.challenges_hint OWNER TO django;

--
-- Name: challenges_hint_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.challenges_hint_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.challenges_hint_id_seq OWNER TO django;

--
-- Name: challenges_hint_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.challenges_hint_id_seq OWNED BY public.challenges_hint.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO django;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO django;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO django;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO django;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO django;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO django;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO django;

--
-- Name: index_welcomepage; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.index_welcomepage (
    id integer NOT NULL,
    content character varying(2000) NOT NULL
);


ALTER TABLE public.index_welcomepage OWNER TO django;

--
-- Name: index_welcomepage_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.index_welcomepage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.index_welcomepage_id_seq OWNER TO django;

--
-- Name: index_welcomepage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.index_welcomepage_id_seq OWNED BY public.index_welcomepage.id;


--
-- Name: logs_log; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.logs_log (
    id integer NOT NULL,
    action character varying(2) NOT NULL,
    category character varying(2) NOT NULL,
    "time" timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.logs_log OWNER TO django;

--
-- Name: logs_log_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.logs_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.logs_log_id_seq OWNER TO django;

--
-- Name: logs_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.logs_log_id_seq OWNED BY public.logs_log.id;


--
-- Name: logs_logintracker; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.logs_logintracker (
    id integer NOT NULL,
    "time" timestamp with time zone NOT NULL,
    address character varying(16) NOT NULL,
    agent character varying(200) NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.logs_logintracker OWNER TO django;

--
-- Name: logs_logintracker_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.logs_logintracker_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.logs_logintracker_id_seq OWNER TO django;

--
-- Name: logs_logintracker_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.logs_logintracker_id_seq OWNED BY public.logs_logintracker.id;


--
-- Name: pages_page; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.pages_page (
    id integer NOT NULL,
    url character varying(15) NOT NULL,
    name character varying(15) NOT NULL,
    content character varying(5000) NOT NULL,
    authenticated boolean NOT NULL
);


ALTER TABLE public.pages_page OWNER TO django;

--
-- Name: pages_page_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.pages_page_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pages_page_id_seq OWNER TO django;

--
-- Name: pages_page_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.pages_page_id_seq OWNED BY public.pages_page.id;


--
-- Name: server_theme; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.server_theme (
    id integer NOT NULL,
    name character varying(25) NOT NULL,
    "primary" character varying(8) NOT NULL,
    secondary character varying(8) NOT NULL,
    foucs character varying(8) NOT NULL,
    accent character varying(8) NOT NULL
);


ALTER TABLE public.server_theme OWNER TO django;

--
-- Name: server_theme_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.server_theme_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.server_theme_id_seq OWNER TO django;

--
-- Name: server_theme_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.server_theme_id_seq OWNED BY public.server_theme.id;


--
-- Name: settings_event; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.settings_event (
    id integer NOT NULL,
    name character varying(25) NOT NULL,
    private boolean NOT NULL,
    start timestamp with time zone NOT NULL,
    "end" timestamp with time zone NOT NULL
);


ALTER TABLE public.settings_event OWNER TO django;

--
-- Name: settings_event_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.settings_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.settings_event_id_seq OWNER TO django;

--
-- Name: settings_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.settings_event_id_seq OWNED BY public.settings_event.id;


--
-- Name: settings_scoreboard; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.settings_scoreboard (
    id integer NOT NULL,
    hidden boolean NOT NULL
);


ALTER TABLE public.settings_scoreboard OWNER TO django;

--
-- Name: settings_scoreboard_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.settings_scoreboard_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.settings_scoreboard_id_seq OWNER TO django;

--
-- Name: settings_scoreboard_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.settings_scoreboard_id_seq OWNED BY public.settings_scoreboard.id;


--
-- Name: settings_team; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.settings_team (
    id integer NOT NULL,
    capacity integer NOT NULL
);


ALTER TABLE public.settings_team OWNER TO django;

--
-- Name: settings_team_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.settings_team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.settings_team_id_seq OWNER TO django;

--
-- Name: settings_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.settings_team_id_seq OWNED BY public.settings_team.id;


--
-- Name: teams_accesscode; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.teams_accesscode (
    id integer NOT NULL,
    value character varying(150) NOT NULL,
    team_id integer NOT NULL
);


ALTER TABLE public.teams_accesscode OWNER TO django;

--
-- Name: teams_accesscode_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.teams_accesscode_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teams_accesscode_id_seq OWNER TO django;

--
-- Name: teams_accesscode_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.teams_accesscode_id_seq OWNED BY public.teams_accesscode.id;


--
-- Name: teams_failure; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.teams_failure (
    id integer NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    challenge_id integer,
    team_id integer NOT NULL,
    user_id integer
);


ALTER TABLE public.teams_failure OWNER TO django;

--
-- Name: teams_failure_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.teams_failure_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teams_failure_id_seq OWNER TO django;

--
-- Name: teams_failure_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.teams_failure_id_seq OWNED BY public.teams_failure.id;


--
-- Name: teams_solvedchallenge; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.teams_solvedchallenge (
    id integer NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    challenge_id integer,
    team_id integer NOT NULL,
    user_id integer
);


ALTER TABLE public.teams_solvedchallenge OWNER TO django;

--
-- Name: teams_solvedchallenge_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.teams_solvedchallenge_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teams_solvedchallenge_id_seq OWNER TO django;

--
-- Name: teams_solvedchallenge_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.teams_solvedchallenge_id_seq OWNED BY public.teams_solvedchallenge.id;


--
-- Name: teams_team; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.teams_team (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    email character varying(50) NOT NULL,
    affiliation character varying(50) NOT NULL,
    website character varying(50) NOT NULL,
    hidden boolean NOT NULL,
    created timestamp with time zone NOT NULL
);


ALTER TABLE public.teams_team OWNER TO django;

--
-- Name: teams_team_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.teams_team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teams_team_id_seq OWNER TO django;

--
-- Name: teams_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.teams_team_id_seq OWNED BY public.teams_team.id;


--
-- Name: uauth_adminregisterkey; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.uauth_adminregisterkey (
    id integer NOT NULL,
    key character varying(32) NOT NULL,
    singleuse boolean NOT NULL,
    expiration timestamp with time zone NOT NULL,
    active boolean NOT NULL
);


ALTER TABLE public.uauth_adminregisterkey OWNER TO django;

--
-- Name: uauth_adminregisterkey_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.uauth_adminregisterkey_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.uauth_adminregisterkey_id_seq OWNER TO django;

--
-- Name: uauth_adminregisterkey_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.uauth_adminregisterkey_id_seq OWNED BY public.uauth_adminregisterkey.id;


--
-- Name: uauth_logintracker; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.uauth_logintracker (
    id integer NOT NULL,
    "time" timestamp with time zone NOT NULL,
    address character varying(16) NOT NULL,
    agent character varying(200) NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.uauth_logintracker OWNER TO django;

--
-- Name: uauth_logintracker_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.uauth_logintracker_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.uauth_logintracker_id_seq OWNER TO django;

--
-- Name: uauth_logintracker_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.uauth_logintracker_id_seq OWNED BY public.uauth_logintracker.id;


--
-- Name: uauth_profile; Type: TABLE; Schema: public; Owner: django
--

CREATE TABLE public.uauth_profile (
    id integer NOT NULL,
    verified boolean NOT NULL,
    hidden boolean NOT NULL,
    team_id integer,
    user_id integer NOT NULL
);


ALTER TABLE public.uauth_profile OWNER TO django;

--
-- Name: uauth_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE public.uauth_profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.uauth_profile_id_seq OWNER TO django;

--
-- Name: uauth_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE public.uauth_profile_id_seq OWNED BY public.uauth_profile.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: categories_category id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.categories_category ALTER COLUMN id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);


--
-- Name: categories_category_logs id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.categories_category_logs ALTER COLUMN id SET DEFAULT nextval('public.categories_category_logs_id_seq'::regclass);


--
-- Name: challenges_challenge id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.challenges_challenge ALTER COLUMN id SET DEFAULT nextval('public.challenges_challenge_id_seq'::regclass);


--
-- Name: challenges_flag id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.challenges_flag ALTER COLUMN id SET DEFAULT nextval('public.challenges_flag_id_seq'::regclass);


--
-- Name: challenges_hash id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.challenges_hash ALTER COLUMN id SET DEFAULT nextval('public.challenges_hash_id_seq'::regclass);


--
-- Name: challenges_hint id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.challenges_hint ALTER COLUMN id SET DEFAULT nextval('public.challenges_hint_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: index_welcomepage id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.index_welcomepage ALTER COLUMN id SET DEFAULT nextval('public.index_welcomepage_id_seq'::regclass);


--
-- Name: logs_log id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.logs_log ALTER COLUMN id SET DEFAULT nextval('public.logs_log_id_seq'::regclass);


--
-- Name: logs_logintracker id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.logs_logintracker ALTER COLUMN id SET DEFAULT nextval('public.logs_logintracker_id_seq'::regclass);


--
-- Name: pages_page id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.pages_page ALTER COLUMN id SET DEFAULT nextval('public.pages_page_id_seq'::regclass);


--
-- Name: server_theme id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.server_theme ALTER COLUMN id SET DEFAULT nextval('public.server_theme_id_seq'::regclass);


--
-- Name: settings_event id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.settings_event ALTER COLUMN id SET DEFAULT nextval('public.settings_event_id_seq'::regclass);


--
-- Name: settings_scoreboard id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.settings_scoreboard ALTER COLUMN id SET DEFAULT nextval('public.settings_scoreboard_id_seq'::regclass);


--
-- Name: settings_team id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.settings_team ALTER COLUMN id SET DEFAULT nextval('public.settings_team_id_seq'::regclass);


--
-- Name: teams_accesscode id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.teams_accesscode ALTER COLUMN id SET DEFAULT nextval('public.teams_accesscode_id_seq'::regclass);


--
-- Name: teams_failure id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.teams_failure ALTER COLUMN id SET DEFAULT nextval('public.teams_failure_id_seq'::regclass);


--
-- Name: teams_solvedchallenge id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.teams_solvedchallenge ALTER COLUMN id SET DEFAULT nextval('public.teams_solvedchallenge_id_seq'::regclass);


--
-- Name: teams_team id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.teams_team ALTER COLUMN id SET DEFAULT nextval('public.teams_team_id_seq'::regclass);


--
-- Name: uauth_adminregisterkey id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.uauth_adminregisterkey ALTER COLUMN id SET DEFAULT nextval('public.uauth_adminregisterkey_id_seq'::regclass);


--
-- Name: uauth_logintracker id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.uauth_logintracker ALTER COLUMN id SET DEFAULT nextval('public.uauth_logintracker_id_seq'::regclass);


--
-- Name: uauth_profile id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.uauth_profile ALTER COLUMN id SET DEFAULT nextval('public.uauth_profile_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add login tracker	7	add_logintracker
26	Can change login tracker	7	change_logintracker
27	Can delete login tracker	7	delete_logintracker
28	Can view login tracker	7	view_logintracker
29	Can add log	8	add_log
30	Can change log	8	change_log
31	Can delete log	8	delete_log
32	Can view log	8	view_log
33	Can add admin register key	9	add_adminregisterkey
34	Can change admin register key	9	change_adminregisterkey
35	Can delete admin register key	9	delete_adminregisterkey
36	Can view admin register key	9	view_adminregisterkey
37	Can add profile	10	add_profile
38	Can change profile	10	change_profile
39	Can delete profile	10	delete_profile
40	Can view profile	10	view_profile
41	Can add login tracker	11	add_logintracker
42	Can change login tracker	11	change_logintracker
43	Can delete login tracker	11	delete_logintracker
44	Can view login tracker	11	view_logintracker
45	Can add theme	12	add_theme
46	Can change theme	12	change_theme
47	Can delete theme	12	delete_theme
48	Can view theme	12	view_theme
49	Can add welcome page	13	add_welcomepage
50	Can change welcome page	13	change_welcomepage
51	Can delete welcome page	13	delete_welcomepage
52	Can view welcome page	13	view_welcomepage
53	Can add page	14	add_page
54	Can change page	14	change_page
55	Can delete page	14	delete_page
56	Can view page	14	view_page
57	Can add team	15	add_team
58	Can change team	15	change_team
59	Can delete team	15	delete_team
60	Can view team	15	view_team
61	Can add solved challenge	16	add_solvedchallenge
62	Can change solved challenge	16	change_solvedchallenge
63	Can delete solved challenge	16	delete_solvedchallenge
64	Can view solved challenge	16	view_solvedchallenge
65	Can add failure	17	add_failure
66	Can change failure	17	change_failure
67	Can delete failure	17	delete_failure
68	Can view failure	17	view_failure
69	Can add access code	18	add_accesscode
70	Can change access code	18	change_accesscode
71	Can delete access code	18	delete_accesscode
72	Can view access code	18	view_accesscode
73	Can add event	19	add_event
74	Can change event	19	change_event
75	Can delete event	19	delete_event
76	Can view event	19	view_event
77	Can add scoreboard	20	add_scoreboard
78	Can change scoreboard	20	change_scoreboard
79	Can delete scoreboard	20	delete_scoreboard
80	Can view scoreboard	20	view_scoreboard
81	Can add team	21	add_team
82	Can change team	21	change_team
83	Can delete team	21	delete_team
84	Can view team	21	view_team
85	Can add category	22	add_category
86	Can change category	22	change_category
87	Can delete category	22	delete_category
88	Can view category	22	view_category
89	Can add challenge	23	add_challenge
90	Can change challenge	23	change_challenge
91	Can delete challenge	23	delete_challenge
92	Can view challenge	23	view_challenge
93	Can add hash	24	add_hash
94	Can change hash	24	change_hash
95	Can delete hash	24	delete_hash
96	Can view hash	24	view_hash
97	Can add hint	25	add_hint
98	Can change hint	25	change_hint
99	Can delete hint	25	delete_hint
100	Can view hint	25	view_hint
101	Can add flag	26	add_flag
102	Can change flag	26	change_flag
103	Can delete flag	26	delete_flag
104	Can view flag	26	view_flag
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$150000$KLvVR4qZJdCI$qE8Un7JYS5ln+YdH+K11GREM2CMyyRYo3hErZzJ4pX8=	\N	t	admin	Admin		email@email.com	t	t	2020-01-25 15:26:00.124685+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: categories_category; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.categories_category (id, name, description, hidden, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: categories_category_logs; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.categories_category_logs (id, category_id, log_id) FROM stdin;
\.


--
-- Data for Name: challenges_challenge; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.challenges_challenge (id, name, description, points, encoded, hidden, created_at, updated_at, category_id) FROM stdin;
\.


--
-- Data for Name: challenges_flag; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.challenges_flag (id, value, algorithm_id, challenge_id) FROM stdin;
\.


--
-- Data for Name: challenges_hash; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.challenges_hash (id, value) FROM stdin;
\.


--
-- Data for Name: challenges_hint; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.challenges_hint (id, title, description, hidden, challenge_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	logs	logintracker
8	logs	log
9	uauth	adminregisterkey
10	uauth	profile
11	uauth	logintracker
12	server	theme
13	index	welcomepage
14	pages	page
15	teams	team
16	teams	solvedchallenge
17	teams	failure
18	teams	accesscode
19	settings	event
20	settings	scoreboard
21	settings	team
22	categories	category
23	challenges	challenge
24	challenges	hash
25	challenges	hint
26	challenges	flag
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2020-01-25 15:25:59.206507+00
2	auth	0001_initial	2020-01-25 15:25:59.247285+00
3	admin	0001_initial	2020-01-25 15:25:59.332793+00
4	admin	0002_logentry_remove_auto_add	2020-01-25 15:25:59.353669+00
5	admin	0003_logentry_add_action_flag_choices	2020-01-25 15:25:59.364545+00
6	contenttypes	0002_remove_content_type_name	2020-01-25 15:25:59.387851+00
7	auth	0002_alter_permission_name_max_length	2020-01-25 15:25:59.396958+00
8	auth	0003_alter_user_email_max_length	2020-01-25 15:25:59.411411+00
9	auth	0004_alter_user_username_opts	2020-01-25 15:25:59.42348+00
10	auth	0005_alter_user_last_login_null	2020-01-25 15:25:59.436908+00
11	auth	0006_require_contenttypes_0002	2020-01-25 15:25:59.441676+00
12	auth	0007_alter_validators_add_error_messages	2020-01-25 15:25:59.453638+00
13	auth	0008_alter_user_username_max_length	2020-01-25 15:25:59.470897+00
14	auth	0009_alter_user_last_name_max_length	2020-01-25 15:25:59.483862+00
15	auth	0010_alter_group_name_max_length	2020-01-25 15:25:59.495254+00
16	auth	0011_update_proxy_permissions	2020-01-25 15:25:59.506684+00
17	logs	0001_initial	2020-01-25 15:25:59.535517+00
18	categories	0001_initial	2020-01-25 15:25:59.565116+00
19	challenges	0001_initial	2020-01-25 15:25:59.639382+00
20	index	0001_initial	2020-01-25 15:25:59.665074+00
21	pages	0001_initial	2020-01-25 15:25:59.679097+00
22	server	0001_initial	2020-01-25 15:25:59.695229+00
23	sessions	0001_initial	2020-01-25 15:25:59.709891+00
24	settings	0001_initial	2020-01-25 15:25:59.752687+00
25	teams	0001_initial	2020-01-25 15:25:59.818222+00
26	uauth	0001_initial	2020-01-25 15:25:59.884144+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
\.


--
-- Data for Name: index_welcomepage; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.index_welcomepage (id, content) FROM stdin;
\.


--
-- Data for Name: logs_log; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.logs_log (id, action, category, "time", user_id) FROM stdin;
\.


--
-- Data for Name: logs_logintracker; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.logs_logintracker (id, "time", address, agent, user_id) FROM stdin;
\.


--
-- Data for Name: pages_page; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.pages_page (id, url, name, content, authenticated) FROM stdin;
\.


--
-- Data for Name: server_theme; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.server_theme (id, name, "primary", secondary, foucs, accent) FROM stdin;
\.


--
-- Data for Name: settings_event; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.settings_event (id, name, private, start, "end") FROM stdin;
\.


--
-- Data for Name: settings_scoreboard; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.settings_scoreboard (id, hidden) FROM stdin;
\.


--
-- Data for Name: settings_team; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.settings_team (id, capacity) FROM stdin;
\.


--
-- Data for Name: teams_accesscode; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.teams_accesscode (id, value, team_id) FROM stdin;
\.


--
-- Data for Name: teams_failure; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.teams_failure (id, "timestamp", challenge_id, team_id, user_id) FROM stdin;
\.


--
-- Data for Name: teams_solvedchallenge; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.teams_solvedchallenge (id, "timestamp", challenge_id, team_id, user_id) FROM stdin;
\.


--
-- Data for Name: teams_team; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.teams_team (id, name, email, affiliation, website, hidden, created) FROM stdin;
\.


--
-- Data for Name: uauth_adminregisterkey; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.uauth_adminregisterkey (id, key, singleuse, expiration, active) FROM stdin;
\.


--
-- Data for Name: uauth_logintracker; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.uauth_logintracker (id, "time", address, agent, user_id) FROM stdin;
\.


--
-- Data for Name: uauth_profile; Type: TABLE DATA; Schema: public; Owner: django
--

COPY public.uauth_profile (id, verified, hidden, team_id, user_id) FROM stdin;
1	t	t	\N	1
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 104, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 1, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.categories_category_id_seq', 1, false);


--
-- Name: categories_category_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.categories_category_logs_id_seq', 1, false);


--
-- Name: challenges_challenge_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.challenges_challenge_id_seq', 1, false);


--
-- Name: challenges_flag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.challenges_flag_id_seq', 1, false);


--
-- Name: challenges_hash_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.challenges_hash_id_seq', 1, false);


--
-- Name: challenges_hint_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.challenges_hint_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 26, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 26, true);


--
-- Name: index_welcomepage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.index_welcomepage_id_seq', 1, false);


--
-- Name: logs_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.logs_log_id_seq', 1, false);


--
-- Name: logs_logintracker_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.logs_logintracker_id_seq', 1, false);


--
-- Name: pages_page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.pages_page_id_seq', 1, false);


--
-- Name: server_theme_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.server_theme_id_seq', 1, false);


--
-- Name: settings_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.settings_event_id_seq', 1, false);


--
-- Name: settings_scoreboard_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.settings_scoreboard_id_seq', 1, false);


--
-- Name: settings_team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.settings_team_id_seq', 1, false);


--
-- Name: teams_accesscode_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.teams_accesscode_id_seq', 1, false);


--
-- Name: teams_failure_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.teams_failure_id_seq', 1, false);


--
-- Name: teams_solvedchallenge_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.teams_solvedchallenge_id_seq', 1, false);


--
-- Name: teams_team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.teams_team_id_seq', 1, false);


--
-- Name: uauth_adminregisterkey_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.uauth_adminregisterkey_id_seq', 1, false);


--
-- Name: uauth_logintracker_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.uauth_logintracker_id_seq', 1, false);


--
-- Name: uauth_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('public.uauth_profile_id_seq', 1, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: categories_category_logs categories_category_logs_category_id_log_id_30be24ee_uniq; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.categories_category_logs
    ADD CONSTRAINT categories_category_logs_category_id_log_id_30be24ee_uniq UNIQUE (category_id, log_id);


--
-- Name: categories_category_logs categories_category_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.categories_category_logs
    ADD CONSTRAINT categories_category_logs_pkey PRIMARY KEY (id);


--
-- Name: categories_category categories_category_name_key; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.categories_category
    ADD CONSTRAINT categories_category_name_key UNIQUE (name);


--
-- Name: categories_category categories_category_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.categories_category
    ADD CONSTRAINT categories_category_pkey PRIMARY KEY (id);


--
-- Name: challenges_challenge challenges_challenge_name_key; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.challenges_challenge
    ADD CONSTRAINT challenges_challenge_name_key UNIQUE (name);


--
-- Name: challenges_challenge challenges_challenge_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.challenges_challenge
    ADD CONSTRAINT challenges_challenge_pkey PRIMARY KEY (id);


--
-- Name: challenges_flag challenges_flag_challenge_id_key; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.challenges_flag
    ADD CONSTRAINT challenges_flag_challenge_id_key UNIQUE (challenge_id);


--
-- Name: challenges_flag challenges_flag_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.challenges_flag
    ADD CONSTRAINT challenges_flag_pkey PRIMARY KEY (id);


--
-- Name: challenges_hash challenges_hash_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.challenges_hash
    ADD CONSTRAINT challenges_hash_pkey PRIMARY KEY (id);


--
-- Name: challenges_hint challenges_hint_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.challenges_hint
    ADD CONSTRAINT challenges_hint_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: index_welcomepage index_welcomepage_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.index_welcomepage
    ADD CONSTRAINT index_welcomepage_pkey PRIMARY KEY (id);


--
-- Name: logs_log logs_log_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.logs_log
    ADD CONSTRAINT logs_log_pkey PRIMARY KEY (id);


--
-- Name: logs_logintracker logs_logintracker_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.logs_logintracker
    ADD CONSTRAINT logs_logintracker_pkey PRIMARY KEY (id);


--
-- Name: pages_page pages_page_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.pages_page
    ADD CONSTRAINT pages_page_pkey PRIMARY KEY (id);


--
-- Name: pages_page pages_page_url_key; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.pages_page
    ADD CONSTRAINT pages_page_url_key UNIQUE (url);


--
-- Name: server_theme server_theme_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.server_theme
    ADD CONSTRAINT server_theme_pkey PRIMARY KEY (id);


--
-- Name: settings_event settings_event_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.settings_event
    ADD CONSTRAINT settings_event_pkey PRIMARY KEY (id);


--
-- Name: settings_scoreboard settings_scoreboard_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.settings_scoreboard
    ADD CONSTRAINT settings_scoreboard_pkey PRIMARY KEY (id);


--
-- Name: settings_team settings_team_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.settings_team
    ADD CONSTRAINT settings_team_pkey PRIMARY KEY (id);


--
-- Name: teams_accesscode teams_accesscode_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.teams_accesscode
    ADD CONSTRAINT teams_accesscode_pkey PRIMARY KEY (id);


--
-- Name: teams_accesscode teams_accesscode_team_id_key; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.teams_accesscode
    ADD CONSTRAINT teams_accesscode_team_id_key UNIQUE (team_id);


--
-- Name: teams_accesscode teams_accesscode_value_key; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.teams_accesscode
    ADD CONSTRAINT teams_accesscode_value_key UNIQUE (value);


--
-- Name: teams_failure teams_failure_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.teams_failure
    ADD CONSTRAINT teams_failure_pkey PRIMARY KEY (id);


--
-- Name: teams_solvedchallenge teams_solvedchallenge_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.teams_solvedchallenge
    ADD CONSTRAINT teams_solvedchallenge_pkey PRIMARY KEY (id);


--
-- Name: teams_team teams_team_name_key; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.teams_team
    ADD CONSTRAINT teams_team_name_key UNIQUE (name);


--
-- Name: teams_team teams_team_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.teams_team
    ADD CONSTRAINT teams_team_pkey PRIMARY KEY (id);


--
-- Name: uauth_adminregisterkey uauth_adminregisterkey_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.uauth_adminregisterkey
    ADD CONSTRAINT uauth_adminregisterkey_pkey PRIMARY KEY (id);


--
-- Name: uauth_logintracker uauth_logintracker_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.uauth_logintracker
    ADD CONSTRAINT uauth_logintracker_pkey PRIMARY KEY (id);


--
-- Name: uauth_profile uauth_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.uauth_profile
    ADD CONSTRAINT uauth_profile_pkey PRIMARY KEY (id);


--
-- Name: uauth_profile uauth_profile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.uauth_profile
    ADD CONSTRAINT uauth_profile_user_id_key UNIQUE (user_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: categories_category_logs_category_id_5e5e7043; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX categories_category_logs_category_id_5e5e7043 ON public.categories_category_logs USING btree (category_id);


--
-- Name: categories_category_logs_log_id_c373d750; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX categories_category_logs_log_id_c373d750 ON public.categories_category_logs USING btree (log_id);


--
-- Name: categories_category_name_debcfc14_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX categories_category_name_debcfc14_like ON public.categories_category USING btree (name varchar_pattern_ops);


--
-- Name: challenges_challenge_category_id_3b71f90c; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX challenges_challenge_category_id_3b71f90c ON public.challenges_challenge USING btree (category_id);


--
-- Name: challenges_challenge_name_1bf05f94_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX challenges_challenge_name_1bf05f94_like ON public.challenges_challenge USING btree (name varchar_pattern_ops);


--
-- Name: challenges_flag_algorithm_id_aa661569; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX challenges_flag_algorithm_id_aa661569 ON public.challenges_flag USING btree (algorithm_id);


--
-- Name: challenges_hint_challenge_id_d951876f; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX challenges_hint_challenge_id_d951876f ON public.challenges_hint USING btree (challenge_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: logs_log_user_id_f24e8690; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX logs_log_user_id_f24e8690 ON public.logs_log USING btree (user_id);


--
-- Name: logs_logintracker_user_id_d0e9b325; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX logs_logintracker_user_id_d0e9b325 ON public.logs_logintracker USING btree (user_id);


--
-- Name: pages_page_url_c10fea58_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX pages_page_url_c10fea58_like ON public.pages_page USING btree (url varchar_pattern_ops);


--
-- Name: teams_accesscode_value_766dd8d7_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX teams_accesscode_value_766dd8d7_like ON public.teams_accesscode USING btree (value varchar_pattern_ops);


--
-- Name: teams_failure_challenge_id_27191bad; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX teams_failure_challenge_id_27191bad ON public.teams_failure USING btree (challenge_id);


--
-- Name: teams_failure_team_id_5ba5d6e0; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX teams_failure_team_id_5ba5d6e0 ON public.teams_failure USING btree (team_id);


--
-- Name: teams_failure_user_id_0e4be211; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX teams_failure_user_id_0e4be211 ON public.teams_failure USING btree (user_id);


--
-- Name: teams_solvedchallenge_challenge_id_02d6bf40; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX teams_solvedchallenge_challenge_id_02d6bf40 ON public.teams_solvedchallenge USING btree (challenge_id);


--
-- Name: teams_solvedchallenge_team_id_00b37417; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX teams_solvedchallenge_team_id_00b37417 ON public.teams_solvedchallenge USING btree (team_id);


--
-- Name: teams_solvedchallenge_user_id_f58a8f08; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX teams_solvedchallenge_user_id_f58a8f08 ON public.teams_solvedchallenge USING btree (user_id);


--
-- Name: teams_team_name_c519f9ad_like; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX teams_team_name_c519f9ad_like ON public.teams_team USING btree (name varchar_pattern_ops);


--
-- Name: uauth_logintracker_user_id_e88cb400; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX uauth_logintracker_user_id_e88cb400 ON public.uauth_logintracker USING btree (user_id);


--
-- Name: uauth_profile_team_id_1444ac62; Type: INDEX; Schema: public; Owner: django
--

CREATE INDEX uauth_profile_team_id_1444ac62 ON public.uauth_profile USING btree (team_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: categories_category_logs categories_category__category_id_5e5e7043_fk_categorie; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.categories_category_logs
    ADD CONSTRAINT categories_category__category_id_5e5e7043_fk_categorie FOREIGN KEY (category_id) REFERENCES public.categories_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: categories_category_logs categories_category_logs_log_id_c373d750_fk_logs_log_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.categories_category_logs
    ADD CONSTRAINT categories_category_logs_log_id_c373d750_fk_logs_log_id FOREIGN KEY (log_id) REFERENCES public.logs_log(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: challenges_challenge challenges_challenge_category_id_3b71f90c_fk_categorie; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.challenges_challenge
    ADD CONSTRAINT challenges_challenge_category_id_3b71f90c_fk_categorie FOREIGN KEY (category_id) REFERENCES public.categories_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: challenges_flag challenges_flag_algorithm_id_aa661569_fk_challenges_hash_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.challenges_flag
    ADD CONSTRAINT challenges_flag_algorithm_id_aa661569_fk_challenges_hash_id FOREIGN KEY (algorithm_id) REFERENCES public.challenges_hash(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: challenges_flag challenges_flag_challenge_id_9385360b_fk_challenge; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.challenges_flag
    ADD CONSTRAINT challenges_flag_challenge_id_9385360b_fk_challenge FOREIGN KEY (challenge_id) REFERENCES public.challenges_challenge(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: challenges_hint challenges_hint_challenge_id_d951876f_fk_challenge; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.challenges_hint
    ADD CONSTRAINT challenges_hint_challenge_id_d951876f_fk_challenge FOREIGN KEY (challenge_id) REFERENCES public.challenges_challenge(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: logs_log logs_log_user_id_f24e8690_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.logs_log
    ADD CONSTRAINT logs_log_user_id_f24e8690_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: logs_logintracker logs_logintracker_user_id_d0e9b325_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.logs_logintracker
    ADD CONSTRAINT logs_logintracker_user_id_d0e9b325_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: teams_accesscode teams_accesscode_team_id_fb3571c1_fk_teams_team_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.teams_accesscode
    ADD CONSTRAINT teams_accesscode_team_id_fb3571c1_fk_teams_team_id FOREIGN KEY (team_id) REFERENCES public.teams_team(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: teams_failure teams_failure_challenge_id_27191bad_fk_challenges_challenge_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.teams_failure
    ADD CONSTRAINT teams_failure_challenge_id_27191bad_fk_challenges_challenge_id FOREIGN KEY (challenge_id) REFERENCES public.challenges_challenge(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: teams_failure teams_failure_team_id_5ba5d6e0_fk_teams_team_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.teams_failure
    ADD CONSTRAINT teams_failure_team_id_5ba5d6e0_fk_teams_team_id FOREIGN KEY (team_id) REFERENCES public.teams_team(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: teams_failure teams_failure_user_id_0e4be211_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.teams_failure
    ADD CONSTRAINT teams_failure_user_id_0e4be211_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: teams_solvedchallenge teams_solvedchalleng_challenge_id_02d6bf40_fk_challenge; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.teams_solvedchallenge
    ADD CONSTRAINT teams_solvedchalleng_challenge_id_02d6bf40_fk_challenge FOREIGN KEY (challenge_id) REFERENCES public.challenges_challenge(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: teams_solvedchallenge teams_solvedchallenge_team_id_00b37417_fk_teams_team_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.teams_solvedchallenge
    ADD CONSTRAINT teams_solvedchallenge_team_id_00b37417_fk_teams_team_id FOREIGN KEY (team_id) REFERENCES public.teams_team(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: teams_solvedchallenge teams_solvedchallenge_user_id_f58a8f08_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.teams_solvedchallenge
    ADD CONSTRAINT teams_solvedchallenge_user_id_f58a8f08_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: uauth_logintracker uauth_logintracker_user_id_e88cb400_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.uauth_logintracker
    ADD CONSTRAINT uauth_logintracker_user_id_e88cb400_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: uauth_profile uauth_profile_team_id_1444ac62_fk_teams_team_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.uauth_profile
    ADD CONSTRAINT uauth_profile_team_id_1444ac62_fk_teams_team_id FOREIGN KEY (team_id) REFERENCES public.teams_team(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: uauth_profile uauth_profile_user_id_5dccadca_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY public.uauth_profile
    ADD CONSTRAINT uauth_profile_user_id_5dccadca_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

