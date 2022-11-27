-- create database
DROP DATABASE IF EXISTS hotel_management_system;
CREATE DATABASE hotel_management_system;
USE hotel_management_system;


-- create department table
CREATE TABLE IF NOT EXISTS department (
  dpt_id        		INT           PRIMARY KEY   AUTO_INCREMENT,
  dpt_name      		VARCHAR(45)   NOT NULL      UNIQUE,
  dpt_description		VARCHAR(100)  DEFAULT NULL
);

-- populate department table with data
INSERT INTO department(dpt_id, dpt_name, dpt_description) VALUES
(1,'Food & beverage','cooking, prepare dining'),
(2,'Housekeeping','cleaning'),
(3,'Front Office','managing reservations and handling reception'),
(4,'Maintenance','manage the function of the building and property'),
(5,'Commute','pick up and drop guests');

-- create employee table
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
 (9,'Candace','Lambert','Plumber''303-805-3106', 'candaceL@gmail.com',4,1),
 (10,'Dana','Hubbard','Waiter','670-019-7909', 'danahubbard@outlook.com',1,1);

-- create hotel_service table
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
-- populate hotel_service table with data
INSERT INTO hotel_service(service_id, service_name, service_description, service_cost, hotel_id) VALUES
(1, 'Car rental', 'Rent a car, price per day', 50.99, 1),
(2, 'Laundry', 'Laundry and dry cleaning, price per piece', 12.99, 1),
(3, 'Flower arrangement', 'Order a decorative display of cut flowers',36.99, 1),
(4, 'Massage', 'Manipulation of tissues for relaxation', 88.99, 1),
(5, 'Shoeshine', 'Polishing shoes', 28.99, 1),
(6, 'Courier service', 'express and door-to-door delivery', 12.99, 1),
(7, 'Room service (24-hour)', '24-hour Room Service to take care of customers needs', 29.99, 1);






