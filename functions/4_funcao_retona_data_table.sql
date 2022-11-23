--funcao para receber duas data e retornar intervalo de acordo com parametro.
USE CURSO;
--FUNÇÃO DE TABELA
--VARIAVEL DIA INTERVALOS ENTRE OS DIAS
--DTI DATA INICIAL
--DTF DATA FINAL
--DROP FUNCTION func_dias
Create FUNCTION dbo.func_dias(@dia INT,@dti DATETIME,@dtf DATETIME) 
	returns @tbl TABLE(SEQ INT,DT DATETIME) 
	AS   
	BEGIN  
	  DECLARE @CONT INT;
	   SET @CONT=1;    
		WHILE @dti <= @dtf         
			BEGIN             
				INSERT INTO @tbl  (SEQ,dt) VALUES (@CONT,@dti)             
				SET @dti = Dateadd(day, @dia, @dti) 
				SET @CONT=@CONT+1        
			End
			Return
	end;

--invocando funcao dias
	SELECT * FROM   dbo.func_dias(3,getdate(),getdate()+12) 
