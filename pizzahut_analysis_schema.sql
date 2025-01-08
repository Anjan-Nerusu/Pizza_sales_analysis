create database pizzahut;
show create table orders_pizza;
CREATE TABLE `order_details` (
   `order_details_id` int DEFAULT NULL,
   `order_id` int DEFAULT NULL,
   `pizza_id` text,
   `quantity` int DEFAULT NULL
 );
 CREATE TABLE `pizza_types` (
   `pizza_type_id` text,
   `name` text,
   `category` text,
   `ingredients` text
 );
 CREATE TABLE `pizzas` (
   `pizza_id` text,
   `pizza_type_id` text,
   `size` text,
   `price` double DEFAULT NULL
 );
 CREATE TABLE `orders_pizza` (
   `order_id` int NOT NULL,
   `order_date` datetime NOT NULL,
   `order_time` time NOT NULL
 );
 show tables;
 
 