----------
--This script file contains all the creation of tables and their various dependencies for the LOCAL SQL
----------

-- all pages for heirachical structure
CREATE TABLE pages (
  id               integer PRIMARY KEY,
  parent_id        integer NOT NULL,
  title            text,
  subtitle         text,
  is_bookmarked    integer(1) NOT NULL,
  allow_bookmarked integer(1) NOT NULL,
  text             blob,
  link_text        text,	
  content_id       integer
);

-- table for looking up content ids matched with the location on disk
CREATE TABLE contents (
  id       integer PRIMARY KEY,
  location text
);

-- table for verifying that the local DB is up to date with the Master one
CREATE TABLE db_version (
  id           integer PRIMARY KEY,
  version      text,
  updated_date text
);



