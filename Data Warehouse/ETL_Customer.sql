USE SalonDW
GO

IF (OBJECT_ID('vETLDimCustomer') IS NOT NULL) DROP VIEW vETLDimCustomer;
GO
CREATE VIEW vETLDimCustomer
AS 
SELECT
	Name_and_Surname = CAST(t1.Name + ' ' + t1.Surname AS VARCHAR(100))
FROM BSSystem.dbo.Customer as t1
GO

MERGE INTO Customer AS TT
	USING vETLDimCustomer AS ST
		ON TT.Name_and_Surname = ST.Name_and_Surname
			WHEN NOT MATCHED
				THEN
					INSERT
					VALUES (
					ST.Name_and_Surname
					)
			WHEN NOT MATCHED BY SOURCE
				THEN
					DELETE;

DROP VIEW vETLDimCustomer