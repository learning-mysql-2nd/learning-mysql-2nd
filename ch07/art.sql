CREATE DATABASE art;

USE art;

CREATE TABLE people (
    person_id SMALLINT UNSIGNED
  , first_name VARCHAR(45)
  , last_name VARCHAR(45)
  , PRIMARY KEY (person_id)
);

INSERT INTO art.people (person_id, first_name, last_name)
SELECT actor_id, first_name, last_name FROM sakila.actor;
