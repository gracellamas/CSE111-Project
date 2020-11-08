DROP TABLE Restaurant;
DROP TABLE Reviews;
DROP TABLE Menu;
DROP TABLE Location;
DROP TABLE Country;
DROP TABLE Continent;

-- Create the tables in the schema.
CREATE TABLE Restaurant (
    name char(25) not null,
    pricing char(5) not null,
    menukey decimal(3, 0) not null,
    locationkey decimal(3,0) not null,
    reviewkey decimal(3,0) not null
);

CREATE TABLE Reviews (
    user char(25) not null,
    stars decimal(1, 0) not null,
    reviewkey decimal(3,0) not null
);

CREATE TABLE Menu (
    item varchar(30) not null,
    cost char(20) not null,
    menukey decimal(3, 0) not null
);

CREATE TABLE Location (
    address varchar(152) not null,
    locationkey decimal(3,0) not null
);

CREATE TABLE Country (
    name char(25) not null,
    locationkey decimal(3,0) not null,
    countrykey decimal(3,0) not null,
    continentkey decimal(3,0) not null
);

CREATE TABLE Continent (
    name char(25) not null,
    continentkey decimal(3,0) not null
);

-- Populate every table with the corresponding data.
-- 1.
-- Restaurant

-- not sure how to import yet, manually inputting
-- .import data/Restaurant.tbl Restaurant

INSERT INTO Restaurant(name, pricing, menukey, locationkey, reviewkey)
    VALUES ("Restaurant Anzu", "$$$", 1, 1, 1);
-- Reviews
INSERT INTO Reviews(user, stars, reviewkey)
    VALUES ("Ileyka W.", 5, 1);
-- Menu
INSERT INTO Menu(item, cost, menukey)
    VALUES ("Garlic Chili Edamame", "$14", 1);
INSERT INTO Menu(item, cost, menukey)
    VALUES ("Honey Soy Glazed Chicken Wings", "$16", 1);
-- Location
INSERT INTO Location(address, locationkey)
    VALUES ("222 Mason St, San Francisco, CA 94102", 1);
-- Country
INSERT INTO Country(name, locationkey, countrykey, continentkey)
    VALUES ("USA", 1, 1, 1);
INSERT INTO Continent(name, continentkey)
    VALUES ("North America", 1);