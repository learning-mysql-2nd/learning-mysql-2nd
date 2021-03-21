CREATE TABLE report (title VARCHAR(128), category VARCHAR(25))
SELECT title, name AS category FROM
film JOIN film_category USING (film_id)
JOIN category USING (category_id);

SELECT * FROM report LIMIT 5;
