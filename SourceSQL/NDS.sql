USE [master]
GO
--drop database [NDS_AIR]
go

CREATE DATABASE [NDS_AIR]
 GO
USE [NDS_AIR]
GO
/*-- DROP TABLE
GO
USE MASTER
DROP TABLE NDS_AirData
DROP TABLE NDS_Counties
DROP TABLE NDS_States
*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE NDS_States (
    StateSK INT IDENTITY(1,1) PRIMARY KEY, -- Surrogate Key
	StateID NVARCHAR(50), --State ID (Natural Key)
    StateCode INT, 
    StateName NVARCHAR(50),       -- Tên của bang
	Created DATETIME DEFAULT GETDATE(),      -- Mặc định là thời gian hiện tại
    LastUpdated DATETIME DEFAULT GETDATE(),  -- Cập nhật khi chỉnh sửa
);

CREATE TABLE NDS_Counties (
    CountySK INT IDENTITY(1,1) PRIMARY KEY, -- Surrogate Key với IDENTITY
    CountyCode INT, 
    CountyName NVARCHAR(50) NOT NULL,      -- Tên quận 
    CountyASCII NVARCHAR(50),              -- Tên quận ASCII 
    CountyFull NVARCHAR(50),               -- Tên đầy đủ của quận
	CountyFips INT,				-- Natural Key
    Latitude FLOAT,                         --  Vĩ độ
    Longitude FLOAT,                        -- Kinh độ
    Population INT,                         -- Dân số
	Created DATETIME DEFAULT GETDATE(),      -- Mặc định là thời gian hiện tại
    LastUpdated DATETIME DEFAULT GETDATE(),
	StateSK INT NOT NULL,                   -- Liên kết với States
    FOREIGN KEY (StateSK) REFERENCES NDS_States (StateSK)
);


CREATE TABLE NDS_AirData (
    AirDataSK INT IDENTITY(1,1) PRIMARY KEY, -- Surrogate Key với IDENTITY
    Date DATE NOT NULL,                      -- Natural Key
    AQI INT NOT NULL,
    Category NVARCHAR(50) NOT NULL,
    DefiningParameter NVARCHAR(50),
    DefiningSite NVARCHAR(50),
    NumberOfSitesReporting INT,
    Created DATETIME DEFAULT GETDATE(),      -- Mặc định là thời gian hiện tại
    LastUpdated DATETIME DEFAULT GETDATE(),  -- Cập nhật khi chỉnh sửa
    FOREIGN KEY (CountySK) REFERENCES NDS_Counties(CountySK),
	CountySK INT NOT NULL,                   -- Liên kết với Counties
	FOREIGN KEY (StateSK) REFERENCES NDS_States(StateSK),
	StateSK INT NOT NULL,                   -- Liên kết với NDS_States
	SourceID INT NOT NULL,
	UNIQUE (CountySK, Date, SourceID, StateSK) -- Khóa tự nhiên để tránh trùng lặp
);
/*
TRUNCATE TABLE NDS_AirData
TRUNCATE TABLE NDS_Counties
TRUNCATE TABLE NDS_States
*/

SELECT * FROM NDS_States
SELECT * FROM NDS_Counties
SELECT * FROM NDS_AirData

SELECT StateSK, StateID
FROM NDS_States
WHERE SourceID = 2

SELECT DISTINCT StateSK, StateID
FROM NDS_States