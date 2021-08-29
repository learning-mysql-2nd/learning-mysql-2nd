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
