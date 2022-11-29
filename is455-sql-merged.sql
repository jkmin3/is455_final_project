-- create database
DROP DATABASE IF EXISTS hotel_management_system;
CREATE DATABASE hotel_management_system;
USE hotel_management_system;


-- Create hotel table
DROP TABLE IF EXISTS hotel;
CREATE TABLE IF NOT EXISTS hotel (
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


-- create department table 
DROP TABLE IF EXISTS department;
CREATE TABLE IF NOT EXISTS department (
  dpt_id        		INT           PRIMARY KEY   AUTO_INCREMENT,
  dpt_name      		VARCHAR(45)   NOT NULL      UNIQUE,
  dpt_description		VARCHAR(100)  DEFAULT NULL
);


-- create guest table
DROP TABLE IF EXISTS `guest` ;
CREATE TABLE IF NOT EXISTS `guest` (
  `guest_id` INT NOT NULL,
  `guest_last_name` VARCHAR(45) NULL,
  `guest_first_name` VARCHAR(45) NULL,
  `guest_contact` VARCHAR(12) NULL,
  `guest_email_add` VARCHAR(45) NULL,
  PRIMARY KEY (`guest_id`));


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
    

-- create employee table
DROP TABLE IF EXISTS employee;
CREATE TABLE IF NOT EXISTS employee (
  emp_id           			INT            PRIMARY KEY   AUTO_INCREMENT,
  emp_first_name            VARCHAR(45)    NOT NULL,
  emp_last_name             VARCHAR(45)    NOT NULL,
  emp_designation	        VARCHAR(45),
  emp_contact_number		VARCHAR(12),
  emp_email_address         VARCHAR(45),
  dpt_id					INT            NOT NULL,
  hotel_id					INT            NOT NULL,
  CONSTRAINT employee_fk_department
    FOREIGN KEY (dpt_id)
    REFERENCES department (dpt_id),
  CONSTRAINT employee_fk_hotel
    FOREIGN KEY (hotel_id)
    REFERENCES hotel (hotel_id)
);


-- create hotel_service table
DROP TABLE IF EXISTS hotel_service;
CREATE TABLE IF NOT EXISTS hotel_service (
  service_id        		INT           PRIMARY KEY   AUTO_INCREMENT,
  service_name      		VARCHAR(45)   NOT NULL      UNIQUE,
  service_description		VARCHAR(100)  DEFAULT NULL,
  service_cost				DECIMAL(10,2) NOT NULL,
  hotel_id					INT 		  NOT NULL,
  CONSTRAINT service_fk_hotel
    FOREIGN KEY (hotel_id)
    REFERENCES hotel (hotel_id)
);


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

-- Create booking table
DROP TABLE IF EXISTS `booking` ;
CREATE TABLE IF NOT EXISTS `booking` (
  `bookings_id` INT NOT NULL,
  `booking_date` DATETIME NULL,
  `check_in_date` DATETIME NULL,
  `check_out_date` DATETIME NULL,
  `emp_id` INT NOT NULL,
  `total_rooms_booked` INT NULL,
  `total_amount` DECIMAL(10,2) NULL,
  `guest_id` INT NOT NULL,
  `hotel_id` INT NOT NULL,
  PRIMARY KEY (`bookings_id`, `emp_id`, `guest_id`, `hotel_id`),
  INDEX `fk_bookings_hotel1_idx` (`hotel_id` ASC),
  INDEX `fk_bookings_employees1_idx` (`emp_id` ASC),
  INDEX `fk_bookings_guests1_idx` (`guest_id` ASC),
  CONSTRAINT `fk_bookings_hotel1`
    FOREIGN KEY (`hotel_id`)
    REFERENCES `hotel` (`hotel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bookings_employees1`
    FOREIGN KEY (`emp_id`)
    REFERENCES `employee` (`emp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bookings_guests1`
    FOREIGN KEY (`guest_id`)
    REFERENCES `guest` (`guest_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    

-- Create table room_booked
DROP TABLE IF EXISTS `room_booked` ;
CREATE TABLE IF NOT EXISTS `room_booked` (
  `rooms_booked_id` INT NOT NULL,
  `room_id` INT NOT NULL,
  `booking_id` INT NOT NULL,
  PRIMARY KEY (`rooms_booked_id`, `room_id`, `booking_id`),
  INDEX `fk_rooms_booked_rooms1_idx` (`room_id` ASC),
  INDEX `fk_rooms_booked_bookings1_idx` (`booking_id` ASC),
  CONSTRAINT `fk_rooms_booked_rooms1`
    FOREIGN KEY (`room_id`)
    REFERENCES `room` (`room_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rooms_booked_bookings1`
    FOREIGN KEY (`booking_id`)
    REFERENCES `booking` (`bookings_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    
-- create hotel_service_guest table
DROP TABLE IF EXISTS `hotel_service_guest` ;
CREATE TABLE IF NOT EXISTS `hotel_service_guest` (
  `services_used_id` INT NOT NULL,
  `booking_id` INT NOT NULL,
  `service_id` INT NOT NULL,
  `emp_id` INT NOT NULL,
  PRIMARY KEY (`services_used_id`, `booking_id`, `service_id`, `emp_id`),
  INDEX `fk_hotel_services_guests_bookings1_idx` (`booking_id` ASC),
  INDEX `fk_hotel_services_guests_hotel_services1_idx` (`service_id` ASC),
  INDEX `fk_hotel_services_guests_employees1_idx` (`emp_id` ASC),
  CONSTRAINT `fk_hotel_services_guests_bookings1`
    FOREIGN KEY (`booking_id`)
    REFERENCES `booking` (`bookings_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hotel_services_guests_hotel_services1`
    FOREIGN KEY (`service_id`)
    REFERENCES `hotel_service` (`service_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hotel_services_guests_employees1`
    FOREIGN KEY (`emp_id`)
    REFERENCES `employee` (`emp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- Populate hotel table with data
INSERT INTO hotel(hotel_id, hotel_contact_number, hotel_email_address, hotel_floor_count, 
hotel_room_capacity, star_rating, hotel_address, check_in_time, check_out_time) VALUES
(1, '555-235-2601', 'thishotel1@gmail.com', '20', '400', 5, '123 Baker St.', '15:00:00', '12:00:00'),
(2, '555-263-3921', 'thishotel2@gmail.com', '15', '300', 4, '1067 Grand Ave.', '15:00:00', '12:00:00'),
(3, '555-092-1053', 'thishotel3@gmail.com', '10', '200', 4, '1823 Manchester St.', '15:00:00', '12:00:00'),
(4, '555-205-1905', 'thishotel4@gmail.com', '25', '500', 3, '5838 Azalea Ln.', '15:00:00', '12:00:00'),
(5, '555-259-4007', 'thishotel5@gmail.com', '10', '200', 5, '712 Prospect St.', '15:00:00', '12:00:00'),
(6, '555-108-3893', 'thishotel6@gmail.com', '20', '400', 3, '521 Central Ave.', '15:00:00', '12:00:00'),
(7, '555-018-2047', 'thishotel7@gmail.com', '20', '400', 2, '862 Monterey St.', '15:00:00', '12:00:00'),
(8, '555-182-1911', 'thishotel8@gmail.com', '15', '300', 4, '912 Green St.', '15:00:00', '12:00:00'),
(9, '555-828-3455', 'thishotel9@gmail.com', '10', '200', 5, '818 Purple St.', '15:00:00', '12:00:00'),
(10, '555-222-3411', 'thishotel10@gmail.com', '20', '400', 5, '814 Red St.', '15:00:00', '12:00:00'),
(11, '555-312-2595', 'thishotel11@gmail.com', '20', '400', 3, '5444 Yellow St.', '15:00:00', '12:00:00'),
(12, '555-938-2287', 'thishotel12@gmail.com', '10', '200', 4, '2986 Apple St.', '15:00:00', '12:00:00');


-- populate department table with data
INSERT INTO department(dpt_id, dpt_name, dpt_description) VALUES
(1,'Food & beverage','Cook and prepare dining'),
(2,'Housekeeping','Cleaning'),
(3,'Front Office','Manage reservations and handle reception'),
(4,'Maintenance','Manage the function of the building and property'),
(5,'Commute','Pick up and drop guests'),
(6, 'Finance and accounts', 'Oversee all incoming and outgoing payments'),
(7, 'Security', 'Prevent security and safety issues'),
(8, 'Sales and reservations', 'Increase room bookings and boosts revenue.'),
(9, 'Purchase', 'Buy all products used in the hotel'),
(10, 'IT', 'Oversee all the systems and software used across the hotel');


-- populate guest table with data
INSERT INTO guest(guest_id, guest_last_name, guest_first_name, guest_contact, guest_email_add) VALUES
(1, 'Chan', 'Jacky', '1234567890', 'jackychan@gmail.com'),
(2, 'Ma', 'Jacky', '2234567890', 'jackyma@gmail.com'),
(3, 'Coper', 'David', '3234567890', 'davidcoper@gmail.com'),
(4, 'Wang', 'Tom', '4234567890', 'tomwang@gmail.com'),
(5, 'Li', 'Jerry', '5234567890', 'jerry_li@gmail.com'),
(6, 'Liu', 'Eric', '6234567890', 'ericliu@gmail.com'),
(7, 'Lee', 'Ann', '7234567890', 'annlee@gmail.com'),
(8, 'Pitt', 'Brad', '8234567890', 'pittb@gmail.com'),
(9, 'Green', 'Rachael', '9234567890', 'realrachael@gmail.com'),
(10, 'Gellar', 'Monica', '0234567890', 'realmon@gmail.com');


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


-- populate employee table with data
INSERT INTO employee(emp_id, emp_first_name, emp_last_name, emp_designation, emp_contact_number, emp_email_address, dpt_id, hotel_id) VALUES
 (1,'Roberto','Martin','driver','263-045-9697','roberto_martin@gmail.com',5,1),
 (2,'Susan','Santiago','Chef','901-217-5130','susan_santiago@outlook.com',1,1),
 (3,'Tom','Lawson','Cashier','274-262-4082','tom_lawson@gmail.com',3,1),
 (4,'Leticia','Cook','Receptionist','821-668-6654','leticia.cook@gmail.com',3,1),
 (5,'Naomi','Jimenez','Room attendant','415-750-0643','naomi_j@gmail.com',2,1),
 (6,'Devin','Schultz','Waitor','491-857-1107', 'devin_schultz@outlook.com',1,1),
 (7,'Raquel','Walsh','Guest service manager','746-597-1771', 'raquel_walsh@gmail.com',3,1),
 (8,'Dale','Manning','Maintenance technician','262-086-8004', 'dale.manning2@hotmail.com',4,1),
 (9,'Candace','Lambert','Plumber', '303-805-3106', 'candaceL@gmail.com',4,1),
 (10,'Dana','Hubbard','Waiter','670-019-7909', 'danahubbard@outlook.com',1,1),
 (11, 'Aonghus', 'Nellie', 'Receptionist', '784-870-6890', 'nellie@gmail.com', 3, 2),
 (12, 'Lucille', 'Powers', 'Receptionist', '343-271-8271', 'lucille_p@hotmail.com', 3, 3),
 (13, 'Paul', 'Ortega', 'Receptionist', '763-431-3216', 'orgeta@gmail.com', 3, 4),
 (14, 'Rosa', 'Fox', 'Receptionist', '274-354-7318', 'rosa_fox@outloook.com', 3, 5);
 


-- populate hotel_service table with data
INSERT INTO hotel_service(service_id, service_name, service_description, service_cost, hotel_id) VALUES
(1, 'Car rental', 'Rent a car, price per day', 48.99, 1),
(2, 'Laundry', 'Laundry and dry cleaning, price per load', 14.99, 1),
(3, 'Flower arrangement', 'Order a decorative display of cut flowers',36.99, 1),
(4, 'Massage', 'Manipulation of tissues for relaxation', 88.99, 1),
(5, 'Shoeshine', 'Polishing shoes', 28.99, 1),
(6, 'Courier service', 'express and door-to-door delivery', 12.99, 1),
(7, 'Room service (24-hour)', '24-hour Room Service to take care of customers needs', 29.99, 1),
(8, 'Cloth ironing', 'Iron clothes, price per piece', 4.99, 1),
(9, 'Daily newspaper', 'Deliver newspaper to the room', 7.99, 1),
(10, 'Pet firendly', 'Pets allowed in room, at a surcharge', 24.99, 1),
(11, 'Spa', 'Indoor mineral spring service', 48.99, 1);


-- Populate room table with data
INSERT INTO room(room_number, hotel_id, room_type_id) VALUES
(1, 2, 1),
(2, 5, 2),
(3, 5, 7),
(4, 6, 9),
(5, 4, 2),
(6, 3, 9),
(7, 10, 10),
(8, 1, 10), -- this line I change it from (8, 13, 10) to (8, 1, 10) because there is no hotel_id greater than 12.
(9, 12, 9),
(10, 4, 8),
(20, 4, 1);


-- Populate booking table with data
-- Here I changed the emp_id values for the table, to make sure only receptionist can booking rooms for guests
INSERT INTO `booking` (bookings_id, booking_date, check_in_date, check_out_date, emp_id, total_rooms_booked, total_amount, guest_id, hotel_id)
 VALUES
	('1', '2018-08-08 00:00:00', '2018-08-10 12:00:00', '2018-08-15 23:00:00', '3', '1', '590', '1', '1'),
	('2', '2018-06-08 00:00:00', '2018-06-08 12:00:00', '2018-06-28 23:00:00', '11', '2', '2300', '2', '2'),
	('3', '2018-06-08 00:00:00', '2018-06-08 12:00:00', '2018-06-18 23:00:00', '3', '1', '1100', '3', '1'),
	('4', '2018-06-08 00:00:00', '2018-06-08 12:00:00', '2018-06-10 23:00:00', '13', '1', '290', '4', '4'),
	('5', '2018-06-08 00:00:00', '2018-06-08 12:00:00', '2018-06-11 23:00:00', '11', '1', '350', '5', '2'),
	('6', '2018-06-08 00:00:00', '2018-06-08 12:00:00', '2018-06-13 23:00:00', '12', '1', '570', '6', '3'),
	('7', '2018-08-13 00:00:00', '2018-06-13 12:00:00', '2018-06-15 23:00:00', '14', '1', '280', '7', '5'),
	('8', '2018-08-10 00:00:00', '2018-08-11 12:00:00', '2018-08-13 23:00:00', '12', '1', '350', '8', '3'),
	('9', '2018-08-10 00:00:00', '2018-08-12 12:00:00', '2018-08-16 23:00:00', '13', '1', '570', '9', '4'),
	('10', '2018-08-14 00:00:00', '2018-08-15 12:00:00', '2018-08-17 23:00:00', '14', '1', '280', '10', '5');


-- Populate room_booked table with data
INSERT INTO `room_booked` (`rooms_booked_id`, `room_id`, `booking_id`) 
VALUES 
(1, 1, 1),
(2, 2, 2),
(3, 3, 2),
(4, 4, 3),
(5, 5, 4),
(6, 6, 5),
(7, 7, 6),
(8, 8, 7),
(9, 9, 8),
(10,10,9),
(11,7,10);


-- Populate hotel_service_guest table with data
INSERT INTO hotel_service_guest (services_used_id, booking_id, service_id, emp_id) VALUES 
(1, 1, 1, 3),
(2, 1, 7, 6),
(3, 2, 7, 7),
(4, 3, 5, 10),
(5, 5, 2, 10),
(6, 5, 6, 10),
(7, 7, 7, 6),
(8, 8, 7, 5),
(9, 8, 7, 5),
(10, 9, 7, 7);
