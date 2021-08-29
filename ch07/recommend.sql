CREATE TABLE recommend (
    film_id SMALLINT UNSIGNED,
    language_id TINYINT UNSIGNED,
    release_year YEAR,
    title VARCHAR(128),
    length SMALLINT UNSIGNED,
    sequence_id SMALLINT AUTO_INCREMENT,
    PRIMARY KEY (sequence_id)
);

INSERT INTO recommend (film_id, language_id, release_year, title, length)
SELECT film_id, language_id, release_year, title, length
FROM film ORDER BY RAND() LIMIT 10;

SELECT * FROM recommend;
