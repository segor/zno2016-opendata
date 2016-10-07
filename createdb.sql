USE [master]
GO
CREATE DATABASE [zno2016]
GO
ALTER DATABASE [zno2016]
MODIFY FILE
( NAME = N'zno2016', SIZE = 2048MB, FILEGROWTH = 10% )
GO
ALTER DATABASE [zno2016]
MODIFY FILE
( NAME = N'zno2016_log', SIZE = 1024MB, FILEGROWTH = 10% )
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
USE [zno2016]
GO
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[get_eo_hash] 
(	
	@EOName nvarchar(500),
	@EORegName nvarchar(500),
	@EOAreaName nvarchar(500)
)
RETURNS varbinary(20)
AS
BEGIN	
	RETURN CASE 
		WHEN @EOName IS NOT NULL 
		THEN HASHBYTES ('SHA1', @EOName + @EORegName + @EOAreaName) 
	END
END


GO
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonScores](
	[OutID] [nvarchar](200) NOT NULL,
	[SexTypeName] [nvarchar](500) NULL,
	[Age] [int] NULL,
	[EOHash] [varbinary](20) NULL,
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schools](
	[EOHash] [varbinary](20) NOT NULL,
	[EOName] [nvarchar](500) NULL,
	[EOTypeName] [nvarchar](500) NULL,
	[EORegName] [nvarchar](500) NULL,
	[EOAreaName] [nvarchar](500) NULL,
	[EOTerName] [nvarchar](500) NULL,
	[TerType] [nvarchar](10) NULL,
	[AreaName] [nvarchar](500) NULL
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[Scores] AS
 SELECT [OutID]
	,SexTypeName
	,Age	
      ,[EOHash]      
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SchoolScores] AS
SELECT A.*, M.MedScore FROM
	(SELECT  EOHash    
			  ,AVG([Score]) AvgScore
			  ,COUNT([Score]) AS Exams
			  ,SUM([IsFailed]) FailedExams
			  , 1 - 1.0 * SUM([IsFailed])/ COUNT([Score])  AS PassRate
		  FROM [dbo].[Scores]	  
		  GROUP BY EOHash) AS A
INNER JOIN 
	(SELECT DISTINCT EOHash
				, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY [Score]) OVER (PARTITION BY EOHash) AS MedScore
	FROM [dbo].[Scores]	) AS M 
ON A.EOHash = M.EOHash
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SchoolSubjScores]
AS
SELECT 
	A.[EOHash]
	,[Examinees]
	,[UkrAvg]
	,[UkrMed]
	,[UkrN]
	,[HistAvg]
	,[HistMed]
	,[HistN]
	,[MathAvg]
	,[MathMed]
	,[MathN]
	,[PhysAvg]
	,[PhysMed]
	,[PhysN]
	,[ChemAvg]
	,[ChemMed]
	,[ChemN]
	,[BioAvg]
	,[BioMed]
	,[BioN]
	,[GeoAvg]
	,[GeoMed]
	,[GeoN]
	,[EngAvg]
	,[EngMed]
	,[EngN]
	,[FrAvg]
	,[FrMed]
	,[FrN]
	,[DeuAvg]
	,[DeuMed]
	,[DeuN]
	,[SpAvg]
	,[SpMed]
	,[SpN]
	,[RusAvg]
	,[RusMed]
	,[RusN]
FROM
	(SELECT EOHash
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
	GROUP BY EOHash) AS A
INNER JOIN 
	(SELECT DISTINCT EOHash
		, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Ukr) OVER (PARTITION BY EOHash) AS UkrMed
		, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Hist) OVER (PARTITION BY EOHash) AS HistMed
		, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Math) OVER (PARTITION BY EOHash) AS MathMed
		, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Phys) OVER (PARTITION BY EOHash) AS PhysMed
		, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Chem) OVER (PARTITION BY EOHash) AS ChemMed
		, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Bio) OVER (PARTITION BY EOHash) AS BioMed
		, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Geo) OVER (PARTITION BY EOHash) AS GeoMed
		, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Eng) OVER (PARTITION BY EOHash) AS EngMed
		, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Fr) OVER (PARTITION BY EOHash) AS FrMed
		, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Deu) OVER (PARTITION BY EOHash) AS DeuMed
		, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Sp) OVER (PARTITION BY EOHash) AS SpMed
		, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Rus) OVER (PARTITION BY EOHash) AS RusMed
	FROM            PersonScores ) AS M
ON A.EOHash = M.EOHash


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SchoolScoresTotal] AS
SELECT  School.AvgScore
		  ,School.FailedExams
		  , School.PassRate
		  , School.MedScore
		  , Subj.*
  FROM [dbo].[SchoolSubjScores] AS Subj
  INNER JOIN 
	  SchoolScores AS School
  ON (School.EOHash = Subj.EOHash)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[EOTypesForRating] AS
SELECT N'середня загальноосвітня школа' AS [EOTypeName]
UNION 
SELECT N'навчально-виховний комплекс' AS [EOTypeName]
UNION 
SELECT N'гімназія' AS [EOTypeName]
UNION 
SELECT N'спеціалізована школа' AS [EOTypeName]
UNION 
SELECT N'ліцей' AS [EOTypeName]
UNION 
SELECT N'середня загальноосвітня школа-інтернат' AS [EOTypeName]
UNION 
SELECT N'спеціалізована школа-інтернат' AS [EOTypeName]
UNION 
SELECT N'колегіум' AS [EOTypeName]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SchoolRating]
AS
SELECT TOP 1000000
	    CASE WHEN IsInRating=1 
			THEN DENSE_RANK() OVER (ORDER BY [AvgScore] DESC, [Examinees] DESC) END AS TotalRank
	  , CASE WHEN IsInRating=1 
			THEN DENSE_RANK() OVER (ORDER BY [MedScore] DESC, [Examinees] DESC) END AS MedTotalRank
	  , CASE WHEN IsInRating=1 AND [MathN]>=3 AND [PhysN]>=3 AND [EngN]>=3 
			THEN DENSE_RANK() OVER (ORDER BY ( [MathAvg] + [PhysAvg] + [EngAvg] ) DESC) END AS IT_Rank     
      , CASE WHEN IsInRating=1 AND [UkrN]>=3
			THEN DENSE_RANK() OVER (ORDER BY [UkrAvg] DESC, [UkrN] DESC) END AS UkrRank
      , CASE WHEN IsInRating=1 AND [MathN]>=3
			THEN DENSE_RANK() OVER (ORDER BY [MathAvg] DESC, [MathN] DESC) END AS MathRank
      , CASE WHEN IsInRating=1 AND [PhysN]>=3
			THEN DENSE_RANK() OVER (ORDER BY [PhysAvg] DESC, [PhysN] DESC) END AS PhysRank
      , CASE WHEN IsInRating=1 AND [EngN]>=3
			THEN DENSE_RANK() OVER (ORDER BY [EngAvg] DESC, [EngN] DESC) END AS EngRank
	  , CASE WHEN IsInRating=1 AND [HistN]>=3
			THEN DENSE_RANK() OVER (ORDER BY [HistAvg] DESC, [HistN] DESC) END AS HistRank
      , CASE WHEN IsInRating=1 AND [ChemN]>=3
			THEN DENSE_RANK() OVER (ORDER BY [ChemAvg] DESC, [ChemN] DESC) END AS ChemRank
      , CASE WHEN IsInRating=1 AND [BioN]>=3
			THEN DENSE_RANK() OVER (ORDER BY [BioAvg] DESC, [BioN] DESC) END AS BioRank 
	  , Q.*	  
FROM (
SELECT   
	   [AvgScore]
	  ,[MedScore]
	  ,[EOName]
	  ,[AreaName] AS EORegName
	  ,[Examinees]
	  ,[PassRate]
      ,[UkrAvg]
      ,[UkrMed]
      ,[UkrN]
      ,[HistAvg]
      ,[HistMed]
      ,[HistN]
      ,[MathAvg]
      ,[MathMed]
      ,[MathN]
      ,[PhysAvg]
      ,[PhysMed]
      ,[PhysN]
      ,[ChemAvg]
      ,[ChemMed]
      ,[ChemN]
      ,[BioAvg]
      ,[BioMed]
      ,[BioN]
      ,[GeoAvg]
      ,[GeoMed]
      ,[GeoN]
      ,[EngAvg]
      ,[EngMed]
      ,[EngN]
      ,[FrAvg]
      ,[FrMed]
      ,[FrN]
      ,[DeuAvg]
      ,[DeuMed]
      ,[DeuN]
      ,[SpAvg]
      ,[SpMed]
      ,[SpN]
      ,[RusAvg]
      ,[RusMed]
      ,[RusN]
	  ,[EOTypeName]
	  ,[TerType]
	  ,CAST (
			CASE WHEN				
				Examinees >=3 AND
				EXISTS (
					SELECT 1
					FROM [EOTypesForRating] 
					WHERE [EOTypesForRating].[EOTypeName] = [Schools].[EOTypeName]
				)
			THEN 1
			ELSE 0 END
		AS BIT) AS IsInRating
  FROM [dbo].[SchoolScoresTotal] AS T
  INNER JOIN [dbo].[Schools] on (T.EOHash = [Schools].EOHash)
) AS Q
ORDER BY IsInRating DESC, TotalRank, [AvgScore] DESC, [Examinees] DESC
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[SchoolRatingOd] as
SELECT *
  FROM [dbo].[SchoolRating]
  where EORegName = N'Одеська обл., м.Одеса'


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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
	  INNER JOIN [dbo].[Schools] on ([Scores].EOHash = [Schools].EOHash)	  
	  GROUP BY TerType

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[StudentRaiting] as 
SELECT TOP 1000000
	 DENSE_RANK() OVER (ORDER BY [AvgScore] DESC, [Exams] DESC) AS TotalRank
	 ,V.*
  FROM [dbo].[PersonScoresWithAvg] V
  ORDER BY [TotalRank] ASC


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[StudentRaitingTop1000] as 
SELECT TOP 1000  V.*
  FROM [dbo].[StudentRaiting] AS V  
  order by [TotalRank] asc
 

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[SchoolsWithBestPeople] as 
SELECT TOP 10
       Count (DISTINCT [OutID]) AS N    
      ,[Schools].EOName
	  , [Schools].AreaName     
  FROM [dbo].[StudentRaitingTop1000]
  INNER JOIN [dbo].[Schools] on ([StudentRaitingTop1000].EOHash = [Schools].EOHash)
  group by [Schools].EOHash, [Schools].EOName , [Schools].AreaName
  order by N DESC


GO
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[EOTypeScores] AS
SELECT  EOTypeName    
			,COUNT(DISTINCT OutID) AS N
		  ,AVG([Score]) AvgScore
		  ,COUNT([Score]) AS Exams
		  ,SUM([IsFailed]) FailedExams
		  , 1 - 1.0 * SUM([IsFailed])/ COUNT([Score])  AS PassRate
	  FROM [dbo].[Scores]
	  INNER JOIN [dbo].[Schools] on ([Scores].EOHash = [Schools].EOHash)	  
	  GROUP BY EOTypeName




GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[EOTypes] AS
SELECT  EOTypeName, count(*) AS N
  FROM [dbo].[OpenData2016]  
  WHERE EOTypeName IS NOT NULL
  group by EOTypeName



GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_EO] ON [dbo].[PersonScores]
(
	[EOHash] ASC
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
CREATE NONCLUSTERED INDEX [IX_ID] ON [dbo].[PersonScores]
(
	[OutID] ASC
)
INCLUDE ( 	[EOHash],
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
CREATE UNIQUE NONCLUSTERED INDEX [IX_Schools] ON [dbo].[Schools]
(
	[EOHash] ASC
)
INCLUDE ( 	[EOName],
	[TerType],
	[AreaName]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [zno2016] SET  READ_WRITE 
GO
