create database [DDS_AIR]
go
USE [DDS_AIR]
GO

/*-- DROP TABLE
GO
USE MASTER
DROP TABLE [dbo].[FACT_AirQuality]
DROP TABLE [dbo].[DIM_Date]
DROP TABLE [dbo].[DIM_Counties]
DROP TABLE [dbo].[DIM_States]
*/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DIM_States](
	[StateSK] [int] NOT NULL,
	[StateCode] [int] NOT NULL,
	[StateName] [nvarchar](50) NULL,
	[Created] [date] NULL,
	[LastUpdated] [date] NULL,
 CONSTRAINT [PK_DIM_States] PRIMARY KEY CLUSTERED 
(
	[StateSK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DIM_Counties](
	[CountySK] [int] NOT NULL,
	[CountyName] [varchar](50) NULL,
	[CountyASCII] [varchar](50) NULL,
	[CountyFull] [varchar](50) NULL,
	[CountyFips] [int] NULL,
	[Population] [int] NULL,
	[Created] [date] NULL,
	[LastUpdated] [date] NULL,
	[StateSK] [int] NOT NULL,
 CONSTRAINT [PK_DIM_Counties] PRIMARY KEY CLUSTERED 
(
	[CountySK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DIM_Counties] WITH CHECK ADD  CONSTRAINT [FK_DIM_Counties_DIM_States] FOREIGN KEY([StateSK])
REFERENCES [dbo].[DIM_States] ([StateSK])

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DIM_Date](
	[DateSK] [int] NOT NULL,
	[Day] [int] NULL,
	[Month] [int] NULL,
	[Quarter] [int] NULL,
	[Year] [int] NULL,
	[Date] [date] NULL,
 CONSTRAINT [PK_DIM_NGAYTHANG] PRIMARY KEY CLUSTERED 
(
	[DateSK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACT_AirQuality](
	[AirDataSK] [int] NOT NULL,
	[DateSK] [int] NOT NULL,
	[StateSK] [int] NOT NULL,
	[CountySK] [int] NOT NULL,
	[AQI] [int] NULL,
	[Category] [varchar](50) NULL,
	[DefiningParameter] [varchar](50) NULL,
	[DefiningSite] [varchar](50) NULL,
	[NumberOfSitesReporting] [int] NULL,
	[Created] [date] NULL,
	[LastUpdated] [date] NULL,
 CONSTRAINT [PK_FACT_AirQuality] PRIMARY KEY CLUSTERED 
(
	[AirDataSK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[FACT_AirQuality]  WITH CHECK ADD  CONSTRAINT [FK_FACT_AirQuality_DIM_Date] FOREIGN KEY([DateSK])
REFERENCES [dbo].[DIM_Date] ([DateSK])
GO

ALTER TABLE [dbo].[FACT_AirQuality]  WITH CHECK ADD  CONSTRAINT [FK_FACT_AirQuality_DIM_States] FOREIGN KEY([StateSK])
REFERENCES [dbo].[DIM_States] ([StateSK])
GO

ALTER TABLE [dbo].[FACT_AirQuality]  WITH CHECK ADD  CONSTRAINT [FK_FACT_AirQuality_DIM_Counties] FOREIGN KEY([CountySK])
REFERENCES [dbo].[DIM_Counties] ([CountySK])
GO