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
ORDER BY 
	[number of products sold] desc
----------------------------------------------


