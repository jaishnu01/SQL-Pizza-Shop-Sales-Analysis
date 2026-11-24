CREATE DATABASE IF NOT EXISTS pizzashop;
USE pizzashop;



CREATE TABLE IF NOT EXISTS categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    city VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS pizzas (
    pizza_id INT PRIMARY KEY,
    pizza_name VARCHAR(100) NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(8,2) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE IF NOT EXISTS orderdetails (
    detail_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    pizza_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (pizza_id) REFERENCES pizzas(pizza_id)
);


INSERT INTO categories (category_id, category_name) VALUES
(1, 'Veg'),
(2, 'Non-Veg'),
(3, 'Cheese'),
(4, 'Special');

INSERT INTO customers (customer_id, name, phone, city) VALUES
(1, 'Rahul Sharma', '9876543210', 'Mumbai'),
(2, 'Amit Patil', '9876543211', 'Pune'),
(3, 'Priya Shah', '9876543212', 'Mumbai'),
(4, 'Neha Joshi', '9876543213', 'Nashik'),
(5, 'Rohan Mehta', '9876543214', 'Mumbai'),
(6, 'Sneha Kulkarni', '9876543215', 'Pune'),
(7, 'Karan Singh', '9876543216', 'Thane'),
(8, 'Anjali Desai', '9876543217', 'Mumbai'),
(9, 'Vikas More', '9876543218', 'Navi Mumbai'),
(10, 'Pooja Gupta', '9876543219', 'Mumbai');

INSERT INTO pizzas (pizza_id, pizza_name, category_id, price) VALUES
(1, 'Margherita', 1, 199),
(2, 'Veggie Delight', 1, 249),
(3, 'Farmhouse', 1, 299),
(4, 'Chicken Tikka', 2, 349),
(5, 'Chicken BBQ', 2, 379),
(6, 'Pepperoni', 2, 399),
(7, 'Cheese Burst', 3, 329),
(8, 'Four Cheese', 3, 399),
(9, 'Paneer Special', 4, 349),
(10, 'Chicken Special', 4, 449);

INSERT INTO orders (order_id, customer_id, order_date) VALUES
(101, 1, '2026-01-01'),
(102, 2, '2026-01-02'),
(103, 3, '2026-01-02'),
(104, 4, '2026-01-03'),
(105, 5, '2026-01-04'),
(106, 6, '2026-01-05'),
(107, 7, '2026-01-06'),
(108, 8, '2026-01-07'),
(109, 9, '2026-01-08'),
(110, 10, '2026-01-09'),
(111, 1, '2026-01-10'),
(112, 3, '2026-01-11'),
(113, 5, '2026-01-12'),
(114, 8, '2026-01-13'),
(115, 2, '2026-01-14');

INSERT INTO orderdetails (detail_id, order_id, pizza_id, quantity) VALUES
(1, 101, 1, 2),
(2, 101, 4, 1),
(3, 102, 3, 2),
(4, 102, 7, 1),
(5, 103, 5, 2),
(6, 103, 2, 1),
(7, 104, 6, 1),
(8, 104, 9, 2),
(9, 105, 10, 1),
(10, 105, 1, 2),
(11, 106, 8, 1),
(12, 106, 3, 2),
(13, 107, 4, 2),
(14, 107, 7, 1),
(15, 108, 2, 3),
(16, 108, 5, 1),
(17, 109, 9, 2),
(18, 109, 10, 1),
(19, 110, 1, 2),
(20, 110, 6, 1),
(21, 111, 3, 1),
(22, 111, 8, 2),
(23, 112, 4, 1),
(24, 112, 10, 2),
(25, 113, 5, 1),
(26, 113, 9, 2),
(27, 114, 7, 2),
(28, 114, 2, 1),
(29, 115, 6, 2),
(30, 115, 3, 1);


SELECT * FROM categories;
SELECT * FROM customers;
SELECT * FROM pizzas;
SELECT * FROM orders;
SELECT * FROM orderdetails;




SELECT * FROM pizzas;

SELECT * FROM customers;


SELECT * FROM orders;


-- QUERY 1: COUNT - total number of customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- QUERY 2: COUNT - total number of orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- QUERY 3: SUM - total number of pizza units sold
SELECT SUM(quantity) AS total_pizzas_sold
FROM orderdetails;

-- QUERY 4: AVG - average listed pizza price
SELECT ROUND(AVG(price), 2) AS average_pizza_price
FROM pizzas;

-- QUERY 5: MIN - cheapest pizza price
SELECT MIN(price) AS cheapest_pizza_price
FROM pizzas;

-- QUERY 6: MAX - highest pizza price
SELECT MAX(price) AS highest_pizza_price
FROM pizzas;

-- QUERY 7: SUM + JOIN - estimated gross sales before discounts/tax
SELECT SUM(od.quantity * p.price) AS total_sales
FROM orderdetails AS od
JOIN pizzas AS p ON od.pizza_id = p.pizza_id;

-- QUERY 8: WHERE - pizzas priced above 300
SELECT pizza_name, price
FROM pizzas
WHERE price > 300;

-- QUERY 9: LIKE - pizza names containing 'Chicken'
SELECT pizza_name, price
FROM pizzas
WHERE pizza_name LIKE '%Chicken%';

-- QUERY 10: BETWEEN - pizzas priced from 200 to 400 (inclusive)
SELECT pizza_name, price
FROM pizzas
WHERE price BETWEEN 200 AND 400;

-- QUERY 11: DISTINCT - list each customer city once
SELECT DISTINCT city
FROM customers;

-- QUERY 12: GROUP BY + COUNT - number of customers in each city
SELECT city, COUNT(*) AS customer_count
FROM customers
GROUP BY city
ORDER BY customer_count DESC;

-- QUERY 13: GROUP BY + AVG - average price by category
SELECT c.category_name, ROUND(AVG(p.price), 2) AS average_price
FROM pizzas AS p
JOIN categories AS c ON p.category_id = c.category_id
GROUP BY c.category_id, c.category_name;

-- QUERY 14: GROUP BY + SUM - quantity sold for each pizza
SELECT p.pizza_name, SUM(od.quantity) AS quantity_sold
FROM orderdetails AS od
JOIN pizzas AS p ON od.pizza_id = p.pizza_id
GROUP BY p.pizza_id, p.pizza_name
ORDER BY quantity_sold DESC;

-- QUERY 15: GROUP BY + SUM + JOIN - sales by category
SELECT c.category_name,
       SUM(od.quantity * p.price) AS category_sales
FROM orderdetails AS od
JOIN pizzas AS p ON od.pizza_id = p.pizza_id
JOIN categories AS c ON p.category_id = c.category_id
GROUP BY c.category_id, c.category_name
ORDER BY category_sales DESC;

-- QUERY 16: ORDER BY + LIMIT - top 5 pizzas by revenue
SELECT p.pizza_name,
       SUM(od.quantity * p.price) AS total_sales
FROM orderdetails AS od
JOIN pizzas AS p ON od.pizza_id = p.pizza_id
GROUP BY p.pizza_id, p.pizza_name
ORDER BY total_sales DESC
LIMIT 5;

-- EXTRA QUERY 17: Daily sales
SELECT o.order_date,
       SUM(od.quantity * p.price) AS daily_sales
FROM orders AS o
JOIN orderdetails AS od ON o.order_id = od.order_id
JOIN pizzas AS p ON od.pizza_id = p.pizza_id
GROUP BY o.order_date
ORDER BY o.order_date;

-- EXTRA QUERY 18: Best customers by spend
SELECT c.customer_id, c.name,
       SUM(od.quantity * p.price) AS total_spend
FROM customers AS c
JOIN orders AS o ON c.customer_id = o.customer_id
JOIN orderdetails AS od ON o.order_id = od.order_id
JOIN pizzas AS p ON od.pizza_id = p.pizza_id
GROUP BY c.customer_id, c.name
ORDER BY total_spend DESC;

-- EXTRA QUERY 19: Sales between two dates
SELECT o.order_date,
       SUM(od.quantity * p.price) AS daily_sales
FROM orders AS o
JOIN orderdetails AS od ON o.order_id = od.order_id
JOIN pizzas AS p ON od.pizza_id = p.pizza_id
WHERE o.order_date BETWEEN '2026-01-01' AND '2026-01-10'
GROUP BY o.order_date
ORDER BY o.order_date;

-- EXTRA QUERY 20: Find pizza categories where total sales revenue is greater than ₹3,000.
SELECT
    c.category_name,
    SUM(od.quantity * p.price) AS total_revenue
FROM categories c
JOIN pizzas p
    ON c.category_id = p.category_id
JOIN orderdetails od
    ON p.pizza_id = od.pizza_id
GROUP BY c.category_name
HAVING SUM(od.quantity * p.price) > 3000;

-- EXTRA QUERY 21: Display every possible combination of customers and pizza categories(Cross Join).
SELECT
    cu.name AS customer_name,
    c.category_name
FROM customers cu
CROSS JOIN categories c;


-- STEP 6: Verify row counts
SELECT 'categories' AS table_name, COUNT(*) AS row_count FROM categories
UNION ALL
SELECT 'customers', COUNT(*) FROM customers
UNION ALL
SELECT 'pizzas', COUNT(*) FROM pizzas
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'orderdetails', COUNT(*) FROM orderdetails;

