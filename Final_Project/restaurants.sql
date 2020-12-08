DROP TABLE restaurant;
DROP TABLE customer;
DROP TABLE reviews;
DROP TABLE menu;
DROP TABLE location;
DROP TABLE country;
DROP TABLE basket;

-- Create the tables in the schema.
CREATE TABLE restaurant (
    name char(25) not null,
    pricing char(5) not null,
    menukey decimal(3, 0) not null,
    locationkey decimal(3,0) not null,
    restaurantkey decimal(3,0) not null
);

CREATE TABLE customer (
    name varchar(25) not null,
    restaurantkey decimal(3, 0) not null,
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
    locationkey decimal(3,0) not null,
    countrykey decimal(3,0) not null
);

CREATE TABLE country (
    name char(25) not null,
    countrykey decimal(3,0) not null
);

CREATE TABLE basket (
    item varchar(30),
    cost decimal(5, 2)
);

-- Populate every table with the corresponding data.

-- Restaurant

-- notes: add more attributes i.e type of food (mexican, american, etc)
--   
INSERT INTO restaurant(name, pricing, menukey, locationkey, restaurantkey)
    VALUES 
        ("Restaurant Anzu", "$$$", 1, 1, 1), -- San Fran
        ("BAIA", "$$$", 2, 2, 2),
        ("Fog Harbor Fish House", "$$", 3, 3, 3),
        ("Cielito Lindo", "$", 4, 4, 4),
        ("Farmhouse Kitchen Thai Cuisine", "$$", 5, 5, 5),
        ("Burma Superstar", "$$", 6, 6, 6),
        ("Lily", "$$", 7, 7, 7),
        ("Po'Boys Kitchen", "$", 8, 8, 8),
        ("San Tung", "$$", 9, 9, 9),
        ("Sotto Mare Oysteria & Seafood", "$", 10, 10, 10),
        ("House of Prime Rib", "$$$", 11, 11, 11),
        ("Abu Salim Middle Eastern Grill", "$$$", 12, 12, 12),
        ("Spice of America", "$$", 13, 13, 13),

        ("In-N-Out", "$", 35, 35, 35),
        ("In-N-Out", "$", 36, 36, 36),

        ("The Mayfair Chippy", "$$", 14, 14, 14), -- UK
        ("Dishoom", "$$", 15, 15, 15),
        ("Restaurant Gordon Ramsay", "$$$$", 16, 16, 16),
        ("Duck & Waffle", "$$$", 17, 17, 17),
        ("Mother Mash", "$$", 18, 18, 18),
        ("Riddle and Fins The Lanes", "$$", 19, 19, 19), 
        ("The Basketmakers", "$$", 20, 20, 20),

        ("Contramar", "$$$", 21, 21, 21),-- Mexico
        ("El Cardenal", "$$", 22, 22, 22),
        ("Taqueria Los Cocuyos", "$", 23, 23, 23),
        ("Azul", "$$$", 24, 24, 24),
        ("Cafe Nin", "$$", 25, 25, 25),
        ("Lardo", "$$", 26, 26, 26),
        ("Pujol", "$$$$", 27, 27, 27),

        ("Falafel Plus", "$$", 28, 28, 28), -- Canada
        ("Pai Northern Thai Kitchen", "$$", 29, 29, 29),
        ("Seven Lives Tacos y Mariscos", "$", 30, 30, 30),
        ("Kinka Izakaya Original", "$$", 31, 31, 31),
        ("Banh Mi Boys", "$", 32, 32, 32),
        ("Richmond Station", "$$$", 33, 33, 33),
        ("Byblos", "$$$", 34, 34, 34);


-- Customer
INSERT INTO customer(name, restaurantkey, reviewkey)
    VALUES 
        ("Ileyka W.", 1, 1), -- Restaurant Anzu
        ("Roberta J.", 2, 2), -- BAIA
        ("Theart P.", 2, 3),
        ("Alice C.", 3, 4), -- Fog Harbor Fish House
        ("Jeff W.", 4, 5), -- Cielito Lindo
        ("Cathy L.", 5, 6), -- Farmhouse Kitchen Thai Cuisine
        ("Mitali N.", 5, 7),
        ("David S.", 6, 8), -- Burma Superstar
        ("Karen L.", 7, 9), -- Lily
        ("Jeff N.", 7, 10),
        ("Cherylynn N.", 8, 11), -- Po'Boys Kitchen
        ("Dirk T.", 8, 12), 
        ("Thomas C.", 9, 13), -- San Tung
        ("Sydney J.", 9, 14),
        ("John S.", 10, 15), -- Sotto Mare Oysteria & Seafood
        ("Carol N.", 11, 16), -- House of Prime Rib
        ("Phuong P.", 11, 17),

        ("Daniel R.", 14, 18), -- The Mayfair Chippy
        ("Anthony D.", 14, 19),
        ("Shane R.", 15, 20), -- Dishoom
        ("Patricia Z.", 15, 21),
        ("Mark B.", 16, 22), -- Restaurant Gordon Ramsay
        ("Joe D.", 16, 23),
        ("Robert C.", 17, 24), -- Duck & Waffle
        ("C￯﾿ﾃ￯ﾾﾩli. K.", 17, 25),
        ("Samantha K.", 18, 26), -- Mother Mash
        ("Chris H.", 18, 27),
        ("Dee C.", 19, 28), -- Riddle and Fins The 
        ("Rosquete B.", 19, 29),
        ("Ryan J.", 20, 30), -- The Basketmakers
        ("Tim D.", 20, 31),

        -- Contramar
        ("Bella T.", 21, 32),
        ("Juliana P.", 21, 33),
        -- El Cardenal
        ("Nithya M.", 22, 34),
        ("Aram K.", 22, 35), 
        -- Taqueria Los Cocuyos
        ("Shawn H.",23, 36), 
        ("Jackson C.", 23, 37),
        -- Azul
        ("Bianca M.", 24, 38),
        ("Tony Y.", 24, 39),
        ("Michelle C.", 24, 40),
        -- Cafe Nin
        ("Vermillian R.", 25, 41),
        ("Arturo R.", 25, 41),
        -- Lardo
        ("Cassandra S.", 26, 42),
        ("Magaly G.", 26, 43),
        -- Pujol
        ("Diesel P.", 27, 44),
        ("Alejandro H.", 27, 45),

        -- Falafel Plus
        ("Chris B.", 28, 46),
        ("Mehrzad N.", 28, 47),
        -- Pai Northern Thai Kitchen
        ("Yifu Z.", 29, 48),
        ("Angela Y.", 29, 49),
        -- Seven Lives Tacos y Mariscos
        ("Fiona L.", 30, 50),
        ("Liron P.", 30, 51),
        -- Kinka Izakaya Original
        ("Tammy N.", 31, 52), 
        ("Sandi L.", 31, 53),
        -- Banh Mi Boys
        ("Lester C.", 32, 54),
        ("Tomas D.", 32, 55),
        -- Richmond Station
        ("Billy L.", 33, 56),
        ("Dianna C.", 33, 57),
        -- Byblos
        ("Bojan P.", 34, 58),
        ("Hadia G.", 34, 59);


-- Reviews
INSERT INTO reviews(user, stars, reviewkey)
    VALUES 
        ("Ileyka W.", 5, 1),
        ("Roberta J.", 5, 2),
        ("Theart P.", 3, 3),
        ("Alice C.", 5, 4),
        ("Jeff W.", 5, 5),
        ("Cathy L.", 5, 6), 
        ("Mitali N.", 4, 7),
        ("David S.", 5, 8),
        ("Karen L.", 5, 9),
        ("Jeff N.", 3, 10),
        ("Cherylynn N.", 4, 11),
        ("Dirk T.", 5, 12), 
        ("Thomas C.", 5, 13),
        ("Sydney J.", 4, 14),
        ("John S.", 5, 15),
        ("Carol N.", 4, 16), -- House of Prime Rib
        ("Phuong P.", 5, 17),

        ("Daniel R.", 5, 18), -- The Mayfair Chippy
        ("Anthony D.", 1, 19),
        ("Shane R.", 5, 20),
        ("Patricia Z.", 3, 21),
        ("Mark B.", 5, 22), 
        ("Joe D.", 5, 23),
        ("Robert C.", 4, 24),
        ("C￯﾿ﾃ￯ﾾﾩli. K.", 5, 25),
        ("Samantha K.", 5, 26),
        ("Chris H.", 4, 27),
        ("Dee C.", 5, 28), -- Riddle and Fins The 
        ("Rosquete B.", 5, 29),
        ("Ryan J.", 5, 30), -- The Basketmakers
        ("Tim D.", 1, 31),

        ("Bella T.", 5, 32),
        ("Juliana P.", 4, 33),
        ("Nithya M.", 5, 34),
        ("Aram K.", 4, 35),
        ("Shawn H.", 5, 36), 
        ("Jackson C.", 3, 37),
        ("Bianca M.", 5, 38),
        ("Tony Y.", 4, 39),
        ("Michelle C.", 5, 40),
        -- ("Vermillian R.", 5, 41),
        ("Arturo R.", 2, 41),
        ("Cassandra S.", 5, 42),
        ("Magaly G.", 1, 43),
        ("Diesel P.", 5, 44),
        ("Alejandro H.", 3, 45),

        ("Chris B.", 5, 46),
        ("Mehrzad N.", 1, 47),
        ("Yifu Z.", 5, 48),
        ("Angela Y.", 3, 49),
        ("Fiona L.", 5, 50),
        ("Liron P.", 5, 51),
        ("Tammy N.", 5, 52), 
        ("Sandi L.", 4, 53),
        ("Lester C.", 5, 54),
        ("Tomas D.", 3, 55),
        ("Billy L.", 5, 56),
        ("Dianna C.", 4, 57),
        ("Bojan P.", 5, 58),
        ("Hadia G.", 4, 59);


-- Menu
INSERT INTO menu(item, cost, menukey)
    VALUES 
    -- Restaurant Anzu
    ("Garlic Chili Edamame", 14, 1),
    ("Honey Soy Glazed Chicken Wings", 16, 1),
    -- BAIA
    ("Lasagne", 27, 2),
    ("Cacio E Pepe", 23, 2),
    ("Caesar", 15, 2),
    -- Fog Harbor Fish House
    ("Clam Chowder (Bowl)", 9.50, 3),
    ("Dungness Crab Cakes", 19, 3),
    ("Mixed Grill", 31, 3),
    -- Cielito Lindo
    ("Quesabrilla", 3, 4),
    ("Tacos", 2, 4),
    ("Enchiladas", 5, 4),
    -- Farmhouse Kitchen Thai Cuisine
    ("Hat Yai Fried Chicken", 27.95, 5),
    ("Somasa", 12.50, 5),
    ("Pad Thai", 17.25, 5),
    -- Burma Superstar
    ("Tea Leaf Salad", 14, 6),
    ("Coconut Rice", 4, 6),
    ("Rainbow Salad", 14.50, 6),
    -- Lily
    ("Caramel Chicken Wings", 14, 7),
    ("Pea Leaf & Cilantro ", 14, 7),
    ("Shaking Beef Salad", 18, 7),
    -- Po'Boys Kitchen
    ("Cheese Cake", 7, 8),
    ("Baked Mac & Cheese", 10, 8),
    ("Sweet Patato Fries", 7, 8),
    -- San Tung
    ("Dry Fried Chicken", 10, 9),
    ("Black Bean Sauce Noodles", 9.50, 9),
    ("Shrimp with Chili Sauce", 14, 9),
    -- Sotto Mare Oysteria & Seafood
    ("Boston Clam Chowder", 7.50, 10),
    ("Smoked Salmon", 8, 10),
    -- House of Prime 
    ("House of Prime Rib ", 35, 11),
    ("Roast Beef", 30, 11),

    -- The Mayfair Chippy
    ("Cod", 11.25, 14),
    -- Dishoom
    ("Lamb Samosasm", 5.50, 15),
    ("Murgh Malai", 9.70, 15),
    ("Gunpowder Potatoes", 6.90, 15),
    -- Restaurant Gordon Ramsay
    ("Menu Prestige", 160, 16),
    -- Duck & Waffle
    ("BBQ-Spiced Crispy Pig Ears", 7, 17),
    ("Cornish Crab", 18, 17),
    ("Caramelized Banana", 13, 17),
    -- Mother Mash
    ("Mash Heaven w/ pie", 10.95, 18),
    ("Baked Beans", 1.65, 18),
    ("Warm Sausage Salad", 6.96, 18),
    ("Sticky Toffee", 4.95, 18),
    -- Riddle and Fins The Lanes
    ("New England Clam & Bacon Chowder", 7.50, 19),
    ("Calamari w/ Penut & Ginger Dipping Sauce", 8.50, 19),
    ("Risotto of the Day", 13.50, 19),
    -- The Basketmakers
    ("Mussels", 10, 20),
    ("Chips", 3, 20),
    ("Sunday Roast", 15, 20),

    -- Contramar
    ("Puntas de atun a las Brasas", 15.86, 21),
    ("Sopes", 4.63, 21),
    ("Green Salad", 7.32, 21),
    -- El Cardenal
    ("Gorditas Hidalguenses", 4, 22),
    ("Enchiladas michoacanas", 5, 22),
    ("Revueltos a La cazuela", 4, 22),
    -- Taqueria Los Cocuyos
    ("Tacos de Azada", 1, 23),
    ("Tacos de Maciza", 1, 23),
    ("Tacos de lengua", 1, 23),
    -- Azul
    ("Cazuelita de Escamoles", 16.26, 24),
    ("Tamalito de frijol negro", 5.48, 24),
    ("Sopa de tortilla", 8.25, 24),
    -- Cafe Nin
    ("Chilaquiles Verdes", 8, 25), 
    ("Vanilla Concha", 1, 25),
    ("Cappuccino", 2, 25),
    -- Lardo
    ("Seasonal Fruit Salad", 5, 26),
    ("Croissant, Ham and Gouda Cheese", 4, 26),
    ("Kombucha Tamarindo", 2, 26),
    -- Pujol
    ("Botanas", 50, 27),
    ("Mole Madre", 45, 27),
    ("Raspado de Miel", 30, 27),

    -- Falafel Plus
    ("Falafel", 10, 28),
    ("Chicken Shwarma", 14, 28),
    ("Zaater Pasteries", 7, 28),
    -- Pai Northern Thai Kitchen
    ("Khao Soi", 17.50, 29),
    ("Gaeng Kiaw Wan", 17, 29),
    ("Chef Nuit Pad Thai", 17.50, 29),
    -- Seven Lives Tacos y Mariscos
    ("Fish Tacos", 2, 30),
    ("Blackened Mahi Mahi", 10, 30),
    ("Smoked Tuna", 8, 30),
    -- Kinka Izakaya Original
    ("Baked Oysters", 14, 31),
    ("Fried Chicken", 10, 31),
    ("Salmon Tataki", 15, 31),
    -- Banh Mi Boys
    ("Five Spice Pork Belly", 9, 32),
    ("Grilled Prok Banh Mi", 10, 32),
    ("Fried Chicken", 8, 32),
    -- Richmond Station
    ("Polenta Fries", 12, 33),
    ("Crispy Organic Ontario Tofu", 12, 33),
    ("Station Charcuterie", 20, 33),
    -- Byblos
    ("Duck Kibbeh", 14, 34),
    ("Tuna", 19, 34),
    ("Lamb Ribs", 18, 34);


-- Location
INSERT INTO location(address, locationkey, countrykey)
    VALUES 
        ("222 Mason St, San Francisco, CA 94102", 1, 1),
        ("300 Grove St, San Francisco, CA 94102", 2, 1),
        ("The Embarcadero Ste A-202, San Francisco, CA 94133", 3, 1),
        ("3450 Balboa St, San Francisco, CA 94121", 4, 1),
        ("710 Florida St, San Francisco, CA 94110", 5, 1),
        ("309 Clement St, San Francisco, CA 94118", 6, 1),
        ("225 Clement St, San Francisco, CA 94118", 7, 1),
        ("317 Connecticut St, San Francisco, CA 94107", 8, 1),
        ("1031 Irving St, San Francisco, CA 94122", 9, 1),
        ("552 Green St, San Francisco, CA 94133", 10, 1),
        ("1906 Van Ness Ave, San Francisco, CA 94109", 11, 1),

        ("14 North Audley Street, London W1K 6WE, United Kingdom", 14, 2),
        ("12 Upper Saint Martin's Lane, London WC2H 9FB, United Kingdom", 15, 2),
        ("68 Royal Hospital Road, London SW3 4HP, United Kingdom", 16, 2),
        ("110 Bishopsgate, 40th Floor, London EC2N 4AY, United Kingdom", 17, 2),
        ("26 Ganton Street, London W1F 7QZ, United Kingdom", 18, 2),
        ("12B Meeting House Lane, Brighton BN1 1HB, United Kingdom", 19, 2),
        ("12 Gloucester Road, Brighton BN1 4AD, United Kingdom", 20, 2),

        ("Calle de Durango 200, Col. Roma Nte., 06700 Ciudad de Mexico, CDMX, Mexico", 21, 3),
        ("Calle de la Palma 23, Col. Centro Histￃﾳrico, 06000 Ciudad de Mￃﾩxico, CDMX, Mexico", 22, 3),
        ("Bolivar 56, Col. Centro, 06800 Mￃﾩxico, D.F., Mexico", 23, 3),
        ("Calle Isabel La Catￃﾳlica 30, Col. Centro Histￃﾳrico, 06000 Ciudad de Mￃﾩxico, CDMX, Mexico", 24, 3),
        ("Calle Havre 73, 06600 Juￃﾡrez, CDMX, Mexico", 25, 3),
        ("Agustￃﾭn Melgar 6, Col. Condesa, 06140 Ciudad de Mￃﾩxico, CDMX, Mexico", 26, 3),
        ("Tennyson 133, Polanco IV Secciￃﾳn, 11550 Ciudad de Mￃﾩxico, CDMX, Mexico", 27, 3),

        ("1065 Canadian Pl, 133, Mississauga, ON L4W 0B8, Canada", 28, 4),
        ("18 Duncan Street, Toronto, ON M5H 3G8, Canada", 29, 4),
        ("72 Kensington Avenue, Toronto, ON M5T 2K1, Canada", 30, 4),
        ("398 Church Street, Toronto, ON M5B 2A2, Canada", 31, 4),
        ("392 Queen Street W, Toronto, ON M5V 2A9, Canada", 32, 4),
        ("1 Richmond Street W, Toronto, ON M5H 3W4, Canada", 33, 4),
        ("11 Duncan Street, Toronto, ON M5V 3M2, Canada", 34, 4),
        
        ("2098 Foothill Blvd, La Verne, CA 91750", 35, 1),
        ("12611 S Kirkwood Rd, Stafford, TX 77477", 36, 1);
        

-- Country
INSERT INTO country(name, countrykey)
    VALUES 
        ("USA", 1),
        ("UK", 2),
        ("Mexico", 3),
        ("Canada", 4),
        ("Australia", 5),
        ("Sweden", 6),
        ("Japan", 7),
        ("Germany", 8);
        