-- Dropping tables to allow rerun of .sql
DROP TABLE if exists "user";
DROP TABLE if exists attraction;

CREATE TABLE attraction (
	attraction_id serial PRIMARY KEY,
	name VARCHAR ( 50 ) UNIQUE NOT NULL,
	description VARCHAR ( 500 ),
	address VARCHAR ( 500 ),
	max_tickets_per_day INT NOT NULL,
    price_per_ticket INT NOT NULL
);

INSERT INTO attraction (name,description,address,max_tickets_per_day,price_per_ticket)
VALUES
    ('Mt. Rainier Day Trip from Seattle',
    'With massive glaciers, powerful waterfalls, and alpine meadows, Mount Rainier National Park is among one of Washington''s most spectacular reserves, but it can be hard to get to, especially in heavy traffic. Visiting the active volcano on a guided tour lets you focus on the views while your guide takes on the hassle of driving. Plus your guide knows some of the best stops to make at some of the most beautiful places in the park.',
    'Mt. Rainier, Seattle, WA, USA',
    50,
    16),
    ('Seattle Harbor Cruise',
    'See some of Seattle’s most famous landmarks from the water during this guided harbor cruise that has been running since 1949. Hop aboard, and head to either the lower deck or upper sun deck to take in stunning views of Mt. Rainier, the Space Needle, and the Seattle Great Wheel. With an easy-to-find meeting spot and commentary throughout the cruise, you’re sure to have a stress-free time.',
    'Pier 55, 1101 Alaskan Way, Seattle, WA 98101, USA',
    100,
    38);

CREATE TABLE "user" (
	user_id serial PRIMARY KEY,
	name VARCHAR ( 50 ) NOT NULL,
    email VARCHAR ( 50 ) UNIQUE NOT NULL,
    password VARCHAR ( 50 ) NOT NULL
);

INSERT INTO "user" (name,email,password)
VALUES
    ('Admin',
    'admin@gmail',
    'admin'),
    ('Nikhil',
    'nik@gmail',
    'nikhil'),
    ('Apple',
    'apple@gmail',
    'apple');

