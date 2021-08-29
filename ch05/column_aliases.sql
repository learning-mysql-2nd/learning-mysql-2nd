USE sakila

SELECT first_name AS 'First Name', last_name AS 'Last Name'
FROM actor LIMIT 5;

SELECT CONCAT(first_name, ' ', last_name, ' played in ', title) AS movie
FROM actor JOIN film_actor USING (actor_id)
JOIN film USING (film_id)
ORDER BY movie LIMIT 20;

SELECT CONCAT(first_name, " ", last_name, " played in ", title) AS movie
FROM actor JOIN film_actor USING (actor_id)
JOIN film USING (film_id)
ORDER BY CONCAT(first_name, " ", last_name, " played in ", title)
LIMIT 20;

SELECT first_name AS name FROM actor WHERE name = 'ZERO CAGE';

SELECT actor_id AS id FROM actor WHERE first_name = 'ZERO';

SELECT actor_id id FROM actor WHERE first_name = 'ZERO';
