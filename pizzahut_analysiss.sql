/* 
Basic:
Retrieve the total number of orders placed.
Calculate the total revenue generated from pizza sales.
Identify the highest-priced pizza.
Identify the most common pizza size ordered.
List the top 5 most ordered pizza types along with their quantities.


Intermediate:
Join the necessary tables to find the total quantity of each pizza category ordered.
Determine the distribution of orders by hour of the day.
Join relevant tables to find the category-wise distribution of pizzas.
Group the orders by date and calculate the average number of pizzas ordered per day.
Determine the top 3 most ordered pizza types based on revenue.

Advanced:
Calculate the percentage contribution of each pizza type to total revenue.

*/
-- Retrieve the total number of orders placed.
SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders_pizza;


-- Calculate the total revenue generated from pizza sales.
SELECT 
    SUM(p.price * o.quantity) AS total_revenue
FROM
    pizzas p
        JOIN
    order_details o ON p.pizza_id = o.pizza_id;


-- Identify the highest-priced pizza.
SELECT 
    pizza_id AS highest_priced_pizza, price
FROM
    pizzas
ORDER BY price DESC
LIMIT 1;

-- ---------------------------or-----------------
SELECT 
    pi.name AS highest_Priced_pizza, p.price
FROM
    pizza_types pi
        JOIN
    pizzas p ON pi.pizza_type_id = p.pizza_type_id
ORDER BY price DESC;


-- Identify the most common pizza size ordered.
select * from pizzas;
SELECT 
    p.size AS most_common_size,
    COUNT(o.order_details_id) AS order_count
FROM
    pizzas p
        JOIN
    order_details o ON p.pizza_id = o.pizza_id
GROUP BY p.size
ORDER BY order_count DESC
LIMIT 1;

-- List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pi.name AS most_Ordered_pizza, SUM(o.quantity) AS quantity
FROM
    pizza_types pi
        JOIN
    pizzas p ON pi.pizza_type_id = p.pizza_type_id
        JOIN
    order_details o ON o.pizza_id = p.pizza_id
GROUP BY most_Ordered_pizza
ORDER BY quantity DESC
LIMIT 5;

-- -Join the necessary tables to find the total quantity of each pizza category ordered.
select pi.category, 
sum(o.quantity) as total_quantity 
from pizza_types pi 
join pizzas p on p.pizza_type_id = pi.pizza_type_id
join order_details o on p.pizza_id = o.pizza_id
group by pi.category
order by total_quantity desc;
-- ---Determine the distribution of orders by hour of the day.

SELECT 
    COUNT(order_id) AS order_dist,
    HOUR(order_time) AS order_time
FROM
    orders_pizza
GROUP BY order_time
ORDER BY order_dist DESC;
-- Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    COUNT(name) AS disitribution, category
FROM
    pizza_types
GROUP BY category;
-- Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
    AVG(quantity) as average_pizza_ordered_perday
FROM
    (SELECT 
        COUNT(o.order_id) AS ordered,
            SUM(o.quantity) AS quantity,
            op.order_date
    FROM
        order_details o
    JOIN orders_pizza op ON o.order_id = op.order_id
    GROUP BY order_date) AS order_quantity;
-- Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    p.pizza_type_id, SUM(p.price * o.quantity) AS total_revenue
FROM
    pizzas p
        JOIN
    order_details o ON p.pizza_id = o.pizza_id
GROUP BY pizza_type_id
ORDER BY total_revenue DESC
LIMIT 3;

-- -Calculate the percentage contribution of each pizza type to total revenue.

select pt.category,  (sum(p.price * o.quantity)/
 (SELECT SUM(p.price * o.quantity) AS total_revenue FROM
    pizzas p
        JOIN
    order_details o ON p.pizza_id = o.pizza_id )*100) as percentage_contribution from pizza_types pt 
join pizzas p on pt.pizza_type_id = p.pizza_type_id
join order_details o on p.pizza_id = o.pizza_id
group by pt.category
order by percentage_contribution desc;
-- ---Analyze the cumulative revenue generated over time.







