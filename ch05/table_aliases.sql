USE sakila

SELECT ac.actor_id, ac.first_name, ac.last_name, fl.title FROM
actor AS ac INNER JOIN film_actor AS fla USING (actor_id)
INNER JOIN film AS fl USING (film_id)
WHERE fl.title = 'AFFAIR PREJUDICE';

SELECT ac.actor_id, ac.first_name, ac.last_name, fl.title FROM
actor AS ac INNER JOIN film_actor AS fla USING (actor_id)
INNER JOIN film AS fl USING (film_id)
WHERE film.title = 'AFFAIR PREJUDICE';

SELECT * FROM film WHERE title = title;

SELECT m1.film_id, m2.title
FROM film AS m1, film AS m2
WHERE m1.title = m2.title;

SELECT m1.film_id, m2.title
FROM film AS m1, film AS m2
WHERE m1.title = m2.title
AND m1.film_id <> m2.film_id;
