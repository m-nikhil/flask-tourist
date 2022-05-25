CREATE TABLE IF NOT EXISTS Attraction (
	attraction_id serial PRIMARY KEY,
	name VARCHAR ( 50 ) UNIQUE NOT NULL,
	description VARCHAR ( 255 ),
	address VARCHAR ( 255 ),
	max_tickets_per_day INT NOT NULL,
    price_per_ticket INT NOT NULL
);