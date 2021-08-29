USE sakila

SELECT DISTINCT first_name
FROM actor JOIN film_actor USING (actor_id);

SELECT first_name
FROM actor JOIN film_actor USING (actor_id)
LIMIT 5;

SELECT DISTINCT first_name, last_name
FROM actor JOIN film_actor USING (actor_id);
