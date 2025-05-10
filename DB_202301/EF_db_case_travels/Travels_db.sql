--pregunta 2
CREATE FUNCTION mostrar_datos_usuario() 
RETURNS TABLE
AS
RETURN(
SELECT 
	e.apellido_paterno, e.apellido_materno as 'nombre'
	c.carrera_nombre as 'carrera'
	FROM estudiantes e
	JOIN carreras c ON e.codigo_carrera=c.codigo
	);

SELECT * FROM mostrar_datos_usuario();

--pregunta 3
CREATE FUNCTION mostrar_cantidad_estudiantes_x_carrera() 
RETURNS TABLE
AS
RETURN(
SELECT 
	c.nombre as 'carrera', COUNT(*) as cantidad
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

--pregunta7

db.createCollection("Reserva_Espacio_Estacionamiento", {
   validator: 
{
  $jsonSchema: {
    bsonType: 'object',
    title: 'Coleccion Reserva_Espacio_Estacionamiento',
    required: [
      'reserva_espacio_estacionamiento_id',
      'usuario',
      'espacio_estacionamiento',      
      'fecha_reserva',
      'fecha_inicio',
      'hora_reserva',
      'hora_inicio',
      'tipo_vehiculo',
      'placa',
      'marca',
      'modelo',
    ],
    properties: {
      reserva_espacio_estacionamiento_id: {
        bsonType: 'int',
        description: 'Debe ser un int es obligatorio'
      },

      usuario: {
        bsonType: 'object',
	 required: [“nombre”, “apellido_paterno”, “apellido_materno”, “email”],
	 properties: {
	   nombre: {
	bsonType: “string”
}
		
}
        
      },
      fecha_reserva: {
        bsonType: 'date',
        description: 'Debe ser un date y es obligatorio'
      },
      fecha_inicio: {
        bsonType: 'date',
        description: 'Debe ser un date y es obligatorio'
      },
	hora_reserva: {
        bsonType: 'time',
        description: 'Debe ser un time y es obligatorio'
      },
      tipo_vehiculo: {
        bsonType: 'string',
        description: 'Debe ser un string y es obligatorio'
      },
      hora_inicio: {
        bsonType: 'time',
        description: 'Debe ser un time y es obligatorio'
      },

      placa: {
        bsonType: 'string',
        description: 'Debe ser un string es obligatorio'
      },

      marca: {
        bsonType: 'string',
        description: 'Debe ser un string y es obligatorio'
      },
      modelo: {
        bsonType: 'date',
        description: 'Debe ser un date y es obligatorio'
      },
     
          
      }
     }
    }
   }
})

----------------------------------------------------------
--Pregunta 8 
--Model one-to-one relationships with embedded documents
--Solo un usuario puede realizar una reserva
-- Documento embebido: En el mismo documento que representa una reserva de estacionamiento se tiene el campo [usuario] el cual es un objeto que representa a un usuario.

--Model one-to-one relationships with embedded documents
--Una reserva solo se puede hacer en un estacionamiento
-- Documento embebido: En el mismo documento que representa una reserva de estacionamiento se tiene el campo [espacio_estacionamiento] el cual es un objeto que representa a un espacio de un estacionamiento.
----------------------------------------------------------------

---------------------------------------------
--NoSQL - MONGO DB PART
---------------------------------------------
---Pregunta 9
db.restaurant.aggregate([{ $group: { _id: "city", quantity: {$count :{}} }}])
 
--Pregunta 10
db.restaurant.aggregate([{$match:{"cuisine":"Bakery"}},{$group: { _id: "city", quantity: {$count :{}} }}])
