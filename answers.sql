--Question one

WITH RECURSIVE split_products AS (
  SELECT
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(Products, ',', 1)) AS Product,
    SUBSTRING(Products, LENGTH(SUBSTRING_INDEX(Products, ',', 1)) + 2) AS remaining
  FROM ProductDetail

  UNION ALL

  SELECT
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(remaining, ',', 1)),
    SUBSTRING(remaining, LENGTH(SUBSTRING_INDEX(remaining, ',', 1)) + 2)
  FROM split_products
  WHERE remaining != ''
)

SELECT OrderID, CustomerName, Product
FROM split_products
ORDER BY OrderID;


--Question two

--Orders — to hold order-level data
-- Table to store order-level details
CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  CustomerName VARCHAR(100)
);

--OrderItems — to store product-level data
-- Table to store item-level details (products in each order)
CREATE TABLE OrderItems (
  OrderID INT,
  Product VARCHAR(100),
  Quantity INT,
  PRIMARY KEY (OrderID, Product),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);


--Insert into Orders
INSERT INTO Orders (OrderID, CustomerName)
VALUES 
  (101, 'John Doe'),
  (102, 'Jane Smith'),
  (103, 'Emily Clark');

--Insert into OrderItems
INSERT INTO OrderItems (OrderID, Product, Quantity)
VALUES
  (101, 'Laptop', 2),
  (101, 'Mouse', 1),
  (102, 'Tablet', 3),
  (102, 'Keyboard', 1),
  (102, 'Mouse', 2),
  (103, 'Phone', 1);

