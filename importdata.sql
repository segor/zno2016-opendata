USE [zno2016]
GO

TRUNCATE TABLE [dbo].OpenData2016_tmp
GO

TRUNCATE TABLE [dbo].OpenData2016
GO

BULK INSERT OpenData2016_tmp
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
 WITH(TABLOCK)
SELECT 
	dbo.clean_str(OutID) AS OutID,
	dbo.clean_str(Birth) AS Birth,
	dbo.clean_str(SexTypeName) AS SexTypeName,
	dbo.clean_str(Regname) AS Regname,
	dbo.clean_str(AreaName) AS AreaName,
	dbo.clean_str(TerName) AS TerName,
	dbo.clean_str(RegTypeName) AS RegTypeName,
	dbo.clean_str(EOName) AS EOName,
	dbo.clean_str(EOTypeName) AS EOTypeName,
	dbo.clean_str(EORegName) AS EORegName,
	dbo.clean_str(EOAreaName) AS EOAreaName,
	dbo.clean_str(EOTerName) AS EOTerName,
	dbo.clean_str(EOParent) AS EOParent,
	dbo.clean_str(UkrTest) AS UkrTest,
	dbo.clean_str(UkrTestStatus) AS UkrTestStatus,
	dbo.clean_num(UkrBall100) AS UkrBall100,
	dbo.clean_str(UkrBall12) AS UkrBall12,
	dbo.clean_str(UkrPTName) AS UkrPTName,
	dbo.clean_str(UkrPTRegName) AS UkrPTRegName,
	dbo.clean_str(UkrPTAreaName) AS UkrPTAreaName,
	dbo.clean_str(UkrPTTerName) AS UkrPTTerName,
	dbo.clean_str(HistTest) AS HistTest,
	dbo.clean_str(HistLang) AS HistLang,
	dbo.clean_str(HistTestStatus) AS HistTestStatus,
	dbo.clean_num(HistBall100) AS HistBall100,
	dbo.clean_str(HistBall12) AS HistBall12,
	dbo.clean_str(HistPTName) AS HistPTName,
	dbo.clean_str(HistPTRegName) AS HistPTRegName,
	dbo.clean_str(HistPTAreaName) AS HistPTAreaName,
	dbo.clean_str(HistPTTerName) AS HistPTTerName,
	dbo.clean_str(MathTest) AS MathTest,
	dbo.clean_str(MathLang) AS MathLang,
	dbo.clean_str(MathTestStatus) AS MathTestStatus,
	dbo.clean_num(MathBall100) AS MathBall100,
	dbo.clean_str(MathBall12) AS MathBall12,
	dbo.clean_str(MathPTName) AS MathPTName,
	dbo.clean_str(MathPTRegName) AS MathPTRegName,
	dbo.clean_str(MathPTAreaName) AS MathPTAreaName,
	dbo.clean_str(MathPTTerName) AS MathPTTerName,
	dbo.clean_str(PhysTest) AS PhysTest,
	dbo.clean_str(PhysLang) AS PhysLang,
	dbo.clean_str(PhysTestStatus) AS PhysTestStatus,
	dbo.clean_num(PhysBall100) AS PhysBall100,
	dbo.clean_str(PhysPTName) AS PhysPTName,
	dbo.clean_str(PhysPTRegName) AS PhysPTRegName,
	dbo.clean_str(PhysPTAreaName) AS PhysPTAreaName,
	dbo.clean_str(PhysPTTerName) AS PhysPTTerName,
	dbo.clean_str(ChemTest) AS ChemTest,
	dbo.clean_str(ChemLang) AS ChemLang,
	dbo.clean_str(ChemTestStatus) AS ChemTestStatus,
	dbo.clean_num(ChemBall100) AS ChemBall100,
	dbo.clean_str(ChemPTName) AS ChemPTName,
	dbo.clean_str(ChemPTRegName) AS ChemPTRegName,
	dbo.clean_str(ChemPTAreaName) AS ChemPTAreaName,
	dbo.clean_str(ChemPTTerName) AS ChemPTTerName,
	dbo.clean_str(BioTest) AS BioTest,
	dbo.clean_str(BioLang) AS BioLang,
	dbo.clean_str(BioTestStatus) AS BioTestStatus,
	dbo.clean_num(BioBall100) AS BioBall100,
	dbo.clean_str(BioPTName) AS BioPTName,
	dbo.clean_str(BioPTRegName) AS BioPTRegName,
	dbo.clean_str(BioPTAreaName) AS BioPTAreaName,
	dbo.clean_str(BioPTTerName) AS BioPTTerName,
	dbo.clean_str(GeoTest) AS GeoTest,
	dbo.clean_str(GeoLang) AS GeoLang,
	dbo.clean_str(GeoTestStatus) AS GeoTestStatus,
	dbo.clean_num(GeoBall100) AS GeoBall100,
	dbo.clean_str(GeoPTName) AS GeoPTName,
	dbo.clean_str(GeoPTRegName) AS GeoPTRegName,
	dbo.clean_str(GeoPTAreaName) AS GeoPTAreaName,
	dbo.clean_str(GeoPTTerName) AS GeoPTTerName,
	dbo.clean_str(EngTest) AS EngTest,
	dbo.clean_str(EngTestStatus) AS EngTestStatus,
	dbo.clean_num(EngBall100) AS EngBall100,
	dbo.clean_str(EngPTName) AS EngPTName,
	dbo.clean_str(EngPTRegName) AS EngPTRegName,
	dbo.clean_str(EngPTAreaName) AS EngPTAreaName,
	dbo.clean_str(EngPTTerName) AS EngPTTerName,
	dbo.clean_str(FrTest) AS FrTest,
	dbo.clean_str(FrTestStatus) AS FrTestStatus,
	dbo.clean_num(FrBall100) AS FrBall100,
	dbo.clean_str(FrPTName) AS FrPTName,
	dbo.clean_str(FrPTRegName) AS FrPTRegName,
	dbo.clean_str(FrPTAreaName) AS FrPTAreaName,
	dbo.clean_str(FrPTTerName) AS FrPTTerName,
	dbo.clean_str(DeuTest) AS DeuTest,
	dbo.clean_str(DeuTestStatus) AS DeuTestStatus,
	dbo.clean_num(DeuBall100) AS DeuBall100,
	dbo.clean_str(DeuPTName) AS DeuPTName,
	dbo.clean_str(DeuPTRegName) AS DeuPTRegName,
	dbo.clean_str(DeuPTAreaName) AS DeuPTAreaName,
	dbo.clean_str(DeuPTTerName) AS DeuPTTerName,
	dbo.clean_str(SpTest) AS SpTest,
	dbo.clean_str(SpTestStatus) AS SpTestStatus,
	dbo.clean_num(SpBall100) AS SpBall100,
	dbo.clean_str(SpPTName) AS SpPTName,
	dbo.clean_str(SpPTRegName) AS SpPTRegName,
	dbo.clean_str(SpPTAreaName) AS SpPTAreaName,
	dbo.clean_str(SpPTTerName) AS SpPTTerName,
	dbo.clean_str(RusTest) AS RusTest,
	dbo.clean_str(RusTestStatus) AS RusTestStatus,
	dbo.clean_num(RusBall100) AS RusBall100,
	dbo.clean_str(RusPTName) AS RusPTName,
	dbo.clean_str(RusPTRegName) AS RusPTRegName,
	dbo.clean_str(RusPTAreaName) AS RusPTAreaName,
	dbo.clean_str(RusPTTerName) AS RusPTTerName
FROM [OpenData2016_tmp]
 
GO

TRUNCATE TABLE [dbo].OpenData2016_tmp
GO

TRUNCATE TABLE [dbo].[PersonScores]
GO

INSERT INTO [dbo].[PersonScores] 
 WITH(TABLOCK)  
SELECT  
	OutID
	, SexTypeName
	, 2016 - try_convert(smallint, Birth, NULL) AS Age
	, (CASE WHEN CHARINDEX( N'м.Київ', EOAreaName) > 0 THEN N' столица' WHEN CHARINDEX( N'м.', EOAreaName) > 0 THEN N'обл. центр' 
			WHEN CHARINDEX( N'м.', EOTerName) > 0 THEN N'райцентр' WHEN EOTerName=N'null' THEN NULL ELSE N'село' END) AS TerType
	, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EOName, N'навчально-виховний комплекс', N'НВК'),
			 N'спеціалізована школа', N'СШ'), N'загальноосвітня школа', N'ЗОШ'), N'дошкільний навчальний заклад', N'ДНЗ'),
			 N'комунальний заклад', N'КЗ'), N'ступенів', N'ст.') AS EOName
	, REPLACE(EORegName, N'область', N'обл.')
		 + CASE WHEN EOAreaName = EORegName THEN N'' ELSE ', ' + REPLACE(EOAreaName, N'район', N'р-н') END 
		 AS EORegName
	, dbo.get_score(UkrTestStatus, UkrBall100, UkrBall12) AS Ukr
	, dbo.get_score(HistTestStatus, HistBall100, HistBall12) AS Hist
	, dbo.get_score(MathTestStatus, MathBall100, MathBall12) AS Math
	, dbo.get_score(PhysTestStatus, PhysBall100, NULL) AS Phys
	, dbo.get_score(ChemTestStatus, ChemBall100, NULL) AS Chem
	, dbo.get_score(BioTestStatus, BioBall100, NULL) AS Bio
	, dbo.get_score(GeoTestStatus, GeoBall100, NULL) AS Geo
	, dbo.get_score(EngTestStatus, EngBall100, NULL) AS Eng
	, dbo.get_score(FrTestStatus, FrBall100, NULL) AS Fr
	, dbo.get_score(DeuTestStatus, DeuBall100, NULL) AS Deu
	, dbo.get_score(SpTestStatus, SpBall100, NULL) AS Sp
	, dbo.get_score(RusTestStatus, RusBall100, NULL) AS Rus
FROM            dbo.OpenData2016
WHERE	(UkrTestStatus = N'Не склав' OR UkrTestStatus = N'Отримав результат' OR 
		HistTestStatus = N'Не склав' OR HistTestStatus = N'Отримав результат' OR
		MathTestStatus = N'Не склав' OR MathTestStatus = N'Отримав результат' OR
		PhysTestStatus = N'Не склав' OR PhysTestStatus = N'Отримав результат' OR
		ChemTestStatus = N'Не склав' OR ChemTestStatus = N'Отримав результат' OR
		BioTestStatus = N'Не склав' OR BioTestStatus = N'Отримав результат' OR
		GeoTestStatus = N'Не склав' OR GeoTestStatus = N'Отримав результат' OR
		EngTestStatus = N'Не склав' OR EngTestStatus = N'Отримав результат' OR
		FrTestStatus = N'Не склав' OR FrTestStatus = N'Отримав результат' OR
		DeuTestStatus = N'Не склав' OR DeuTestStatus = N'Отримав результат' OR
		SpTestStatus = N'Не склав' OR SpTestStatus = N'Отримав результат' OR
		RusTestStatus = N'Не склав' OR RusTestStatus = N'Отримав результат')
		AND RegTypeName = N'Випускник загальноосвітнього навчального закладу 2016 року'

GO

SELECT TOP 1000 *
  FROM [dbo].[SchoolRating]
