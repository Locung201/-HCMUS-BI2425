CREATE DATABASE METADATA
GO

USE METADATA
GO 

/*
GO
USE MASTER
DROP DATABASE METADATA
GO

-- DROP TABLE
DROP TABLE Data_Flow
*/

CREATE TABLE Data_Flow(
	ID INT NOT NULL IDENTITY(1,1),
	TableName VARCHAR(20) NOT NULL,
	LSET DATETIME,
	CET DATETIME,
	CONSTRAINT PK_Data_Flow PRIMARY KEY CLUSTERED (ID)
)
go

SELECT * FROM Data_Flow
/*CREATE TRIGGER insert_dataflow on DATA_FLOW AFTER INSERT AS
BEGIN
	UPDATE DATA_FLOW
	SET LSET = GETDATE(), CET = GETDATE()
	WHERE ID IN (SELECT DISTINCT ID FROM INSERTED)
END
go*/

-- stage
INSERT Data_Flow (TableName, LSET, CET) VALUES ('Counties', GETDATE(), GETDATE())
INSERT Data_Flow (TableName, LSET, CET) VALUES ('Air_Quality', GETDATE(), GETDATE())



SELECT * FROM Data_Flow
go