-- Solutions with Northwind Data, SQL Practice Problems

-- Question 1 - Which shippers do we have?
SELECT * FROM Employees

-- Question 2 | Certain fields from Categories
SELECT
	[CategoryName],
	[Description]
FROM
	[dbo].[Categories]

-- Question 3 | Sales Representatives
SELECT
	[FirstName],
	[LastName],
	[HireDate],
	[Title]
FROM
	[dbo].[Employees]
WHERE
	[Title] = 'Sales Representative'

-- Question 4 | Sales Representatives in the United States
SELECT
	[FirstName],
	[LastName],
	[HireDate]
FROM
	[dbo].[Employees]
WHERE
	[Title] = 'Sales Representative' AND
	[Country] = 'USA'

-- Question 5 | Orders placed by specific EmployeeID
SELECT
	[OrderId],
	[OrderDate]
FROM
	[dbo].[Orders]
WHERE 
	[EmployeeID] = 5

-- Question 6 | Suppliers and ContactTitles
SELECT
	[SupplierID],
	[ContactName],
	[ContactTitle]
FROM
	[dbo].[Suppliers]
WHERE
	[ContactTitle] != 'Marketing Manager'

-- Question 7 | Products with "queso" in ProductName
SELECT
	[ProductID],
	[ProductName]
FROM
	[dbo].[Products]
WHERE 
	[ProductName] LIKE '%queso%'
	
-- Question 8 | Orders shipping to Fance or Belgium
SELECT
	[OrderId],
	[CustomerID],
	[ShipCountry]
FROM 
	[dbo].[Orders]
WHERE
	[ShipCountry] = 'France' OR
	[ShipCountry] = 'Belgium'

-- Question 9 | Orders shipping to any country in Latin America
SELECT
	[OrderID],
	[CustomerID],
	[ShipCountry]
FROM
	[dbo].[Orders]
WHERE
	[ShipCountry] IN
	(
	 'Brazil',
	 'Mexico',
	 'Argentina',
	 'Venezuela'
	)
	
-- Solutions with Northwind Data, SQL Practice Problems

-- Question 11 | Showing only the Date with a DateTime field

-- For Date Formats
-- https://anubhavg.wordpress.com/2009/06/11/how-to-format-datetime-date-in-sql-server-2005/

SELECT
	[FirstName],
	[LastName],
	[Title],
	 FORMAT([BirthDate], 'yyyy-MM-dd') as BirthDate
FROM
	[dbo].[Employees]
ORDER BY
	[BirthDate]

-- Question 12 | Employees full Name
SELECT
	[FirstName],
	[LastName],
	CONCAT([FirstName], ' ', [LastName]) AS FullName
FROM 
	[dbo].[Employees]

-- Question 13 | OrderDetails amount per line item
SELECT 
	[OrderID],
	[ProductID],
	[UnitPrice],
	[Quantity],
	[TotalPrice] = [UnitPrice] * [Quantity]
FROM
	[dbo].[OrderDetails]
ORDER BY
	[OrderID],
	[ProductID]

-- Question 14 | How many Customers?
SELECT COUNT(*) AS TotalCustomers FROM [dbo].Customers

-- Question 15 | When was the first order?
SELECT FirstOrder = MIN([OrderDate]) FROM [dbo].[Orders]

-- Question 16 | Countries where there are customers
SELECT [Country] FROM [dbo].[Customers] GROUP BY [Country]

-- Question 17 | Contact titles for customers
SELECT
	[ContactTitle],
	COUNT([ContactTitle]) AS TotalContactTitle
FROM
	[dbo].[Customers]
GROUP BY
	[ContactTitle]
ORDER BY
	[TotalContactTitle] DESC

-- Question 18 | Products with associated supplier names
SELECT
	[ProductID],
	[ProductName],
	[Suppliers].[CompanyName] AS Supplier
FROM 
	[dbo].[Products]
		JOIN [dbo].[Suppliers] ON
		[dbo].[Suppliers].[SupplierID] = [dbo].[Products].[SupplierID]
ORDER BY
	[ProductID]
	
-- Question 19 | Orders and the Shipper that was used
SELECT
	[Orders].[OrderID],
	Convert(date, [OrderDate]) AS OrderDate,
	[CompanyName] AS Shipper
FROM [dbo].[Orders]
	JOIN [dbo].[Shippers] ON [dbo].[Orders].[ShipVia] = [dbo].[Shippers].[ShipperID]
WHERE [OrderID] < 10270
ORDER BY
	[OrderID]

-- Question 10 | Employees, in order of Age
SELECT 
	[FirstName],
	[LastName],
	[Title],
	[BirthDate]
FROM
	[dbo].[Employees]
ORDER BY
	[BirthDate]

	-- Solutions with Northwind Data, SQL Practice Problems

-- Question 20 | Categories, and the total products in each category
SELECT
	cgs.CategoryName,
	count(CategoryName) AS TotalProducts
FROM [dbo].[Categories] cgs
	JOIN [dbo].[Products] p ON p.CategoryID = cgs.CategoryID
GROUP BY
	cgs.CategoryName
ORDER BY 
	TotalProducts
DESC

-- Question 21 | Total customers per country/city
SELECT
	[Country],
	[City],
	COUNT([CustomerID]) AS TotalCustomers
FROM [dbo].[Customers]
GROUP BY
	[Country],
	[City]
ORDER BY
	COUNT(CustomerID) 
DESC

-- Question 22 | Products that need reordering
SELECT
	p.ProductId,
	p.ProductName,
	p.UnitsInStock,
	p.ReorderLevel
FROM [dbo].[Products] p
WHERE p.UnitsInStock < p.ReorderLevel
ORDER BY p.ProductID

-- Question 23 | Products that need reordering, continued
SELECT
	p.ProductId,
	p.ProductName,
	p.UnitsInStock,
	p.ReorderLevel
FROM [dbo].[Products] p
WHERE
	((p.UnitsInStock + p.UnitsOnOrder) <= p.ReorderLevel) AND p.Discontinued = 0
ORDER BY p.ProductID

-- Question 24 | Customer List by Region
SELECT
	c.CustomerID,
	c.CompanyName,
	c.region,
	(case when c.Region is null then 1 else 0 end) AS sort
FROM dbo.[Customers] c
ORDER BY
	sort,
	c.region,
	c.CustomerID
	
-- Question 25 | High freight charges
SELECT TOP 3
	o.ShipCountry,
	AVG(o.Freight) AS AverageFreight
FROM
	[dbo].[Orders] o
GROUP BY
	o.ShipCountry	
ORDER BY
	AverageFreight DESC

-- Question 26 | High freight charges - 2015
SELECT TOP 3
	o.ShipCountry,
	AVG(o.Freight) AS AverageFreight
FROM
	[dbo].[Orders] o
WHERE YEAR(o.OrderDate) = '2015'
GROUP BY
	o.ShipCountry
ORDER BY
	AverageFreight DESC

-- Question 27 | High freight charges with between
SELECT TOP 3
	o.ShipCountry,
	AVG(o.Freight) AS AverageFreight
FROM
	[dbo].[Orders] o
WHERE
	o.OrderDate BETWEEN '2015-01-01 15:00:00.000' AND '2015-12-31 11:00:00.000'
GROUP BY
	o.ShipCountry
ORDER BY
	AverageFreight DESC

-- Question 28 | High freight charges - last year
SELECT TOP 3
	o.ShipCountry,
	AVG(o.Freight) AS AverageFreight
FROM
	[dbo].[Orders] o 
WHERE 
	o.OrderDate >= DATEADD(YY, -1, (SELECT MAX(OrderDate) FROM [dbo].[Orders]))
GROUP BY
	o.ShipCountry
ORDER BY
	AverageFreight 
DESC

-- Question 29 | Employee/Order Detail Report
SELECT
	e.EmployeeID,
	e.LastName,
	o.OrderID,
	p.ProductName,
	od.Quantity
FROM [dbo].[Employees] e
	JOIN [dbo].[Orders] o ON o.EmployeeID = e.EmployeeID
	JOIN [dbo].[OrderDetails] od ON od.OrderID = o.OrderID
	JOIN [dbo].[Products] p ON p.ProductID = od.ProductID
ORDER BY
	o.OrderID,
	p.ProductID

-- Question 30 | Customers with no orders
SELECT
	Customers_CustomerID = c.CustomerID,
	Orders_CustomerId = o.CustomerID
FROM [dbo].[Customers] c LEFT JOIN
	 [dbo].[Orders] o ON o.CustomerID = c.CustomerID
WHERE o.OrderID IS NULL

-- Question 31 | Customers with no orders for EmployeeID 4
SELECT
	c.CustomerID, 
	o.CustomerID
FROM dbo.[Customers] c
	LEFT OUTER JOIN [dbo].[Orders] o ON
		o.CustomerID = c.CustomerID AND o.EmployeeID = 4
WHERE
	o.CustomerID IS NULL