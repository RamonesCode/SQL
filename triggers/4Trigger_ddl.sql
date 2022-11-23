--create trigger de restrição DDL
--drop trigger trig_controla_ddl on database
--drop trigger trig_controla_ddl on ALL SERVER
--disable trigger trig_controla_ddl on database
--enable trigger trig_controla_ddl on database

--disable trigger trig_controla_ddl_db on database
--drop TRIGGER trig_controla_ddl_db on database
use curso
GO
create TRIGGER trig_controla_ddl_db 
ON DATABASE
FOR create_procedure, alter_procedure, drop_procedure,CREATE_TABLE,DROP_TABLE, ALTER_TABLE
AS 
    IF Datepart(hh, Getdate()) <= 8 
        OR Datepart(hh, Getdate()) >= 18 
      BEGIN 
          DECLARE @msg VARCHAR(200) 
          SELECT @msg = 'Complete o trabalho em horario comercial' 
          PRINT ( @msg ) 
          ROLLBACK 
      END 

--disable trigger trig_controla_ddl_SRV on ALL SERVER
--drop TRIGGER trig_controla_ddl_SRV on ALL SERVER
create TRIGGER trig_controla_ddl_SRV 
ON ALL SERVER
FOR create_procedure, alter_procedure, drop_procedure,CREATE_TABLE,DROP_TABLE, ALTER_TABLE
AS 
    IF Datepart(hh, Getdate()) <= 8 
        OR Datepart(hh, Getdate()) >= 18 
      BEGIN 
          DECLARE @msg VARCHAR(200) 
          SELECT @msg = 'Complete o trabalho em horario comercial' 
          PRINT ( @msg ) 
          ROLLBACK 
      END 
--teste procudere criacao
--drop PROCEDURE Proc_teste_dml
	 CREATE PROCEDURE Proc_teste_dml
		AS 
		BEGIN 
			PRINT 'Teste de criacao' 
		END 
	  
	  execute proc_teste_dml;

--teste create tabela
    drop table teste_tg
	create table teste_tg
	(
	 numero int
	 );
	

