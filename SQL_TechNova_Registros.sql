--Insertar 10 registros en la tabla autenticacion--
INSERT INTO autenticacion(autenticacion_ID,correo_electronico,contrasena)
VALUES
(1,'mariaperez23@gmail.com','P@ssw0rd#2023'),(2,'juancastro45@gmail.com','Secur1tyR0cks!'),
(3,'alejandravelez78@gmail.com','Qu1ckBrownF0x'),(4,'carlosrodriguez12@gmail.com','Str0ngP@ss123'),
(5,'lauragomez55@gmail.com','L3tM3In$ecure'),(6,'pedroalvarez99@gmail.com','F1n@nc1@l$af3'),
(7,'isabellopez11@gmail.com','B3$tPr@ct1c3s!'),(8,'diegohernandez33@gmail.com','C0ff33&Ch0c0l@t3'),
(9,'adrianamartinez66@gmail.com','$t@yH3@lthy!'),(10,'juanmendoza88@gmail.com','2F@st2Fur10us');

--Insertar 10 registros en la tabla usuario--
INSERT INTO usuario(usuario_ID,nombre,apellido,genero,numero_telefono,autenticacion_autenticacion_ID)
VALUES
(1,'Maria','Perez','Femenino',987654321,1),(2,'Juan','Castro','Masculino',956789012,2),
(3,'Alejandra','Velez','Femenino',945678901,3),(4,'Carlos','Rodriguez','Masculino',998765432,4),
(5,'Laura','Gomez','Femenino',965432109,5),(6,'Pedro','Alvarez','Masculino',976543210,6),
(7,'Isabel','Lopez','Femenino',934567890,7),(8,'Diego','Hernandez','Masculino',977654321,8),
(9,'Adriana','Martinez','Femenino',954321098,9),(10,'Juan','Mendoza','Masculino',993210987,10);

--Insertar 10 registros en la tabla servicio_curso--
INSERT INTO servicio_curso(servicio_curso_ID,titulo_curso,duracion_curso,descripcion_curso,usuario_usuario_ID)
VALUES
(1,'Fundamentos de Finanzas Personales','02:30:00','Este curso te proporcionará los conocimientos esenciales para tomar el control de tus finanzas personales, incluyendo la gestión del dinero, el ahorro y la inversión',3),
(2,'Presupuesto Inteligente y Control de Gastos','01:35:00','Aprende a crear un presupuesto efectivo, rastrear tus gastos y tomar decisiones financieras informadas para mejorar tu salud financiera',4),
(3,'Inversiones para Principiantes','01:00:00','Descubre las opciones de inversión disponibles y cómo empezar a construir un portafolio de inversiones acorde a tus metas financieras',1),
(4,'Gestión de Deudas y Crédito Responsable','02:45:00','Aprende estrategias para manejar deudas, mejorar tu puntaje crediticio y evitar problemas financieros relacionados con el crédito',2),
(5,'Planificación Financiera a Largo Plazo','01:15:00','Este curso se enfoca en la planificación financiera a largo plazo, incluyendo la jubilación, la educación de los hijos y la planificación patrimonial',10),
(6,'Educación Financiera para Emprendedores','02:00:00','Diseñado para emprendedores, este curso cubre temas financieros específicos para quienes dirigen sus propios negocios, como financiamiento y gestión de flujo de efectivo',8),
(7,'Ahorro y Estrategias de Inversión','02:15:00','Aprende a ahorrar de manera efectiva y a evaluar opciones de inversión que te ayuden a alcanzar tus objetivos financieros',7),
(8,'Finanzas Personales Éticas y Sostenibles','01:55:00','Explora cómo alinear tus valores personales con tus decisiones financieras y apoyar prácticas financieras éticas y sostenibles',9),
(9,'Educación Financiera para Jóvenes Adultos','02:05:00','Dirigido a jóvenes adultos, este curso enseña habilidades financieras fundamentales, como la gestión del dinero, la planificación de carrera y la inversión temprana',6),
(10,'Tomando Decisiones Financieras Inteligentes','02:20:00','Adquiere las habilidades necesarias para tomar decisiones financieras informadas, desde la compra de una vivienda hasta la planificación de grandes compras',5);

--Insertar 10 registros en la tabla temas_servicio_curso--
INSERT INTO tema_servicio_curso(tema_servicio_curso_ID,titulo_tema,descripcion_tema,servicio_curso_servicio_curso_ID)
VALUES
(1,'Inversión y Crecimiento del Dinero','En este tema, explorarás estrategias para hacer que tu dinero trabaje para ti. Aprenderás sobre las diferentes opciones de inversión y cómo construir un portafolio diversificado que te permita alcanzar tus metas financieras a largo plazo',1),
(2,'El Poder del Ahorro','Este tema se centra en la importancia del ahorro y cómo puedes hacerlo de manera efectiva. Aprenderás a establecer un fondo de emergencia, ahorrar para objetivos específicos y asegurarte de que tus finanzas estén protegidas',2),
(3,'Estrategias de Inversión y Riesgo','En este tema, profundizarás en las estrategias de inversión, desde la inversión a corto plazo hasta la inversión a largo plazo. También comprenderás cómo evaluar y gestionar el riesgo en tus inversiones',3),
(4,'Consolidación de Deudas y Reparación Crediticia','Descubre cómo consolidar tus deudas para simplificar los pagos y mejorar tu situación financiera. También aprenderás estrategias para reparar y mantener un buen historial crediticio',4),
(5,'Planificación de Jubilación y Herencia','Este tema se enfoca en la planificación de la jubilación y la gestión de activos a largo plazo. Aprenderás a construir un plan de jubilación sólido y a planificar la herencia de tu patrimonio',5),
(6,'Finanzas Empresariales Avanzadas','Para los emprendedores, este tema aborda temas financieros más avanzados, como la gestión del flujo de efectivo, la valoración de empresas y la estrategia de financiamiento empresarial',6),
(7,'Inversión para Objetivos Específicos','Aprenderás cómo invertir con un propósito, ya sea para la educación universitaria de tus hijos, la compra de una vivienda o la jubilación. Descubrirás cómo diseñar estrategias de inversión alineadas con tus objetivos',7),
(8,'Inversión Ética y Sostenible','En este tema, profundizarás en la inversión ética y sostenible. Aprenderás a identificar inversiones alineadas con tus valores y a apoyar empresas y proyectos que promuevan un impacto positivo en el mundo',8),
(9,'Carrera y Crecimiento Profesional','Este tema se enfoca en la planificación de carrera, el crecimiento profesional y cómo tomar decisiones financieras inteligentes a medida que avanzas en tu vida adulta y tu carrera',9),
(10,'Decisiones Importantes: Vivienda y Grandes Compras','Explora cómo tomar decisiones financieras informadas en situaciones cruciales, como la compra de una vivienda, un automóvil o la planificación de grandes compras. Aprende a evaluar opciones y a tomar decisiones acertadas',10);

--Insertar 10 registros en la tabla logro_servicio_curso--
INSERT INTO logro_servicio_curso(logro_servicio_curso_ID,cantidad_curso_completo,fecha_finalizacion_curso,servicio_curso_servicio_curso_ID)
VALUES
(1,3,'2023-01-15',7),(2,6,'2023-03-28',8),
(3,1,'2023-05-10',9),(4,2,'2023-07-22',5),
(5,8,'2023-09-04',1),(6,4,'2023-10-17',4),
(7,2,'2023-02-09',2),(8,9,'2023-04-13',3),
(9,1,'2023-06-26',6),(10,5,'2023-08-31',10);

--Insertar 10 registros en la tabla comentario_servicio_curso--
INSERT INTO comentario_servicio_curso(comentario_servicio_curso_ID,contenido_comentario_servicio_curso)
VALUES
(1,'¡Un excelente curso para comenzar! Aprendí a presupuestar, ahorrar e invertir de manera inteligente. ¡Muy útil para cualquier persona!'),
(2,'Este curso me dio el control de mis finanzas. El tema del presupuesto y el control de gastos fue especialmente útil. ¡Ahora tengo una visión clara de mis gastos!'),
(3,'Aprendí a invertir de manera efectiva en este curso. Las estrategias de inversión me ayudaron a tomar decisiones financieras más acertadas'),
(4,'Una guía imprescindible para gestionar deudas y mantener un buen crédito. Mi puntaje crediticio mejoró significativamente después de tomar este curso'),
(5,'Este curso me dio confianza en mi planificación financiera a largo plazo. Ahora sé cómo prepararme para la jubilación y cómo planificar mi herencia'),
(6,'Como emprendedor, este curso fue exactamente lo que necesitaba. Aprendí a gestionar el flujo de efectivo y a tomar decisiones financieras inteligentes para mi negocio'),
(7,'Aprender a ahorrar e invertir estratégicamente fue fundamental. Ahora sé cómo alcanzar mis objetivos financieros, ya sea un fondo de emergencia o la jubilación'),
(8,'Me encantó aprender sobre inversión ética y sostenible en este curso. Ahora puedo invertir de manera alineada con mis valores y contribuir a un mundo más sostenible'),
(9,'Este curso me preparó para la vida adulta. Aprendí a manejar mi dinero, planificar mi carrera y tomar decisiones financieras informadas'),
(10,'El curso me ayudó a tomar decisiones financieras acertadas en situaciones importantes. Aprendí a evaluar riesgos y recompensas en mis decisiones financieras');

--Insertar 10 registros en la tabla comentario_por_servicio_curso--
INSERT INTO comentario_por_servicio_curso(servicio_curso_servicio_curso_ID,comentario_servicio_curso_comentario_servicio_curso_ID,fecha_publicacion_comentario)
VALUES
(1,1,'2023-01-10'),(2,2,'2023-03-20'),
(3,3,'2023-05-15'),(4,4,'2023-07-08'),
(5,5,'2023-09-22'),(6,6,'2023-10-12'),
(7,7,'2023-02-18'),(8,8,'2023-04-30'),
(9,9,'2023-06-25'),(10,10,'2023-08-05');

--Insertar 10 registros en la tabla notificacion_servicio_curso--
INSERT INTO notificacion_servicio_curso(notificacion_servicio_curso_ID,descripcion_notificacion_servicio_curso,fecha_notificacion,hora_notificacion,servicio_curso_servicio_curso_ID)
VALUES
(1,'¡No te pierdas nuestro próximo curso de educación financiera! Aprende a presupuestar, ahorrar e invertir sabiamente. Regístrate ahora','2023-10-01','08:30:00',1),(2,'Descubre cómo tomar el control de tus finanzas. Nuestro curso de educación financiera te enseñará las mejores prácticas. ¡Inscríbete hoy!','2023-10-15','10:15:45',2),
(3,'¡La educación financiera es clave para un futuro financiero sólido! Únete a nuestro curso y adquiere las habilidades que necesitas.','2024-01-10','12:00:30',3),(4,'Estás a un paso de mejorar tus habilidades financieras. Únete a nuestro curso de educación financiera y toma el control de tu dinero','2024-02-28','14:45:15',4),
(5,'¡La educación financiera no es un lujo, es una necesidad! Únete a nuestro curso para aprender a administrar tus recursos de manera eficiente','2024-03-20','16:20:10',5),(6,'¿Quieres tomar decisiones financieras más inteligentes? Nuestro curso de educación financiera te guiará en el camino hacia el éxito financiero','2024-04-05','18:05:55',6),
(7,'Aprende a construir un futuro financiero sólido con nuestro curso de educación financiera. ¡Regístrate ahora y toma el primer paso!','2024-05-12','20:40:40',7),(8,'No importa tu edad o tu situación financiera actual, la educación financiera es valiosa. Únete a nuestro curso y empieza a aprender','2024-05-12','22:25:25',8),
(9,'Nuestro curso de educación financiera te brindará las herramientas necesarias para administrar tu dinero con confianza. ¡Regístrate ya!','2024-07-25','02:10:20',9),(10,'¡La educación financiera te empodera! Únete a nuestro curso y prepárate para tomar decisiones financieras informadas','2024-07-25','04:55:05',10);

--Insertar 10 registros en la tabla banco--
INSERT INTO banco(banco_ID,nombre_banco)
VALUES
(1,'Banco de Comercio'),(2,'Banco de Crédito del Perú'),
(3,'Banco Interamericano de Finanzas'),(4,'Banco Pichincha'),
(5,'Banco Bilbao Vizcaya Argentaria'),(6,'Interbank'),
(7,'Scotiabank'),(8,'Banco de la Nación'),
(9,'Banco Falabella'),(10,'Banco Pichincha');

--Insertar 10 registros en la tabla servicio_administracion_financiera--
INSERT INTO servicio_administracion_financiera(servicio_administracion_financiera_ID,fecha_acceso,banco_banco_ID,usuario_usuario_ID)
VALUES
(1,'2023-03-25',1,2),(2,'2023-01-12',2,3),
(3,'2023-08-14',3,1),(4,'2023-06-29',4,8),
(5,'2023-04-05',5,10),(6,'2023-02-22',6,5),
(7,'2023-10-10',7,4),(8,'2023-09-28',8,6),
(9,'2023-07-10',9,9),(10,'2023-08-06',10,7);

--Insertar 10 registros en la tabla notificacion_administracion_financiera--
INSERT INTO notificacion_administracion_financiera(notificacion_administracion_financiera_ID,descripcion_notificacion_administracion_financiera,fecha_notificacion,hora_notificacion,servicio_administracion_financiera_servicio_administracion_financiera_ID)
VALUES
(1,'Te informamos que se ha realizado un depósito exitoso en tu cuenta','2023-10-15','08:34:52',1),(2,'Hemos procesado exitosamente un retiro de fondos en tu cuenta','2023-09-28','12:15:27',2),
(3,'Te informamos que se ha recibido una transferencia en tu cuenta','2023-08-10','15:42:18',3),(4,'Te informamos que el pago de tu factura ha sido exitoso','2023-07-21','19:28:06',4),
(5,'Hemos detectado una transacción inusual en tu cuenta que podría ser sospechosa','2023-06-03','21:59:33',5),(6,'Hemos procesado una transferencia desde tu cuenta','2023-05-17','04:07:14',6),
(7,'Te informamos que hemos recibido y procesado un recibo en tu cuenta','2023-04-29','11:23:45',7),(8,'Te informamos que se ha realizado el pago de tu préstamo','2023-03-12','14:56:29',8),
(9,'Hemos procesado con éxito una transferencia internacional en tu cuenta','2023-02-24','22:10:17',9),(10,'Si tienes alguna pregunta o necesitas más información sobre esta transacción','2023-01-06','05:48:50',10);

--Insertar 10 registros en la tabla cuenta_bancaria--
INSERT INTO cuenta_bancaria(cuenta_bancaria_ID,numero_tarjeta,contrasena_tarjeta,tipo_tarjeta,banco_banco_ID)
VALUES
(1,'4970100000000055',7531,'Credito',10),(2,'4970100000000113',4289,'Credito',2),
(3,'4970100000000063',6197,'Debito',9),(4,'4970100000000435',2350,'Credito',1),
(5,'4970110000001029',8742,'Debito',5),(6,'4970110000000054',3621,'Debito',3),
(7,'4970110000001003',5984,'Debito',7),(8,'4917480000000107',1473,'Credito',4),
(9,'4917480000000065',6905,'Credito',6),(10,'4917480000000008',3248,'Debito',8);

--Insertar 10 registros en la tabla transaccion--
INSERT INTO transaccion(transaccion_ID,numero_transaccion,monto_transaccion,fecha_transaccion,hora_transaccion,cuenta_bancaria_cuenta_bancaria_ID)
VALUES
(1,23568974,4321.98,'2023-03-15','09:15:30',1),(2,78453621,987.65,'2023-07-28','11:30:45',2),
(3,10247856,1567.89,'2023-01-10','02:45:20',3),(4,36987412,345.67,'2023-05-22','04:20:55',4),
(5,56321489,1876.54,'2023-09-09','08:10:10',5),(6,98765432,1234.67,'2023-02-14','01:55:25',6),
(7,14789632,1234.56,'2023-08-03','03:40:05',7),(8,32147896,1456.78,'2023-04-17','10:25:15',8),
(9,65432187,9876.43,'2023-06-25','12:05:50',9),(10,89562314,1789.01,'2023-10-30','05:50:40',10);

SELECT * FROM notificacion_servicio_curso;
SELECT * FROM autenticacion;
SELECT * FROM usuario;
SELECT * FROM servicio_curso;
SELECT * FROM tema_servicio_curso;
SELECT * FROM logro_servicio_curso;
SELECT * FROM comentario_servicio_curso;
SELECT * FROM banco;
SELECT * FROM servicio_administracion_financiera;
SELECT * FROM notificacion_administracion_financiera;
SELECT * FROM cuenta_bancaria;
SELECT * FROM transaccion;


Use TechNova
Go

--CREATE PROCEDURE find_popular_courses
--AS
--BEGIN
--  -- Devuelve los cursos con la mayor cantidad de alumnos completados
--SELECT sc.servicio_curso_ID, sc.titulo_curso,
--      COUNT(lc.logro_servicio_curso_ID) AS cantidad_completos
--    FROM servicio_curso sc
--    INNER JOIN logro_servicio_curso lc ON sc.servicio_curso_ID = lc.servicio_curso_ID
--    GROUP BY
--      sc.servicio_curso_ID, sc.titulo_curso
--    ORDER BY
--      cantidad_completos
--END;


CREATE PROCEDURE find_cursos_populares
AS
BEGIN

-- Obtener los cursos con más logros
	SELECT
		sc.servicio_curso_ID,
		sc.titulo_curso,
		sc.duracion_curso,
		COUNT(lc.cantidad_curso_completo) AS cantidad_logros
	FROM
		servicio_curso sc
	JOIN logro_servicio_curso lc ON sc.servicio_curso_ID = lc.servicio_curso_servicio_curso_ID
	GROUP BY
	sc.servicio_curso_ID,
	sc.titulo_curso,
	sc.duracion_curso
	ORDER BY cantidad_logros DESC
	--LIMIT 5
END;

exec find_cursos_populares;
