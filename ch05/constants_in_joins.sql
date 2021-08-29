USE sakila

SELECT first_name, last_name, title
FROM actor JOIN film_actor USING (actor_id)
JOIN film USING (film_id)
WHERE actor_id = 11;

SELECT first_name, last_name, title
FROM actor JOIN film_actor
ON actor.actor_id = film_actor.actor_id
AND actor.actor_id = 11
JOIN film USING (film_id);

SELECT email, name AS category_name, COUNT(rental_id) AS cnt
FROM category cat LEFT JOIN film_category USING (category_id)
LEFT JOIN inventory USING (film_id)
LEFT JOIN rental USING (inventory_id)
LEFT JOIN customer cs USING (customer_id)
WHERE cs.email = 'WESLEY.BULL@sakilacustomer.org'
GROUP BY email, category_name
ORDER BY cnt DESC;

SELECT email, name AS category_name, COUNT(rental_id) AS cnt
FROM category cat LEFT JOIN film_category USING (category_id)
LEFT JOIN inventory USING (film_id)
LEFT JOIN rental USING (inventory_id)
LEFT JOIN customer cs ON rental.customer_id = cs.customer_id
AND cs.email = 'WESLEY.BULL@sakilacustomer.org'
GROUP BY email, category_name
ORDER BY cnt DESC;
