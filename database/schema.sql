--
-- PostgreSQL database dump
--

-- Dumped from database version 12.12 (Ubuntu 12.12-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.12 (Ubuntu 12.12-0ubuntu0.20.04.1)

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

SET default_table_access_method = heap;

--
-- Name: organization; Type: TABLE; Schema: open_mind; Owner: greg
--

CREATE TABLE open_mind.organization (
    organization_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name text NOT NULL,
    description jsonb NOT NULL,
    is_personal boolean NOT NULL,
    is_private boolean NOT NULL,
    owner_id uuid NOT NULL
);


ALTER TABLE open_mind.organization OWNER TO greg;

--
-- Name: thinker; Type: TABLE; Schema: open_mind; Owner: greg
--

CREATE TABLE open_mind.thinker (
    thinker_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    nickname text NOT NULL,
    personnal_organization_id uuid NOT NULL
);


ALTER TABLE open_mind.thinker OWNER TO greg;

--
-- Name: thinker_membership; Type: TABLE; Schema: open_mind; Owner: greg
--

CREATE TABLE open_mind.thinker_membership (
    thinker_id uuid NOT NULL,
    organization_id uuid NOT NULL,
    permissions bigint DEFAULT 0 NOT NULL
);


ALTER TABLE open_mind.thinker_membership OWNER TO greg;

--
-- Name: TABLE thinker_membership; Type: COMMENT; Schema: open_mind; Owner: greg
--

COMMENT ON TABLE open_mind.thinker_membership IS 'relationship between thinkers and organizations';


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
-- Data for Name: organization; Type: TABLE DATA; Schema: open_mind; Owner: greg
--

COPY open_mind.organization (organization_id, name, description, is_personal, is_private, owner_id) FROM stdin;
bab05b8d-e587-42ee-8e3a-a2829bc0bfce	greg	{"description": "greg personal organization"}	t	f	35b21b43-5eac-4427-8ea9-a38c10d498ac
86e38b91-cb52-48a2-b607-21c76db76525	whatever	{"description": "a normal organization"}	f	f	35b21b43-5eac-4427-8ea9-a38c10d498ac
\.


--
-- Data for Name: thinker; Type: TABLE DATA; Schema: open_mind; Owner: greg
--

COPY open_mind.thinker (thinker_id, nickname, personnal_organization_id) FROM stdin;
35b21b43-5eac-4427-8ea9-a38c10d498ac	greg	bab05b8d-e587-42ee-8e3a-a2829bc0bfce
\.


--
-- Data for Name: thinker_membership; Type: TABLE DATA; Schema: open_mind; Owner: greg
--

COPY open_mind.thinker_membership (thinker_id, organization_id, permissions) FROM stdin;
35b21b43-5eac-4427-8ea9-a38c10d498ac	bab05b8d-e587-42ee-8e3a-a2829bc0bfce	0
35b21b43-5eac-4427-8ea9-a38c10d498ac	86e38b91-cb52-48a2-b607-21c76db76525	0
\.


--
-- Data for Name: thought; Type: TABLE DATA; Schema: open_mind; Owner: greg
--

COPY open_mind.thought (thought_id, thinker_id, organization_id, parent_thought_id, created_at, content, medias, sources, tags) FROM stdin;
\.


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
-- Name: thinker_belongs_to_organization_thinker_id_organization_id_idx; Type: INDEX; Schema: open_mind; Owner: greg
--

CREATE UNIQUE INDEX thinker_belongs_to_organization_thinker_id_organization_id_idx ON open_mind.thinker_membership USING btree (thinker_id, organization_id);


--
-- Name: thinker_personnal_organization_id_idx; Type: INDEX; Schema: open_mind; Owner: greg
--

CREATE UNIQUE INDEX thinker_personnal_organization_id_idx ON open_mind.thinker USING btree (personnal_organization_id);


--
-- Name: thought_organization_id_thought_id_idx; Type: INDEX; Schema: open_mind; Owner: greg
--

CREATE UNIQUE INDEX thought_organization_id_thought_id_idx ON open_mind.thought USING btree (organization_id, thought_id);


--
-- Name: organization owner_must_be_member; Type: FK CONSTRAINT; Schema: open_mind; Owner: greg
--

ALTER TABLE ONLY open_mind.organization
    ADD CONSTRAINT owner_must_be_member FOREIGN KEY (owner_id, organization_id) REFERENCES open_mind.thinker_membership(thinker_id, organization_id) DEFERRABLE;


--
-- Name: thought parent_must_share_organization; Type: FK CONSTRAINT; Schema: open_mind; Owner: greg
--

ALTER TABLE ONLY open_mind.thought
    ADD CONSTRAINT parent_must_share_organization FOREIGN KEY (parent_thought_id, organization_id) REFERENCES open_mind.thought(thought_id, organization_id);


--
-- Name: thinker_membership thinker_belongs_to_organization_organization_id_fkey; Type: FK CONSTRAINT; Schema: open_mind; Owner: greg
--

ALTER TABLE ONLY open_mind.thinker_membership
    ADD CONSTRAINT thinker_belongs_to_organization_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES open_mind.organization(organization_id);


--
-- Name: thinker_membership thinker_belongs_to_organization_thinker_id_fkey; Type: FK CONSTRAINT; Schema: open_mind; Owner: greg
--

ALTER TABLE ONLY open_mind.thinker_membership
    ADD CONSTRAINT thinker_belongs_to_organization_thinker_id_fkey FOREIGN KEY (thinker_id) REFERENCES open_mind.thinker(thinker_id);


--
-- Name: thinker thinker_thinker_id_personnal_organization_id_fkey; Type: FK CONSTRAINT; Schema: open_mind; Owner: greg
--

ALTER TABLE ONLY open_mind.thinker
    ADD CONSTRAINT thinker_thinker_id_personnal_organization_id_fkey FOREIGN KEY (thinker_id, personnal_organization_id) REFERENCES open_mind.thinker_membership(thinker_id, organization_id) DEFERRABLE;


--
-- Name: thought thought_belongs_to_member; Type: FK CONSTRAINT; Schema: open_mind; Owner: greg
--

ALTER TABLE ONLY open_mind.thought
    ADD CONSTRAINT thought_belongs_to_member FOREIGN KEY (thinker_id, organization_id) REFERENCES open_mind.thinker_membership(thinker_id, organization_id);


--
-- PostgreSQL database dump complete
--

