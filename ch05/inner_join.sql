USE sakila

SELECT first_name, last_name, film_id FROM
actor INNER JOIN film_actor USING (actor_id)
LIMIT 20;

SELECT first_name, last_name, film_id
FROM actor, film_actor
WHERE actor.actor_id = film_actor.actor_id
LIMIT 20;

SELECT first_name, last_name, film_id FROM
actor INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
LIMIT 20;

SELECT first_name, last_name, film_id
FROM actor, film_actor LIMIT 20;

SELECT COUNT(*) FROM actor, film_actor;

SELECT first_name, last_name, film_id
FROM actor INNER JOIN film_actor;
