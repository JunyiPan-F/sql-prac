-- Q1
SELECT City
FROM Employees
INTERSECT
SELECT City
FROM Customers;

-- Q2a
SELECT DISTINCT City
FROM Customers
WHERE City NOT IN (SELECT DISTINCT City FROM Employees);

-- Q2b
SELECT DISTINCT c.City
FROM Customers c
LEFT JOIN Employees e ON c.City = e.City
WHERE e.EmployeeID IS NULL;

-- Q3
SELECT ProductName, SUM(Quantity) AS TotalOrderQuantity
FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
GROUP BY ProductName;

-- Q4
SELECT c.City, SUM(od.Quantity) AS TotalProductsOrdered
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.City;

-- Q5a
SELECT City
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID) >= 2
UNION
SELECT City
FROM Employees
GROUP BY City
HAVING COUNT(EmployeeID) >= 2;

-- Q5b
SELECT City
FROM (
    SELECT City, COUNT(CustomerID) AS CustomerCount
    FROM Customers
    GROUP BY City
    HAVING COUNT(CustomerID) >= 2
) AS CustCities
UNION
SELECT City
FROM (
    SELECT City, COUNT(EmployeeID) AS EmployeeCount
    FROM Employees
    GROUP BY City
    HAVING COUNT(EmployeeID) >= 2
) AS EmpCities;

-- Q6
SELECT c.City
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.City
HAVING COUNT(DISTINCT od.ProductID) >= 2;

-- Q7
SELECT c.CustomerName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.City <> o.ShipCity;

-- Q8 
SELECT TOP 5 p.ProductName, AVG(od.UnitPrice) AS AvgPrice, c.City AS MostOrderedCity
FROM Products p
JOIN [Order Details] od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY p.ProductName, c.City
ORDER BY SUM(od.Quantity) DESC;

-- Q9a
SELECT DISTINCT City
FROM Employees
WHERE City NOT IN (SELECT DISTINCT City FROM Customers);

-- Q9b
SELECT DISTINCT e.City
FROM Employees e
LEFT JOIN Customers c ON e.City = c.City
WHERE c.CustomerID IS NULL;

-- Q10
SELECT TOP 1 t1.City
FROM 
    (SELECT TOP 1 e.City, COUNT(o.OrderID) AS OrderCntByCity
    FROM Employees e
    JOIN Orders o
    ON o.EmployeeID = e.EmployeeID
    GROUP BY e.City
    ORDER BY COUNT(o.OrderID) DESC) AS t1
JOIN
    (SELECT TOP 1 p.ProductID, SUM(od.Quantity) AS TotalProductQtyOrdered, c.City
    FROM Orders o
    JOIN [Order Details] od
    ON od.OrderID = o.OrderID
    JOIN Products p
    ON p.ProductID = od.ProductID
    JOIN Customers c
    ON c.CustomerID = o.CustomerID
    GROUP BY p.ProductID, c.City
    ORDER BY SUM(od.Quantity) DESC) AS t2
ON t1.City = t2.City;

-- Q11
SELECT DISTINCT * FROM table1;
