-- Create customer table 
CREATE TABLE Customers (
customer_id INT PRIMARY KEY,
	name VARCHAR(100),
	email VARCHAR(100) UNIQUE,
	phone VARCHAR(20),
	address TEXT
);

-- create categories table
CREATE TABLE Categories (
category_id INT PRIMARY KEY,
	category_name VARCHAR(50)
);

-- create products table
CREATE TABLE Products (
product_id INT PRIMARY KEY,
	product_name VARCHAR(100),
	category_id INT,
	price DECIMAL(10, 2),
	stock_qty INT,
	FOREIGN KEY(category_id) REFERENCES Categories(category_id)
);

-- Create Orders table
CREATE TABLE Orders (
order_id INT PRIMARY KEY,
	customer_id INT,
	order_date DATE,
	status VARCHAR(20),
	total_amount DECIMAL(10, 2),
	FOREIGN KEY(customer_id) REFERENCES Customers(customer_id)
);

--Create order items table
CREATE TABLE Order_Items (
order_id INT,
	product_id INT,
	quantity INT,
	price DECIMAL(10, 2),
	PRIMARY KEY(order_id, product_id),
	FOREIGN KEY(order_id) REFERENCES Orders(order_id),
	FOREIGN KEY(product_id) REFERENCES Products(product_id)
);

-- Insert sample data
--insert customers 
INSERT INTO Customers VALUES(1, 'John Doe', 'john@example.com', '1234567890', '123 Eml St');
INSERT INTO Customers VALUES(2, 'Jane Smith', 'jane@example.com', '0987654321', '456 Oak St');

--Insert categories
INSERT INTO Categories VALUES(1, 'Electronics');
INSERT INTO Categories VALUES(2, 'Clothing');

--Insert products
INSERT INTO Products VALUES(1, 'Smartphone', 1, 699.99, 100);
INSERT INTO Products VALUES(2, 'Laptop', 1, 999.99, 50);
INSERT INTO Products VALUES(3, 'Tshirt', 2, 19.99, 200);

-- insert orders
INSERT INTO Orders VALUES(101,1, '2023-07-29', 'Completed', 699.99);
INSERT INTO Orders VALUES(102,2, '2023-07-30', 'Pending', 1019.98);

--OrderItems 
INSERT INTO Order_Items VALUES(101, 1, 1, 699.99);
INSERT INTO Order_Items VALUES(102, 2, 1, 999.99);
INSERT INTO Order_Items VALUES(103, 3, 1, 19.99);

-- List all customers 
SELECT * FROM Customers;

-- list all products in electronics category 
SELECT product_name, price FROM Products
WHERE category_id = 1;

-- find total sales amount per product
SELECT p.product_name, SUM(oi.quantity) AS total_quantity_sol, SUM(oi.price*oi.quantity) AS total_sales
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC;

-- find all orders for customer "john doe"
SELECT o.order_id, o.order_date, o.status, o.total_amount
FROM Orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE c.name = 'John Doe';

-- find all products with low stock (lessthan 50 units)
SELECT product_name, stock_qty FROM Products
WHERE stock_qty < 50;