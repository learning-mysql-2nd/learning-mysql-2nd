CREATE DATABASE nasa;

USE nasa;

CREATE TABLE facilities (
    center TEXT
  , center_search_status TEXT
  , facility TEXT
  , facility_url TEXT
  , occupied TEXT
  , status TEXT
  , url_link TEXT
  , record_date DATETIME
  , last_update TIMESTAMP
  , country TEXT
  , contact TEXT
  , phone TEXT
  , location TEXT
  , city TEXT
  , state TEXT
  , zipcode TEXT
);

LOAD DATA INFILE '/var/lib/mysql-files/NASA_Facilities.csv'
INTO TABLE facilities FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 LINES
(center, center_search_status, facility, facility_url,
occupied, status, url_link, @var_record_date, @var_last_update,
country, contact, phone, location, city, state, zipcode)
SET record_date = IF(
  CHAR_LENGTH(@var_record_date)=0, NULL,
    STR_TO_DATE(@var_record_date, '%m/%d/%Y %h:%i:%s %p')
),
last_update = IF(
  CHAR_LENGTH(@var_last_update)=0, NULL,
    STR_TO_DATE(@var_last_update, '%m/%d/%Y %h:%i:%s %p')
);

SELECT facility, occupied, last_update
FROM facilities
ORDER BY last_update DESC LIMIT 5;
