DROP TABLE restaurant;
DROP TABLE reviews;
DROP TABLE menu;
DROP TABLE location;
DROP TABLE country;
DROP TABLE continent;

-- Create the tables in the schema.
CREATE TABLE restaurant (
    name char(25) not null,
    pricing char(5) not null,
    menukey decimal(3, 0) not null,
    locationkey decimal(3,0) not null,
    reviewkey decimal(3,0) not null
);

CREATE TABLE reviews (
    user char(25) not null,
    stars decimal(1, 0) not null,
    reviewkey decimal(3,0) not null
);

CREATE TABLE menu (
    item varchar(30) not null,
    cost decimal(5,2) not null,
    menukey decimal(3, 0) not null
);

CREATE TABLE location (
    address varchar(152) not null,
    locationkey decimal(3,0) not null
);

CREATE TABLE country (
    name char(25) not null,
    locationkey decimal(3,0) not null,
    countrykey decimal(3,0) not null,
    continentkey decimal(3,0) not null
);

CREATE TABLE continent (
    name char(25) not null,
    continentkey decimal(3,0) not null
);

-- Populate every table with the corresponding data.
-- 1.
-- Restaurant

-- not sure how to import yet, manually inputting
-- .import data/restaurant.tbl Restaurant

INSERT INTO restaurant(name, pricing, menukey, locationkey, reviewkey)
    VALUES ("Restaurant Anzu", "$$$", 1, 1, 1);
-- Reviews
INSERT INTO reviews(user, stars, reviewkey)
    VALUES ("Ileyka W.", 5, 1);
-- Menu
INSERT INTO menu(item, cost, menukey)
    VALUES ("Garlic Chili Edamame", 14, 1);
INSERT INTO menu(item, cost, menukey)
    VALUES ("Honey Soy Glazed Chicken Wings", 16, 1);
-- Location
INSERT INTO location(address, locationkey)
    VALUES ("222 Mason St, San Francisco, CA 94102", 1);
-- Country
INSERT INTO country(name, locationkey, countrykey, continentkey)
    VALUES ("USA", 1, 1, 1);
-- Continent
INSERT INTO continent(name, continentkey)
    VALUES ("North America", 1);