DROP TABLE IF EXISTS `guest` ;

CREATE TABLE IF NOT EXISTS `guest` (
  `guest_id` INT NOT NULL,
  `guest_first_name` VARCHAR(45) NULL,
  `guest_last_name` VARCHAR(45) NULL,
  `guest_contact` VARCHAR(12) NULL,
  `guest_email_add` VARCHAR(45) NULL,
  PRIMARY KEY (`guest_id`));


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

