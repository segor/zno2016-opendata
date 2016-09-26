USE [zno2016]
GO

TRUNCATE TABLE [dbo].OpenData2016_CSV
GO

TRUNCATE TABLE [dbo].OpenData2016
GO

BULK INSERT OpenData2016_CSV
	-- !!! SET PATH TO CSV FILE HERE: 	
    FROM N'C:\Users\sgorodetsky\Downloads\OpenDataZNO2016\OpenData2016.csv'	
    WITH
    (
    FIRSTROW = 2,
	CODEPAGE = '1251',
    FIELDTERMINATOR = ';',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK	
    )
GO

INSERT INTO OpenData2016
SELECT 
  CASE WHEN [OutID] <> 'null' THEN REPLACE([OutID], '"', '') END AS [OutID]
, CASE WHEN [Birth] <> 'null' THEN REPLACE([Birth], '"', '') END AS [Birth]
, CASE WHEN [SexTypeName] <> 'null' THEN REPLACE([SexTypeName], '"', '') END AS [SexTypeName]
, CASE WHEN [Regname] <> 'null' THEN REPLACE([Regname], '"', '') END AS [Regname]
, CASE WHEN [AreaName] <> 'null' THEN REPLACE([AreaName], '"', '') END AS [AreaName]
, CASE WHEN [TerName] <> 'null' THEN REPLACE([TerName], '"', '') END AS [TerName]
, CASE WHEN [RegTypeName] <> 'null' THEN REPLACE([RegTypeName], '"', '') END AS [RegTypeName]
, CASE WHEN [EOName] <> 'null' THEN REPLACE([EOName], '"', '') END AS [EOName]
, CASE WHEN [EOTypeName] <> 'null' THEN REPLACE([EOTypeName], '"', '') END AS [EOTypeName]
, CASE WHEN [EORegName] <> 'null' THEN REPLACE([EORegName], '"', '') END AS [EORegName]
, CASE WHEN [EOAreaName] <> 'null' THEN REPLACE([EOAreaName], '"', '') END AS [EOAreaName]
, CASE WHEN [EOTerName] <> 'null' THEN REPLACE([EOTerName], '"', '') END AS [EOTerName]
, CASE WHEN [EOParent] <> 'null' THEN REPLACE([EOParent], '"', '') END AS [EOParent]
, CASE WHEN [UkrTest] <> 'null' THEN REPLACE([UkrTest], '"', '') END AS [UkrTest]
, CASE WHEN [UkrTestStatus] <> 'null' THEN REPLACE([UkrTestStatus], '"', '') END AS [UkrTestStatus]
, CASE WHEN [UkrBall100] <> 'null' THEN REPLACE([UkrBall100], ',', '.') END AS [UkrBall100]
, CASE WHEN [UkrBall12] <> 'null' THEN REPLACE([UkrBall12], ',', '.') END AS [UkrBall12]
, CASE WHEN [UkrPTName] <> 'null' THEN REPLACE([UkrPTName], '"', '') END AS [UkrPTName]
, CASE WHEN [UkrPTRegName] <> 'null' THEN REPLACE([UkrPTRegName], '"', '') END AS [UkrPTRegName]
, CASE WHEN [UkrPTAreaName] <> 'null' THEN REPLACE([UkrPTAreaName], '"', '') END AS [UkrPTAreaName]
, CASE WHEN [UkrPTTerName] <> 'null' THEN REPLACE([UkrPTTerName], '"', '') END AS [UkrPTTerName]
, CASE WHEN [HistTest] <> 'null' THEN REPLACE([HistTest], '"', '') END AS [HistTest]
, CASE WHEN [HistLang] <> 'null' THEN REPLACE([HistLang], '"', '') END AS [HistLang]
, CASE WHEN [HistTestStatus] <> 'null' THEN REPLACE([HistTestStatus], '"', '') END AS [HistTestStatus]
, CASE WHEN [HistBall100] <> 'null' THEN REPLACE([HistBall100], ',', '.') END AS [HistBall100]
, CASE WHEN [HistBall12] <> 'null' THEN REPLACE([HistBall12], ',', '.') END AS [HistBall12]
, CASE WHEN [HistPTName] <> 'null' THEN REPLACE([HistPTName], '"', '') END AS [HistPTName]
, CASE WHEN [HistPTRegName] <> 'null' THEN REPLACE([HistPTRegName], '"', '') END AS [HistPTRegName]
, CASE WHEN [HistPTAreaName] <> 'null' THEN REPLACE([HistPTAreaName], '"', '') END AS [HistPTAreaName]
, CASE WHEN [HistPTTerName] <> 'null' THEN REPLACE([HistPTTerName], '"', '') END AS [HistPTTerName]
, CASE WHEN [MathTest] <> 'null' THEN REPLACE([MathTest], '"', '') END AS [MathTest]
, CASE WHEN [MathLang] <> 'null' THEN REPLACE([MathLang], '"', '') END AS [MathLang]
, CASE WHEN [MathTestStatus] <> 'null' THEN REPLACE([MathTestStatus], '"', '') END AS [MathTestStatus]
, CASE WHEN [MathBall100] <> 'null' THEN REPLACE([MathBall100], ',', '.') END AS [MathBall100]
, CASE WHEN [MathBall12] <> 'null' THEN REPLACE([MathBall12], ',', '.') END AS [MathBall12]
, CASE WHEN [MathPTName] <> 'null' THEN REPLACE([MathPTName], '"', '') END AS [MathPTName]
, CASE WHEN [MathPTRegName] <> 'null' THEN REPLACE([MathPTRegName], '"', '') END AS [MathPTRegName]
, CASE WHEN [MathPTAreaName] <> 'null' THEN REPLACE([MathPTAreaName], '"', '') END AS [MathPTAreaName]
, CASE WHEN [MathPTTerName] <> 'null' THEN REPLACE([MathPTTerName], '"', '') END AS [MathPTTerName]
, CASE WHEN [PhysTest] <> 'null' THEN REPLACE([PhysTest], '"', '') END AS [PhysTest]
, CASE WHEN [PhysLang] <> 'null' THEN REPLACE([PhysLang], '"', '') END AS [PhysLang]
, CASE WHEN [PhysTestStatus] <> 'null' THEN REPLACE([PhysTestStatus], '"', '') END AS [PhysTestStatus]
, CASE WHEN [PhysBall100] <> 'null' THEN REPLACE([PhysBall100], ',', '.') END AS [PhysBall100]
, CASE WHEN [PhysPTName] <> 'null' THEN REPLACE([PhysPTName], '"', '') END AS [PhysPTName]
, CASE WHEN [PhysPTRegName] <> 'null' THEN REPLACE([PhysPTRegName], '"', '') END AS [PhysPTRegName]
, CASE WHEN [PhysPTAreaName] <> 'null' THEN REPLACE([PhysPTAreaName], '"', '') END AS [PhysPTAreaName]
, CASE WHEN [PhysPTTerName] <> 'null' THEN REPLACE([PhysPTTerName], '"', '') END AS [PhysPTTerName]
, CASE WHEN [ChemTest] <> 'null' THEN REPLACE([ChemTest], '"', '') END AS [ChemTest]
, CASE WHEN [ChemLang] <> 'null' THEN REPLACE([ChemLang], '"', '') END AS [ChemLang]
, CASE WHEN [ChemTestStatus] <> 'null' THEN REPLACE([ChemTestStatus], '"', '') END AS [ChemTestStatus]
, CASE WHEN [ChemBall100] <> 'null' THEN REPLACE([ChemBall100], ',', '.') END AS [ChemBall100]
, CASE WHEN [ChemPTName] <> 'null' THEN REPLACE([ChemPTName], '"', '') END AS [ChemPTName]
, CASE WHEN [ChemPTRegName] <> 'null' THEN REPLACE([ChemPTRegName], '"', '') END AS [ChemPTRegName]
, CASE WHEN [ChemPTAreaName] <> 'null' THEN REPLACE([ChemPTAreaName], '"', '') END AS [ChemPTAreaName]
, CASE WHEN [ChemPTTerName] <> 'null' THEN REPLACE([ChemPTTerName], '"', '') END AS [ChemPTTerName]
, CASE WHEN [BioTest] <> 'null' THEN REPLACE([BioTest], '"', '') END AS [BioTest]
, CASE WHEN [BioLang] <> 'null' THEN REPLACE([BioLang], '"', '') END AS [BioLang]
, CASE WHEN [BioTestStatus] <> 'null' THEN REPLACE([BioTestStatus], '"', '') END AS [BioTestStatus]
, CASE WHEN [BioBall100] <> 'null' THEN REPLACE([BioBall100], ',', '.') END AS [BioBall100]
, CASE WHEN [BioPTName] <> 'null' THEN REPLACE([BioPTName], '"', '') END AS [BioPTName]
, CASE WHEN [BioPTRegName] <> 'null' THEN REPLACE([BioPTRegName], '"', '') END AS [BioPTRegName]
, CASE WHEN [BioPTAreaName] <> 'null' THEN REPLACE([BioPTAreaName], '"', '') END AS [BioPTAreaName]
, CASE WHEN [BioPTTerName] <> 'null' THEN REPLACE([BioPTTerName], '"', '') END AS [BioPTTerName]
, CASE WHEN [GeoTest] <> 'null' THEN REPLACE([GeoTest], '"', '') END AS [GeoTest]
, CASE WHEN [GeoLang] <> 'null' THEN REPLACE([GeoLang], '"', '') END AS [GeoLang]
, CASE WHEN [GeoTestStatus] <> 'null' THEN REPLACE([GeoTestStatus], '"', '') END AS [GeoTestStatus]
, CASE WHEN [GeoBall100] <> 'null' THEN REPLACE([GeoBall100], ',', '.') END AS [GeoBall100]
, CASE WHEN [GeoPTName] <> 'null' THEN REPLACE([GeoPTName], '"', '') END AS [GeoPTName]
, CASE WHEN [GeoPTRegName] <> 'null' THEN REPLACE([GeoPTRegName], '"', '') END AS [GeoPTRegName]
, CASE WHEN [GeoPTAreaName] <> 'null' THEN REPLACE([GeoPTAreaName], '"', '') END AS [GeoPTAreaName]
, CASE WHEN [GeoPTTerName] <> 'null' THEN REPLACE([GeoPTTerName], '"', '') END AS [GeoPTTerName]
, CASE WHEN [EngTest] <> 'null' THEN REPLACE([EngTest], '"', '') END AS [EngTest]
, CASE WHEN [EngTestStatus] <> 'null' THEN REPLACE([EngTestStatus], '"', '') END AS [EngTestStatus]
, CASE WHEN [EngBall100] <> 'null' THEN REPLACE([EngBall100], ',', '.') END AS [EngBall100]
, CASE WHEN [EngPTName] <> 'null' THEN REPLACE([EngPTName], '"', '') END AS [EngPTName]
, CASE WHEN [EngPTRegName] <> 'null' THEN REPLACE([EngPTRegName], '"', '') END AS [EngPTRegName]
, CASE WHEN [EngPTAreaName] <> 'null' THEN REPLACE([EngPTAreaName], '"', '') END AS [EngPTAreaName]
, CASE WHEN [EngPTTerName] <> 'null' THEN REPLACE([EngPTTerName], '"', '') END AS [EngPTTerName]
, CASE WHEN [FrTest] <> 'null' THEN REPLACE([FrTest], '"', '') END AS [FrTest]
, CASE WHEN [FrTestStatus] <> 'null' THEN REPLACE([FrTestStatus], '"', '') END AS [FrTestStatus]
, CASE WHEN [FrBall100] <> 'null' THEN REPLACE([FrBall100], ',', '.') END AS [FrBall100]
, CASE WHEN [FrPTName] <> 'null' THEN REPLACE([FrPTName], '"', '') END AS [FrPTName]
, CASE WHEN [FrPTRegName] <> 'null' THEN REPLACE([FrPTRegName], '"', '') END AS [FrPTRegName]
, CASE WHEN [FrPTAreaName] <> 'null' THEN REPLACE([FrPTAreaName], '"', '') END AS [FrPTAreaName]
, CASE WHEN [FrPTTerName] <> 'null' THEN REPLACE([FrPTTerName], '"', '') END AS [FrPTTerName]
, CASE WHEN [DeuTest] <> 'null' THEN REPLACE([DeuTest], '"', '') END AS [DeuTest]
, CASE WHEN [DeuTestStatus] <> 'null' THEN REPLACE([DeuTestStatus], '"', '') END AS [DeuTestStatus]
, CASE WHEN [DeuBall100] <> 'null' THEN REPLACE([DeuBall100], ',', '.') END AS [DeuBall100]
, CASE WHEN [DeuPTName] <> 'null' THEN REPLACE([DeuPTName], '"', '') END AS [DeuPTName]
, CASE WHEN [DeuPTRegName] <> 'null' THEN REPLACE([DeuPTRegName], '"', '') END AS [DeuPTRegName]
, CASE WHEN [DeuPTAreaName] <> 'null' THEN REPLACE([DeuPTAreaName], '"', '') END AS [DeuPTAreaName]
, CASE WHEN [DeuPTTerName] <> 'null' THEN REPLACE([DeuPTTerName], '"', '') END AS [DeuPTTerName]
, CASE WHEN [SpTest] <> 'null' THEN REPLACE([SpTest], '"', '') END AS [SpTest]
, CASE WHEN [SpTestStatus] <> 'null' THEN REPLACE([SpTestStatus], '"', '') END AS [SpTestStatus]
, CASE WHEN [SpBall100] <> 'null' THEN REPLACE([SpBall100], ',', '.') END AS [SpBall100]
, CASE WHEN [SpPTName] <> 'null' THEN REPLACE([SpPTName], '"', '') END AS [SpPTName]
, CASE WHEN [SpPTRegName] <> 'null' THEN REPLACE([SpPTRegName], '"', '') END AS [SpPTRegName]
, CASE WHEN [SpPTAreaName] <> 'null' THEN REPLACE([SpPTAreaName], '"', '') END AS [SpPTAreaName]
, CASE WHEN [SpPTTerName] <> 'null' THEN REPLACE([SpPTTerName], '"', '') END AS [SpPTTerName]
, CASE WHEN [RusTest] <> 'null' THEN REPLACE([RusTest], '"', '') END AS [RusTest]
, CASE WHEN [RusTestStatus] <> 'null' THEN REPLACE([RusTestStatus], '"', '') END AS [RusTestStatus]
, CASE WHEN [RusBall100] <> 'null' THEN REPLACE([RusBall100], ',', '.') END AS [RusBall100]
, CASE WHEN [RusPTName] <> 'null' THEN REPLACE([RusPTName], '"', '') END AS [RusPTName]
, CASE WHEN [RusPTRegName] <> 'null' THEN REPLACE([RusPTRegName], '"', '') END AS [RusPTRegName]
, CASE WHEN [RusPTAreaName] <> 'null' THEN REPLACE([RusPTAreaName], '"', '') END AS [RusPTAreaName]
, CASE WHEN [RusPTTerName] <> 'null' THEN REPLACE([RusPTTerName], '"', '') END AS [RusPTTerName]
 FROM [OpenData2016_CSV]
 
GO

--TRUNCATE TABLE [dbo].OpenData2016_CSV
GO

TRUNCATE TABLE [dbo].[PersonScores]
GO

INSERT INTO [dbo].[PersonScores]   
SELECT  OutID
, SexTypeName
, 2016 - try_convert(smallint, Birth, NULL) AS Age
, (CASE WHEN RegTypeName = N'Випускник загальноосвітнього навчального закладу 2016 року' THEN 1 ELSE 0 END) AS IsFromSchool
, (CASE WHEN CHARINDEX( N'м.Київ', EOAreaName) > 0 THEN N' столица' WHEN CHARINDEX( N'м.', EOAreaName) > 0 THEN N'обл. центр' 
		WHEN CHARINDEX( N'м.', EOTerName) > 0 THEN N'райцентр' WHEN EOTerName=N'null' THEN NULL ELSE N'село' END) AS TerType
, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EOName, N'навчально-виховний комплекс', N'НВК'),
		 N'спеціалізована школа', N'СШ'), N'загальноосвітня школа', N'ЗОШ'), N'дошкільний навчальний заклад', N'ДНЗ'),
		 N'комунальний заклад', N'КЗ'), N'ступенів', N'ст.') AS EOName
, REPLACE(EORegName, N'область', N'обл.')
	 + CASE WHEN EOAreaName = EORegName THEN N'' ELSE ', ' + REPLACE(EOAreaName, N'район', N'р-н') END 
	 AS EORegName
, UkrBall100 AS Ukr
, HistBall100 AS Hist
, MathBall100 AS Math
, PhysBall100 AS Phys
, ChemBall100 AS Chem
, BioBall100 AS Bio
, GeoBall100 AS Geo
, EngBall100 AS Eng
, FrBall100 AS Fr
, DeuBall100 AS Deu
, SpBall100 AS Sp
, RusBall100 AS Rus
FROM            dbo.OpenData2016

GO

SELECT TOP 1000 *
  FROM [dbo].[SchoolRating]
