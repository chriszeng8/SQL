--http://www.tutorialspoint.com/postgresql/postgresql_select_database.htm

--Pronunciation (you will keep saying this word again and again, so it is
--				better to pronounce it right sooner than later).
--PostgreSQL (pronounced as post-gress-Q-L)


--Using psql
\help

-- Create database
CREATE DATABASE dbname;
-- Drop/delete database
DROP DATABASE dbname;

-- List all available database using \l
\l

-- Connect/select a desired database (equivalent of USE in MySQL)
\c dbname;

-- You can select your database from command prompt itself at the time when 
-- you login to your database. 
psql -h localhost -p 5432 -U postgress dbname
-- does not work on my mac somehow

-- Create table
CREATE TABLE table_name(
   Column1 datatype PRIMARY KEY NOT NULL,
   column2 datatype,
   column3 datatype,
)
-- Drop table
DROP TABLE table_name;
DROP TABLE table_name_1, table_name_2;

-- List all available tables using \d
\d


-- insert new tuple into a table.
INSERT INTO TABLE_NAME VALUES (value1,value2,value3,...valueN);


-- TYPE OF CONSTRAINTS:
--1. NOT NULL Constraint: Ensures that a column cannot have NULL value.
--2. UNIQUE Constraint: Ensures that all values in a column are different.
--3. PRIMARY Key: Uniquely identifies each row/record in a database table.
--4. FOREIGN Key: Constrains data based on columns in other tables.
--5. CHECK Constraint: The CHECK constraint ensures that all values in a column satisfy 
--   certain conditions.
--6. EXCLUSION Constraint: The EXCLUDE constraint ensures that if any two rows are compared on
--   the specified column(s) or expression(s) using the specified operator(s), not all of 
--   these comparisons will return TRUE.

-- ==================================== Check Constraint =======================================
-- The CHECK Constraint enables a condition to check the value being entered into a record. 
-- If the condition evaluates to false, the record violates the constraint and isn't entered into the table.






-- Trigger 
-- 1. The basic syntax of creating a trigger is as follows:

CREATE  TRIGGER trigger_name [BEFORE|AFTER|INSTEAD OF] event_name
ON table_name
[
 -- Trigger logic goes here....
];

event_name can be 
INSERT, DELETE, UPDATE, TRUNCATE

-- 2. Creating a trigger on an UPDATE operation on one or more specified columns of a table as follows:
CREATE  TRIGGER trigger_name [BEFORE|AFTER] UPDATE OF column_name
ON table_name
[
 -- Trigger logic goes here....
];

