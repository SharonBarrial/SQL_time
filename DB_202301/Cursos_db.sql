--"""foros"""
create function cursos_foros(@anio int)
	returns table
	(nombre_curso varchar(255),anio int, cantidad_foros int) 
	return
	(SELECT C.nombre, C.anio, COUNT(*) AS cantidad_foros
	FROM cursos C
	 WHERE C.anio = @anio
	GROUP BY C.nombre, C.anio
	ORDER BY cantidad_foros DESC
	LIMIT 10
	);

END;

select * FROM dbo.cursos_foros(2003)


create table foros (
  foro_id int PRIMARY KEY NOT NULL,
  fecha_registro datetime NOT NULL,
  descripcion varchar(255) NOT NULL,
);

 SET IDENTITY_INSERT foros ON
INSERT INTO foros (foro_id, fecha_registro, descripcion)
VALUES (1,'2023-08-11', 'Un foro para hablar de programación');

CREATE TRIGGER auditoria_foros_insert_update
AFTER INSERT OR UPDATE
ON foros
AS
	BEGIN TRAN foros
		SET IDENTITY_INSERT Categories ON
	    INSERT INTO foros(foro_id, fecha_registro, descripcion)
		VALUES (@newid, @fecha, @Descripcion)
		if @@ERROR=0
			Begin
				COMMIT TRAN foros
				PRINT 'Foro creado'
				PRINT 'Foro actualizado'
         End 
END;


--"""lecciones"""
Create Function cursos_lecciones_categoroa (@categoria varchar(250))
returns table
return
	(SELECT C.codigo, C.nombre, C.categoria, COUNT(CO.codigo) AS Cantidad_lecciones
	FROM cursos C
	JOIN lecciones l ON C.codigo = l.codigo_curso
	WHERE C.categoria= @categoria
	GROUP BY C.codigo, C.nombre, C.categoria)

select * from dbo.cursos_lecciones_categoroa(2003)

create procedure mas_cursos (@categoria varchar(250))
as
 Begin
   select nombre
    from dbo.cursos_lecciones_categoroas(@categoria varchar(250))
	where cantidad = (select max (cantidad) 
	                   from dbo.rsos_lecciones_categoroas(@categoria varchar(250))
 End;

Exec cursos_lecciones_categoroas ('arte')

--"""leccionesxcategorias"""
create Function cursos_lecciones_categoroas(@anio int)
returns table
return
	(SELECT C.codigo, C.nombre, C.categoria, C.lecciones, COUNT(CO.codigo) AS Cantidad_lecciones
	FROM cursos C
	JOIN lecciones l ON C.codigo = l.codigo_curso
	WHERE year(l.fecha) = @anio 
	GROUP BY C.codigo, C.nombre, C.categoria, C.lecciones)

select * from dbo.cursos_lecciones_categoroa(2003)

create procedure mas_cursos (@anio int)
as
 Begin
   select nombre
    from dbo.cursos_lecciones_categoroas(@anio)
	where cantidad = (select max (cantidad) 
	                   from dbo.cursos_lecciones_categoroas(@anio))
 End;


Exec cursos_lecciones_categoroas 2003
  
--"""precios"""
SELECT nombre, precio
FROM cursos
WHERE precio > (
    SELECT AVG(precio)
    FROM cursos
	);

select * from cursos

--"""usuarios"""
SELECT*FROM usuarios
INSERT INTO usuarios(usuariosID,nombre,apellido, num_telef,email,contraseña)
VALUES
(1, 'Juan', 'Perez', '92358746', 'juan@example.com', '123juan'),
(2, 'Luana', 'Torres', '98288746', 'luana@example.com', '123lqqqa'),
(3, 'Luis', 'Alvarado', '92520746', 'luis@example.com', '123luiass'),
(4, 'garly', 'Lopez', '95018746', 'lopex@example.com', '123lopex4'),
(5, 'KJulia', 'Kim', '99998549', 'Julia@example.com', 'quendmjd'),

