

/* Desarrolle una procedure (store procedure) que reciba como parámetro de entrada 
el código de un producto la nueva descripci´on y permita modificar  la descripción del producto,
considerando COMMIT o ROLLBACK para confirmar el resultado de modificación. */

Use Northwind
go

CREATE PROCEDURE Modifica_Producto
    @CodigoProducto INT,
    @Nuevo NVARCHAR(40)
AS
BEGIN
    BEGIN TRAN TProduct
    UPDATE Products
    SET ProductName = @Nuevo
    WHERE ProductID = @CodigoProducto
    IF @@ERROR = 0
    BEGIN
        COMMIT TRAN TProduct
        PRINT 'Descripción del producto modificada exitosamente.'
    END
    ELSE
    BEGIN
        ROLLBACK TRAN TProduct
        PRINT 'Error al modificar la descripción del producto. La transacción se ha revertido.'
    END
END

select * from Products

Exec  Modifica_Producto 2, "alfajor"


/*Crear un trigger sobre la TABLA Producto. Debe validarse que mínimo Solo debe existir la cantidad de 1 producto, 
esta validación debe realizarse para un UPDATE. 
Además, se debe controlar el resultado de la VALIDACION mediante un mensaje permitiendo realizar un COMMIT TRAN 
si esta todo bien o caso contrario debe realizar el ROLLBACK TRAN confirmando con otro mensaje. */

--nunca sobre un select
--si puede haber transacciones en el trigger
Create TRIGGER trg_valida_cantidad_producto
ON products
AFTER UPDATE --después de actualizarse
AS
BEGIN
  Begin Tran
	Declare @q int
    Select @q=INSERTED.UnitsInStock From INSERTED
    IF @q=0
    BEGIN
        ROLLBACK TRANSACTION;
  --      RAISERROR('Al menos debe quedar un producto en stock', 16, 1);
		--Print ERROR_MESSAGE()
		print 'Al menos debe quedar un producto en stock'
    END
    ELSE
    BEGIN
        COMMIT TRANSACTION
		print 'se actualizó con éxito'
    END
END

Select * from Products
update Products
set UnitsInStock=1
where ProductID = 1

update Products
set UnitsInStock=0
where ProductID = 7


/*Crear una función o procedimiento almacenado que retorne la categoría con la menor cantidad de
órdenes realizadas durante un determinado año del peido, el cual es ingresado como parámetro.*/

Use Northwind
go

SELECT Cat.CategoryID, Cat.CategoryName, count(O.OrderID) as cantidad
    FROM Categories Cat
	join Products P on P.CategoryID = Cat.CategoryID
	Join OrderDetails OD on OD.ProductID = P.ProductID
	join Orders O on O.OrderID = OD.OrderID
	where year(O.OrderDate) = 1996
	group by Cat.CategoryID, Cat.CategoryName


select CategoryName, cantidad
from (
SELECT Cat.CategoryID, Cat.CategoryName, count(O.OrderID) as cantidad
    FROM Categories Cat
	join Products P on P.CategoryID = Cat.CategoryID
	Join OrderDetails OD on OD.ProductID = P.ProductID
	join Orders O on O.OrderID = OD.OrderID
	group by Cat.CategoryID, Cat.CategoryName ) W
where cantidad = (select min(cantidad) from 
                  (SELECT Cat.CategoryID, Cat.CategoryName, count(O.OrderID) as cantidad
					FROM Categories Cat
					join Products P on P.CategoryID = Cat.CategoryID
					Join OrderDetails OD on OD.ProductID = P.ProductID
					join Orders O on O.OrderID = OD.OrderID
					group by Cat.CategoryID, Cat.CategoryName ) W)

create function cantidad_pedido_por_categoria (@anio int )
returns table
return
 (SELECT Cat.CategoryID, Cat.CategoryName, count(O.OrderID) as cantidad
    FROM Categories Cat
	join Products P on P.CategoryID = Cat.CategoryID
	Join OrderDetails OD on OD.ProductID = P.ProductID
	join Orders O on O.OrderID = OD.OrderID
	where year(O.OrderDate) = @anio
	group by Cat.CategoryID, Cat.CategoryName )

 create function menor_pedido_categoria (@anio int)
 returns table
 return 
  (select CategoryName, cantidad
    from dbo.cantidad_pedido_por_categoria(@anio)
	where cantidad = (select min(cantidad) from 
                       dbo.cantidad_pedido_por_categoria(@anio)
					   )
	)

select * from dbo.menor_pedido_categoria(1996)



CREATE FUNCTION ObtenerCategoria_MinOrder (@Año INT)
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @CategoriaMinima NVARCHAR(50)

    SELECT TOP 1 @CategoriaMinima = Categoria
    FROM (
        SELECT Categoria, COUNT(*) AS CantidadOrdenes
        FROM TuTablaDeOrdenes
        WHERE YEAR(FechaOrden) = @Año
        GROUP BY Categoria
    ) AS CategoriasConCantidad
    ORDER BY CantidadOrdenes

    RETURN @CategoriaMinima
END