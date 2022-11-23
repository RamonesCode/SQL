--Procedure para calcular IMC- Indice de massa do corpo
--drop procedure calc_imc
USE curso
GO
CREATE PROCEDURE calc_imc @PESO decimal(10,2),@ALTURA decimal(10,2)
AS
BEGIN
--DECLARA VARIVEL
DECLARE @IMC decimal(10,2);
--ATRIBUI VALOR
SET @IMC= @PESO/(@ALTURA*@ALTURA)
--BLOCO CONDICIONAL
	IF @IMC < 17
	Begin
		PRINT 'SEU IMC é '+cast(@IMC as varchar(20))+' Muito abaixo do peso'
	End
	ELSE IF @IMC >= 17 and @IMC <= 18.49
	Begin
		PRINT 'SEU IMC é '+cast(@IMC as varchar(20))+' Abaixo do peso'
	End

	ELSE IF @IMC >= 18.5 and @IMC <= 24.99
	Begin
		PRINT 'SEU IMC é '+cast(@IMC as varchar(20))+' Peso normal'
	end

	ELSE IF @IMC >= 25 and @IMC <= 29.99
	Begin
		PRINT 'SEU IMC é '+cast(@IMC as varchar(20))+' Acima do peso'
	End

	ELSE IF @IMC >= 30 and @IMC <= 34.99
	Begin
		PRINT 'SEU IMC é '+cast(@IMC as varchar(20))+' Obesidade I'
	End

	ELSE IF @IMC >= 35 and @IMC <= 39.99
	Begin
		PRINT 'SEU IMC é '+cast(@IMC as varchar(20))+' Obesidade II (severa)'
	End

	ELSE IF @IMC >= 40
		Begin
		PRINT 'SEU IMC é '+cast(@IMC as varchar(20))+' Obesidade III (mórbida)'
	END
END

--excutando procedure calc_imc
--informando peso e altura
exec calc_imc 70,1.70