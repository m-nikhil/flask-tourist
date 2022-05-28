-- Dropping tables to allow rerun of .sql
DROP TABLE if exists amenity cascade;
DROP TABLE if exists "booking" cascade;
DROP TABLE if exists "user" cascade;
DROP TABLE if exists "day_attraction" cascade;
DROP TABLE if exists attraction cascade;
DROP TABLE if exists Payment cascade;

---Created attraction, user, amenity table , day attraction , booking  and their insertions
CREATE TABLE attraction (
	attraction_id serial PRIMARY KEY,
	name VARCHAR ( 100 ) UNIQUE NOT NULL,
	description VARCHAR ( 1000 ),
	address VARCHAR ( 1000 ),
	max_tickets_per_day INT NOT NULL,
    price_per_ticket INT NOT NULL,
    city VARCHAR ( 100 ) NOT NULL,
    CONSTRAINT positive_price CHECK (price_per_ticket >= 0),
    CONSTRAINT positive_max_tickets_per_day  CHECK (max_tickets_per_day  >= 0)
);

-- Insert base (raw) entries into attraction table
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
    'San Francisco'),
    ('Beneath The Streets Underground History',
    'Get to know Seattle''s first established neighborhood, Pioneer Square, by walking its underground pathways as they existed in the 1890s in the company of a guide. Trace the city’s history, from an Indigenous dwelling to its Gold Rush days and up through its current state as a thriving modern neighborhood on this walking tour.',
    '102 Cherry St, Seattle, WA 98104, USA',
    20,
    25,
    'Seattle'),
    ('Premier 3-Hour Seattle City Tour',
    'Get an overview of Seattle on a half-day bus tour that includes stops at top destinations. Get a closer look at attractions such as the Space Needle, Pioneer Square, Klondike Gold Rush National Historical Park, and Ballard Locks, and pass by landmarks including Pike Place Market.',
    '300 Occidental Ave S, Seattle, WA 98104, USA',
    20,
    75,
    'Seattle'),
    ('Leavenworth Tour from Seattle',
    'This tour is all things that you expected to see in just one day. It will be full of unbelievable beauty of nature. You would never expect to step into Bavaria while visiting Washington, but upon entering Leavenworth, you will certainly feel as though you have been transported to Germany.',
    'Blue & Gold Fleet, Pier 41, San Francisco, CA 94133, USA',
    15,
    100,
    'Seattle'),
    ('Bellevue Botanical Garden',
    'The Bellevue Botanical Garden is an urban refuge, encompassing 53-acres of cultivated gardens, restored woodlands, and natural wetlands. One of the highly recommended botanical gardens to visit',
    '12001 Main St, Bellevue, WA 98005-3522',
    15,
    150,
    'Bellevue'),
    ('Bellevue Square',
    'The Bellevue Square is the definitive local-to-global mix of fashion, tech, dining and entertainment in the Pacific Northwest. Bellevue is a city in Washington state, across Lake Washington from Seattle. Downtown Park has a large lawn, gardens and a waterfall.',
    '12001 Main St, Bellevue, WA 98005-3522',
    15,
    25,
    'Bellevue'),
    ('2 Hour Guided Boat Tour in Gig Harbor and Narrows Bridges',
    'See a new side of Gig Harbor—and soak up the wild scenery of Puget Sound—on this boat tour. Meet your Coast Guard-certified captain, hop aboard the ex-navy boat, and set sail. ',
    '8829 N Harborview Dr, Gig Harbor, WA 98332, USA',
    25,
    150,
    'Tacoma'),
    ('Tacoma Scavenger Hunt: Bright Lights, Big Glass',
    'Let’s Roam is the #1 app-led scavenger hunt company. Walk to all the best landmarks and hidden gems, answering trivia questions and solving challenges. Work with your team or compete against them, as you learn new facts and create memorable experiences.',
    '1701 Pacific Ave, Tacoma, WA 98402, USA',
    15,
    25,
    'Tacoma');

-- Create user table to keep track of authorized users of the system
CREATE TABLE "user" (
	user_id serial PRIMARY KEY,
	name VARCHAR ( 500 ) NOT NULL,
    email VARCHAR ( 100 ) UNIQUE NOT NULL,
    contact INT  NOT NULL,
    password VARCHAR ( 100 ) NOT NULL
);

-- Insert base (raw) entries into user table
INSERT INTO "user" (name,email,password,contact)
VALUES
    ('Admin',
    'admin@gmail.com',
    'admin',
    '235265852'),
    ('Nikhil',
    'nikhil@gmail',
    'nikhil',
    '235265858'),
     ('Shraddha',
    'shraddha@gmail.com',
    'shraddha',
    '235658449'),
    ('Ayushi',
    'ayushi@gmail.com',
    'ayushi',
    '235659449'),
    ('Apple',
    'apple@gmail',
    'apple',
    '235658552'),
    ('Rachel',
    'rachel@gmail.com',
    'rachel',
    '238558449'),
     ('Vivian',
    'vivian@gmail.com',
    'vivian',
    '239558449'),
     ('Kunal',
    'kunal@gmail.com',
    'kunal',
    '238558447'),
     ('Sam',
    'sam@gmail.com',
    'sam',
    '238118447'),
     ('Christopher',
    'chris@gmail.com',
    'chris',
    '238338447')
    ;

-- Create payment table to keep track of payment info of a given user
CREATE TABLE payment (
	user_id integer UNIQUE PRIMARY KEY,
	card_number VARCHAR ( 50 ) UNIQUE NOT NULL,
    expiration VARCHAR ( 50 )  NOT NULL,
    CONSTRAINT fk_payment_user
      FOREIGN KEY(user_id)
	  REFERENCES "user"(user_id)
);

-- Insert base (raw) entries into payment table
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
    '01/25'),
    (4,
    '456789',
    '01/25'),
    (5,
    '000222',
    '01/25'),
    (6,
    '654123',
    '01/25'),
    (7,
    '765432',
    '01/25'),
    (8,
    '111222',
    '01/25'),
    (9,
    '444555',
    '01/25'),
    (10,
    '666555',
    '01/25');

-- Create day_attraction table to keep track of attractions available on a given day
CREATE TABLE "day_attraction" (
	date DATE NOT NULL,
	attraction_id INT NOT NULL,
    number_of_tickets_booked INT NOT NULL,
    CONSTRAINT fk_attraction
      FOREIGN KEY(attraction_id) 
	  REFERENCES attraction(attraction_id),
    PRIMARY KEY(date, attraction_id),
    CONSTRAINT positive_number_OF_tickets_booked CHECK (number_of_tickets_booked >= 0)
);

-- Insert base (raw) entries into day_attraction table
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
       (NOW() - INTERVAL '1 DAY', 3, 15 ),

       (NOW(), 4, 10 ),
       (NOW() + INTERVAL '1 DAY', 4, 2 ),
       (NOW() - INTERVAL '1 DAY', 4, 5 ),

       (NOW(), 5, 8 ),
       (NOW() + INTERVAL '1 DAY', 5, 7 ),
       (NOW() - INTERVAL '1 DAY', 5, 10 ),

       (NOW(), 6, 5 ),
       (NOW() + INTERVAL '1 DAY', 6, 7 ),
       (NOW() - INTERVAL '1 DAY', 6, 10 ),

       (NOW(), 7, 7 ),
       (NOW() + INTERVAL '1 DAY', 7, 5),
       (NOW() - INTERVAL '1 DAY', 7, 12 ),

       (NOW(), 8, 12 ),
       (NOW() + INTERVAL '1 DAY', 8, 4 ),
       (NOW() - INTERVAL '1 DAY', 8, 10 ),


       (NOW(), 9, 12 ),
       (NOW() + INTERVAL '1 DAY', 9, 4 ),
       (NOW() - INTERVAL '1 DAY', 9, 10 ),


       (NOW(), 10, 12 ),
       (NOW() + INTERVAL '1 DAY', 10, 4 ),
       (NOW() - INTERVAL '1 DAY', 10, 10 );


-- Create amenity table to keep track of amenities included in a given attraction
CREATE TABLE amenity (
    amenity_id serial PRIMARY KEY,
	attraction_id INT NOT NULL,
    amenity_name VARCHAR (100) NOT NULL,
    CONSTRAINT fk_attraction
      FOREIGN KEY(attraction_id)
	  REFERENCES attraction(attraction_id)
);


-- Insert base (raw) entries into amenity table
insert into amenity (attraction_id,amenity_name )
VALUES (1, 'Hotel pickup offered'),
       (1, 'Free parking'),
       (1, 'Food & Drinks'),
       (2, 'Hotel pickup offered'),
       (2, 'Taking Covid-19 safety measures'),
       (3, 'Taking Covid-19 safety measures'),
       (3, 'Souvenir photos'),
       (4, 'Taking Covid-19 safety measures'),
       (4, 'Souvenir photos'),
       (5, 'Taking Covid-19 safety measures'),
       (5, 'Souvenir photos'),
       (6, 'Taking Covid-19 safety measures'),
       (6, 'Souvenir photos'),
       (7, 'Taking Covid-19 safety measures'),
       (7, 'Souvenir photos'),
       (8, 'Taking Covid-19 safety measures'),
       (8, 'Souvenir photos'),
       (9, 'Taking Covid-19 safety measures'),
       (9, 'Souvenir photos'),
       (10, 'Taking Covid-19 safety measures'),
       (10, 'Souvenir photos');

-- Create booking table to keep track of bookings done on any given day
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
	CONSTRAINT positive_number_OF_tickets CHECK (number_of_tickets >= 0)

);


-- Insert base (raw) entries into booking table
INSERT INTO booking(user_id, attraction_id, date_of_booking, number_of_tickets, status)
VALUES
(1, 1, NOW() - INTERVAL '2 DAY', 4, 'Payment Done'),
(2, 1, NOW() - INTERVAL '4 DAY', 3, 'Payment Done'),
(3, 1, NOW() - INTERVAL '3 DAY', 2, 'Payment Done'),
(4, 2, NOW() + INTERVAL '1 DAY', 1, 'Payment Done'),
(4, 1, NOW() - INTERVAL '2 DAY', 2, 'Payment Done'),
(5, 2, NOW() + INTERVAL '1 DAY', 3, 'Payment Done'),
(5, 1, NOW() - INTERVAL '2 DAY', 2, 'Payment Done'),
(6, 2, NOW() + INTERVAL '1 DAY', 3, 'Payment Done'),
(6, 1, NOW() - INTERVAL '2 DAY', 2, 'Payment Done'),
(6, 1, NOW() - INTERVAL '2 DAY', 1, 'Payment Done');