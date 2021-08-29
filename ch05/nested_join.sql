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
