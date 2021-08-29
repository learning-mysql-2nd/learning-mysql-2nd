--
-- Every piece of SQL used in Chapter 5 "Advanced Querying"
--


-- Column Aliases

USE sakila

SELECT first_name AS 'First Name', last_name AS 'Last Name'
FROM actor LIMIT 5;

SELECT CONCAT(first_name, ' ', last_name, ' played in ', title) AS movie
FROM actor JOIN film_actor USING (actor_id)
JOIN film USING (film_id)
ORDER BY movie LIMIT 20;

SELECT CONCAT(first_name, " ", last_name, " played in ", title) AS movie
FROM actor JOIN film_actor USING (actor_id)
JOIN film USING (film_id)
ORDER BY CONCAT(first_name, " ", last_name, " played in ", title)
LIMIT 20;

SELECT first_name AS name FROM actor WHERE name = 'ZERO CAGE';

SELECT actor_id AS id FROM actor WHERE first_name = 'ZERO';

SELECT actor_id id FROM actor WHERE first_name = 'ZERO';

-- Table Aliases

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

-- The DISTINCT Clause

USE sakila

SELECT DISTINCT first_name
FROM actor JOIN film_actor USING (actor_id);

SELECT first_name
FROM actor JOIN film_actor USING (actor_id)
LIMIT 5;

SELECT DISTINCT first_name, last_name
FROM actor JOIN film_actor USING (actor_id);

-- The GROUP BY Clause

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

-- Aggregate functions

USE sakila

SELECT COUNT(*) FROM customer;

SELECT COUNT(email) FROM customer;

-- The HAVING Clause

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

-- The Inner Join

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

-- The Union

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

-- The Left and Right Joins

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

-- The Natural Join

USE sakila

SELECT first_name, last_name, film_id
FROM actor_info NATURAL JOIN film_actor
LIMIT 20;

SELECT first_name, last_name, film_id FROM
actor_info JOIN film_actor
WHERE (actor_info.actor_id = film_actor.actor_id)
LIMIT 20;

SELECT first_name, last_name, film_id FROM actor NATURAL JOIN film_actor;

EXPLAIN SELECT first_name, last_name, film_id FROM actor NATURAL JOIN film_actor;

SHOW WARNINGS\G

-- Constant expressions in joins

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

-- Nested Query Basics

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

-- Using ANY and IN

USE employees

SELECT emp_no, first_name, last_name, hire_date
FROM employees JOIN titles USING (emp_no)
WHERE title = 'Assistant Engineer'
AND hire_date < ANY (SELECT hire_date FROM
employees JOIN titles USING (emp_no)
WHERE title = 'Manager');

SELECT hire_date FROM
employees JOIN titles USING (emp_no)
WHERE title = 'Manager';

SELECT emp_no, first_name, last_name
FROM employees JOIN titles USING (emp_no)
WHERE title = 'Manager'
AND emp_no = ANY (SELECT emp_no FROM employees
JOIN titles USING (emp_no) WHERE
title <> 'Manager');

SELECT emp_no, first_name, last_name
FROM employees JOIN titles USING (emp_no)
WHERE title = 'Manager'
AND emp_no IN (SELECT emp_no FROM employees
JOIN titles USING (emp_no) WHERE
title <> 'Manager');

SELECT DISTINCT emp_no, first_name, last_name
FROM employees JOIN titles mgr USING (emp_no)
JOIN titles nonmgr USING (emp_no)
WHERE mgr.title = 'Manager'
AND nonmgr.title <> 'Manager';

-- Using ALL

USE employees

SELECT emp_no, first_name, last_name, hire_date
FROM employees JOIN titles USING (emp_no)
WHERE title = 'Assistant Engineer'
AND hire_date < ALL (SELECT hire_date FROM
employees JOIN titles USING (emp_no)
WHERE title = 'Manager');

(SELECT 'Assistant Engineer' AS title,
MIN(hire_date) AS mhd FROM employees
JOIN titles USING (emp_no)
WHERE title = 'Assistant Engineer')
UNION
(SELECT 'Manager' title, MIN(hire_date) mhd FROM employees
JOIN titles USING (emp_no)
WHERE title = 'Manager');

SELECT emp_no, first_name, last_name
FROM employees JOIN titles USING (emp_no)
WHERE title = 'Manager' AND emp_no NOT IN
(SELECT emp_no FROM titles
WHERE title = 'Senior Staff');

-- Writing row subqueries

USE employees

SELECT mgr.emp_no, YEAR(mgr.from_date) AS fd
FROM titles AS mgr, titles AS other
WHERE mgr.emp_no = other.emp_no
AND mgr.title = 'Manager'
AND mgr.title <> other.title
AND YEAR(mgr.from_date) = YEAR(other.from_date);

SELECT emp_no, YEAR(from_date) AS fd
FROM titles WHERE title = 'Manager' AND
(emp_no, YEAR(from_date)) IN
(SELECT emp_no, YEAR(from_date)
FROM titles WHERE title <> 'Manager');

SELECT first_name, last_name
FROM employees, titles
WHERE (employees.emp_no, first_name, last_name, title) =
(titles.emp_no, 'Marjo', 'Giarratana', 'Senior Staff');

-- EXISTS and NOT EXISTS basics

USE sakila

SELECT COUNT(*) FROM film
WHERE EXISTS (SELECT * FROM rental);

SELECT title FROM film
WHERE EXISTS (SELECT * FROM film
WHERE title = 'IS THIS A MOVIE?');

SELECT * FROM actor WHERE NOT EXISTS
(SELECT * FROM film WHERE title = 'ZHIVAGO CORE');

-- Correlated subqueries

USE sakila

SELECT first_name, last_name FROM staff
WHERE EXISTS (SELECT * FROM customer
WHERE customer.first_name = staff.first_name
AND customer.last_name = staff.last_name);

INSERT INTO customer(store_id, first_name, last_name,
email, address_id, create_date)
VALUES (1, 'Mike', 'Hillyer',
'Mike.Hillyer@sakilastaff.com', 3, NOW());

SELECT first_name, last_name FROM staff
WHERE EXISTS (SELECT * FROM customer
WHERE customer.first_name = staff.first_name
AND customer.last_name = staff.last_name);

SELECT * FROM customer WHERE customer.first_name = staff.first_name;

SELECT COUNT(*) FROM film WHERE EXISTS
(SELECT film_id FROM inventory
WHERE inventory.film_id = film.film_id
GROUP BY film_id HAVING COUNT(*) >= 2);

USE employees

SELECT emp_no, first_name, last_name
FROM employees JOIN titles USING (emp_no)
WHERE title = 'Manager'
AND emp_no IN (SELECT emp_no FROM employees
JOIN titles USING (emp_no) WHERE
title <> 'Manager');

SELECT emp_no, first_name, last_name
FROM employees JOIN titles USING (emp_no)
WHERE title = 'Manager'
AND EXISTS (SELECT emp_no FROM titles
WHERE titles.emp_no = employees.emp_no
AND title <> 'Manager');

SELECT emp_no, first_name, last_name
FROM employees JOIN titles USING (emp_no)
WHERE title = 'Manager'
AND emp_no IN (SELECT emp_no FROM titles
WHERE titles.emp_no = employees.emp_no
AND title <> 'Manager');

SELECT emp_no, first_name, last_name
FROM employees JOIN titles USING (emp_no)
WHERE title = 'Manager'
AND emp_no = (SELECT emp_no FROM titles
WHERE titles.emp_no = employees.emp_no
AND title <> 'Manager');

SELECT emp_no, first_name, last_name
FROM employees JOIN titles USING (emp_no)
WHERE title = 'Manager'
AND emp_no = (SELECT emp_no FROM titles
WHERE titles.emp_no = employees.emp_no
AND title = 'Senior Engineer');

-- Nested Queries in the FROM Clause

USE employees

SELECT emp_no, monthly_salary FROM
(SELECT emp_no, salary/12 AS monthly_salary FROM salaries) AS ms
LIMIT 5;

SELECT emp_no, monthly_salary FROM
(SELECT emp_no, salary/12 AS monthly_salary FROM salaries)
LIMIT 5;

USE sakila

SELECT AVG(gross) FROM
(SELECT SUM(amount) AS gross
FROM payment JOIN rental USING (rental_id)
JOIN inventory USING (inventory_id)
JOIN film USING (film_id)
GROUP BY film_id) AS gross_amount;

SELECT SUM(amount) AS gross
FROM payment JOIN rental USING (rental_id)
JOIN inventory USING (inventory_id)
JOIN film USING (film_id)
GROUP BY film_id;

SELECT AVG(SUM(amount)) AS avg_gross
FROM payment JOIN rental USING (rental_id)
JOIN inventory USING (inventory_id)
JOIN film USING (film_id) GROUP BY film_id;

-- Nested Queries in JOINs

USE sakila

SELECT cat.name AS category_name, COUNT(cat.category_id) AS cnt
FROM category AS cat LEFT JOIN film_category USING (category_id)
LEFT JOIN inventory USING (film_id)
LEFT JOIN rental USING (inventory_id)
JOIN customer AS cs ON rental.customer_id = cs.customer_id
WHERE cs.email = 'WESLEY.BULL@sakilacustomer.org'
GROUP BY category_name ORDER BY cnt DESC;

SELECT cat.name AS category_name, cnt
FROM category AS cat
LEFT JOIN (SELECT cat.name, COUNT(cat.category_id) AS cnt
FROM category AS cat
LEFT JOIN film_category USING (category_id)
LEFT JOIN inventory USING (film_id)
LEFT JOIN rental USING (inventory_id)
JOIN customer cs ON rental.customer_id = cs.customer_id
WHERE cs.email = 'WESLEY.BULL@sakilacustomer.org'
GROUP BY cat.name) customer_cat USING (name)
ORDER BY cnt DESC;

-- User Variables

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
