create schema AmazonDB;
use AmazonDB;
 
create table Users(
 user_id INT PRIMARY KEY AUTO_INCREMENT,
 name VARCHAR(100) NOT NULL,
 email VARCHAR(150) UNIQUE NOT NULL,
 registered_date DATE NOT NULL,
 membership ENUM('Basic', 'Prime') DEFAULT 'Basic'
);

create table Products(
product_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(200) NOT NULL,
price DECIMAL(10, 2) NOT NULL,
category VARCHAR(100) NOT NULL,
stock INT NOT NULL
);

create table Orders(
order_id INT PRIMARY KEY AUTO_INCREMENT,
user_id INT,
order_date DATE NOT NULL,
total_amount DECIMAL(10, 2) NOT NULL,
FOREIGN KEY(user_id) REFERENCES Users(user_id)
);

create table OrderDetails(
order_details_id INT PRIMARY KEY AUTO_INCREMENT,
order_id INT,
product_id INT,
quantity INT NOT NULL,
FOREIGN KEY(order_id) REFERENCES Orders(order_id),
FOREIGN KEY(product_id) REFERENCES Products(product_id)
);

INSERT INTO Users (name, email, registered_date, membership) VALUES
('Alice Johnson', 'alice.j@example.com', '2024-01-15', 'Prime'),
('Bob Smith', 'bob.s@example.com', '2024-02-01', 'Basic'),
('Charlie Brown', 'charlie.b@example.com', '2024-03-10', 'Prime'),
('Daisy Ridley', 'daisy.r@example.com', '2024-04-12', 'Basic');

INSERT INTO Products (name, price, category, stock) VALUES
('Echo Dot', 49.99, 'Electronics', 120),
('Kindle Paperwhite', 129.99, 'Books', 50),
('Fire Stick', 39.99, 'Electronics', 80),
('Yoga Mat', 19.99, 'Fitness', 200),
('Wireless Mouse', 24.99, 'Electronics', 150);

INSERT INTO Orders (user_id, order_date, total_amount) VALUES
(1, '2024-05-01', 79.98),
(2, '2024-05-03', 129.99),
(1, '2024-05-04', 49.99),
(3, '2024-05-05', 24.99);

INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES
(1, 1, 2),
(2, 2, 1),
(3, 1, 1),
(4, 5, 1);

#Question 1
select * from Users left join Orders on Users.user_id=Orders.user_id
where Orders.total_amount>80;
#Question 2
select name, email from users left join Orders on users.user_id=Orders.user_id where Orders.order_date between current_date-280 and current_date();
#Question 3
select category, AVG(price) from Products
group by category;
#Question 4
select * from Users where user_id in (select user_id from Orders where order_id in (select order_id from OrderDetails where product_id in (select product_id from Products
where category = "Electronics")));
#Question 5
SELECT p.name AS product_name,SUM(od.quantity * p.price) AS total_revenue
FROM OrderDetails od JOIN Products p ON od.product_id = p.product_id
GROUP BY p.product_id, p.name ORDER BY total_revenue DESC;
#Question 6
update Products
set price = price*1.10
where category = 'Books';
#Question 7
delete  from Orders where Orders.order_date<'2020-01-01';
#Question 8
SELECT u.name AS customer_name, p.name AS product_name, od.quantity FROM Orders o
JOIN Users u ON o.user_id = u.user_id
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
WHERE o.order_date = '2020-05-24';
#Question 9
SELECT u.user_id, u.name, COUNT(o.order_id) AS total_orders
FROM Users u
LEFT JOIN Orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.name;
#Question 11
SELECT u.name AS customer_name,p.name AS product_name,SUM(od.quantity) AS total_quantity
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
GROUP BY u.name, p.name
HAVING SUM(od.quantity) > 1;
#Question 12
SELECT p.category, SUM(od.quantity * p.price) AS total_revenue
FROM OrderDetails od JOIN Products p ON od.product_id = p.product_id
GROUP BY p.category;



