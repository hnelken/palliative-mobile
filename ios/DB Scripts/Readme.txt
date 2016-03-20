These files are SQL files which will hold SQLite scripts.  These scripts should
be easily and correctly run on SQLite DBs without problem.


Here is a description of the files and their purposes within, please update
if changing this:

- SP_Queries.sql
* These are important queries that will be used for various functionality.

- SP_Tables.sql
* These are create statements to generate all the tables for the LOCAL DB.

===Steps to take to clean CSV from Drive===

- export as MS Excel
- save again as CSV(MS-DOS)
- remove first row (column headers)
- remove empty rows at bottom of file
- fix each line commas with a replace


===Fixes made for CSV to work in the DB===

- removed NOT NULL, PRIMARY KEY from pages definition


===Steps to populate DB with CSV===
- start new sqlite3 with master_local.db
- read the table definitons
- use ".mode csv" to get ready for import
- import the csv