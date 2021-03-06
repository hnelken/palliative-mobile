----------
--This script file contains all the creation of tables and their various dependencies for the LOCAL SQL
----------

-- all pages for heirachical structure
CREATE TABLE pages (
  id               integer,--  PRIMARY KEY,
  parent_id        integer,-- NOT NULL,
  title            text,
  is_bookmarked    integer(1),-- NOT NULL,
  text             text,
  detail           text,
  link_text        text,	
  content_id       integer
);

-- table for looking up content ids matched with the location on disk
CREATE TABLE contents (
  id       integer PRIMARY KEY,
  type     integer(1),
  content  text
);

CREATE TABLE bookmarks (
  id      integer PRIMARY KEY,
  page_id integer
);

-- table for verifying that the local DB is up to date with the Master one
-- this will also store demographic information, area, age, experience, dept.
CREATE TABLE settings (
  id    integer PRIMARY KEY,
  name  text,
  value text
);
-------------------------QUIZ STUFF-----------------------------
CREATE TABLE quizzes (
  id   integer PRIMARY KEY,
  name text
);

CREATE TABLE questions (
  id       integer PRIMARY KEY,
  quiz_id  integer,
  question text
);

CREATE TABLE answers (
  id          integer,
  question_id integer,
  answer      text,
  is_correct  integer
);

CREATE TABLE quiz_session (
  id      integer PRIMARY KEY,
  quiz_id integer,
  score   real
);
----------------USAGE STUFF--------------------
CREATE TABLE page_hits (
  page_id integer PRIMARY KEY,
  hits    integer
);



