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
cod_usuarios int FOREIGN KEY REFERENCES usuarios(usuariosID) default,
cod_curso int FOREIGN KEY REFERENCES cursos(cursosID) default,
)
------------
--Esquema
--He considerado para mi esquema cod_usuarios y cod_cursos como foreign key. Y mis primary key not null usuariosid, cursosid y reatrolimentacionesid.
-----------
