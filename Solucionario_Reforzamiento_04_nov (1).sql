
Use Northwind
go

/*Crear un procedimiento almacenado o función que retorne el nombre del embarcador con mayor
cantidad de pedidos atentidos para un determinado país de destino, el cual es ingresado como
parámetro.*/

/*  Primera Opción  de solución con 2 funciones */
create function Get_company_cantidad_pais (@pais nvarchar(20) )
returns table
return
 ( SELECT S.CompanyName, count(O.OrderID) as Cantidad
    FROM Shippers S
	join Orders O on O.ShipVia = S.ShipperID
	where O.ShipCountry=@pais
	group by S.CompanyName)

Select * from dbo.Get_company_cantidad_pais('Spain')

/*Función principal*/
create function mayor_pedido_emabarcador (@pais varchar(20))
 returns table
 return 
  ( select CompanyName
    from dbo.Get_company_cantidad_pais(@pais)
	where cantidad = (select max (cantidad) 
	                   from dbo.Get_company_cantidad_pais(@pais))
  )

  select * from dbo.mayor_pedido_emabarcador('Mexico')

  /*  Segunda  Opción  de solución con 1 función */

 alter function max_pedido_embarcador (@pais varchar(20))
 returns table
 return 
  ( Select W.CompanyName
	from ( SELECT S.CompanyName, count(O.OrderID) as Cantidad
			 FROM Shippers S
			join Orders O on O.ShipVia = S.ShipperID
			where O.ShipCountry=@pais
			group by S.CompanyName ) W
	where  w.Cantidad = (Select max(Cantidad) from 
				( SELECT S.CompanyName, count(O.OrderID) as Cantidad
					 FROM Shippers S
					join Orders O on O.ShipVia = S.ShipperID
					where O.ShipCountry=@pais 
					group by S.CompanyName ) W )
	)


 select * from dbo.max_pedido_embarcador('Mexico')

 /*Crear un procedimiento almacenado o función que retorne el cliente con la mayor cantidad de órdenes
realizadas de acuerdo a un determiando país de destino y un determinado año, el cual ambos datos son ingresados
como parámetros */

Select ContactName
from  (SELECT C.ContactName,  COUNT(O.OrderID) AS Cantidad
	FROM Customers C
	JOIN Orders O ON C.CustomerID = O.CustomerID
	WHERE O.ShipCountry = 'Spain' and year(O.OrderDate) = 1996
	GROUP BY C.ContactName ) W
where Cantidad =( select max(cantidad)
                  from (SELECT C.ContactName,  COUNT(O.OrderID) AS Cantidad
					FROM Customers C
					JOIN Orders O ON C.CustomerID = O.CustomerID
					WHERE O.ShipCountry = 'Spain' and year(O.OrderDate) = 1996
						GROUP BY C.ContactName) W 
					)

/* Primera función que muestra la cantidad de pedidos por
cliente en un pais y año determinado*/

Create Function Ordenes_Cliente (@pais varchar(20), @anio int)
returns table
return
	(SELECT C.ContactName, COUNT(O.OrderID) AS Cantidad
	FROM Customers C
	JOIN Orders O ON C.CustomerID = O.CustomerID
	WHERE O.ShipCountry = @pais  and year(O.OrderDate) = @anio 
	GROUP BY C.ContactName)

select * from dbo.Ordenes_Cliente ('mexico',1996)

create procedure mayor_pedido_cliente (@pais varchar(20),@anio int )
as
 Begin
   select ContactName
    from dbo.Ordenes_Cliente(@pais, @anio)
	where cantidad = (select max (cantidad) 
	                   from dbo.Ordenes_Cliente(@pais, @anio))
 End

 Exec  mayor_pedido_cliente 'Spain', 1996

 ----------------------------------------
 /*Diseñar un procedimiento almacenado que permita insertar (INSERT) datos en la tabla Categorias,
considerando como datos de entrada el Código de categoría,nombre, descripción. 
Tener en cuenta que se debe controlar el resultado de operación mediante un mensaje de registro de 
"categoria insertada satisfactoriamente" luego de confirmar el COMMIT TRAN o caso
contrario debe realizar el ROLLBACK TRAN confirmando con mensaje "Categoria no ingresada" */

Select * from Categories

Use Northwind
go

 SET IDENTITY_INSERT Categories ON --Activar que se puedan insertar datos
Insert into Categories (CategoryID,CategoryName,Description)
values (120,'turron san jose', 'dulce en el mes morado')


Create PROCEDURE Insertanewcategory
    @CodigoCategoria int,
    @Nombre nvarchar(15),
    @Descripcion nvarchar(max)
AS
BEGIN
     BEGIN TRAN TCategoria
	    SET IDENTITY_INSERT Categories ON
	    INSERT INTO Categories(CategoryID, CategoryName, Description)
		VALUES (@CodigoCategoria, @Nombre, @Descripcion)
		--si se ejecutó correctamente 
		if @@ERROR=0 --variable global del error
			Begin																				
				COMMIT TRAN TCategoria
				PRINT 'Categoría insertada satisfactoriamente'
			 End 
         Else
			Begin
				ROLLBACK TRAN TCategoria
				PRINT 'Categoría no ingresada, presenta error'
         End 
END

Exec Insertanewcategory 77,'dulce', 'arequipeños'
     


CREATE TRIGGER foros_auditoria_trigger
AFTER INSERT OR UPDATE ON foros
FOR EACH ROW
BEGIN
  INSERT INTO foros_auditoria (
    id_foro,
    fecha_registro,
    descripcion
  ) VALUES (
    NEW.id,
    NOW(),
    IF (
      NEW.id IS NULL,
      "Foro creado",
      "Foro actualizado"
    )
  );
END;

Create Function clientes_compras (@anio int)
returns table
return
	(SELECT C.nombre, COUNT(CO.codigo) AS Cantidad
	FROM Clientes C
	JOIN Compras CO ON C.codigo = CO.codigo_cliente
	WHERE CO.codigo_linea=1 
	AND year(CO.fecha_compra) = @anio 
	GROUP BY C.nombre)

select * from dbo.clientes_compras(2003)

create procedure mas_compras (@anio int)
as
 Begin
   select nombre
    from dbo.clientes_compras(@anio)
	where cantidad = (select max (cantidad) 
	                   from dbo.clientes_compras(@anio))
 End;

Exec mas_compras 2003
