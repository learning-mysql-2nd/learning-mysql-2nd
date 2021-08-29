USE sakila

SELECT first_name, last_name FROM
actor JOIN film_actor USING (actor_id)
JOIN film USING (film_id)
WHERE title = 'ZHIVAGO CORE';

SELECT first_name, last_name FROM
actor JOIN film_actor USING (actor_id)
WHERE film_id = (SELECT film_id FROM film
WHERE title = 'ZHIVAGO CORE');

SELECT film_id FROM film WHERE title = 'ZHIVAGO CORE';

SELECT first_name, last_name
FROM actor JOIN film_actor USING (actor_id)
WHERE film_id = 998;

SELECT MAX(rental_date) FROM rental
JOIN customer USING (customer_id)
WHERE email = 'WESLEY.BULL@sakilacustomer.org';

SELECT title FROM film
JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
JOIN customer USING (customer_id)
WHERE email = 'WESLEY.BULL@sakilacustomer.org'
AND rental_date = '2005-08-23 15:46:33';

SELECT title FROM film JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
WHERE rental_date = (SELECT MAX(rental_date) FROM rental
JOIN customer USING (customer_id)
WHERE email = 'WESLEY.BULL@sakilacustomer.org');
