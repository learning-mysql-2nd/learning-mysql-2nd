REPLACE INTO actor VALUES (1, 'Penelope', 'Guiness', NOW());

REPLACE actor_2 VALUES (1, 'Penelope', 'Guiness', NOW());

REPLACE INTO actor_2 VALUES (1, 'Penelope', 'Guiness', NOW());

REPLACE INTO actor_2 (actor_id, first_name, last_name)
VALUES (1, 'Penelope', 'Guiness');

REPLACE actor_2 (actor_id, first_name, last_name)
VALUES (1, 'Penelope', 'Guiness');

REPLACE actor_2 SET actor_id = 1,
first_name = 'Penelope', last_name = 'Guiness';

REPLACE actor_2 (actor_id, first_name, last_name)
VALUES (2, 'Nick', 'Wahlberg'),
(3, 'Ed', 'Chase');

REPLACE actor_2 (actor_id, first_name, last_name)
VALUES (1000, 'William', 'Dyer');

REPLACE INTO recommend SELECT film_id, language_id,
release_year, title, length, 7 FROM film
ORDER BY RAND() LIMIT 1;

INSERT INTO actor (actor_id, first_name, last_name) VALUES (1, 'Penelope', 'Guiness')
ON DUPLICATE KEY UPDATE first_name = 'Penelope', last_name = 'Guiness';

INSERT INTO actor VALUES (1, 'Penelope', 'Guiness', NOW())
ON DUPLICATE KEY UPDATE
actor_id = 1, first_name = 'Penelope',
last_name = 'Guiness', last_update = NOW();

INSERT INTO actor (actor_id, first_name, last_name) VALUES
(1, 'Penelope', 'Guiness'), (2, 'Nick', 'Wahlberg'),
(3, 'Ed', 'Chase'), (1001, 'William', 'Dyer')
ON DUPLICATE KEY UPDATE first_name = VALUES(first_name),
last_name = VALUES(last_name);
