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
