ALTER PROCEDURE dbo.ObtenerClientes(@ParametrosEntrada NVARCHAR(MAX) = NULL, @ParametrosSalida NVARCHAR(MAX) = NULL OUT)
AS BEGIN
    BEGIN TRY
        --------------------
        --- TESTING CODE ---
        --------------------
        -- DECLARE @ParametrosEntrada NVARCHAR(MAX) = '{}'

        SELECT 
            c.[IdCliente],
            c.[IdTipoDocumento],
            c.[Nombre],
            c.[PrimerApellido],
            c.[SegundoApellido],
            c.[Documento],
            c.[FechaAlta],
            c.[FechaBaja],
            c.[Activo]
        FROM dbo.Clientes c
        OUTER APPLY OPENJSON(@ParametrosEntrada)
        WITH (  idcliente       INT,
                nombre          VARCHAR(50),
                primerapellido  VARCHAR(50),
                segundoapellido VARCHAR(50),
                documento       VARCHAR(9),
                fechaalta       DATETIME,
                fechabaja       DATETIME,
                activo          BIT
            ) AS p
        WHERE (ISNULL(p.idcliente,0) = 0 OR (ISNULL(p.idcliente,0) <> 0 AND c.IdCliente = p.idcliente))
            AND (ISNULL(p.nombre,'') = '' OR (ISNULL(p.nombre,'') <> '' AND c.Nombre LIKE p.nombre + '%'))
            AND (ISNULL(p.fechaalta,'') = '' OR (ISNULL(p.fechaalta,'') <> '' AND CONVERT(DATE, p.fechaalta, 112) = CONVERT(DATE, c.FechaAlta, 112)))
    END TRY
    BEGIN CATCH
        -- TODO: mensaje de error controlado por jquery + tabla de errores SQL
    END CATCH
END