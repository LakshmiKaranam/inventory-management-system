create database Grossary;
use Grossary;
CREATE TABLE Categories (
    category_id int PRIMARY KEY,
    name VARCHAR(100)
);
CREATE TABLE Products (
    product_id int PRIMARY KEY,
    name VARCHAR(100),
    quantity INTEGER,
    price DECIMAL(10, 2),
    category_id INTEGER REFERENCES Categories(category_id)
);
INSERT INTO Categories (category_id,name) VALUES (1,'Fruits'), (2,'Pickles'), (3,'Drinks');

INSERT INTO Products (product_id,name, quantity, price, category_id) VALUES
(101,'Kiwi', 15, 1.50, 1),
(102,'Banana', 8, 0.80, 1),
(103,'Apple', 5, 2.00, 1),
(104,'Chicken', 20, 0.50, 2),
(105,'Mutton', 12, 1.20, 2),
(106,'Mango', 3, 1.00, 2),
(107,'Mirinda', 10, 2.50, 3),
(108,'Pepsi', 7, 3.00, 3);
SELECT * FROM Products WHERE category_id = (SELECT category_id FROM Categories WHERE name = 'Fruits');
SELECT * FROM Products WHERE quantity < 10;
UPDATE Products SET price = 0.90 WHERE name = 'Banana';
DELETE FROM Products WHERE name = 'Mango';
SELECT c.name AS category_name, SUM(p.quantity * p.price) AS total_value
FROM Products p
JOIN Categories c ON p.category_id = c.category_id
GROUP BY c.name;
SELECT * FROM Products ORDER BY quantity DESC LIMIT 5;
SELECT * FROM Products WHERE price > (SELECT AVG(price) FROM Products);
SELECT category_name, product_name, price
FROM (
    SELECT c.name AS category_name, p.name AS product_name, p.price,
           ROW_NUMBER() OVER (PARTITION BY c.category_id ORDER BY p.price DESC) AS row_num
    FROM Products p
    JOIN Categories c ON p.category_id = c.category_id
) AS ranked_products
WHERE row_num = 1;



















