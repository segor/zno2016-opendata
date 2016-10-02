USE [master]
GO
/****** Object:  Database [zno2016]    Script Date: 10/3/2016 12:23:53 AM ******/
CREATE DATABASE [zno2016]
GO
ALTER DATABASE [zno2016]
MODIFY FILE
( NAME = N'zno2016', SIZE = 2200MB, FILEGROWTH =  10% )
GO
ALTER DATABASE [zno2016]
MODIFY FILE
( NAME = N'zno2016_log', SIZE = 1200MB, FILEGROWTH =  10% )
GO
ALTER DATABASE [zno2016] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [zno2016].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [zno2016] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [zno2016] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [zno2016] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [zno2016] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [zno2016] SET ARITHABORT OFF 
GO
ALTER DATABASE [zno2016] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [zno2016] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [zno2016] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [zno2016] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [zno2016] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [zno2016] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [zno2016] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [zno2016] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [zno2016] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [zno2016] SET  DISABLE_BROKER 
GO
ALTER DATABASE [zno2016] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [zno2016] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [zno2016] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [zno2016] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [zno2016] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [zno2016] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [zno2016] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [zno2016] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [zno2016] SET  MULTI_USER 
GO
ALTER DATABASE [zno2016] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [zno2016] SET DB_CHAINING OFF 
GO
ALTER DATABASE [zno2016] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [zno2016] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'zno2016', N'ON'
GO
USE [zno2016]
GO
/****** Object:  UserDefinedFunction [dbo].[clean_num]    Script Date: 10/3/2016 12:23:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[clean_num] 
(
	@num NVARCHAR(500) NULL
)
RETURNS NVARCHAR(500)
AS
BEGIN
	RETURN CASE WHEN @num <> 'null' THEN REPLACE(@num, ',', '.') END
END


GO
/****** Object:  UserDefinedFunction [dbo].[clean_str]    Script Date: 10/3/2016 12:23:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[clean_str] 
(
	@str NVARCHAR(500) NULL
)
RETURNS NVARCHAR(500)
AS
BEGIN
	RETURN CASE WHEN @str <> 'null' THEN REPLACE(@str, '"', '') END

END


GO
/****** Object:  UserDefinedFunction [dbo].[get_score]    Script Date: 10/3/2016 12:23:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[get_score] 
(	
	@testStatus nvarchar(500),
	@ball100 decimal(4,1),
	@ball12 int NULL = NULL
)
RETURNS decimal(4,1)
AS
BEGIN	
	RETURN 
	CASE WHEN @testStatus = N'Не склав' OR @testStatus = N'Отримав результат' THEN  
		CASE 
		WHEN @ball100 >= 100 THEN @ball100
		WHEN @ball12 IS NULL THEN 50
		ELSE @ball12 * 20	
		END
	END
END


GO
/****** Object:  Table [dbo].[OpenData2016]    Script Date: 10/3/2016 12:23:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpenData2016](
	[OutID] [uniqueidentifier] NULL,
	[Birth] [int] NULL,
	[SexTypeName] [nvarchar](500) NULL,
	[Regname] [nvarchar](500) NULL,
	[AreaName] [nvarchar](500) NULL,
	[TerName] [nvarchar](500) NULL,
	[RegTypeName] [nvarchar](500) NULL,
	[EOName] [nvarchar](500) NULL,
	[EOTypeName] [nvarchar](500) NULL,
	[EORegName] [nvarchar](500) NULL,
	[EOAreaName] [nvarchar](500) NULL,
	[EOTerName] [nvarchar](500) NULL,
	[EOParent] [nvarchar](500) NULL,
	[UkrTest] [nvarchar](500) NULL,
	[UkrTestStatus] [nvarchar](500) NULL,
	[UkrBall100] [decimal](4, 1) NULL,
	[UkrBall12] [int] NULL,
	[UkrPTName] [nvarchar](500) NULL,
	[UkrPTRegName] [nvarchar](500) NULL,
	[UkrPTAreaName] [nvarchar](500) NULL,
	[UkrPTTerName] [nvarchar](500) NULL,
	[HistTest] [nvarchar](500) NULL,
	[HistLang] [nvarchar](500) NULL,
	[HistTestStatus] [nvarchar](500) NULL,
	[HistBall100] [decimal](4, 1) NULL,
	[HistBall12] [int] NULL,
	[HistPTName] [nvarchar](500) NULL,
	[HistPTRegName] [nvarchar](500) NULL,
	[HistPTAreaName] [nvarchar](500) NULL,
	[HistPTTerName] [nvarchar](500) NULL,
	[MathTest] [nvarchar](500) NULL,
	[MathLang] [nvarchar](500) NULL,
	[MathTestStatus] [nvarchar](500) NULL,
	[MathBall100] [decimal](4, 1) NULL,
	[MathBall12] [int] NULL,
	[MathPTName] [nvarchar](500) NULL,
	[MathPTRegName] [nvarchar](500) NULL,
	[MathPTAreaName] [nvarchar](500) NULL,
	[MathPTTerName] [nvarchar](500) NULL,
	[PhysTest] [nvarchar](500) NULL,
	[PhysLang] [nvarchar](500) NULL,
	[PhysTestStatus] [nvarchar](500) NULL,
	[PhysBall100] [decimal](4, 1) NULL,
	[PhysPTName] [nvarchar](500) NULL,
	[PhysPTRegName] [nvarchar](500) NULL,
	[PhysPTAreaName] [nvarchar](500) NULL,
	[PhysPTTerName] [nvarchar](500) NULL,
	[ChemTest] [nvarchar](500) NULL,
	[ChemLang] [nvarchar](500) NULL,
	[ChemTestStatus] [nvarchar](500) NULL,
	[ChemBall100] [decimal](4, 1) NULL,
	[ChemPTName] [nvarchar](500) NULL,
	[ChemPTRegName] [nvarchar](500) NULL,
	[ChemPTAreaName] [nvarchar](500) NULL,
	[ChemPTTerName] [nvarchar](500) NULL,
	[BioTest] [nvarchar](500) NULL,
	[BioLang] [nvarchar](500) NULL,
	[BioTestStatus] [nvarchar](500) NULL,
	[BioBall100] [decimal](4, 1) NULL,
	[BioPTName] [nvarchar](500) NULL,
	[BioPTRegName] [nvarchar](500) NULL,
	[BioPTAreaName] [nvarchar](500) NULL,
	[BioPTTerName] [nvarchar](500) NULL,
	[GeoTest] [nvarchar](500) NULL,
	[GeoLang] [nvarchar](500) NULL,
	[GeoTestStatus] [nvarchar](500) NULL,
	[GeoBall100] [decimal](4, 1) NULL,
	[GeoPTName] [nvarchar](500) NULL,
	[GeoPTRegName] [nvarchar](500) NULL,
	[GeoPTAreaName] [nvarchar](500) NULL,
	[GeoPTTerName] [nvarchar](500) NULL,
	[EngTest] [nvarchar](500) NULL,
	[EngTestStatus] [nvarchar](500) NULL,
	[EngBall100] [decimal](4, 1) NULL,
	[EngPTName] [nvarchar](500) NULL,
	[EngPTRegName] [nvarchar](500) NULL,
	[EngPTAreaName] [nvarchar](500) NULL,
	[EngPTTerName] [nvarchar](500) NULL,
	[FrTest] [nvarchar](500) NULL,
	[FrTestStatus] [nvarchar](500) NULL,
	[FrBall100] [decimal](4, 1) NULL,
	[FrPTName] [nvarchar](500) NULL,
	[FrPTRegName] [nvarchar](500) NULL,
	[FrPTAreaName] [nvarchar](500) NULL,
	[FrPTTerName] [nvarchar](500) NULL,
	[DeuTest] [nvarchar](500) NULL,
	[DeuTestStatus] [nvarchar](500) NULL,
	[DeuBall100] [decimal](4, 1) NULL,
	[DeuPTName] [nvarchar](500) NULL,
	[DeuPTRegName] [nvarchar](500) NULL,
	[DeuPTAreaName] [nvarchar](500) NULL,
	[DeuPTTerName] [nvarchar](500) NULL,
	[SpTest] [nvarchar](500) NULL,
	[SpTestStatus] [nvarchar](500) NULL,
	[SpBall100] [decimal](4, 1) NULL,
	[SpPTName] [nvarchar](500) NULL,
	[SpPTRegName] [nvarchar](500) NULL,
	[SpPTAreaName] [nvarchar](500) NULL,
	[SpPTTerName] [nvarchar](500) NULL,
	[RusTest] [nvarchar](500) NULL,
	[RusTestStatus] [nvarchar](500) NULL,
	[RusBall100] [decimal](4, 1) NULL,
	[RusPTName] [nvarchar](500) NULL,
	[RusPTRegName] [nvarchar](500) NULL,
	[RusPTAreaName] [nvarchar](500) NULL,
	[RusPTTerName] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OpenData2016_tmp]    Script Date: 10/3/2016 12:23:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpenData2016_tmp](
	[OutID] [nvarchar](100) NULL,
	[Birth] [nvarchar](500) NULL,
	[SexTypeName] [nvarchar](500) NULL,
	[Regname] [nvarchar](500) NULL,
	[AreaName] [nvarchar](500) NULL,
	[TerName] [nvarchar](500) NULL,
	[RegTypeName] [nvarchar](500) NULL,
	[EOName] [nvarchar](500) NULL,
	[EOTypeName] [nvarchar](500) NULL,
	[EORegName] [nvarchar](500) NULL,
	[EOAreaName] [nvarchar](500) NULL,
	[EOTerName] [nvarchar](500) NULL,
	[EOParent] [nvarchar](500) NULL,
	[UkrTest] [nvarchar](500) NULL,
	[UkrTestStatus] [nvarchar](500) NULL,
	[UkrBall100] [nvarchar](500) NULL,
	[UkrBall12] [nvarchar](500) NULL,
	[UkrPTName] [nvarchar](500) NULL,
	[UkrPTRegName] [nvarchar](500) NULL,
	[UkrPTAreaName] [nvarchar](500) NULL,
	[UkrPTTerName] [nvarchar](500) NULL,
	[HistTest] [nvarchar](500) NULL,
	[HistLang] [nvarchar](500) NULL,
	[HistTestStatus] [nvarchar](500) NULL,
	[HistBall100] [nvarchar](500) NULL,
	[HistBall12] [nvarchar](500) NULL,
	[HistPTName] [nvarchar](500) NULL,
	[HistPTRegName] [nvarchar](500) NULL,
	[HistPTAreaName] [nvarchar](500) NULL,
	[HistPTTerName] [nvarchar](500) NULL,
	[MathTest] [nvarchar](500) NULL,
	[MathLang] [nvarchar](500) NULL,
	[MathTestStatus] [nvarchar](500) NULL,
	[MathBall100] [nvarchar](500) NULL,
	[MathBall12] [nvarchar](500) NULL,
	[MathPTName] [nvarchar](500) NULL,
	[MathPTRegName] [nvarchar](500) NULL,
	[MathPTAreaName] [nvarchar](500) NULL,
	[MathPTTerName] [nvarchar](500) NULL,
	[PhysTest] [nvarchar](500) NULL,
	[PhysLang] [nvarchar](500) NULL,
	[PhysTestStatus] [nvarchar](500) NULL,
	[PhysBall100] [nvarchar](500) NULL,
	[PhysPTName] [nvarchar](500) NULL,
	[PhysPTRegName] [nvarchar](500) NULL,
	[PhysPTAreaName] [nvarchar](500) NULL,
	[PhysPTTerName] [nvarchar](500) NULL,
	[ChemTest] [nvarchar](500) NULL,
	[ChemLang] [nvarchar](500) NULL,
	[ChemTestStatus] [nvarchar](500) NULL,
	[ChemBall100] [nvarchar](500) NULL,
	[ChemPTName] [nvarchar](500) NULL,
	[ChemPTRegName] [nvarchar](500) NULL,
	[ChemPTAreaName] [nvarchar](500) NULL,
	[ChemPTTerName] [nvarchar](500) NULL,
	[BioTest] [nvarchar](500) NULL,
	[BioLang] [nvarchar](500) NULL,
	[BioTestStatus] [nvarchar](500) NULL,
	[BioBall100] [nvarchar](500) NULL,
	[BioPTName] [nvarchar](500) NULL,
	[BioPTRegName] [nvarchar](500) NULL,
	[BioPTAreaName] [nvarchar](500) NULL,
	[BioPTTerName] [nvarchar](500) NULL,
	[GeoTest] [nvarchar](500) NULL,
	[GeoLang] [nvarchar](500) NULL,
	[GeoTestStatus] [nvarchar](500) NULL,
	[GeoBall100] [nvarchar](500) NULL,
	[GeoPTName] [nvarchar](500) NULL,
	[GeoPTRegName] [nvarchar](500) NULL,
	[GeoPTAreaName] [nvarchar](500) NULL,
	[GeoPTTerName] [nvarchar](500) NULL,
	[EngTest] [nvarchar](500) NULL,
	[EngTestStatus] [nvarchar](500) NULL,
	[EngBall100] [nvarchar](500) NULL,
	[EngPTName] [nvarchar](500) NULL,
	[EngPTRegName] [nvarchar](500) NULL,
	[EngPTAreaName] [nvarchar](500) NULL,
	[EngPTTerName] [nvarchar](500) NULL,
	[FrTest] [nvarchar](500) NULL,
	[FrTestStatus] [nvarchar](500) NULL,
	[FrBall100] [nvarchar](500) NULL,
	[FrPTName] [nvarchar](500) NULL,
	[FrPTRegName] [nvarchar](500) NULL,
	[FrPTAreaName] [nvarchar](500) NULL,
	[FrPTTerName] [nvarchar](500) NULL,
	[DeuTest] [nvarchar](500) NULL,
	[DeuTestStatus] [nvarchar](500) NULL,
	[DeuBall100] [nvarchar](500) NULL,
	[DeuPTName] [nvarchar](500) NULL,
	[DeuPTRegName] [nvarchar](500) NULL,
	[DeuPTAreaName] [nvarchar](500) NULL,
	[DeuPTTerName] [nvarchar](500) NULL,
	[SpTest] [nvarchar](500) NULL,
	[SpTestStatus] [nvarchar](500) NULL,
	[SpBall100] [nvarchar](500) NULL,
	[SpPTName] [nvarchar](500) NULL,
	[SpPTRegName] [nvarchar](500) NULL,
	[SpPTAreaName] [nvarchar](500) NULL,
	[SpPTTerName] [nvarchar](500) NULL,
	[RusTest] [nvarchar](500) NULL,
	[RusTestStatus] [nvarchar](500) NULL,
	[RusBall100] [nvarchar](500) NULL,
	[RusPTName] [nvarchar](500) NULL,
	[RusPTRegName] [nvarchar](500) NULL,
	[RusPTAreaName] [nvarchar](500) NULL,
	[RusPTTerName] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PersonScores]    Script Date: 10/3/2016 12:23:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonScores](
	[OutID] [nvarchar](200) NOT NULL,
	[SexTypeName] [nvarchar](500) NULL,
	[Age] [int] NULL,
	[TerType] [nvarchar](10) NULL,
	[EOName] [nvarchar](500) NULL,
	[EORegName] [nvarchar](500) NULL,
	[Ukr] [decimal](4, 1) NULL,
	[Hist] [decimal](4, 1) NULL,
	[Math] [decimal](4, 1) NULL,
	[Phys] [decimal](4, 1) NULL,
	[Chem] [decimal](4, 1) NULL,
	[Bio] [decimal](4, 1) NULL,
	[Geo] [decimal](4, 1) NULL,
	[Eng] [decimal](4, 1) NULL,
	[Fr] [decimal](4, 1) NULL,
	[Deu] [decimal](4, 1) NULL,
	[Sp] [decimal](4, 1) NULL,
	[Rus] [decimal](4, 1) NULL
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[Scores]    Script Date: 10/3/2016 12:23:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[Scores] AS
 SELECT [OutID]
	,SexTypeName
	,Age
	,TerType
      ,[EOName]
      ,[EORegName]      
	  ,[Subj],
	  [Score],
	  CASE WHEN [Score] < 100 THEN 1 ELSE 0 END AS IsFailed
FROM 
   (SELECT *   FROM [dbo].[PersonScores]) p
UNPIVOT
   ([Score] FOR [Subj] IN 
      ([Ukr]
      ,[Hist]
      ,[Math]
      ,[Phys]
      ,[Chem]
      ,[Bio]
      ,[Geo]
      ,[Eng]
      ,[Fr]
      ,[Deu]
      ,[Sp]
      ,[Rus])
)AS unpvt;

GO
/****** Object:  View [dbo].[SchoolSchores]    Script Date: 10/3/2016 12:23:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[SchoolSchores] AS
SELECT  EOName, [EORegName]    
		  ,AVG([Score]) AvgScore
		  ,COUNT([Score]) AS Exams
		  ,SUM([IsFailed]) FailedExams
		  , 1 - 1.0 * SUM([IsFailed])/ COUNT([Score])  AS PassRate
	  FROM [dbo].[Scores]	  
	  GROUP BY EOName, [EORegName]
GO
/****** Object:  View [dbo].[SchoolSubjScores]    Script Date: 10/3/2016 12:23:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[SchoolSubjScores]
AS
SELECT  EOName, EORegName
, COUNT(DISTINCT OutId) As Examinees
, AVG(Ukr) AS UkrAvg
, COUNT(Ukr) AS UkrN
, AVG(Hist) AS HistAvg
, COUNT(Hist) AS HistN
, AVG(Math) AS MathAvg
, COUNT(Math) AS MathN
, AVG(Phys) AS PhysAvg
, COUNT(Phys) AS PhysN
, AVG(Chem) AS ChemAvg
, COUNT(Chem) AS ChemN
, AVG(Bio) AS BioAvg
, COUNT(Bio) AS BioN
, AVG(Geo) AS GeoAvg
, COUNT(Geo) AS GeoN
, AVG(Eng) AS EngAvg
, COUNT(Eng) AS EngN
, AVG(Fr) AS FrAvg
, COUNT(Fr) AS FrN
, AVG(Deu) AS DeuAvg
, COUNT(Deu) AS DeuN
, AVG(Sp) AS SpAvg
, COUNT(Sp) AS SpN
, AVG(Rus) AS RusAvg
, COUNT(Rus) AS RusN
FROM            PersonScores
GROUP BY EOName, EORegName

GO
/****** Object:  View [dbo].[SchoolScoresTotal]    Script Date: 10/3/2016 12:23:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[SchoolScoresTotal] AS
SELECT  School.AvgScore
		  ,School.FailedExams
		  , School.PassRate
		  , Subj.*
  FROM [dbo].[SchoolSubjScores] AS Subj
  INNER JOIN 
	  SchoolSchores AS School
  ON (School.EOName = Subj.EOName AND School.[EORegName] = Subj.[EORegName])
 
GO
/****** Object:  View [dbo].[SchoolRating]    Script Date: 10/3/2016 12:23:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [dbo].[SchoolRating]
AS
SELECT TOP 1000000
	    DENSE_RANK() OVER (ORDER BY [AvgScore] DESC, [Examinees] DESC) AS TotalRank
	  , DENSE_RANK() OVER (ORDER BY (CASE WHEN [MathN]>=3 and [PhysN]>=3 and [EngN]>=3 THEN [MathAvg] + [PhysAvg] + [EngAvg] END) DESC) AS IT_Rank     
      , DENSE_RANK() OVER (ORDER BY [UkrAvg] DESC, [UkrN] DESC) AS UkrRank
      , DENSE_RANK() OVER (ORDER BY [MathAvg] DESC, [MathN] DESC) AS MathRank
      , DENSE_RANK() OVER (ORDER BY [PhysAvg] DESC, [PhysN] DESC) AS PhysRank
      , DENSE_RANK() OVER (ORDER BY [EngAvg] DESC, [EngN] DESC) AS EngRank
	  , DENSE_RANK() OVER (ORDER BY [HistAvg] DESC, [HistN] DESC) AS HistRank
      , DENSE_RANK() OVER (ORDER BY [ChemAvg] DESC, [ChemN] DESC) AS ChemRank
      , DENSE_RANK() OVER (ORDER BY [BioAvg] DESC, [BioN] DESC) AS BioRank 
	  ,S.*
  FROM [dbo].[SchoolScoresTotal] AS S
  WHERE S.Examinees >=3
  ORDER BY TotalRank

GO
/****** Object:  View [dbo].[SchoolRatingOd]    Script Date: 10/3/2016 12:23:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Script for SelectTopNRows command from SSMS  ******/
CREATE view [dbo].[SchoolRatingOd] as
SELECT *
  FROM [dbo].[SchoolRating]
  where EORegName = N'Одеська обл., м.Одеса'

GO
/****** Object:  View [dbo].[PersonScoresWithAvg]    Script Date: 10/3/2016 12:23:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Script for SelectTopNRows command from SSMS  ******/

CREATE VIEW [dbo].[PersonScoresWithAvg] AS
SELECT   S.AvgScore, S.Exams, P.*
  FROM [dbo].[PersonScores] AS P
  RIGHT OUTER JOIN 
	  (SELECT [OutID]      
		  ,AVG([Score]) AvgScore
		  ,COUNT([Score]) Exams
	  FROM [dbo].[Scores]
	  GROUP BY [OutID]) AS S
  ON S.[OutID] = P.[OutID]

GO
/****** Object:  View [dbo].[SexTypeScores]    Script Date: 10/3/2016 12:23:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[SexTypeScores] AS
SELECT  SexTypeName    
			,COUNT(DISTINCT OutID) AS N
		  ,AVG([Score]) AvgScore
		  ,COUNT([Score]) AS Exams
		  ,SUM([IsFailed]) FailedExams
		  , 1 - 1.0 * SUM([IsFailed])/ COUNT([Score])  AS PassRate
	  FROM [dbo].[Scores]	  
	  GROUP BY SexTypeName

GO
/****** Object:  View [dbo].[AgeScores]    Script Date: 10/3/2016 12:23:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[AgeScores] AS
SELECT  Age   
			,COUNT(DISTINCT OutID) AS N
		  ,AVG([Score]) AvgScore
		  ,COUNT([Score]) AS Exams
		  ,SUM([IsFailed]) FailedExams
		  , 1 - 1.0 * SUM([IsFailed])/ COUNT([Score])  AS PassRate
	  FROM [dbo].[Scores]
	  GROUP BY Age

GO
/****** Object:  View [dbo].[TerTypeScores]    Script Date: 10/3/2016 12:23:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[TerTypeScores] AS
SELECT  TerType    
			,COUNT(DISTINCT OutID) AS N
		  ,AVG([Score]) AvgScore
		  ,COUNT([Score]) AS Exams
		  ,SUM([IsFailed]) FailedExams
		  , 1 - 1.0 * SUM([IsFailed])/ COUNT([Score])  AS PassRate
	  FROM [dbo].[Scores]	  
	  GROUP BY TerType

GO
/****** Object:  View [dbo].[StudentRaiting]    Script Date: 10/3/2016 12:23:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Script for SelectTopNRows command from SSMS  ******/
CREATE view [dbo].[StudentRaiting] as 
SELECT TOP 1000000
	 DENSE_RANK() OVER (ORDER BY [AvgScore] DESC, [Exams] DESC) AS TotalRank
	 ,V.*
  FROM [dbo].[PersonScoresWithAvg] V
  ORDER BY [TotalRank] ASC
  
GO
/****** Object:  View [dbo].[StudentRaitingTop1000]    Script Date: 10/3/2016 12:23:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
create view [dbo].[StudentRaitingTop1000] as 
SELECT TOP 1000  V.*
  FROM [dbo].[StudentRaiting] AS V  
  order by [TotalRank] asc
 
GO
/****** Object:  View [dbo].[SchoolsWithBestPeople]    Script Date: 10/3/2016 12:23:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Script for SelectTopNRows command from SSMS  ******/
CREATE view [dbo].[SchoolsWithBestPeople] as 
SELECT TOP 10
       Count (DISTINCT [OutID]) AS N    
      ,[EOName]
      ,[EORegName]      
  FROM [dbo].[StudentRaitingTop1000]
  group by [EOName],[EORegName] 
  order by N DESC

GO
/****** Object:  View [dbo].[SubjectSexTypeScores]    Script Date: 10/3/2016 12:23:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[SubjectSexTypeScores] AS
SELECT Subj, SexTypeName    
			,COUNT(DISTINCT OutID) AS N
		  ,AVG([Score]) AvgScore
		  ,COUNT([Score]) AS Exams
		  ,SUM([IsFailed]) AS FailedExams
		  , 1 - 1.0 * SUM([IsFailed])/ COUNT([Score])  AS PassRate
	  FROM [dbo].[Scores]	  
	  GROUP BY Subj, SexTypeName
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_EO]    Script Date: 10/3/2016 12:23:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_EO] ON [dbo].[PersonScores]
(
	[EOName] ASC,
	[EORegName] ASC
)
INCLUDE ( 	[OutID],
	[Ukr],
	[Hist],
	[Math],
	[Phys],
	[Chem],
	[Bio],
	[Geo],
	[Eng],
	[Fr],
	[Deu],
	[Sp],
	[Rus]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ID]    Script Date: 10/3/2016 12:23:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_ID] ON [dbo].[PersonScores]
(
	[OutID] ASC
)
INCLUDE ( 	[EOName],
	[EORegName],
	[Ukr],
	[Hist],
	[Math],
	[Phys],
	[Chem],
	[Bio],
	[Geo],
	[Eng],
	[Fr],
	[Deu],
	[Sp],
	[Rus]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [zno2016] SET  READ_WRITE 
GO
