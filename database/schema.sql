--
-- PostgreSQL database dump
--

-- Dumped from database version 11.14 (Debian 11.14-0+deb10u1)
-- Dumped by pg_dump version 12.11 (Ubuntu 12.11-0ubuntu0.20.04.1)

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
-- Name: open_mind; Type: SCHEMA; Schema: -; Owner: greg
--

CREATE SCHEMA open_mind;


ALTER SCHEMA open_mind OWNER TO greg;

SET default_tablespace = '';

--
-- Name: flying_note; Type: TABLE; Schema: open_mind; Owner: greg
--

CREATE TABLE open_mind.flying_note (
    flying_note_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    thinker_id uuid NOT NULL,
    organization_id uuid NOT NULL,
    content jsonb NOT NULL
);


ALTER TABLE open_mind.flying_note OWNER TO greg;

--
-- Name: member; Type: TABLE; Schema: open_mind; Owner: greg
--

CREATE TABLE open_mind.member (
    thinker_id uuid NOT NULL,
    organization_id uuid NOT NULL
);


ALTER TABLE open_mind.member OWNER TO greg;

--
-- Name: organization; Type: TABLE; Schema: open_mind; Owner: greg
--

CREATE TABLE open_mind.organization (
    organization_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    owner_thinker_id uuid NOT NULL,
    is_personal boolean NOT NULL,
    is_private boolean NOT NULL,
    name text NOT NULL,
    description text
);


ALTER TABLE open_mind.organization OWNER TO greg;

--
-- Name: thinker; Type: TABLE; Schema: open_mind; Owner: greg
--

CREATE TABLE open_mind.thinker (
    thinker_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    nickname text NOT NULL
);


ALTER TABLE open_mind.thinker OWNER TO greg;

--
-- Name: thought; Type: TABLE; Schema: open_mind; Owner: greg
--

CREATE TABLE open_mind.thought (
    thought_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    thinker_id uuid NOT NULL,
    organization_id uuid NOT NULL,
    parent_thought_id uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    content text NOT NULL,
    medias jsonb DEFAULT '{}'::jsonb NOT NULL,
    sources jsonb DEFAULT '{}'::jsonb NOT NULL,
    tags public.ltree[],
    CONSTRAINT content_length_max CHECK ((length(content) < 400))
);


ALTER TABLE open_mind.thought OWNER TO greg;

--
-- Data for Name: flying_note; Type: TABLE DATA; Schema: open_mind; Owner: greg
--

COPY open_mind.flying_note (flying_note_id, created_at, thinker_id, organization_id, content) FROM stdin;
\.


--
-- Data for Name: member; Type: TABLE DATA; Schema: open_mind; Owner: greg
--

COPY open_mind.member (thinker_id, organization_id) FROM stdin;
\.


--
-- Data for Name: organization; Type: TABLE DATA; Schema: open_mind; Owner: greg
--

COPY open_mind.organization (organization_id, owner_thinker_id, is_personal, is_private, name, description) FROM stdin;
\.


--
-- Data for Name: thinker; Type: TABLE DATA; Schema: open_mind; Owner: greg
--

COPY open_mind.thinker (thinker_id, nickname) FROM stdin;
\.


--
-- Data for Name: thought; Type: TABLE DATA; Schema: open_mind; Owner: greg
--

COPY open_mind.thought (thought_id, thinker_id, organization_id, parent_thought_id, created_at, content, medias, sources, tags) FROM stdin;
\.


--
-- Name: flying_note flying_note_pkey; Type: CONSTRAINT; Schema: open_mind; Owner: greg
--

ALTER TABLE ONLY open_mind.flying_note
    ADD CONSTRAINT flying_note_pkey PRIMARY KEY (flying_note_id);


--
-- Name: member member_pkey; Type: CONSTRAINT; Schema: open_mind; Owner: greg
--

ALTER TABLE ONLY open_mind.member
    ADD CONSTRAINT member_pkey PRIMARY KEY (thinker_id, organization_id);


--
-- Name: organization organization_name_key; Type: CONSTRAINT; Schema: open_mind; Owner: greg
--

ALTER TABLE ONLY open_mind.organization
    ADD CONSTRAINT organization_name_key UNIQUE (name);


--
-- Name: organization organization_pkey; Type: CONSTRAINT; Schema: open_mind; Owner: greg
--

ALTER TABLE ONLY open_mind.organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (organization_id);


--
-- Name: thinker thinker_nickname_key; Type: CONSTRAINT; Schema: open_mind; Owner: greg
--

ALTER TABLE ONLY open_mind.thinker
    ADD CONSTRAINT thinker_nickname_key UNIQUE (nickname);


--
-- Name: thinker thinker_pkey; Type: CONSTRAINT; Schema: open_mind; Owner: greg
--

ALTER TABLE ONLY open_mind.thinker
    ADD CONSTRAINT thinker_pkey PRIMARY KEY (thinker_id);


--
-- Name: thought thought_pkey; Type: CONSTRAINT; Schema: open_mind; Owner: greg
--

ALTER TABLE ONLY open_mind.thought
    ADD CONSTRAINT thought_pkey PRIMARY KEY (thought_id);


--
-- Name: flying_note flying_note_organization_id_fkey; Type: FK CONSTRAINT; Schema: open_mind; Owner: greg
--

ALTER TABLE ONLY open_mind.flying_note
    ADD CONSTRAINT flying_note_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES open_mind.organization(organization_id);


--
-- Name: flying_note flying_note_thinker_id_fkey; Type: FK CONSTRAINT; Schema: open_mind; Owner: greg
--

ALTER TABLE ONLY open_mind.flying_note
    ADD CONSTRAINT flying_note_thinker_id_fkey FOREIGN KEY (thinker_id) REFERENCES open_mind.thinker(thinker_id);


--
-- Name: member member_organization_id_fkey; Type: FK CONSTRAINT; Schema: open_mind; Owner: greg
--

ALTER TABLE ONLY open_mind.member
    ADD CONSTRAINT member_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES open_mind.organization(organization_id);


--
-- Name: member member_thinker_id_fkey; Type: FK CONSTRAINT; Schema: open_mind; Owner: greg
--

ALTER TABLE ONLY open_mind.member
    ADD CONSTRAINT member_thinker_id_fkey FOREIGN KEY (thinker_id) REFERENCES open_mind.thinker(thinker_id);


--
-- Name: organization organization_owner_thinker_id_fkey; Type: FK CONSTRAINT; Schema: open_mind; Owner: greg
--

ALTER TABLE ONLY open_mind.organization
    ADD CONSTRAINT organization_owner_thinker_id_fkey FOREIGN KEY (owner_thinker_id) REFERENCES open_mind.thinker(thinker_id);


--
-- Name: thought thought_organization_id_fkey; Type: FK CONSTRAINT; Schema: open_mind; Owner: greg
--

ALTER TABLE ONLY open_mind.thought
    ADD CONSTRAINT thought_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES open_mind.organization(organization_id);


--
-- Name: thought thought_parent_thought_id_fkey; Type: FK CONSTRAINT; Schema: open_mind; Owner: greg
--

ALTER TABLE ONLY open_mind.thought
    ADD CONSTRAINT thought_parent_thought_id_fkey FOREIGN KEY (parent_thought_id) REFERENCES open_mind.thought(thought_id);


--
-- Name: thought thought_thinker_id_fkey; Type: FK CONSTRAINT; Schema: open_mind; Owner: greg
--

ALTER TABLE ONLY open_mind.thought
    ADD CONSTRAINT thought_thinker_id_fkey FOREIGN KEY (thinker_id) REFERENCES open_mind.thinker(thinker_id);


--
-- PostgreSQL database dump complete
--

