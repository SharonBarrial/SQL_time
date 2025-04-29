--solucion ejemplo pc2
Use Prueba3
go
--La empresa cuenta con distintos planes tarifarios. Los planes tarifarios tienen un código único, nombre,
--fecha de creación, empleado responsable, cantidad de MB, cantidad de minutos.

create table planes_tarifarios 
(
codigo int primary key not null,
nombre varchar (250) not null,
fecha_creación date not null,
empleado varchar (250) not null,
cantidad_mb int not null,
cant_minutos int not null,
)

--Del fabricante se conoce su código y nombre. 
--Cada fabricante tiene por lo menos un modelo asignado. Cada modelo de celular estáidentificado por un código único.

create table fabricantes 
(
codigo int primary key not null,
nombre varchar(250) not null,
)

--Los modelos de celulares también son almacenados en la empresa. De los modelos se almacena su
--nombre, código SAP, fecha de lanzamiento, color y fabricante.

create table modelos_celulares 
(
codigo int primary key not null,
nombre varchar (250) not null,
codigo_sap varchar (250) not null,
fecha_lanzamiento date not null,
color varchar (250) not null,
codigo_fabricante int FOREIGN KEY REFERENCES fabricantes (codigo),
)

--La campaña tiene un código, descripción de campaña,
--fecha de creación, empleado responsable y una fecha de caducidad.

create table Campanias 
(
codigo int primary key not null,
descripcion varchar(250) not null,
fecha_creación date not null,
empleado varchar(250) not null,
fecha_caducidad date not null,
)

CREATE TABLE Lineas 
(
codigo int PRIMARY KEY NOT NULL,
num_telefono varchar(10) NOT NULL,
zona varchar(250) NOT NULL,
)

CREATE TABLE Tipos_Lineas
(
codigo int PRIMARY KEY NOT NULL,
descripcion varchar(250) NOT NULL,
)

CREATE TABLE Clientes
(
codigo int primary key not null,
nombre varchar(250) not null,
dni varchar(8) not null,
direccion varchar(250) not null,
email varchar(250) not null,
)

CREATE TABLE Promociones
(
codigo int PRIMARY KEY NOT NULL,
codigo_campania int FOREIGN KEY REFERENCES Campanias (codigo) NOT NULL,
codigo_plan int FOREIGN KEY REFERENCES planes_tarifarios(codigo) NOT NULL,
codigo_modelo int FOREIGN KEY REFERENCES modelos_celulares(codigo) NOT NULL,
fecha_promocion date NOT NULL,
precio int NOT NULL,
descuento decimal NOT NULL,
)

CREATE TABLE Compras
(
codigo int PRIMARY KEY NOT NULL,
codigo_cliente int FOREIGN KEY REFERENCES Clientes (codigo) NOT NULL,
codigo_promocion int FOREIGN KEY REFERENCES Promociones(codigo) NOT NULL,
codigo_linea int FOREIGN KEY REFERENCES Lineas(codigo) NOT NULL,
codigo_tipo_linea int FOREIGN KEY REFERENCES Tipos_Lineas(codigo) NOT NULL,
servicios varchar(250) NOT NULL,
monto int NOT NULL,
fecha_compra date NOT NULL,
)

--Cree las sentencias que permita insertar por lo menos cinco (5) registros en dos (2) de las tablas creadas en
--la pregunta 1.
SELECT*FROM Campanias
INSERT INTO Campanias(codigo, descripcion, fecha_creación, empleado, fecha_caducidad)
VALUES
(1, 'Campaña de verano', '2023-11-08', 'Juan Lopez', '2023-11-20'),
(2, 'Campaña escolar', '2023-11-05', 'Anita Kim', '2023-11-09'),
(3, 'Campaña de verano', '2023-11-08', 'Juan Lopez', '2023-11-20'),
(4, 'Campaña de verano', '2023-11-08', 'Juan Lopez', '2023-11-20'),
(5, 'Campaña de verano', '2023-11-08', 'Juan Lopez', '2023-11-20');

SELECT*FROM Clientes
INSERT INTO Clientes(codigo, nombre, dni, direccion, email)
VALUES
(1, 'Lucero Jamil', '71418561', 'Calle Crisantemos', 'lujam@example.com'),
(2, 'Campaña escolar', '12345678', 'Anita Kim', '2023-11-09'),
(3, 'Campaña de verano', '85962145', 'Juan Lopez', '2023-11-20'),
(4, 'Campaña de verano', '25631498', 'Juan Lopez', '2023-11-20'),
(5, 'Campaña de verano', '95742035', 'Juan Lopez', '2023-11-20');

SELECT*FROM fabricantes
INSERT INTO fabricantes (codigo, nombre)
VALUES
(1, 'Lucero'),
(2, 'Camp'),
(3, 'Lucero');


--Diseñar la función o procedimiento almacenado que permita determinar la cantidad de modelos de celulares
--desarrollados por fabricante para un determinado año (considerar la fecha de lanzamiento). El año es
--ingresado como parámetro.

--Procedimiento

Create Function cant_model (@anio int)
returns table
return
	(SELECT F.nombre, COUNT(M.codigo) AS Cantidad
	FROM fabricantes F
	JOIN modelos_celulares M ON F.codigo = M.codigo_fabricante
	WHERE year(M.fecha_lanzamiento) = @anio 
	GROUP BY F.nombre)

select * from dbo.cant_model(2003)

--• Diseñar la función o procedimiento almacenado que retorne el nombre de el(los) cliente(s) que más compras
--en línea realizó durante un determinado año (considerar la fecha de compra). El año es ingresado como
--parámetro.

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

--Diseñar la función o procedimiento almacenado que permita determinar el(los) cliente(s) que no realizaron
--ninguna compra en línea durante un determinado año (considerar la fecha de compra). El año es ingresado
--como parámetro.

Create Function clientes_compras (@anio int)
returns table
return
	(SELECT C.nombre, COUNT(CO.codigo) AS Cantidad
	FROM Clientes C
	JOIN Compras CO ON C.codigo = CO.codigo_cliente
	WHERE CO.codigo_linea= 0
	AND year(CO.fecha_compra) = @anio 
	GROUP BY C.nombre)

select * from dbo.clientes_compras(2003)

--Diseñar la función o procedimiento almacenado que permita determinar la(las) promoción(es)
--(código_promoción), descripción de campaña, con la mayor cantidad de compras en línea para un
--determinado mes de un determinado año (considerar la fecha de compra). El año y mes son ingresados como
--parámetros.

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

---Diseñar el procedimiento almacenado que permita imprimir las compras en línea (código_compra) y el
--monto pagado (monto_compra) por cada cliente (nombre de cliente) para un determinado año (considerar la
--fecha de compra realizada).