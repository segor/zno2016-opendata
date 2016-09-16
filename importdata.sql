USE [zno2016]
GO

TRUNCATE TABLE [dbo].OpenData2016
GO
BULK INSERT OpenData2016
	-- !!! SET PATH TO CSV FILE HERE: 	
    FROM '%USERPROFILE%\Downloads\OpenDataZNO2016\OpenData2016.csv'
    WITH
    (
    FIRSTROW = 2,
	CODEPAGE = '1251',
    FIELDTERMINATOR = ';',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
    )
GO

TRUNCATE TABLE [dbo].[PersonScores]
INSERT INTO [dbo].[PersonScores]   
SELECT  REPLACE(OutID, '"', '') AS OutID
, REPLACE(SexTypeName, '"', '') AS SexTypeName
, 2016 - try_convert(smallint, REPLACE(Birth, '"', ''), NULL) AS Age
, (CASE WHEN RegTypeName = N'"Випускник загальноосвітнього навчального закладу 2016 року"' THEN 1 ELSE 0 END) AS IsFromSchool
, (CASE WHEN CHARINDEX( N'м.Київ', EOAreaName) > 0 THEN N' столица' WHEN CHARINDEX( N'м.', EOAreaName) > 0 THEN N'обл. центр' 
		WHEN CHARINDEX( N'м.', EOTerName) > 0 THEN N'райцентр' WHEN EOTerName=N'null' THEN NULL ELSE N'село' END) AS TerType
, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(EOName, '"', ''), N'навчально-виховний комплекс', N'НВК'),
		 N'спеціалізована школа', N'СШ'), N'загальноосвітня школа', N'ЗОШ'), N'дошкільний навчальний заклад', N'ДНЗ'),
		 N'комунальний заклад', N'КЗ'), N'ступенів', N'ст.') AS EOName
, REPLACE(REPLACE(EORegName, '"', ''), N'область', N'обл.')
	 + CASE WHEN EOAreaName = EORegName THEN N'' ELSE ', ' + REPLACE(REPLACE(EOAreaName, '"', ''), N'район', N'р-н') END 
	 AS EORegName
, try_convert(decimal, REPLACE(UkrBall100, ',0', ''), NULL) AS Ukr
, try_convert(decimal, REPLACE(HistBall100, ',0', ''), NULL) AS Hist
, try_convert(decimal, REPLACE(MathBall100, ',0', ''), NULL) AS Math
, try_convert(decimal, REPLACE(PhysBall100, ',0', ''), NULL) AS Phys
, try_convert(decimal, REPLACE(ChemBall100, ',0', ''), NULL) AS Chem
, try_convert(decimal, REPLACE(BioBall100, ',0', ''), NULL) AS Bio
, try_convert(decimal, REPLACE(GeoBall100, ',0', ''), NULL) AS Geo
, try_convert(decimal, REPLACE(EngBall100, ',0', ''), NULL) AS Eng
, try_convert(decimal, REPLACE(FrBall100, ',0', ''), NULL) AS Fr
, try_convert(decimal, REPLACE(DeuBall100, ',0', ''), NULL) AS Deu
, try_convert(decimal, REPLACE(SpBall100, ',0', ''), NULL) AS Sp
, try_convert(decimal, REPLACE(RusBall100, ',0', ''), NULL) AS Rus
FROM            dbo.OpenData2016

GO

SELECT TOP 1000 *
  FROM [dbo].[SchoolRating]
