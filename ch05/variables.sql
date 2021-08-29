USE sakila

SELECT @film:=title FROM film WHERE film_id = 1;

SELECT @film;

SELECT @film:=title FROM film WHERE film_id = 1;

SHOW WARNINGS\G

SET @film := (SELECT title FROM film WHERE film_id = 1);

SELECT @film;

SELECT title INTO @film FROM film WHERE film_id = 1;

SELECT @film;

SET @counter := 0;

SET @counter = 0, @age := 23;

SELECT 0 INTO @counter;

SELECT 0, 23 INTO @counter, @age;

SELECT MAX(rental_date) FROM rental
JOIN customer USING (customer_id)
WHERE email = 'WESLEY.BULL@sakilacustomer.org';

SELECT title FROM film
JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
JOIN customer USING (customer_id)
WHERE email = 'WESLEY.BULL@sakilacustomer.org'
AND rental_date = '2005-08-23 15:46:33';

SELECT MAX(rental_date) INTO @recent FROM rental
JOIN customer USING (customer_id)
WHERE email = 'WESLEY.BULL@sakilacustomer.org';

SELECT title FROM film
JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
JOIN customer USING (customer_id)
WHERE email = 'WESLEY.BULL@sakilacustomer.org'
AND rental_date = @recent;

SELECT @fid, @fid:=film.film_id, @fid FROM film, inventory
WHERE inventory.film_id = @fid;

SELECT @fid, @fid:=film.film_id, @fid FROM film, inventory
WHERE inventory.film_id = film.film_id LIMIT 20;

SELECT @fid, @fid:=film.film_id, @fid FROM film, inventory
WHERE inventory.film_id = film.film_id LIMIT 20;
