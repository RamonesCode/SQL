--Criando Function  – Table Value
--drop function F_Cidades

use curso

Create Function FN_Cidades (@UF VarChar(2))
Returns Table
As
 Return(
  Select a.nome_mun,a.populacao from senso a
  Where a.uf = @UF);
 
--Invocando funções 
Select * from dbo.FN_Cidades('SP')