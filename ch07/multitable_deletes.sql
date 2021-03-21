SELECT * FROM inventory WHERE NOT EXISTS
(SELECT 1 FROM rental WHERE
rental.inventory_id = inventory.inventory_id);

DELETE FROM inventory WHERE NOT EXISTS
(SELECT 1 FROM rental WHERE
rental.inventory_id = inventory.inventory_id);

DELETE inventory FROM inventory LEFT JOIN rental
USING (inventory_id) WHERE rental.inventory_id IS NULL;

DELETE FROM inventory USING inventory
LEFT JOIN rental USING (inventory_id)
WHERE rental.inventory_id IS NULL;

DELETE FROM film WHERE NOT EXISTS
(SELECT 1 FROM inventory WHERE
film.film_id = inventory.film_id);

DELETE FROM film_actor, film USING
film JOIN film_actor USING (film_id)
LEFT JOIN inventory USING (film_id)
WHERE inventory.film_id IS NULL;

BEGIN;

DELETE FROM film_actor USING
film JOIN film_actor USING (film_id)
LEFT JOIN inventory USING (film_id)
WHERE inventory.film_id IS NULL;

DELETE FROM film_category USING
film JOIN film_category USING (film_id)
LEFT JOIN inventory USING (film_id)
WHERE inventory.film_id IS NULL;

DELETE FROM film USING
film LEFT JOIN inventory USING (film_id)
WHERE inventory.film_id IS NULL;

ROLLBACK;

SET foreign_key_checks=0;

BEGIN;

DELETE FROM film, film_actor, film_category
USING film JOIN film_actor USING (film_id)
JOIN film_category USING (film_id)
LEFT JOIN inventory USING (film_id)
WHERE inventory.film_id IS NULL;

ROLLBACK;

SET foreign_key_checks=1;

BEGIN;

DELETE FROM film_actor, film_category USING
film JOIN film_actor USING (film_id)
JOIN film_category USING (film_id)
LEFT JOIN inventory USING (film_id)
WHERE inventory.film_id IS NULL;

DELETE FROM film USING
film LEFT JOIN inventory USING (film_id)
WHERE inventory.film_id IS NULL;

ROLLBACK;
