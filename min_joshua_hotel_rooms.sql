USE hotel_management_system;

-- Create room table
DROP TABLE IF EXISTS room;
CREATE TABLE IF NOT EXISTS room(
	room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number INT,
    hotel_id INT,
    room_type_id INT,
    CONSTRAINT room_fk_hotel
		FOREIGN KEY (hotel_id)
        REFERENCES hotel (hotel_id),
	CONSTRAINT room_fk_type
		FOREIGN KEY (room_type_id)
		REFERENCES room_type (room_type_id)
        );

-- Populate room table with data
INSERT INTO room(room_number, hotel_id, room_type_id) VALUES
(1, 2, 1),
(2, 5, 2),
(3, 5, 7),
(4, 6, 9),
(5, 4, 2),
(6, 3, 9),
(7, 10, 10),
(8, 13, 10),
(9, 12, 9),
(10, 4, 8),
(20, 4, 1);

-- Create room_type table

DROP TABLE IF EXISTS room_type;
CREATE TABLE IF NOT EXISTS room_type(
	room_type_id INT PRIMARY KEY AUTO_INCREMENT,
    room_type_name VARCHAR(45),
    room_cost INT,
    room_type_description VARCHAR(100),
    smoke_friendly TINYINT(1),
    pet_friendly TINYINT(1)
    );
    
-- Populate room_type table with data

INSERT INTO room_type(room_type_name, room_cost, room_type_description,
smoke_friendly, pet_friendly) VALUES
('Standard Single', 200, 'Has one twin bed and one bath', 0, 0),
('Standard Double', 300, 'Has two twin beds and one bath', 0, 0) ,
('Stadard Triple', 300, 'Has three twin beds and two baths', 0, 0),
('Standard Quad', 500, 'Has four twin beds and two baths', 0, 0),
('Deluxe Single', 400, 'Has one double bed and one bath', 1, 1),
('Deluxe Double', 600, 'Has two double beds and two baths', 1, 1),
('Deluxe Triple', 800, 'Has three double beds and three baths', 1, 1),
('Deluxe Quad', 1000, 'Has four double beds and four baths', 1, 1),
('Accessible Room', 200, 'Has one double bed and one bath', 0, 0),
('Penthouse', 4000, 'Has four rooms with double beds, one bath, a living room, a balcony, with inclusive room service', 1, 1);

    
    
-- Create hotel table

DROP TABLE IF EXISTS hotel;
CREATE TABLE IF NOT EXISTS hotel(
hotel_id INT PRIMARY KEY AUTO_INCREMENT,
hotel_contact_number VARCHAR(12),
hotel_email_address VARCHAR(45),
hotel_floor_count INT,
hotel_room_capacity INT, 
star_rating INT,
hotel_address VARCHAR(100),
check_in_time TIME,
check_out_time TIME
);

-- Populate room_type table with data

INSERT INTO hotel(hotel_contact_number, hotel_email_address, hotel_floor_count, 
hotel_room_capacity, star_rating, hotel_address, check_in_time, check_out_time) VALUES
('555-235-2601', 'thishotel1@gmail.com', '20', '400', 5, '123 Baker St.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('555-263-3921', 'thishotel2@gmail.com', '15', '300', 4, '1067 Grand Ave.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('555-092-1053', 'thishotel3@gmail.com', '10', '200', 4, '1823 Manchester St.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('555-205-1905', 'thishotel4@gmail.com', '25', '500', 3, '5838 Azalea Ln.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('555-259-4007', 'thishotel5@gmail.com', '10', '200', 5, '712 Prospect St.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('555-108-3893', 'thishotel6@gmail.com', '20', '400', 3, '521 Central Ave.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('555-018-2047', 'thishotel7@gmail.com', '20', '400', 2, '862 Monterey St.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('555-182-1911', 'thishotel8@gmail.com', '15', '300', 4, '912 Green St.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('555-828-3455', 'thishotel9@gmail.com', '10', '200', 5, '818 Purple St.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('555-222-3411', 'thishotel10@gmail.com', '20', '400', 5, '814 Red St.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('555-312-2595', 'thishotel11@gmail.com', '20', '400', 3, '5444 Yellow St.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('555-938-2287', 'thishotel12@gmail.com', '10', '200', 4, '2986 Apple St.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
;
    
    
    