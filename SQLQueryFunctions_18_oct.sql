Use Northwind
go

/*Ejercicio: Defina una función que liste los registros de
los clientes e incluya : 
• Código
• Nombre
• Dirección
• País */


CREATE FUNCTION Clientes() RETURNS TABLEAS
RETURN (Select CustomerID as 'codigo', 
		CompanyName as 'Cliente', 
		Address as 'direccion', 
		Country as 'Pais'
		From Customers)


--ejecutando la funcion
Select * from dbo.Clientes() Where Pais='Germany'Go================================/* Ejemplo: Defina una función que liste los registros de los
pedidos para un determinado año e incluya:
• El código del pedido
• La fecha del pedido
• El nombre del producto
• El precio que fue vendido
• La cantidad vendida*/


CREATE FUNCTION dbo.PedidosAño(@y int) RETURNS TABLEAS
RETURN (Select o.OrderID as 'Pedido',
	o.OrderDate as 'FechaPedido',	p.Productname as 'NombreProducto',
	od.UnitPrice as 'Precio',	od.Quantity as 'cantidad'
	From Orders o JOIN OrderDetails od
	ON o.orderID = od.OrderID	JOIN Products p
	ON od.ProductID = p.productID
	where year(OrderDate) = @y)

go

--ejecutando la funcion
Select * from dbo.PedidosAño(1998)

=================================

/*MULTISENTENCIAS
• Ejemplo: Defina una función que retorne los PRODUCTOSque se acaban de registrar en la base de datos.*/CREATE FUNCTION dbo.Inventario() 
RETURNS @tabla TABLE( idproducto int, nombre varchar(50),precio decimal,stock int)
ASBEGIN
	INSERT INTO @tabla
	SELECT ProductID, ProductName, UnitPrice, UnitsInStock	FROM Products
	RETURN
END

--ejecutando la funcion
Select * from dbo.Inventario()

==================================

/*FUNCIONES DE TABLAMULTISENTENCIAS
Ejemplo: Defina una función que permita generar unreporte de ventas por empleado, por año. En esteproceso la función debe retornar: los datos del empleado,la cantidad de pedidos registrados y el monto total porempleado*/CREATE FUNCTION dbo.ReporteVentas(@y int)
RETURNS @tabla TABLE(id int, nombre varchar(50), cantidad int, monto decimal)
ASBEGIN
	INSERT INTO @tabla
	select E.EmployeeID, E.LastName, count(O.OrderID) as Cantidad_Pedidos, sum(OD.Quantity * OD.UnitPrice) as Monto	from Employees E JOIN Orders O on E.EmployeeId = O.EmployeeId     Join OrderDetails OD on OD.OrderID = O.OrderID	 Join Products P on P.ProductId = OD.ProductID	where year(O.OrderDate) =  @y	group by E.EmployeeID, E.LastName
    Return
ENDGO--imprimir el reporte del año 1997
Select * from dbo.ReporteVentas(1997)

=====================================

/* PROCEDIMIENTOS*/

Create procedure listaClientes
AS
	SELECT * from Customers where Customers.City
	like '%M%'


alter procedure listaClientes
AS
	declare @letra char(3)
	set @letra='%A%'
	SELECT * from Customers where Customers.City like
	@letra

Execute listaClientes

=======================
/*Ejemplo: Crear un procedimiento almacenado que liste los clientes */
--procedimiento almacenado---

CREATE PROCEDURE usp_Listado_Clientes
AS
	Select CustomerID as codigo, CompanyName, Address, Phone
	from Customers
Go
/* Para ejecutar el procedimiento almacenado
--ejecutando el procedimiento almacenado  */

EXEC usp_Listado_Clientes

============================

/*En este procedimiento realizamos la consulta de pedidos entre
un rango de dos fechas.*/

CREATE PROCEDURE usp_PedidosbyFechas
@f1 DateTime,
@f2 DateTime
AS
	Select *
	from Orders
	Where OrderDate BETWEEN @f1 AND @f2
go

/* Ejecutar un procedimiento*/
Execute usp_PedidosbyFechas '1996-09-12','1996-09-23'

======================
/*ESPECIFICAR PARÁMETROS
• Ejemplo: Cree un procedure que liste los código de pedido y su fecha, y el
nombre del producto, precio y cantidad. Se recibe el código del cliente y el año
de las fechas donde se realizaron los PEDIDOS*/CREATE PROCEDURE usp_PedidosClienteAño
@id varchar(5),
@año int = 1996
AS
	Select  O.OrderID as 'Pedido', O.OrderDate as 'FechaPedido', P.ProductName as 'NombreProducto',
	OD.UnitPrice as 'Precio', OD.Quantity as 'Cantidad'
	From Products P Join OrderDetails OD
	on P.ProductID = OD.ProductID Join Orders O
	on O.OrderID = OD.OrderID Join Customers C
	on C.CustomerID = O.CustomerID
     where year(O.OrderDate) =@año and C.CustomerID=@id
Go/* Ejecutar el procedimiento ingresando id de customer*/Exec usp_PedidosClienteAño @id='VINET'/* Ejecutar el procedimiento ingresando id de customer y el año del pedido*/Exec usp_PedidosClienteAño @id='FOLKO', @año=1998=====================/* Eliminar un procedimiento*/Drop Procedure usp_PedidosClienteAño======================