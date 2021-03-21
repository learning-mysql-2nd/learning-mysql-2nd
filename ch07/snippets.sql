--
-- Every piece of SQL used in Chapter 7 "Doing More with MySQL"
--


-- Inserting Data Using Queries

USE sakila;

CREATE TABLE recommend (
    film_id SMALLINT UNSIGNED
  , language_id TINYINT UNSIGNED
  , release_year YEAR
  , title VARCHAR(128)
  , length SMALLINT UNSIGNED
  , sequence_id SMALLINT AUTO_INCREMENT
  , PRIMARY KEY (sequence_id)
);

INSERT INTO recommend (film_id, language_id, release_year, title, length)
SELECT film_id, language_id, release_year, title, length
FROM film ORDER BY RAND() LIMIT 10;

SELECT  FROM recommend;

SELECT RAND();

SELECT title, RAND() FROM film LIMIT 5;

CREATE DATABASE art;

USE art;

CREATE TABLE people (
    person_id SMALLINT UNSIGNED
  , first_name VARCHAR(45)
  , last_name VARCHAR(45)
  , PRIMARY KEY (person_id)
);

INSERT INTO art.people (person_id, first_name, last_name)
SELECT actor_id, first_name, last_name FROM sakila.actor;

USE sakila;

INSERT INTO recommend (film_id, language_id, release_year,
title, length, sequence_id )
SELECT film_id, language_id, release_year, title, length, 1
FROM film LIMIT 1;

INSERT IGNORE INTO recommend (film_id, language_id, release_year,
title, length, sequence_id )
SELECT film_id, language_id, release_year, title, length, 1
FROM film LIMIT 1;

SHOW WARNINGS;

INSERT INTO actor SELECT
actor_id, first_name, last_name, NOW() FROM actor;

INSERT INTO actor SELECT
actor_id+200, first_name, last_name, NOW() FROM actor;

SELECT  FROM actor;

INSERT INTO actor SELECT  FROM
(SELECT actor_id+400, first_name, last_name, NOW() FROM actor) foo;


-- Loading Data from Comma-Delimited Files

CREATE DATABASE nasa;

USE nasa;

CREATE TABLE facilities (
    center TEXT
  , center_search_status TEXT
  , facility TEXT
  , facility_url TEXT
  , occupied TEXT
  , status TEXT
  , url_link TEXT
  , record_date DATETIME
  , last_update TIMESTAMP
  , country TEXT
  , contact TEXT
  , phone TEXT
  , location TEXT
  , city TEXT
  , state TEXT
  , zipcode TEXT
);

LOAD DATA INFILE 'NASA_Facilities.csv' INTO TABLE facilities FIELDS TERMINATED BY ',';

SELECT @@secure_file_priv;

LOAD DATA INFILE '/var/lib/mysql-files/NASA_Facilities.csv' INTO TABLE facilities FIELDS TERMINATED BY ',';

LOAD DATA INFILE '/var/lib/mysql-files/NASA_Facilities.csv'
INTO TABLE facilities FIELDS TERMINATED BY ','
IGNORE 1 LINES;

SELECT STR_TO_DATE('03/01/1996 12:00:00 AM', '%m/%d/%Y %h:%i:%s %p') converted;

LOAD DATA INFILE '/var/lib/mysql-files/NASA_Facilities.csv'
INTO TABLE facilities FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 LINES
(center, center_search_status, facility, facility_url,
occupied, status, url_link, @var_record_date, @var_last_update,
country, contact, phone, location, city, state, zipcode)
SET record_date = IF(
  CHAR_LENGTH(@var_record_date)=0, NULL,
    STR_TO_DATE(@var_record_date, '%m/%d/%Y %h:%i:%s %p')
),
last_update = IF(
  CHAR_LENGTH(@var_last_update)=0, NULL,
    STR_TO_DATE(@var_last_update, '%m/%d/%Y %h:%i:%s %p')
);

SELECT facility, occupied, last_update
FROM facilities
ORDER BY last_update DESC LIMIT 5;


-- Writing Data into Comma-Delimited Files

USE employees;

SELECT emp_no, first_name, last_name, title, from_date
FROM employees JOIN titles USING (emp_no)
WHERE title = 'Manager' AND to_date = '9999-01-01';

SELECT emp_no, first_name, last_name, title, from_date
FROM employees JOIN titles USING (emp_no)
WHERE title = 'Manager' AND to_date = '9999-01-01'
INTO OUTFILE '/var/lib/mysql-files/managers.csv'
FIELDS TERMINATED BY ',';

USE sakila;

SELECT title, special_features FROM film LIMIT 10
INTO OUTFILE '/var/lib/mysql-files/film.csv'
FIELDS TERMINATED BY ',';

SELECT title, special_features FROM film LIMIT 10
INTO OUTFILE '/var/lib/mysql-files/film.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"';


-- Creating Tables with Queries

USE sakila;

CREATE TABLE actor_2 LIKE actor;

DESCRIBE actor_2;

SELECT * FROM actor_2;

DROP TABLE actor_2;

CREATE TABLE actor_2 AS SELECT * from actor;

SELECT * FROM actor_2 LIMIT 5;

CREATE TABLE report (title VARCHAR(128), category VARCHAR(25))
SELECT title, name AS category FROM
film JOIN film_category USING (film_id)
JOIN category USING (category_id);

SELECT * FROM report LIMIT 5;

DESCRIBE actor_2;

SHOW CREATE TABLE actor_2;

CREATE TABLE actor_2 (UNIQUE(actor_id))
AS SELECT * from actor;

DESCRIBE actor_2;

CREATE TABLE actor_3 (
    actor_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT
  , first_name VARCHAR(45) NOT NULL
  , last_name VARCHAR(45) NOT NULL
  , last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  , PRIMARY KEY (`actor_id`)
  , KEY `idx_actor_last_name` (`last_name`)
) SELECT * FROM actor;


-- Multitable deletes

SELECT * FROM inventory WHERE NOT EXISTS
(SELECT 1 FROM rental WHERE
rental.inventory_id = inventory.inventory_id);

DELETE FROM inventory WHERE NOT EXISTS
(SELECT 1 FROM rental WHERE
rental.inventory_id = inventory.inventory_id);

DELETE inventory FROM inventory LEFT JOIN rental
USING (inventory_id) WHERE rental.inventory_id IS NULL;

DELETE FROM inventory USING inventory
LEFT JOIN rental USING (inventory_id)
WHERE rental.inventory_id IS NULL;

DELETE FROM film WHERE NOT EXISTS
(SELECT 1 FROM inventory WHERE
film.film_id = inventory.film_id);

DELETE FROM film_actor, film USING
film JOIN film_actor USING (film_id)
LEFT JOIN inventory USING (film_id)
WHERE inventory.film_id IS NULL;

BEGIN;

DELETE FROM film_actor USING
film JOIN film_actor USING (film_id)
LEFT JOIN inventory USING (film_id)
WHERE inventory.film_id IS NULL;

DELETE FROM film_category USING
film JOIN film_category USING (film_id)
LEFT JOIN inventory USING (film_id)
WHERE inventory.film_id IS NULL;

DELETE FROM film USING
film LEFT JOIN inventory USING (film_id)
WHERE inventory.film_id IS NULL;

ROLLBACK;

SET foreign_key_checks=0;

BEGIN;

DELETE FROM film, film_actor, film_category
USING film JOIN film_actor USING (film_id)
JOIN film_category USING (film_id)
LEFT JOIN inventory USING (film_id)
WHERE inventory.film_id IS NULL;

ROLLBACK;

SET foreign_key_checks=1;

BEGIN;

DELETE FROM film_actor, film_category USING
film JOIN film_actor USING (film_id)
JOIN film_category USING (film_id)
LEFT JOIN inventory USING (film_id)
WHERE inventory.film_id IS NULL;

DELETE FROM film USING
film LEFT JOIN inventory USING (film_id)
WHERE inventory.film_id IS NULL;

ROLLBACK;


-- Multitable updates

SELECT name category, title, rating
FROM film JOIN film_category USING (film_id)
JOIN category USING (category_id)
WHERE name = 'Horror';

SELECT COUNT(title)
FROM film JOIN film_category USING (film_id)
JOIN category USING (category_id)
'R';

UPDATE film JOIN film_category USING (film_id)
JOIN category USING (category_id)
SET rating = 'R' WHERE category.name = 'Horror';


-- Replacing data

REPLACE INTO actor VALUES (1, 'Penelope', 'Guiness', NOW());

REPLACE actor_2 VALUES (1, 'Penelope', 'Guiness', NOW());

REPLACE INTO actor_2 VALUES (1, 'Penelope', 'Guiness', NOW());

REPLACE INTO actor_2 (actor_id, first_name, last_name)
VALUES (1, 'Penelope', 'Guiness');

REPLACE actor_2 (actor_id, first_name, last_name)
VALUES (1, 'Penelope', 'Guiness');

REPLACE actor_2 SET actor_id = 1,
first_name = 'Penelope', last_name = 'Guiness';

REPLACE actor_2 (actor_id, first_name, last_name)
VALUES (2, 'Nick', 'Wahlberg'),
(3, 'Ed', 'Chase');

REPLACE actor_2 (actor_id, first_name, last_name)
VALUES (1000, 'William', 'Dyer');

REPLACE INTO recommend SELECT film_id, language_id,
release_year, title, length, 7 FROM film
ORDER BY RAND() LIMIT 1;

INSERT INTO actor (actor_id, first_name, last_name) VALUES (1, 'Penelope', 'Guiness')
ON DUPLICATE KEY UPDATE first_name = 'Penelope', last_name = 'Guiness';

INSERT INTO actor VALUES (1, 'Penelope', 'Guiness', NOW())
ON DUPLICATE KEY UPDATE
actor_id = 1, first_name = 'Penelope',
last_name = 'Guiness', last_update = NOW();

INSERT INTO actor (actor_id, first_name, last_name) VALUES
(1, 'Penelope', 'Guiness'), (2, 'Nick', 'Wahlberg'),
(3, 'Ed', 'Chase'), (1001, 'William', 'Dyer')
ON DUPLICATE KEY UPDATE first_name = VALUES(first_name),
last_name = VALUES(last_name);


-- Explain

EXPLAIN SELECT * FROM actor WHERE actor_id IN
(SELECT actor_id FROM film_actor JOIN
film USING (film_id)
WHERE title = 'ZHIVAGO CORE');

EXPLAIN SELECT * FROM actor WHERE actor_id IN
(SELECT actor_id FROM film_actor
WHERE film_id = 11);

SHOW WARNINGS\G

EXPLAIN SELECT first_name, last_name FROM actor
JOIN film_actor USING (actor_id)
JOIN film USING (film_id)
JOIN film_category USING (film_id)
JOIN category USING (category_id)
WHERE category.name = 'Horror';

EXPLAIN ANALYZE SELECT first_name, last_name FROM actor
JOIN film_actor USING (actor_id)
JOIN film USING (film_id)
JOIN film_category USING (film_id)
JOIN category USING (category_id)
WHERE category.name = 'Horror'\G


-- Alternative Storage Engines

SHOW ENGINES;

