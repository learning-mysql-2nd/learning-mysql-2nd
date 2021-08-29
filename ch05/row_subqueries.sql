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
