--Retornar texto externo através de parâmetro
--drop PROC_RET_MSG
USE CURSO
GO
Create PROCEDURE PROC_RET_MSG (@meutexto varchar(100))
AS
BEGIN
	SELECT 'TEXTO INFORMADO>>: '+@meutexto
END

--Executando Procedure
EXEC PROC_RET_MSG 'DEU CERTO'
