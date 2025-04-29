create database p2;

go

use p2


S
CREATE FUNCTION mostrar_cantidad_estudiantes_x_carrera() 
RETURNS TABLE
AS
RETURN(
SELECT 
	c.nombre as 'carrera', COUNT(*) as cantidad_estudiantes
	FROM estudiantes e
	JOIN carreras c ON e.codigo_carrera=c.codigo
	GROUP BY c.nombre
	);

SELECT * FROM mostrar_cantidad_estudiantes_x_carrera();

--pregunta 3
CREATE FUNCTION mostrar_cantidad_estudiantes_x_carrera() 
RETURNS TABLE
AS
RETURN(
SELECT 
	c.nombre as 'carrera', COUNT(*) as cantidad_estudiantes
	FROM estudiantes e
	JOIN carreras c ON e.codigo_carrera=c.codigo
	GROUP BY c.nombre
	);

SELECT * FROM mostrar_cantidad_estudiantes_x_carrera();

--pregunta 4
create procedure calcular_destinarios
as
begin
    SELECT
        c.codigo_conversacion,
        p.nombre as destinatario,
        COUNT(p.nombre) as cantidad_destinatarios
    FROM destinatarios_correos dc
    JOIN correos c ON dc.codigo_correo = c.codigo
    JOIN personas p ON dc.codigo_destinatario = p.codigo
    GROUP BY
        c.codigo_conversacion,
        p.nombre
    ORDER BY c.codigo_conversacion;
END;

exec calcular_destinarios

--pregunta 5
CREATE PROCEDURE spammers
AS
BEGIN
    SELECT
        p.codigo as codigo_spammer,
        p.nombre as nombre_spammer
    FROM personas p
    JOIN correos c ON p.codigo=c.codigo_remitente
    JOIN destinatarios_correos dc ON c.codigo = dc.codigo_correo
    GROUP BY p.codigo, p.nombre
    HAVING
        COUNT(c.codigo_conversacion)=
		(
            SELECT max(total_conversaciones)
            FROM (
                SELECT p.codigo, COUNT(c.codigo_conversacion) as total_conversaciones
                FROM personas p
                JOIN correos c ON p.codigo=c.codigo_remitente
                JOIN destinatarios_correos dc ON c.codigo dc.codigo_correo
                GROUP BY p.codigo
            ) as conversaciones_por_persona
        )
end;

exec spammers

--pregunta6

create procedure mas_correos
as
begin
    SELECT
        p.nombre as nombre,
        c.codigo_conversacion as codigo_conversacion,
        COUNT(c.codigo) as cantidad_correos
    FROM personas p
    JOIN correos c ON p.codigo = c.codigo_remitente
    JOIN destinatarios_correos dc ON c.codigo = dc.codigo_correo
    JOIN
        correos c2 ON dc.codigo_destinatario = c2.codigo_remitente AND c.codigo_conversacion = c2.codigo_conversacion
    JOIN
        personas p2 ON c2.codigo_remitente = p2.codigo
    GROUP BY
        p.nombre, c.codigo_conversacion
    HAVING
        COUNT(c2.codigo) >= ALL (
            SELECT
                COUNT(c3.codigo)
            FROM
                correos c3
            JOIN
                destinatarios_correos dc2 ON c3.codigo = dc2.codigo_correo
            WHERE
                c.codigo_conversacion = c3.codigo_conversacion
            GROUP BY
                c3.codigo_conversacion
        );
END;

--pregunta 6
create function mas_correos ()
 returns table
 return 
  ( Select p.codigo
	from ( SELECT c.codigo, count(c.codigo) as cantidad_correos
			 FROM correos c
			join destinarios_correos dc on dc.codigo_correo = c.codigo_conversacion
			group by c.codigo ) w
	where  w.cantidad = (select max(cantidad) from 
				( SELECT dc.codigo, count(c.codigo_remitente) as cantidad
					 FROM destinatarios_correos dc
					join codigo_correo dc on dc.codigo_destiantario = c.codigo
					where dc.codigo_destinario
					group by c.codigo ) w)
	)


 select * from mas_correos