
-- create guest table

DROP TABLE IF EXISTS `guest` ;
CREATE TABLE IF NOT EXISTS `guest` (
  `guest_id` INT NOT NULL,
  `guest_last_name` VARCHAR(45) NULL,
  `guest_first_name` VARCHAR(45) NULL,
  `guest_contact` VARCHAR(12) NULL,
  `guest_email_add` VARCHAR(45) NULL,
  PRIMARY KEY (`guest_id`));

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

-- populate hotel_service_guest table with data

INSERT INTO hotel_service_guest VALUES
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
