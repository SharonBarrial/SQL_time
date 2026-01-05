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
Select * from dbo.PedidosAño(1997)

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
Ejemplo: Defina una función que permita generar unreporte de ventas por empleado, por año. En esteproceso la función debe retornar: los datos del empleado,la cantidad de pedidos registrados y el monto total porempleado*/Use NorthwindgoCREATE FUNCTION dbo.ReporteVentas(@y int)
RETURNS @tabla TABLE(id int, nombre varchar(20), cantidad int, monto decimal)
ASBEGIN
	INSERT INTO @tabla
	select E.EmployeeID, E.LastName, count(O.OrderID) as Cantidad_Pedidos, sum(OD.Quantity * OD.UnitPrice) as Monto	from Employees E JOIN Orders O on E.EmployeeId = O.EmployeeId     Join OrderDetails OD on OD.OrderID = O.OrderID	 Join Products P on P.ProductId = OD.ProductID	where year(O.OrderDate) =  @y	group by E.EmployeeID, E.LastName
    Return
ENDGO--imprimir el reporte del año 1997
Select * from dbo.ReporteVentas(1996)


=====================================

/* PROCEDIMIENTOS*/

Create procedure listaClientes
AS
	SELECT * from Customers where Customers.City
	like '%M%'

/* ejecutar procedure*/
Execute listaClientes

alter procedure listaClientes
AS
	declare @letra char(3)
	set @letra='%A%'
	SELECT * from Customers where Customers.City like
	@letra

/* ejecutar procedure*/
Execute listaClientes
Exec listaClientes

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
Execute usp_PedidosbyFechas '1996-09-12', '1996-09-23'

======================
/*ESPECIFICAR PARÁMETROS
• Ejemplo: Cree un procedure que liste los código de pedido y su fecha, y el
nombre del producto, precio y cantidad. Se recibe el código del cliente y el año
de las fechas donde se realizaron los PEDIDOS*/CREATE PROCEDURE usp_PedidosClienteAño
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
Go/* Ejecutar el procedimiento ingresando id de customer*/Exec usp_PedidosClienteAño @id='FOLKO'/* Ejecutar el procedimiento ingresando id de customer y el año del pedido*/Exec usp_PedidosClienteAño @id='FOLKO', @año=1998Exec usp_PedidosClienteAño 'FOLKO', 1996=====================/* Eliminar un procedimiento*/Drop Procedure usp_PedidosClienteAño======================CREATE Procedure usp_ConsultaPedidos_x_Año
@y int
AS
	Select *
	FROM Orders
	WHERE YEAR(OrderDate) = @y
Go

/** Ejecutar procedimientos*/
/* Opción 1*/
Exec usp_ConsultaPedidos_x_Año 1996

/* Opción 2*/
Exec usp_ConsultaPedidos_x_Año @y=1998


==================================
CREATE Procedure usp_ConsultaPedidos_x_Anio_v2
@y int=1996
AS
	Select *
	FROM Orders
	WHERE YEAR(OrderDate) = @y
Go

Exec usp_ConsultaPedidos_x_Anio_v2 

========================================================
/*Implemente un procedure que retorne el número de pedidos paraun determinado año.*/CREATE Procedure usp_CuantosPedidos_x_Año@y int,
@q int OUTPUTAS
	Select @q= COUNT(*)	FROM Orders
	WHERE YEAR(Orderdate) = @yGo

=====
/* ejecutar procedimiento  con variable OUTPUT*/
declare @cant int
exec usp_CuantosPedidos_x_Año 1996, @q=@cant OUTPUTprint @cant===========================================/*Implemente un procedure que retorne el numero de pedidos para
un determinado año.*/

Use Northwind
go

CREATE Procedure usp_CuantosPedidos_x_Año2
@y int
AS
	Select COUNT(*)
	FROM Orders
	WHERE YEAR(OrderDate) = @y
Go
/*  ejecutar procedimiento*/
exec usp_CuantosPedidos_x_Año2 1998
===========================================================

/* ESPECIFICAR PARÁMETROS
Implemente un procedure que retorne la cantidad de pedidos y el
monto total de pedidos, registrados por un determinado código del
empleado y en determinado año. */


CREATE Procedure usp_ReportePedidosEmpleado
@id int,
@y int,
@q int OUTPUT,
@monto decimal OUTPUT
AS
	Select @q= COUNT(distinct o.OrderID),
	@monto = SUM(od.UnitPrice*(1-od.Discount)*od.Quantity)
	FROM Orders o JOIN OrderDetails od
	ON o.OrderID=od.orderID
	WHERE o.EmployeeID =@id AND YEAR(o.OrderDate) = @y
Go
/* ejecutar procedimiento*/
/*Al ejecutar el procedimiento almacenado, primero declaramos las
variables de retorno y al ejecutar, las variables de retorno se le
indicara con la expresión OUTPUT.*/

DECLARE @q int, @m decimal
EXEC usp_ReportePedidosEmpleado @id=2, @y=1997, @q=@q OUTPUT, @monto=@m OUTPUT
PRINT 'Cantidad de pedidos colocados:' + Str(@q)
PRINT 'Monto percibido:'+Str(@m)
Go

/* CURSORES EN LOS PROCEDURES
• Implemente un procedure que imprima cada uno de los registros
de los productos, donde al finalizar, visualice el total del
inventario.*/


SELECT ProductID,ProductName, UnitPrice, UnitsInStock
	FROM Products

CREATE PROCEDURE usp_Inventario
AS
	DECLARE @Id int, @Nombre varchar(255), @precio decimal, @st int, @inv int
	SET @inv=0
	DECLARE cproducto CURSOR FOR
	SELECT ProductID,ProductName, UnitPrice, UnitsInStock
	FROM Products
		-- Apertura del cursor y lectura
	OPEN cproducto
	FETCH cproducto INTO @id, @Nombre, @precio, @st
	WHILE (@@FETCH_STATUS = 0 )
	BEGIN
	--imprimir
	PRINT Str(@id) + space(5) + @nombre + space(5) + Str(@precio) +
	space(5) + Str(@st)
	--acumular
	SET @inv += @st
	-- Lectura de la siguiente fila del cursor
	FETCH cproducto INTO @id, @Nombre, @precio, @st
	END
	-- Cierre del cursor
	CLOSE cproducto
	DEALLOCATE cproducto
	Print 'Inventario de Productos:' + Str(@inv)

	/*Ejecutar el procedimiento*/
	Execute usp_Inventario
	
	=======================================
/*Defina un procedimiento almacenado para insertar un registro
de la tabla Clientes, en este procedimiento definiremos
parámetros de entrada que representan los campos de la tabla.*/

select * from Customers

CREATE PROCEDURE usp_InsertaCliente
	@id varchar(5),
	@company varchar(40),
	@contacto varchar(30),
	@title varchar(30),
	@address varchar(60)
	AS
	Insert Into Customers(CustomerID, CompanyName, ContactName,ContactTitle, Address)
	Values(@id, @company, @contacto, @title, @address)
Go

/* Ejecutar procedimiento*/
EXEC usp_InsertaCliente 'ABCDE', 'Telefónica', 'Carlos Torres','Sales', 'Calle 25 No 123'
Go