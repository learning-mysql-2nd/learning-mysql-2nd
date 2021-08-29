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
