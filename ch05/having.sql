USE sakila

SELECT first_name, last_name, COUNT(film_id)
FROM actor INNER JOIN film_actor USING (actor_id)
GROUP BY actor_id, first_name, last_name
HAVING COUNT(film_id) > 40
ORDER BY COUNT(film_id) DESC;

SELECT title, COUNT(rental_id) AS num_rented FROM
film INNER JOIN inventory USING (film_id)
INNER JOIN rental USING (inventory_id)
GROUP BY title
HAVING num_rented > 30
ORDER BY num_rented DESC LIMIT 5;

SELECT first_name, last_name, COUNT(film_id) AS film_cnt FROM
actor INNER JOIN film_actor USING (actor_id)
GROUP BY actor_id, first_name, last_name
HAVING first_name = 'EMILY' AND last_name = 'DEE';

SELECT first_name, last_name, COUNT(film_id) AS film_cnt FROM
actor INNER JOIN film_actor USING (actor_id)
WHERE first_name = 'EMILY' AND last_name = 'DEE'
GROUP BY actor_id, first_name, last_name;
