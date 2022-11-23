USE [inwave]
GO
SET
    ANSI_NULLS ON
GO
SET
    QUOTED_IDENTIFIER ON
GO
-- =============================================        
-- Author:  Ramon Guilherme         
-- Create date: 17/08/2022        
-- Description: Receive a user id and return the table of number of queries and how much is left to query        
-- =============================================        
    CREATE FUNCTION [dbo].[fnConsultApiByUser] (@idUser INT) RETURNS @T TABLE (
        nuConsult INT,
        nuLimitConsul INT,
        dsRemaining VARCHAR(100)
    ) BEGIN DECLARE @totalUseConsult INT DECLARE @remainingConsult INT DECLARE @remainingConsultResult VARCHAR(100) DECLARE @idCompanyGroup INT
SELECT
    TOP 1 @idCompanyGroup = idCompanyGroup
FROM
    dbo.fnStoreCompanyGroupByUser(@idUser)
SET
    @totalUseConsult = (
        SELECT
            sum(fcaul.nuItemsConsulted)
        FROM
            factCompanyApiUsageLimit fcaul
            left join dimCompanyGroup dcg on fcaul.idCompanyGroup = dcg.idCompanyGroup
        WHERE
            fcaul.idCompanyGroup = @idCompanyGroup
            AND fcaul.dtCreatedAt < DATEADD(HOUR, -24, GETUTCDATE())
        GROUP BY
            fcaul.nuItemsConsulted
    )
SET
    @remainingConsult = (
        SELECT
            sum(fcaul.nuItemsConsulted) - dcg.nuApiLimit as remaing
        FROM
            factCompanyApiUsageLimit fcaul
            left join dimCompanyGroup dcg on fcaul.idCompanyGroup = dcg.idCompanyGroup
        WHERE
            fcaul.idUserCompany = @idUser
        group by
            dcg.nuApiLimit
    ) IF @remainingConsult < 0
SET
    @remainingConsultResult = ('Limite de consultas excedido.')
    ELSE
SET
    @remainingConsultResult = ('Restam' + @remainingConsult)
INSERT INTO
    @T
SELECT
    'nuConsult' = @totalUseConsult,
    'nuLimitConsul' = dcg.nuApiLimit,
    'dsRemaining' = @remainingConsultResult
FROM
    factCompanyApiUsageLimit fcaul
    LEFT JOIN dimCompanyGroup dcg ON dcg.idCompanyGroup = fcaul.idCompanyGroup RETURN
END