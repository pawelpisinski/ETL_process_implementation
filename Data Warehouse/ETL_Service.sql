USE SalonDW
GO

IF (OBJECT_ID('vETLDimServices') IS NOT NULL) DROP VIEW vETLDimServices;
go
CREATE VIEW vETLDimServices
AS
SELECT DISTINCT
	Name,
	CASE
		WHEN Duration <= 30 THEN 'less than 30 min'
		WHEN Duration > 30 AND Duration < 60 THEN 'between 30 min and 1 hour'
		ELSE 'more than 1 hour'
	END AS Duration
FROM BSSystem.dbo.Service
GO

MERGE INTO [SalonDW].dbo.[Service] AS TT
	USING vETLDimServices AS ST
		ON TT.Name = ST.Name
		AND TT.Duration = ST.Duration
			WHEN NOT MATCHED
				THEN
					INSERT
					VALUES (
					ST.Name,
					ST.Duration
					)
			WHEN NOT MATCHED BY SOURCE
				THEN
					DELETE;

DROP VIEW vETLDimServices
