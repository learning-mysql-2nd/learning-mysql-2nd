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
