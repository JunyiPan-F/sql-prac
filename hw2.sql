-- Q1
SELECT COUNT(*) AS TotalProducts
FROM Production.Product;

-- Q2
SELECT COUNT(*) AS ProductsInSubcategory
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL;

-- Q3
SELECT ProductSubcategoryID, COUNT(*) AS CountedProducts
FROM Production.Product
GROUP BY ProductSubcategoryID;

-- Q4
SELECT COUNT(*) AS ProductsWithoutSubcategory
FROM Production.Product
WHERE ProductSubcategoryID IS NULL;

-- Q5
SELECT SUM(Quantity) AS TotalQuantity
FROM  Production.ProductInventory

-- Q6
SELECT ProductID, SUM(Quantity) AS TheSum
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY ProductID
HAVING SUM(Quantity) < 100;


-- Q7
SELECT Inv.Shelf, Inv.ProductID, SUM(Inv.Quantity) AS TheSum
FROM Production.ProductInventory as Inv
WHERE LocationID = 40
GROUP BY Inv.Shelf, Inv.ProductID
HAVING SUM(Inv.Quantity) < 100;

-- Q8
SELECT AVG(Quantity) AS AvgQuantity
FROM Production.ProductInventory
WHERE LocationID = 10;

-- Q9
SELECT ProductID, Shelf, AVG(Quantity) AS TheAvg
FROM Production.ProductInventory
GROUP BY ProductID, Shelf;

-- Q10
SELECT ProductID, Shelf, AVG(Quantity) AS TheAvg
FROM Production.ProductInventory
WHERE Shelf <> 'N/A'
GROUP BY ProductID, Shelf;

-- Q11
SELECT Color, Class, COUNT(*) AS TheCount, AVG(ListPrice) AS AvgPrice
FROM Production.Product
WHERE Color IS NOT NULL AND Class IS NOT NULL
GROUP BY Color, Class;

-- Q12
SELECT CR.Name AS Country, SP.Name AS Province
FROM Person.CountryRegion CR
INNER JOIN Person.StateProvince SP ON CR.CountryRegionCode = SP.CountryRegionCode;

-- Q13
SELECT CR.Name AS Country, SP.Name AS Province
FROM Person.CountryRegion CR
INNER JOIN Person.StateProvince SP ON CR.CountryRegionCode = SP.CountryRegionCode
WHERE CR.Name IN ('Germany', 'Canada');

-- use Northwind
-- Q14
SELECT DISTINCT p.ProductName
FROM Products p
INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
INNER JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.OrderDate >= DATEADD(year, -26, GETDATE());

-- Q15
SELECT TOP 5 ShipPostalCode, COUNT(*) AS TotalSales
FROM Products p
JOIN "Order Details" od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
GROUP BY ShipPostalCode
ORDER BY TotalSales DESC;

-- Q16
SELECT TOP 5 o.ShipPostalCode, SUM(od.Quantity)
FROM Products p
JOIN "Order Details" od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.OrderDate >= DATEADD(YEAR, -25, 
	(SELECT MAX(OrderDate)
	FROM Orders
	)
)
GROUP BY o.ShipPostalCode
ORDER BY SUM(od.Quantity) DESC

-- Q17
SELECT City, COUNT(CustomerID) AS NumberOfCustomers
FROM Customers
GROUP BY City;

-- Q18
SELECT City, COUNT(CustomerID) AS NumberOfCustomers
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID) > 2;

-- Q19
SELECT DISTINCT c.ContactName, o.OrderDate
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate > '1998-01-01';

-- Q20
SELECT c.ContactName, MAX(o.OrderDate) AS MostRecentOrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName 

-- Q21
SELECT c.ContactName, COUNT(od.ProductID) AS ProductCount
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.ContactName

-- Q22
SELECT o.CustomerID, COUNT(od.ProductID) AS ProductCount
FROM Orders o
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY o.CustomerID
HAVING COUNT(od.ProductID) > 100;

-- Q23
SELECT DISTINCT s.CompanyName AS SupplierCompanyName, sh.CompanyName AS ShippingCompanyName
FROM Suppliers s
CROSS JOIN Shippers sh;

-- Q24
SELECT o.OrderDate, p.ProductName
FROM Orders o
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
INNER JOIN Products p ON od.ProductID = p.ProductID
  
-- Q25
SELECT e1.EmployeeID AS EmployeeID1, e1.FirstName + ' ' + e1.LastName AS EmployeeName1,
       e2.EmployeeID AS EmployeeID2, e2.FirstName + ' ' + e2.LastName AS EmployeeName2,
       e1.Title AS JobTitle
FROM Employees e1
INNER JOIN Employees e2 ON e1.EmployeeID < e2.EmployeeID AND e1.Title = e2.Title

-- Q26
SELECT e.EmployeeID, e.FirstName + ' ' + e.LastName AS ManagerName, COUNT(sub.EmployeeID) AS EmployeesReportingTo
FROM Employees e
JOIN Employees sub ON e.EmployeeID = sub.ReportsTo
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING COUNT(sub.EmployeeID) > 2

-- Q27
SELECT City, CompanyName , ContactName AS Name, 'Customer' AS Type
FROM Customers
UNION
SELECT City, CompanyName AS Name, ContactName, 'Supplier' AS Type
FROM Suppliers
ORDER BY City, Name;
