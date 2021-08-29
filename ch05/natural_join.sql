USE sakila

SELECT first_name, last_name, film_id
FROM actor_info NATURAL JOIN film_actor
LIMIT 20;

SELECT first_name, last_name, film_id FROM
actor_info JOIN film_actor
WHERE (actor_info.actor_id = film_actor.actor_id)
LIMIT 20;

SELECT first_name, last_name, film_id FROM actor NATURAL JOIN film_actor;

EXPLAIN SELECT first_name, last_name, film_id FROM actor NATURAL JOIN film_actor;

SHOW WARNINGS\G
