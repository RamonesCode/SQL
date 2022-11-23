--https://docs.microsoft.com/pt-br/sql/relational-databases/security/dynamic-data-masking?view=sql-server-ver15

--USE master
--DROP DATABASE DB_LGPD
CREATE DATABASE DB_LGPD;
GO

USE DB_LGPD

CREATE TABLE CLIENTE  
  (ID_CLIENTE int IDENTITY PRIMARY KEY,  
   Primeiro_nome varchar(100) MASKED WITH (FUNCTION = 'partial(1,"XXXXXXX",0)') NOT NULL,  
   Ultimo_nome varchar(100) NOT NULL,  
   telefone varchar(12) MASKED WITH (FUNCTION = 'default()') NULL,  
   Email varchar(100) MASKED WITH (FUNCTION = 'email()') NULL, 
   cartao_credito varchar(20) NOT NULL,  
   salario decimal(10,2)NOT NULL)  ;  
  
INSERT CLIENTE  VALUES   
('Andre', 'Rosa', '555.123.4567', 'andrer@teste.com','1111-2222-3333-4444',12000),  
('Pedro', 'Silva', '555.123.4568', 'pedros@teste.com','1234-4321-9632-7411',9000),  
('Mariana', 'Souza', '555.123.4569', 'marianas@teste.net','1234-4321-9632-7411',15000);  

--Dados teste
SELECT * FROM CLIENTE


--cria role PERSONALIZADAS PARA ACESSO 

  create role vendedores_com_acesso
  create role vendedores_sem_mask
  create role vendedores_sem_acesso
--cria users teste

  CREATE USER  joao  WITHOUT LOGIN; 
  CREATE USER  pedro WITHOUT LOGIN; 
  CREATE USER  paulo WITHOUT LOGIN;


  --adiciona users as respectivas roles
--ADICIONA USUARIO A ROLE vendedores_com_acesso
EXEC sp_addrolemember 'vendedores_com_acesso', 'joao';
EXEC sp_addrolemember 'vendedores_com_acesso', 'pedro';
--ADICIONA USUARIO A ROLE vendedores_SEM_MASK
EXEC sp_addrolemember 'vendedores_sem_mask', 'pedro';
--ADICIONA USUARIO A ROLE vendedores_SEM_acesso
EXEC sp_addrolemember 'vendedores_sem_acesso', 'paulo';


--Concede acesso a role de leitura

GRANT SELECT ON CLIENTE TO vendedores_com_acesso

--Concede acesso a role de leitura sem mascara

GRANT UNMASK TO vendedores_sem_mask; 

--Nega acesso a role

DENY SELECT ON CLIENTE TO vendedores_sem_acesso



--Teste de acesso joao

EXECUTE AS USER = 'joao';  
SELECT * FROM CLIENTE;  
REVERT;  


--teste de acesso Pedro

EXECUTE AS USER = 'pedro';  
SELECT * FROM CLIENTE; 
REVERT;  
--teste de acesso Paulo --Sem acesso, erro  esperado

EXECUTE AS USER = 'paulo';  
SELECT * FROM CLIENTE; 
REVERT;  

--Identificando os campos com mascara
SELECT c.name, tbl.name as table_name, c.is_masked, c.masking_function  
FROM sys.masked_columns AS c  
JOIN sys.tables AS tbl   
    ON c.[object_id] = tbl.[object_id]  
WHERE is_masked = 1;  

--ADICIONAR MASCARA NA TABELA EXISTENTE
--
--MASCARA  ULTIMO NOME
ALTER TABLE CLIENTE ALTER COLUMN ULTIMO_NOME ADD MASKED WITH (FUNCTION = 'partial(2,"XXXXXXX",0)')

--MASCARA TELEFONE
ALTER TABLE CLIENTE ALTER COLUMN TELEFONE ADD MASKED WITH (FUNCTION = 'partial(5,"XXXXXXX",0)')

--MASCARA CARTAO DE CREDITO
ALTER TABLE CLIENTE ALTER COLUMN CARTAO_CREDITO ADD MASKED WITH (FUNCTION = 'partial(0,"XXXX-XXXX-XXXX-",4)')

--MASCARA SALARIO
ALTER TABLE CLIENTE ALTER COLUMN SALARIO ADD MASKED WITH (FUNCTION = 'default()')


--Teste de acesso joao

EXECUTE AS USER = 'joao';  
SELECT * FROM CLIENTE;  
REVERT;  


--teste de acesso Pedro

EXECUTE AS USER = 'pedro';  
SELECT * FROM CLIENTE; 
REVERT;  
--teste de acesso Paulo --Sem acesso, erro  esperado

EXECUTE AS USER = 'paulo';  
SELECT * FROM CLIENTE; 
REVERT;  


--Remover users de role

EXEC sp_droprolemember 'vendedores_sem_mask', 'pedro';


--teste de acesso Pedro

EXECUTE AS USER = 'pedro';  
SELECT * FROM CLIENTE; 
REVERT;  