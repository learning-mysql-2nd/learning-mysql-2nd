USE sakila

SELECT first_name FROM actor
UNION
SELECT first_name FROM customer
UNION
SELECT title FROM film;

(SELECT title, COUNT(rental_id) AS num_rented
FROM film JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
GROUP BY title ORDER BY num_rented DESC LIMIT 5)
UNION
(SELECT title, COUNT(rental_id) AS num_rented
FROM film JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
GROUP BY title ORDER BY num_rented ASC LIMIT 5);

SELECT first_name FROM actor WHERE actor_id = 88
UNION
SELECT first_name FROM actor WHERE actor_id = 169;

(SELECT title, rental_date, return_date
FROM film JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
WHERE film_id = 998);

(SELECT title, rental_date, return_date
FROM film JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
WHERE film_id = 998
ORDER BY rental_date ASC);

(SELECT title, rental_date, return_date
FROM film JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
WHERE film_id = 998
ORDER BY rental_date ASC LIMIT 5);

(SELECT title, rental_date, return_date
FROM film JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
WHERE film_id = 998
ORDER BY rental_date ASC)
UNION ALL
(SELECT title, rental_date, return_date
FROM film JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
WHERE film_id = 998
ORDER BY rental_date ASC LIMIT 5);

(SELECT title, rental_date, return_date
FROM film JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
WHERE film_id = 998
ORDER BY rental_date ASC)
UNION ALL
(SELECT title, rental_date, return_date
FROM film JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
WHERE film_id = 998
ORDER BY rental_date ASC LIMIT 5)
ORDER BY rental_date DESC;

(SELECT first_name, last_name FROM actor WHERE actor_id < 5)
UNION
(SELECT first_name, last_name FROM actor WHERE actor_id > 190)
ORDER BY first_name LIMIT 4;

SELECT first_name, last_name FROM actor
WHERE actor_id < 5 OR actor_id > 190
ORDER BY first_name LIMIT 4;
