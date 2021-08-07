USE SalonDW
GO

IF (OBJECT_ID('vETLDimBeautySalon') IS NOT NULL) DROP VIEW vETLDimBeautySalon; 
GO
CREATE VIEW vETLDimBeautySalon
AS 
SELECT
	t1.Salon_ID,
	t1.Name,
	RIGHT(t1.Address, 24) City,
	LEFT(t1.Address, 25) Street,
	CASE
		WHEN COUNT(t2.Employee_ID) <= 10 THEN 'small'
		WHEN COUNT(t2.Employee_ID) BETWEEN 11 AND 26 THEN 'average'
		ELSE 'big'
	END AS [Salon_Size]
FROM BSSystem.dbo.Beauty_Salon AS t1
JOIN BSSystem.dbo.Employee AS t2 ON t1.Salon_ID = t2.FK_Salon_ID
GROUP BY
	t1.Salon_ID,
	t1.Name,
	t1.Address
GO 

MERGE INTO [SalonDW].dbo.[Beauty_salon] AS TT
	USING vETLDimBeautySalon AS ST
		ON TT.Name = ST.Name
		AND TT.City = ST.City
		AND TT.Street = ST.Street
			WHEN NOT MATCHED
				THEN
					INSERT Values (
					ST.Name,
					ST.City,
					ST.Street,
					ST.Salon_Size
					)
			WHEN MATCHED
				AND (ST.Salon_Size <> TT.Salon_Size)
			THEN
				UPDATE
				SET TT.Salon_Size = ST.Salon_Size;

DROP VIEW vETLDimBeautySalon 

