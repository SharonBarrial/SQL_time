--1(Intermedio) Determinar el nivel de actividad de cada usuario en términos de comentarios realizados y cursos tomados, 
--categorizando a los usuarios en "Activo", "Moderadamente Activo" y "Poco Activo" basado en el número total 
--de comentarios y cursos completados.

SELECT 
    u.usuario_ID, 
    u.nombre, 
    u.apellido,
    (SELECT COUNT(*) FROM comentario_servicio_curso csc 
     JOIN comentario_por_servicio_curso cpsc ON csc.comentario_servicio_curso_ID = cpsc.comentario_servicio_curso_comentario_servicio_curso_ID 
     WHERE cpsc.servicio_curso_servicio_curso_ID IN 
         (SELECT servicio_curso_ID FROM servicio_curso WHERE usuario_usuario_ID = u.usuario_ID)) AS Total_Comentarios,
    (SELECT COUNT(*) FROM logro_servicio_curso lsc 
     WHERE lsc.servicio_curso_servicio_curso_ID IN 
         (SELECT servicio_curso_ID FROM servicio_curso WHERE usuario_usuario_ID = u.usuario_ID)) AS Cursos_Completados,
    CASE 
        WHEN (SELECT COUNT(*) FROM comentario_servicio_curso csc 
              JOIN comentario_por_servicio_curso cpsc ON csc.comentario_servicio_curso_ID = cpsc.comentario_servicio_curso_comentario_servicio_curso_ID 
              WHERE cpsc.servicio_curso_servicio_curso_ID IN 
                  (SELECT servicio_curso_ID FROM servicio_curso WHERE usuario_usuario_ID = u.usuario_ID)) 
             +
             (SELECT COUNT(*) FROM logro_servicio_curso lsc 
              WHERE lsc.servicio_curso_servicio_curso_ID IN 
                  (SELECT servicio_curso_ID FROM servicio_curso WHERE usuario_usuario_ID = u.usuario_ID)) > 10 THEN 'Activo'
        WHEN (SELECT COUNT(*) FROM comentario_servicio_curso csc 
              JOIN comentario_por_servicio_curso cpsc ON csc.comentario_servicio_curso_ID = cpsc.comentario_servicio_curso_comentario_servicio_curso_ID 
              WHERE cpsc.servicio_curso_servicio_curso_ID IN 
                  (SELECT servicio_curso_ID FROM servicio_curso WHERE usuario_usuario_ID = u.usuario_ID)) 
             +
             (SELECT COUNT(*) FROM logro_servicio_curso lsc 
              WHERE lsc.servicio_curso_servicio_curso_ID IN 
                  (SELECT servicio_curso_ID FROM servicio_curso WHERE usuario_usuario_ID = u.usuario_ID)) BETWEEN 5 AND 10 THEN 'Moderadamente Activo'
        ELSE 'Poco Activo'
    END AS Nivel_Actividad
FROM 
    usuario u;

--2(Intermedio) Obtener un informe detallado para un usuario específico, mostrando la cantidad de cursos tomados, 
--   el total de comentarios hechos, y un resumen de su actividad financiera.
go
CREATE PROCEDURE DetalleUsuario(@UsuarioID int)
AS
BEGIN
    SELECT 
        u.usuario_ID, 
        u.nombre, 
        u.apellido,
        CursosTomados,
        TotalComentarios,
        ActividadFinanciera.Rango_Actividad_Financiera,
        ActividadFinanciera.Total_Transacciones,
        ActividadFinanciera.Total_Monto
    FROM 
        usuario u
        CROSS APPLY (SELECT COUNT(*) AS CursosTomados 
                     FROM servicio_curso 
                     WHERE usuario_usuario_ID = u.usuario_ID) CursoData
        CROSS APPLY (SELECT COUNT(*) AS TotalComentarios 
                     FROM comentario_por_servicio_curso cpsc
                     JOIN comentario_servicio_curso csc ON cpsc.comentario_servicio_curso_comentario_servicio_curso_ID = csc.comentario_servicio_curso_ID
                     WHERE cpsc.servicio_curso_servicio_curso_ID IN (SELECT servicio_curso_ID FROM servicio_curso WHERE usuario_usuario_ID = u.usuario_ID)) ComentarioData
        CROSS APPLY (SELECT 
                         RANK() OVER (ORDER BY SUM(t.monto_transaccion) DESC) AS Rango_Actividad_Financiera,
                         COUNT(t.transaccion_ID) AS Total_Transacciones,
                         SUM(t.monto_transaccion) AS Total_Monto
                     FROM 
                         servicio_administracion_financiera saf
                         JOIN cuenta_bancaria cb ON saf.banco_banco_ID = cb.banco_banco_ID
                         JOIN transaccion t ON cb.cuenta_bancaria_ID = t.cuenta_bancaria_cuenta_bancaria_ID
                     WHERE saf.usuario_usuario_ID = u.usuario_ID
                     GROUP BY saf.usuario_usuario_ID) ActividadFinanciera
    WHERE 
        u.usuario_ID = @UsuarioID;
END;

EXEC DetalleUsuario @UsuarioID = 1; -- Reemplazar '1' con el ID de usuario deseado

--3 (Básico) Determinar la relación entre la participación de los usuarios en los cursos y su actividad financiera, 
--para identificar patrones de gasto y aprendizaje que podrían informar estrategias de marketing y desarrollo de cursos.

SELECT 
    u.usuario_ID,
    u.nombre,
    u.apellido,
    COUNT(DISTINCT sc.servicio_curso_ID) AS Cantidad_Cursos_Tomados,
    AVG(DATEDIFF(MINUTE, '00:00:00', sc.duracion_curso)) AS Duracion_Promedio_Cursos_En_Minutos,
    SUM(t.monto_transaccion) AS Gasto_Total,
    AVG(t.monto_transaccion) AS Gasto_Promedio_Transaccion
FROM 
    usuario u
    LEFT JOIN servicio_curso sc ON u.usuario_ID = sc.usuario_usuario_ID
    LEFT JOIN servicio_administracion_financiera saf ON u.usuario_ID = saf.usuario_usuario_ID
    LEFT JOIN cuenta_bancaria cb ON saf.banco_banco_ID = cb.banco_banco_ID
    LEFT JOIN transaccion t ON cb.cuenta_bancaria_ID = t.cuenta_bancaria_cuenta_bancaria_ID
GROUP BY 
    u.usuario_ID, u.nombre, u.apellido;


