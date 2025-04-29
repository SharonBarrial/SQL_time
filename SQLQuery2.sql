CREATE DATABASE WX42_INTELLECTA

Use WX42_INTELLECTA
Go

create table usuarios 
(
usuariosID int primary key not null,
nombre varchar(250) not null,
apellido varchar(250) not null,
num_telef varchar(250) not null,
email varchar(250) not null,
contraseña varchar(250) not null,
)

create table cursos 
(
cursosID int primary key not null,
nombre varchar(250) not null,
descripcion varchar(250) not null,
precio decimal not null,
categorizacion varchar(250) not null,
)

create table  retroalimentaciones
(
retorID int primary key not null,
score int not null,
comentarios varchar(250) not null,
cod_usuarios int FOREIGN KEY REFERENCES usuarios(usuariosID),
cod_curso int FOREIGN KEY REFERENCES cursos(cursosID)
)


SELECT*FROM usuarios
INSERT INTO usuarios(usuariosID,nombre,apellido, num_telef,email,contraseña)
VALUES
(1, 'Juan', 'Perez', '92358746', 'juan@example.com', '123juan'),
(2, 'Luana', 'Torres', '98288746', 'luana@example.com', '123lqqqa'),
(3, 'Luis', 'Alvarado', '92520746', 'luis@example.com', '123luiass'),
(4, 'garly', 'Lopez', '95018746', 'lopex@example.com', '123lopex4'),
(5, 'KJulia', 'Kim', '99998549', 'Julia@example.com', 'quendmjd'),

SELECT nombre, precio
FROM cursos
WHERE precio > (
    SELECT AVG(precio)
    FROM cursos
	);

select * from cursos


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

