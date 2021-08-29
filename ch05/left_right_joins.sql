USE sakila

SELECT title, rental_date
FROM film LEFT JOIN inventory USING (film_id)
LEFT JOIN rental USING (inventory_id);

SELECT title, rental_date
FROM rental LEFT JOIN inventory USING (inventory_id)
LEFT JOIN film USING (film_id)
ORDER BY rental_date DESC;

SELECT email, name AS category_name, COUNT(cat.category_id) AS cnt
FROM customer cs INNER JOIN rental USING (customer_id)
INNER JOIN inventory USING (inventory_id)
INNER JOIN film_category USING (film_id)
INNER JOIN category cat USING (category_id)
GROUP BY email, category_name
ORDER BY cnt DESC LIMIT 5;

SELECT COUNT(*) FROM category;

SELECT email, name AS category_name, COUNT(category_id) AS cnt
FROM category cat LEFT JOIN film_category USING (category_id)
LEFT JOIN inventory USING (film_id)
LEFT JOIN rental USING (inventory_id)
JOIN customer cs ON rental.customer_id = cs.customer_id
WHERE cs.email = 'WESLEY.BULL@sakilacustomer.org'
GROUP BY email, category_name
ORDER BY cnt DESC;

INSERT INTO category(name) VALUES ('Thriller');

SELECT cat.name, COUNT(rental_id) cnt
FROM category cat LEFT JOIN film_category USING (category_id)
LEFT JOIN inventory USING (film_id)
LEFT JOIN rental USING (inventory_id)
LEFT JOIN customer cs ON rental.customer_id = cs.customer_id
GROUP BY 1
ORDER BY 2 DESC;

SELECT title, rental_date
FROM rental RIGHT JOIN inventory USING (inventory_id)
RIGHT JOIN film USING (film_id)
ORDER BY rental_date DESC;
