--Criando função escalar TRIM
--drop function Trim
USE curso;
go
--drop FUNCTION FN_Trim;

CREATE FUNCTION FN_Trim(@ST VARCHAR(1000)) 
 returns VARCHAR(1000)   
  BEGIN       
	RETURN(Ltrim(Rtrim(@ST)))   
  END;




--Invocando função escalar TRIM
SELECT '>' + ('      Silva Telles       ')+'<'
union
SELECT '>' + dbo.FN_Trim('      Silva Telles       ')+'<'



--PARA ALTERAR FUNÇÃO
ALTER  FUNCTION FN_Trim(@ST VARCHAR(500)) 
 returns VARCHAR(500)   
  BEGIN       
	RETURN(Ltrim(Rtrim(@ST)))   
  END

--APAGAR FUNÇÃO
DROP FUNCTION FN_Tri;

