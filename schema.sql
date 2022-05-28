-- Dropping tables to allow rerun of .sql
DROP TABLE if exists amenity cascade;
DROP TABLE if exists "booking" cascade;
DROP TABLE if exists "user" cascade;
DROP TABLE if exists "day_attraction" cascade;
DROP TABLE if exists attraction cascade;
DROP TABLE if exists Payment cascade;


CREATE TABLE attraction (
	attraction_id serial PRIMARY KEY,
	name VARCHAR ( 50 ) UNIQUE NOT NULL,
	description VARCHAR ( 500 ),
	address VARCHAR ( 500 ),
	max_tickets_per_day INT NOT NULL,
    price_per_ticket INT NOT NULL,
    city VARCHAR ( 50 ) NOT NULL,
    CONSTRAINT positive_price CHECK (price_per_ticket > 0),
    CONSTRAINT positive_max_tickets_per_day  CHECK (max_tickets_per_day  > 0)
);

INSERT INTO attraction (name,description,address,max_tickets_per_day,price_per_ticket, city)
VALUES
    ('Mt. Rainier Day Trip from Seattle',
    'With massive glaciers, powerful waterfalls, and alpine meadows, Mount Rainier National Park is among one of Washington''s most spectacular reserves, but it can be hard to get to, especially in heavy traffic. Visiting the active volcano on a guided tour lets you focus on the views while your guide takes on the hassle of driving. Plus your guide knows some of the best stops to make at some of the most beautiful places in the park.',
    'Mt. Rainier, Seattle, WA, USA',
    50,
    16,
    'Seattle'),
    ('Seattle Harbor Cruise',
    'See some of Seattle’s most famous landmarks from the water during this guided harbor cruise that has been running since 1949. Hop aboard, and head to either the lower deck or upper sun deck to take in stunning views of Mt. Rainier, the Space Needle, and the Seattle Great Wheel. With an easy-to-find meeting spot and commentary throughout the cruise, you’re sure to have a stress-free time.',
    'Pier 55, 1101 Alaskan Way, Seattle, WA 98101, USA',
    100,
    38,
    'Seattle'),
    ('Alcatraz with San Francisco Bay Cruise',
    'This convenient package gives you access to two essential San Francisco experiences—a visit to Alcatraz Island, and a sightseeing cruise. Instead of waiting in long ticket lines, this time-saving option helps you explore San Francisco more efficiently. Take a ferry to Alcatraz Island where you can go inside the Alcatraz Federal Penitentiary and enjoy an audio guide.',
    'Blue & Gold Fleet, Pier 41, San Francisco, CA 94133, USA',
    15,
    139,
    'San Francisco');

CREATE TABLE "user" (
	user_id serial PRIMARY KEY,
	name VARCHAR ( 50 ) NOT NULL,
    email VARCHAR ( 50 ) UNIQUE NOT NULL,
    contact INT  NOT NULL,
    password VARCHAR ( 50 ) NOT NULL
);

INSERT INTO "user" (name,email,password,contact)
VALUES
    ('Admin',
    'admin@gmail',
    'admin',
    '235265852'),
    ('Nikhil',
    'nik@gmail',
    'nikhil',
    '235265858'),
    ('Apple',
    'apple@gmail',
    'apple',
    '235658552');


CREATE TABLE payment (
	user_id integer PRIMARY KEY,
	card_number VARCHAR ( 50 ) UNIQUE NOT NULL,
    expiration VARCHAR ( 50 )  NOT NULL,
    CONSTRAINT fk_payment_user
      FOREIGN KEY(user_id)
	  REFERENCES "user"(user_id)
);

INSERT INTO payment (user_id,card_number,expiration)
VALUES
    (1,
    '123456',
    '01/25'),
    (2,
    '654321',
    '01/25'),
    (3,
    '987654',
    '01/25');



CREATE TABLE "day_attraction" (
	date DATE NOT NULL,
	attraction_id INT NOT NULL,
    number_of_tickets_booked INT NOT NULL,
    CONSTRAINT fk_attraction
      FOREIGN KEY(attraction_id) 
	  REFERENCES attraction(attraction_id),
    PRIMARY KEY(date, attraction_id),
    CONSTRAINT positive_number_OF_tickets_booked CHECK (number_of_tickets_booked > 0)
);

insert into day_attraction (date,attraction_id,number_of_tickets_booked )
VALUES (NOW(), 1, 25 ),
       (NOW() + INTERVAL '1 DAY', 1, 30 ),
       (NOW() + INTERVAL '2 DAY', 1, 40 ),
       (NOW() - INTERVAL '1 DAY', 1, 45 ),
       (NOW(), 2, 100 ),
       (NOW() + INTERVAL '1 DAY', 2, 90 ),
       (NOW() + INTERVAL '2 DAY', 2, 75 ),
       (NOW() - INTERVAL '1 DAY', 2, 50 ),
       (NOW(), 3, 15 ),
       (NOW() + INTERVAL '1 DAY', 3, 15 ),
       (NOW() + INTERVAL '2 DAY', 3, 15 ),
       (NOW() - INTERVAL '1 DAY', 3, 15 );

CREATE TABLE amenity (
    amenity_id serial PRIMARY KEY,
	attraction_id INT NOT NULL,
    amenity_name VARCHAR (100) NOT NULL,
    CONSTRAINT fk_attraction
      FOREIGN KEY(attraction_id)
	  REFERENCES attraction(attraction_id)
);

insert into amenity (attraction_id,amenity_name )
VALUES (1, 'Hotel pickup offered'),
       (1, 'Free parking'),
       (1, 'Food & Drinks'),
       (2, 'Hotel pickup offered'),
       (2, 'Taking Covid-19 safety measures'),
       (3, 'Taking Covid-19 safety measures'),
       (3, 'Souvenir photos');


CREATE TABLE booking (
	booking_id serial PRIMARY KEY,
	user_id INT NOT NULL,
	attraction_id INT NOT NULL,
	date_of_booking DATE,
    number_of_tickets INT NOT NULL,
    status VARCHAR (100) NOT NULL,
    CONSTRAINT fk_booking_attraction
      FOREIGN KEY(attraction_id)
	  REFERENCES attraction(attraction_id),
    CONSTRAINT fk_booking_user
      FOREIGN KEY(user_id)
	  REFERENCES "user"(user_id),
	CONSTRAINT positive_number_OF_tickets CHECK (number_of_tickets > 0)

);

INSERT INTO booking(user_id, attraction_id, date_of_booking, number_of_tickets, status)
VALUES
(2, 1, NOW(), 3, 'Payment Done'),
(3, 2, NOW() + INTERVAL '1 DAY', 1, 'Payment Done');





