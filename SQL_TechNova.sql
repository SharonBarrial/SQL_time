Create Database TechNova;

Use TechNova;
Go

--Tablas--

--Tabla: autenticacion--
Create Table autenticacion(
	autenticacion_ID int NOT NULL PRIMARY KEY,
	correo_electronico varchar(250) NOT NULL,
	contrasena varchar(250) NOT NULL,
);

--Tabla: usuario--
Create Table usuario(
	usuario_ID int NOT NULL PRIMARY KEY,
	nombre varchar(250) NOT NULL,
	apellido varchar(250) NOT NULL,
	genero varchar(250) NOT NULL,
	numero_telefono int NOT NULL,
	autenticacion_autenticacion_ID int FOREIGN KEY REFERENCES autenticacion(autenticacion_ID),
);

--Tabla: servicio_curso--
Create Table servicio_curso(
	servicio_curso_ID int NOT NULL PRIMARY KEY,
	titulo_curso varchar(250) NOT NULL,
	duracion_curso time NOT NULL,
	descripcion_curso varchar(250) NOT NULL,
	usuario_usuario_ID int FOREIGN KEY REFERENCES usuario(usuario_ID),
);

--Tabla: tema_servicio_curso--
Create Table tema_servicio_curso(
	tema_servicio_curso_ID int NOT NULL PRIMARY KEY,
	titulo_tema varchar(250) NOT NULL,
	descripcion_tema varchar(250) NOT NULL,
	servicio_curso_servicio_curso_ID int FOREIGN KEY REFERENCES servicio_curso(servicio_curso_ID),
);

--Tabla: logro_servicio_curso--
Create Table logro_servicio_curso(
	logro_servicio_curso_ID int NOT NULL PRIMARY KEY,
	cantidad_curso_completo int NOT NULL,
	fecha_finalizacion_curso date NOT NULL,
	servicio_curso_servicio_curso_ID int FOREIGN KEY REFERENCES servicio_curso(servicio_curso_ID),
);

--Tabla: comentario_servicio_curso--
Create Table comentario_servicio_curso(
	comentario_servicio_curso_ID int NOT NULL PRIMARY KEY,
	contenido_comentario_servicio_curso varchar(250) NOT NULL,
);

--Tabla: comentario_por_servicio_curso--
Create Table comentario_por_servicio_curso(
	fecha_publicacion_comentario date NOT NULL,
	servicio_curso_servicio_curso_ID int FOREIGN KEY REFERENCES servicio_curso(servicio_curso_ID),
	comentario_servicio_curso_comentario_servicio_curso_ID int FOREIGN KEY REFERENCES comentario_servicio_curso(comentario_servicio_curso_ID),
);

--Tabla: notificacion_servicio_curso--
Create Table notificacion_servicio_curso(
	notificacion_servicio_curso_ID int NOT NULL PRIMARY KEY,
	descripcion_notificacion_servicio_curso varchar(250) NOT NULL,
	fecha_notificacion date NOT NULL,
	hora_notificacion time NOT NULL,
	servicio_curso_servicio_curso_ID int FOREIGN KEY REFERENCES servicio_curso(servicio_curso_ID),
);

--Tabla: banco--
Create Table banco(
	banco_ID int NOT NULL PRIMARY KEY,
	nombre_banco varchar(250) NOT NULL,
);

--Tabla: servicio_administracion_financiera--
Create Table servicio_administracion_financiera(
	servicio_administracion_financiera_ID int NOT NULL PRIMARY KEY,
	fecha_acceso date NOT NULL,
	usuario_usuario_ID int FOREIGN KEY REFERENCES usuario(usuario_ID),
	banco_banco_ID int FOREIGN KEY REFERENCES banco(banco_ID),
);

--Tabla: notificacion_administracion_financiera--
Create Table notificacion_administracion_financiera(
	notificacion_administracion_financiera_ID int NOT NULL PRIMARY KEY,
	descripcion_notificacion_administracion_financiera varchar(250) NOT NULL,
	fecha_notificacion date NOT NULL,
	hora_notificacion time NOT NULL,
	servicio_administracion_financiera_servicio_administracion_financiera_ID int FOREIGN KEY REFERENCES servicio_administracion_financiera(servicio_administracion_financiera_ID),
);

--Tabla: cuenta_bancaria--
Create Table cuenta_bancaria(
	cuenta_bancaria_ID int NOT NULL PRIMARY KEY,
	numero_tarjeta varchar(250) NOT NULL,
	contrasena_tarjeta int NOT NULL,
	tipo_tarjeta varchar(250) NOT NULL,
	banco_banco_ID int FOREIGN KEY REFERENCES banco(banco_ID),
);

--Tabla: transaccion--
Create Table transaccion(
	transaccion_ID int NOT NULL PRIMARY KEY,
	numero_transaccion int NOT NULL,
	monto_transaccion money NOT NULL,
	fecha_transaccion date NOT NULL,
	hora_transaccion time NOT NULL,
	cuenta_bancaria_cuenta_bancaria_ID int FOREIGN KEY REFERENCES cuenta_bancaria(cuenta_bancaria_ID),
);

//