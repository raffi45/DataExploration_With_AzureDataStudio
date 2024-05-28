--- company name of the supplier and calculate the total quantity sold for each supplier.
SELECT 
	Suppliers.CompanyName, 
	SUM(OrderDetails.Quantity)AS [Quantity Sold]
FROM 
	OrderDetails
INNER JOIN 
	Products ON OrderDetails.ProductID = Products.ProductID
INNER JOIN 
	Suppliers ON Products.SupplierID = Suppliers.SupplierID
GROUP BY 
	Suppliers.CompanyName
--------------------------


--- Identifying Best Selling Product Categories:
SELECT 
	Categories.CategoryName, 
	SUM(OrderDetails.Quantity) AS [number of products sold]
FROM 
	OrderDetails
INNER JOIN 
	Products ON OrderDetails.ProductID = Products.ProductID
INNER JOIN
	Categories ON Products.CategoryID = Categories.CategoryID
GROUP BY 
	Categories.CategoryName
----------------------------------------------


---- Measuring Annual Income:
SELECT 
    YEAR(Orders.OrderDate) AS [Year],
	SUM(CONVERT(money,(OrderDetails.Quantity * OrderDetails.UnitPrice)-((OrderDetails.Quantity * OrderDetails.UnitPrice)*OrderDetails.Discount))) AS [Revenue]
FROM 
    OrderDetails
INNER JOIN 
    Orders ON OrderDetails.OrderID = Orders.OrderID
INNER JOIN 
    Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY 
    YEAR(Orders.OrderDate)
---------------------


--- total orders by country
SELECT 
    Customers.Country,
    COUNT(Orders.OrderID) AS TotalOrders
FROM 
    Orders
INNER JOIN 
    Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY 
    Customers.Country;
----- 

--- revenue from each product category at 1997
SELECT 
    Categories.CategoryName,
    SUM(OrderDetails.Quantity * OrderDetails.UnitPrice) AS TotalSales
FROM 
    OrderDetails
INNER JOIN 
    Products ON OrderDetails.ProductID = Products.ProductID
INNER JOIN 
    Categories ON Products.CategoryID = Categories.CategoryID
INNER JOIN 
    Orders ON OrderDetails.OrderID = Orders.OrderID
WHERE 
	YEAR(Orders.OrderDate) = '1997'
GROUP BY 
    Categories.CategoryName;
-----------

--- average delivery time
SELECT 
    Customers.Country,
    AVG(DATEDIFF(day, Orders.OrderDate, Orders.ShippedDate)) AS AverageShippingTime
FROM 
    Orders
INNER JOIN 
    Customers ON Orders.CustomerID = Customers.CustomerID
WHERE 
    Orders.ShippedDate IS NOT NULL
GROUP BY 
	Customers.Country;
----------



--- calculate and summarize the total revenue generated from orders placed in 1997, grouped by the country of the customers
SELECT 
    Customers.Country AS [Customer Country],
    SUM(CONVERT(money,(OrderDetails.Quantity * OrderDetails.UnitPrice)-
        ((OrderDetails.Quantity * OrderDetails.UnitPrice)*OrderDetails.Discount))) AS [Revenue]
FROM 
    OrderDetails
INNER JOIN 
    Orders ON OrderDetails.OrderID = Orders.OrderID
INNER JOIN 
    Customers ON Orders.CustomerID = Customers.CustomerID
WHERE 
	YEAR(Orders.OrderDate) = '1997'
GROUP BY 
	Customers.Country
----------------------------


---------calculates the total revenue generated each month from each customer's country for a specific year
SELECT 
    DATENAME(month,Orders.OrderDate) AS [Month],
    SUM(CONVERT(money,(OrderDetails.Quantity * OrderDetails.UnitPrice)-
        ((OrderDetails.Quantity * OrderDetails.UnitPrice)*OrderDetails.Discount))) AS [Revenue]
FROM 
    OrderDetails
INNER JOIN 
    Orders ON OrderDetails.OrderID = Orders.OrderID
INNER JOIN 
    Customers ON Orders.CustomerID = Customers.CustomerID 
WHERE 
    YEAR(Orders.OrderDate) = 1997 AND Customers.Country = 'USA'
GROUP BY 
    DATENAME(month,Orders.OrderDate),
    Customers.Country
-------------------

---------calculate the total revenue generated from orders placed by customers in the GERMANY at 1997
SELECT 
    DATENAME(month,Orders.OrderDate) AS [Month],
    SUM(CONVERT(money,(OrderDetails.Quantity * OrderDetails.UnitPrice)-
        ((OrderDetails.Quantity * OrderDetails.UnitPrice)*OrderDetails.Discount))) AS [Revenue]
FROM 
    OrderDetails
INNER JOIN 
    Orders ON OrderDetails.OrderID = Orders.OrderID
INNER JOIN 
    Customers ON Orders.CustomerID = Customers.CustomerID 
WHERE 
    YEAR(Orders.OrderDate) = 1997 AND Customers.Country = 'GERMANY'
GROUP BY 
    DATENAME(month,Orders.OrderDate),
    Customers.Country
------------------
