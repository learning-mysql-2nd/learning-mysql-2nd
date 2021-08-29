USE sakila

SELECT CONCAT("INSERT INTO actor VALUES", "(",actor_id,",'",first_name,"','", last_name,"','",last_update,"');")
AS insert_statement FROM actor LIMIT 1\G
