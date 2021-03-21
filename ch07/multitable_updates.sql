SELECT name category, title, rating
FROM film JOIN film_category USING (film_id)
JOIN category USING (category_id)
WHERE name = 'Horror';

SELECT COUNT(title)
FROM film JOIN film_category USING (film_id)
JOIN category USING (category_id)
WHERE name = 'Horror' AND rating <> 'R';

UPDATE film JOIN film_category USING (film_id)
JOIN category USING (category_id)
SET rating = 'R' WHERE category.name = 'Horror';
