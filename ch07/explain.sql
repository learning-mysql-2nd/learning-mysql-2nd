EXPLAIN SELECT * FROM actor WHERE actor_id IN
(SELECT actor_id FROM film_actor JOIN
film USING (film_id)
WHERE title = 'ZHIVAGO CORE');

EXPLAIN SELECT * FROM actor WHERE actor_id IN
(SELECT actor_id FROM film_actor
WHERE film_id = 11);

SHOW WARNINGS\G

EXPLAIN SELECT first_name, last_name FROM actor
JOIN film_actor USING (actor_id)
JOIN film USING (film_id)
JOIN film_category USING (film_id)
JOIN category USING (category_id)
WHERE category.name = 'Horror';

EXPLAIN ANALYZE SELECT first_name, last_name FROM actor
JOIN film_actor USING (actor_id)
JOIN film USING (film_id)
JOIN film_category USING (film_id)
JOIN category USING (category_id)
WHERE category.name = 'Horror'\G
