--Retornar Boas Vindas para usuários logados
--drop PROCEDURE proc_msg_boas_vindas
USE curso
GO
CREATE PROCEDURE proc_msg_boas_vindas
AS
BEGIN
	--msg
	PRINT 'Seja Bem-vindo'+' '+ SYSTEM_USER
	--condicional
	IF (datepart(hour,getdate())>8 and datepart(hour,getdate())<12) 
		PRINT 'Bom dia!!!'
	ELSE IF (datepart(hour,getdate())>=12 and datepart(hour,getdate())<=18)
		PRINT 'Boa tarde!!'
	ELSE 
		PRINT 'Boa Noite!!'
	
END


--Executando Procedure
EXEC proc_msg_boas_vindas

