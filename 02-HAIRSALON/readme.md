## Create database

create database hair_salon;

## Use database

use hair_salon;

## Create table customers

create table customers (
    customer_id int unsigned auto_increment primary key,
    name varchar(200) not null,
    email varchar(200) not null,
    contact_no varchar(200)
) engine = innodb;

## Insert into customers

insert into customers
(name, email, contact_no) VALUES ("Christine","christine@gmail.com","91113333");

insert into customers
(name, email, contact_no) VALUES ("Cheryl","cheryl@gmail.com","91113444");

## Create table appointments

create table appointments (
    appointment_id int unsigned auto_increment primary key,
    appointment_slot datetime
 ) engine = innodb;

 ## Insert into appointments

 insert into appointments (
    appointment_slot) VALUES ("2024-05-05 10:00");
 insert into appointments (
    appointment_slot) VALUES ("2024-05-05 11:00");

## Create table stylists
create table stylists (
    stylist_id int unsigned auto_increment primary key,
    name varchar(100) not null,
    experience_level varchar(50) not null
 ) engine = innodb;

## Insert into stylists
 insert into stylists (name, experience_level) VALUES ("Anne","junior");
 insert into stylists (name, experience_level) VALUES ("Tom","senior");

## reference foreign keys 

ALTER TABLE appointments ADD COLUMN customer_id INT UNSIGNED;
ALTER TABLE appointments ADD COLUMN stylist_id INT UNSIGNED;

## define foreign keys

ALTER TABLE appointments ADD CONSTRAINT fk_appointments_customers
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

ALTER TABLE appointments ADD CONSTRAINT fk_appointments_stylists
    FOREIGN KEY (stylist_id) REFERENCES stylists(stylist_id);


## Create table services
create table services (
    service_id int unsigned auto_increment primary key,
    service_type varchar(255) not null
 ) engine = innodb;

 ## Insert into services
 insert into services (service_type) VALUES ("haircut");
 insert into services (service_type) VALUES ("perm");

## Create price_table
create table price_table (
    price_id int unsigned auto_increment primary key,
    cost decimal unsigned not null 
 ) engine = innodb;

 ## Insert into services
 insert into price_table (cost) VALUES ("40");
 insert into price_table (cost) VALUES ("50");

 ## reference foreign keys 

ALTER TABLE price_table ADD COLUMN service_id INT UNSIGNED;

## define foreign keys

ALTER TABLE price_table ADD CONSTRAINT fk_price_table_services
    FOREIGN KEY (service_id) REFERENCES services(service_id);


## Create appointments_services
create table appointments_services (
    treatment_id int unsigned auto_increment primary key
 ) engine = innodb;

## reference foreign keys

## define foreign keys

# Create point_transactions

## reference foreign keys

## define foreign keys

# Create rewards