create database mba;
go

use mba

CREATE TABLE advisors (
    advisor_id INT PRIMARY KEY,
    advisor_name VARCHAR(100) NOT NULL
);

CREATE TABLE  students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    advisor_id INT,
    FOREIGN KEY (advisor_id) REFERENCES advisors(advisor_id)
);

INSERT INTO advisors (advisor_id, advisor_name) VALUES (1, 'Asesor1');
INSERT INTO advisors (advisor_id, advisor_name) VALUES (2, 'Asesor2');
INSERT INTO advisors (advisor_id, advisor_name) VALUES (3, 'Asesor3');

INSERT INTO students (student_id, student_name, advisor_id) VALUES (101, 'Estudiante1', 1);
INSERT INTO students (student_id, student_name, advisor_id) VALUES (102, 'Estudiante2', 1);
INSERT INTO students (student_id, student_name, advisor_id) VALUES (103, 'Estudiante3', 2);
INSERT INTO students (student_id, student_name, advisor_id) VALUES (104, 'Estudiante4', 2);
INSERT INTO students (student_id, student_name, advisor_id) VALUES (105, 'Estudiante5', 3);



--Crear un procedimiento almacenado o función que retorne 
--los nombres de los asesores con la mayor cantidad alumnos asignados
CREATE PROCEDURE GetTopAdvisorsWithMostStudents
AS
BEGIN
    SELECT a.advisor_name, COUNT(s.student_id) AS cantidad_alumnos
    FROM advisors a
    LEFT JOIN students s ON a.advisor_id = s.advisor_id
    GROUP BY a.advisor_id, a.advisor_name
    ORDER BY cantidad_alumnos DESC
END;

exec GetTopAdvisorsWithMostStudents;

CREATE TABLE master_programs (
    program_id INT PRIMARY KEY,
    program_name VARCHAR(100) NOT NULL,
    program_version VARCHAR(50) NOT NULL
);

--para la pregunta 2

CREATE TABLE students2 (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    program_id INT,
    FOREIGN KEY (program_id) REFERENCES master_programs(program_id)
);

INSERT INTO master_programs (program_id, program_name, program_version) VALUES (1, 'Maestría1', 'Versión1');
INSERT INTO master_programs (program_id, program_name, program_version) VALUES (2, 'Maestría2', 'Versión2');
INSERT INTO master_programs (program_id, program_name, program_version) VALUES (3, 'Maestría3', 'Versión3');

INSERT INTO students2(student_id, student_name, program_id) VALUES (101, 'Estudiante1', 1);
INSERT INTO students2 (student_id, student_name, program_id) VALUES (102, 'Estudiante2', 1);
INSERT INTO students2 (student_id, student_name, program_id) VALUES (103, 'Estudiante3', 2);
INSERT INTO students2 (student_id, student_name, program_id) VALUES (104, 'Estudiante4', 2);
INSERT INTO students2 (student_id, student_name, program_id) VALUES (105, 'Estudiante5', 3);

--Crear un procedimiento almacenado o función que retorne los nombres y versiones 
--de las maestrías con la mayor cantidad de alumnos

CREATE PROCEDURE GetTopMasterPrograms
AS
BEGIN
    SELECT mp.program_name, mp.program_version, COUNT(s.student_id) AS cantidad_alumnos
    FROM master_programs mp
    LEFT JOIN students s ON mp.program_id = s.program_id
    GROUP BY mp.program_id, mp.program_name, mp.program_version
    ORDER BY cantidad_alumnos DESC
END;

EXEC GetTopMasterPrograms;


--PARA LA´PREGUNTA 3
CREATE TABLE study_groups (
    group_id INT PRIMARY KEY,
    group_name VARCHAR(50) NOT NULL
);

INSERT INTO study_groups (group_id, group_name) VALUES (1, 'Group A');
INSERT INTO study_groups (group_id, group_name) VALUES (2, 'Group B');

CREATE TABLE study_group_members (
    student_id INT,
    group_id INT,
    PRIMARY KEY (student_id, group_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (group_id) REFERENCES study_groups(group_id)
);


--Crear un procedimiento almacenado o función que retorne los nombres completos de los estudiantes que no
--forman parte de ningún grupo de estudio.

CREATE PROCEDURE GetStudentsWithoutStudyGroup
AS
BEGIN
    SELECT s.student_id, s.student_name
    FROM students s
    LEFT JOIN study_group_members m ON s.student_id = m.student_id
    WHERE m.group_id IS NULL;
END;

exec GetStudentsWithoutStudyGroup;


--PARA EJERCICIO 4
-- Crear la tabla de cursos
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL
);

-- Crear la tabla de conferencias
CREATE TABLE lectures (
    lecture_id INT PRIMARY KEY,
    lecture_name VARCHAR(100) NOT NULL,
    course_id INT,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO courses (course_id, course_name) VALUES (1, 'Curso A');
INSERT INTO courses (course_id, course_name) VALUES (2, 'Curso B');

INSERT INTO lectures (lecture_id, lecture_name, course_id) VALUES (101, 'Conferencia 1', 1);
INSERT INTO lectures (lecture_id, lecture_name, course_id) VALUES (102, 'Conferencia 2', 1);
INSERT INTO lectures (lecture_id, lecture_name, course_id) VALUES (103, 'Conferencia 3', 2);
INSERT INTO lectures (lecture_id, lecture_name, course_id) VALUES (104, 'Conferencia 4', 2);
INSERT INTO lectures (lecture_id, lecture_name, course_id) VALUES (105, 'Conferencia 5', 2);

--Crear un procedimiento almacenado o función que retorne los nombres de los cursos con la mayor cantidad
--de conferencias.

CREATE FUNCTION GetCoursesWithMostConferences()
RETURNS TABLE(
    course_name VARCHAR(100)
	)
AS
BEGIN
    RETURN
    (
        SELECT c.course_name
        FROM courses c
        JOIN conferences co ON c.course_id = co.course_id
        GROUP BY c.course_id, c.course_name
        HAVING COUNT(co.conference_id) = (
            SELECT COUNT(conference_id)
            FROM conferences
            GROUP BY course_id
            ORDER BY COUNT(conference_id) DESC)
    );
END;

-- SI ALCANZA TIEMPO MOLDEAR
Create Function Ordenes_Cliente ()
returns table
return
	(SELECT C.ContactName, COUNT(O.OrderID) AS Cantidad
	FROM Customers C
	JOIN Orders O ON C.CustomerID = O.CustomerID
	WHERE O.ShipCountry = @pais  and year(O.OrderDate) = @anio 
	GROUP BY C.ContactName)

select * from dbo.Ordenes_Cliente ()

create procedure mayor_pedido_cliente (@pais varchar(20),@anio int )
as
 Begin
   select ContactName
    from dbo.Ordenes_Cliente(@pais, @anio)
	where cantidad = (select max (cantidad) 
	                   from dbo.Ordenes_Cliente(@pais, @anio))
 End

 Exec  mayor_pedido_cliente 'Spain', 1996







 --EJERCICIO 5
CREATE PROCEDURE sp_cantidad_actividades
(
  @id_curso INT
)
AS
BEGIN
  -- Obtener el curso
  DECLARE @curso TABLE (
    id INT,
    nombre VARCHAR(255)
  );
  INSERT INTO @curso
  SELECT id, nombre
  FROM cursos
  WHERE id = @id_curso;

  -- Obtener la cantidad de exámenes
  DECLARE @examenes INT;
  SELECT @examenes = COUNT(*)
  FROM examenes
  WHERE id_curso = @id_curso;

  -- Obtener la cantidad de ensayos
  DECLARE @ensayos INT;
  SELECT @ensayos = COUNT(*)
  FROM ensayos
  WHERE id_curso = @id_curso;

  -- Obtener la cantidad de presentaciones
  DECLARE @presentaciones INT;
  SELECT @presentaciones = COUNT(*)
  FROM presentaciones
  WHERE id_curso = @id_curso;

  -- Calcular la cantidad consolidada de actividades
  DECLARE @cantidad INT;
  SET @cantidad = @examenes + @ensayos + @presentaciones;

  -- Devolver la cantidad consolidada de actividades
  SELECT @cantidad;
END;
