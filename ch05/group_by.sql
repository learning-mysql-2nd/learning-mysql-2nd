USE sakila

SELECT first_name FROM actor
WHERE first_name IN ('GENE', 'MERYL');

SELECT first_name FROM actor
WHERE first_name IN ('GENE', 'MERYL')
GROUP BY first_name;

SELECT first_name, last_name, film_id
FROM actor INNER JOIN film_actor USING (actor_id)
ORDER BY first_name, last_name LIMIT 20;

SELECT first_name, last_name, COUNT(film_id) AS num_films FROM
actor INNER JOIN film_actor USING (actor_id)
GROUP BY first_name, last_name
ORDER BY num_films DESC LIMIT 5;

SELECT title, name AS category_name, COUNT(*) AS cnt
FROM film INNER JOIN film_actor USING (film_id)
INNER JOIN film_category USING (film_id)
INNER JOIN category USING (category_id)
GROUP BY film_id, category_id
ORDER BY cnt DESC LIMIT 5;

SELECT email, name AS category_name, COUNT(category_id) AS cnt
FROM customer cs INNER JOIN rental USING (customer_id)
INNER JOIN inventory USING (inventory_id)
INNER JOIN film_category USING (film_id)
INNER JOIN category cat USING (category_id)
GROUP BY email, category_name
ORDER BY cnt DESC LIMIT 5;

SELECT COUNT(*) FROM actor GROUP BY first_name, last_name;

SELECT a1.actor_id, a1.first_name, a1.last_name
FROM actor AS a1, actor AS a2
WHERE a1.first_name = a2.first_name
AND a1.last_name = a2.last_name
AND a1.actor_id <> a2.actor_id;
