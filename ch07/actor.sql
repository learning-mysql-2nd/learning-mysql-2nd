CREATE TABLE actor_2 LIKE actor;

CREATE TABLE actor_2 AS SELECT * from actor;

CREATE TABLE actor_2 (UNIQUE(actor_id))
AS SELECT * from actor;

CREATE TABLE actor_3 (
    actor_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT
  , first_name VARCHAR(45) NOT NULL
  , last_name VARCHAR(45) NOT NULL
  , last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  , PRIMARY KEY (`actor_id`)
  , KEY `idx_actor_last_name` (`last_name`)
) SELECT * FROM actor;
