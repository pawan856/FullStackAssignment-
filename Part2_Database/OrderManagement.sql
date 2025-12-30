-- Part 2: Database Management Task
-- Order Management System Schema, Data, and Queries

-- Setup Database
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'OrderManagementDB')
BEGIN
    CREATE DATABASE OrderManagementDB;
END
GO
USE OrderManagementDB;
GO


-- 1. Table Creation

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    JoinDate DATETIME DEFAULT GETDATE()
);

-- Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100) NOT NULL,
    Category NVARCHAR(50) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);

-- Orders Table
-- Simplified schema: Orders contains product references directly to satisfy the 4-table limit 
-- while allowing "Revenue per product" calculations.
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    ProductID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL, -- Added to preserve historical pricing
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Payments Table
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    PaymentDate DATETIME DEFAULT GETDATE(),
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentMethod NVARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);


-- 2. Insert Sample Data

-- Insert 5 Customers
INSERT INTO Customers (Name, Email, JoinDate) VALUES 
('John Doe', 'john@example.com', '2023-01-15'),
('Jane Smith', 'jane@example.com', '2023-02-20'),
('Alice Johnson', 'alice@example.com', '2023-03-10'),
('Bob Brown', 'bob@example.com', '2023-05-05'),
('Charlie Davis', 'charlie@example.com', '2023-06-12');

-- Insert Products
INSERT INTO Products (ProductName, Category, Price) VALUES 
('Laptop', 'Electronics', 1200.00),
('Smartphone', 'Electronics', 800.00),
('Desk Chair', 'Furniture', 150.00),
('Coffee Maker', 'Appliances', 80.00),
('Headphones', 'Electronics', 200.00);

-- Insert 10 Orders
-- Ensuring some customers have multiple orders and dates vary
-- Added UnitPrice snapshot for historical accuracy and There are a few older and recent data for the ease of testing
INSERT INTO Orders (CustomerID, ProductID, OrderDate, Quantity, UnitPrice) VALUES 
(1, 1, DATEADD(DAY, -40, GETDATE()), 1, 1200.00), 
(1, 5, DATEADD(DAY, -5, GETDATE()), 2, 200.00),  
(2, 2, DATEADD(DAY, -20, GETDATE()), 1, 800.00), 
(2, 4, DATEADD(DAY, -2, GETDATE()), 1, 80.00),  
(3, 3, DATEADD(DAY, -10, GETDATE()), 4, 150.00),
(1, 3, DATEADD(DAY, -60, GETDATE()), 1, 150.00), 
(4, 2, DATEADD(DAY, -1, GETDATE()), 1, 800.00),  
(5, 1, DATEADD(DAY, -100, GETDATE()), 1, 1200.00),
(2, 5, DATEADD(DAY, -15, GETDATE()), 1, 200.00), 
(3, 4, DATEADD(DAY, -25, GETDATE()), 2, 80.00); 

-- Insert Payments (expecting  1 payment per order for simplicity)
INSERT INTO Payments (OrderID, Amount, PaymentDate, PaymentMethod) VALUES 
(1, 1200.00, DATEADD(DAY, -40, GETDATE()), 'Credit Card'),
(2, 400.00, DATEADD(DAY, -5, GETDATE()), 'PayPal'),
(3, 800.00, DATEADD(DAY, -20, GETDATE()), 'Credit Card'),
(4, 80.00, DATEADD(DAY, -2, GETDATE()), 'Debit Card'),
(5, 600.00, DATEADD(DAY, -10, GETDATE()), 'Credit Card'),
(6, 150.00, DATEADD(DAY, -60, GETDATE()), 'PayPal'),
(7, 800.00, DATEADD(DAY, -1, GETDATE()), 'Credit Card'),
(8, 1200.00, DATEADD(DAY, -100, GETDATE()), 'Debit Card'),
(9, 200.00, DATEADD(DAY, -15, GETDATE()), 'Credit Card'),
(10, 160.00, DATEADD(DAY, -25, GETDATE()), 'PayPal');


-- 3. Queries


--  1: Fetch top 3 customers with the highest number of orders
SELECT TOP 3 
    c.Name, 
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.Name
ORDER BY TotalOrders DESC;

--  2: Retrieve orders placed in the last 30 days
SELECT 
    o.OrderID, 
    c.Name AS CustomerName, 
    p.ProductName, 
    o.OrderDate 
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Products p ON o.ProductID = p.ProductID
WHERE o.OrderDate >= DATEADD(DAY, -30, GETDATE());

--  3: Calculate total revenue for each product
SELECT 
    p.ProductName, 
    SUM(o.Quantity * o.UnitPrice) AS TotalRevenue
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalRevenue DESC;


-- 4. Optimizations

-- Added indexes to improve performance on Foreign Keys and Date filters
CREATE NONCLUSTERED INDEX IX_Orders_CustomerID ON Orders(CustomerID);
CREATE NONCLUSTERED INDEX IX_Orders_OrderDate ON Orders(OrderDate);
