
Use Northwind
go

Select * from Customers

/*Ejercicio 22
Lista los nombres de las categorías y el precio promedio de sus
productos.*/
SELECT CategoryName, AVG(UnitPrice)
FROM Products P, Categories C
WHERE P.CategoryID = C.CategoryID
GROUP BY CategoryName

/*Ejercicio 21
Indicar el producto con el mayor precio unitario.*/
SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice = (SELECT MAX(UnitPrice)
FROM Products)


/*Ejercicio 20
Listar el nombre de las categorías y la cantidad de productos en dicha
categoría*/
SELECT CategoryName, COUNT(ProductID) Quantity
FROM Categories C
JOIN Products P ON C.CategoryID = P.CategoryID
GROUP BY CategoryName

SELECT CategoryName, ProductID
FROM Categories C
JOIN Products P ON C.CategoryID = P.CategoryID
order by CategoryName

/*Indicar el nombre de la categoría con la menor cantidad de ítems de
productos vendidos.*/
SELECT CategoryName, Total
from (SELECT CategoryName, SUM(Quantity) as Total
        FROM Products P
        JOIN OrderDetails OD ON P.ProductID = OD.ProductID
         JOIN Categories C ON P.CategoryID = C.CategoryID
        GROUP BY CategoryName) CQ
where Total = (select min(Total)
                FROM (SELECT CategoryName, SUM(Quantity) as Total
                FROM Products P
                JOIN OrderDetails OD ON P.ProductID =
                OD.ProductID
                JOIN Categories C ON P.CategoryID =
                C.CategoryID
                GROUP BY CategoryName) CQ)


===========
SELECT CategoryName, SUM(Quantity) as Total
        FROM Products P
        JOIN OrderDetails OD ON P.ProductID = OD.ProductID
         JOIN Categories C ON P.CategoryID = C.CategoryID
        GROUP BY CategoryName

select min(Total)
from (SELECT CategoryName, SUM(Quantity) as Total
        FROM Products P
        JOIN OrderDetails OD ON P.ProductID = OD.ProductID
         JOIN Categories C ON P.CategoryID = C.CategoryID
        GROUP BY CategoryName) CQ
=================

/*Ejercicio 14
Listar los nombres de los clientes que son del país de Mexico, Germany, Uk*/
SELECT ContactName, country
 from Customers
 WHERE Country  in ('Mexico', 'Germany', 'UK')
====================
/*Ejercicio 14
Listar los nombres de los clientes que excepto de Spain*/

SELECT ContactName, country
 from Customers
 WHERE Country  not in ('Spain')

SELECT ContactName, country
 from Customers
 WHERE Country  <> 'Spain'

select CustomerID, Country from Customers