Use TechNova
Go

--(Basic) Mostrar los cursos más populares de nuestro sistema
CREATE PROCEDURE cursos_populares
AS
BEGIN
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

exec cursos_populares;



--(intermedia) Mostrar historial de pagos 
--CREATE FUNCTION historial_transacciones_por_usuario(@usuario_id INT)
--RETURNS TABLE (
--    transaccion_ID INT,
--    numero_transaccion INT,
--    monto_transaccion MONEY,
--    fecha_transaccion DATE,
--    hora_transaccion TIME,
--    curso_correspondiente VARCHAR(250)
--)
--AS
--BEGIN
--    RETURN (
--        SELECT
--            T.transaccion_ID,
--            T.numero_transaccion,
--            T.monto_transaccion,
--            T.fecha_transaccion,
--            T.hora_transaccion,
--            SC.titulo_curso AS curso_correspondiente
--        FROM
--            transaccion T
--            INNER JOIN cuenta_bancaria CB ON T.cuenta_bancaria_cuenta_bancaria_ID = CB.cuenta_bancaria_ID
--            INNER JOIN servicio_administracion_financiera SAF ON CB.banco_banco_ID = SAF.banco_banco_ID
--            INNER JOIN usuario U ON SAF.usuario_usuario_ID = U.usuario_ID
--            LEFT JOIN servicio_curso SC ON U.usuario_ID = SC.usuario_usuario_ID
--        WHERE
--            U.usuario_ID = @usuario_ID
--    );
--END;
CREATE FUNCTION historial_transacciones_por_usuario(@usuario_id INT)
RETURNS @Tabla TABLE (
    transaccion_ID INT,
    numero_transaccion INT,
    monto_transaccion MONEY,
    fecha_transaccion DATE,
    hora_transaccion TIME,
    curso_correspondiente VARCHAR(250)
)
AS
BEGIN
	INSERT INTO @Tabla
        SELECT
            T.transaccion_ID,
            T.numero_transaccion,
            T.monto_transaccion,
            T.fecha_transaccion,
            T.hora_transaccion,
            SC.titulo_curso AS curso_correspondiente
        FROM
            transaccion T
            INNER JOIN cuenta_bancaria CB ON T.cuenta_bancaria_cuenta_bancaria_ID = CB.cuenta_bancaria_ID
            INNER JOIN servicio_administracion_financiera SAF ON CB.banco_banco_ID = SAF.banco_banco_ID
            INNER JOIN usuario U ON SAF.usuario_usuario_ID = U.usuario_ID
            LEFT JOIN servicio_curso SC ON U.usuario_ID = SC.usuario_usuario_ID
        WHERE
            U.usuario_ID = @usuario_ID
			return
END;

SELECT * FROM historial_transacciones_por_usuario(3);



--intermedio mostrar primero los comentarios de usuarios en el orden de que hayan llevado más cursos a menos
-- CREATE FUNCTION obtener_comentarios_ordenados_por_cursos()
--RETURNS TABLE (
--    comentario_servicio_curso_ID INT,
--    contenido_comentario_servicio_curso VARCHAR(250)
--)
--AS 
--BEGIN
--    RETURN (
--        SELECT c.comentario_servicio_curso_ID, 
--		c.contenido_comentario_servicio_curso
--        FROM comentario_servicio_curso c
--        JOIN comentario_por_servicio_curso cp 
--		ON c.comentario_servicio_curso_ID = cp.comentario_servicio_curso_comentario_servicio_curso_ID
--        JOIN servicio_curso sc 
--		ON cp.servicio_curso_servicio_curso_ID = sc.servicio_curso_ID
--        JOIN usuario u ON sc.usuario_usuario_ID = u.usuario_ID
--        GROUP BY 
--		c.comentario_servicio_curso_ID,
--		c.contenido_comentario_servicio_curso
--        ORDER BY COUNT(sc.servicio_curso_ID) DESC
--    );
--END;

CREATE FUNCTION obtener_comentarios_ordenados_por_cursos()
RETURNS @tabla TABLE (
    comentario_servicio_curso_ID INT,
    contenido_comentario_servicio_curso VARCHAR(250)
)
AS
BEGIN
INSERT INTO @tabla
        SELECT c.comentario_servicio_curso_ID, 
		c.contenido_comentario_servicio_curso
        FROM comentario_servicio_curso c
        JOIN comentario_por_servicio_curso cp 
		ON c.comentario_servicio_curso_ID = cp.comentario_servicio_curso_comentario_servicio_curso_ID
        JOIN servicio_curso sc 
		ON cp.servicio_curso_servicio_curso_ID = sc.servicio_curso_ID
        JOIN usuario u ON sc.usuario_usuario_ID = u.usuario_ID
        GROUP BY 
		c.comentario_servicio_curso_ID,
		c.contenido_comentario_servicio_curso
        ORDER BY COUNT(sc.servicio_curso_ID) DESC
		return

END;

SELECT * FROM obtener_comentarios_ordenados_por_cursos();


--mostrar notificaciones para el usuario de acuerdo al tiempo
--CREATE PROCEDURE MostrarNotificaciones(@usuarioID INT)
--RETURN @tabla TABLE (
--	usuario_id int,
--	descripcion_notificacion_servicio_curso varchar(250),
--	fecha_notificacion date,
--	hora_notificacion time,
--)
--AS
--BEGIN
--    DECLARE @FechaActual DATE = GETDATE();
--    DECLARE @HoraActual TIME = GETDATE();

--    -- Notificaciones para los cursos
--    SELECT descripcion_notificacion_servicio_curso, fecha_notificacion, hora_notificacion
--    FROM notificacion_servicio_curso
--    WHERE servicio_curso_servicio_curso_ID IN (
--        SELECT servicio_curso_ID
--        FROM servicio_curso
--        WHERE usuario_usuario_ID = @usuarioID
--    )
--    AND fecha_notificacion = @FechaActual
--    AND hora_notificacion > @HoraActual;

--    -- Notificaciones para administración financiera
--    SELECT descripcion_notificacion_administracion_financiera, fecha_notificacion, hora_notificacion
--    FROM notificacion_administracion_financiera
--    WHERE servicio_administracion_financiera_servicio_administracion_financiera_ID IN (
--        SELECT servicio_administracion_financiera_ID
--        FROM servicio_administracion_financiera
--        WHERE usuario_usuario_ID = @usuarioID
--    )
--    AND fecha_notificacion = @FechaActual
--    AND hora_notificacion > @HoraActual;
--END;

--exec MostrarNotificaciones(1);
CREATE FUNCTION dbo.Mostricaciones(@usuarioID INT)
RETURNS TABLE
AS
RETURN (
    SELECT ns.descripcion_notificacion_servicio_curso, ns.fecha_notificacion, ns.hora_notificacion
    FROM notificacion_servicio_curso ns
    INNER JOIN servicio_curso sc ON ns.servicio_curso_servicio_curso_ID = sc.servicio_curso_ID
    INNER JOIN usuario u ON sc.usuario_usuario_ID = u.usuario_ID
    WHERE u.usuario_ID = @usuarioID
    AND ns.fecha_notificacion = CONVERT(DATE, GETDATE())
    AND ns.hora_notificacion > CONVERT(TIME, GETDATE())

    UNION ALL

    SELECT naf.descripcion_notificacion_administracion_financiera, naf.fecha_notificacion, naf.hora_notificacion
    FROM notificacion_administracion_financiera naf
    INNER JOIN servicio_administracion_financiera saf 
	ON naf.servicio_administracion_financiera_servicio_administracion_financiera_ID = saf.servicio_administracion_financiera_ID
    INNER JOIN usuario u ON saf.usuario_usuario_ID = u.usuario_ID
    WHERE u.usuario_ID = @usuarioID
    AND naf.fecha_notificacion = CONVERT(DATE, GETDATE())
    AND naf.hora_notificacion > CONVERT(TIME, GETDATE())
);
