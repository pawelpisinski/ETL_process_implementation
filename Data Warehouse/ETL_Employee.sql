USE SalonDW
GO

IF (OBJECT_ID('vETLDimEmployee') IS NOT NULL) DROP VIEW vETLDimEmployee;
GO
CREATE VIEW vETLDimEmployee
AS
SELECT 
	t1.PESEL,
	Name_and_Surname = CAST(t1.Name + ' ' + t1.Surname AS VARCHAR(100)),
	Position = t1.Position,
	CASE
		WHEN DATEDIFF(year, t1.[Start of work], ISNULL(t1.[End of work], CURRENT_TIMESTAMP)) <= 1 THEN 'up to one year'
		WHEN DATEDIFF(year, t1.[Start of work], ISNULL(t1.[End of work], CURRENT_TIMESTAMP)) BETWEEN 1 AND 5 THEN 'between one and five years'
		ELSE 'more than five years'
	END AS Work_experience,
	ID_Beauty_Salon = t3.Salon_ID,
	CASE
		WHEN DATEDIFF(year, t1.BirthDate, CURRENT_TIMESTAMP) BETWEEN 17 AND 29 THEN 'young'
		WHEN DATEDIFF(year, t1.BirthDate, CURRENT_TIMESTAMP) BETWEEN 30 AND 45 THEN 'mid age'
		WHEN DATEDIFF(year, t1.BirthDate, CURRENT_TIMESTAMP) BETWEEN 46 AND 60 THEN 'old'
	END AS Age
	FROM BSSystem.dbo.Employee AS t1
	JOIN BSSystem.dbo.Beauty_Salon AS t2 ON t1.FK_Salon_ID = t2.Salon_ID
	JOIN dbo.Beauty_Salon AS t3 ON t2.Name = t3.Name 
		AND t3.City = RIGHT(t2.Address, 24) 
		AND t3.Street = LEFT(t2.Address, 25)
GO

MERGE INTO Employee AS TT
	USING vETLDimEmployee AS ST
		ON TT.Name_and_Surname = ST.Name_and_Surname
			WHEN NOT MATCHED
				THEN
					INSERT VALUES (
					ST.Name_and_Surname,
					ST.Position,
					ST.Work_experience,
					1,
					ST.ID_Beauty_Salon,
					ST.Age
					)
			WHEN MATCHED
				AND (ST.Age <> TT.Age
				OR ST.Position <> TT.Position
				OR ST.Work_experience <> TT.Work_experience
				OR ST.ID_Beauty_Salon <> TT.ID_Beauty_Salon)
			THEN
				UPDATE
				SET TT.isCurrent = 0
			WHEN NOT MATCHED BY SOURCE
			THEN
				UPDATE
				SET TT.IsCurrent = 0; 

INSERT INTO Employee (
	Name_and_Surname, 
	Position, 
	Work_experience, 
	isCurrent, 
	ID_Beauty_Salon, 
	Age
	)
	SELECT 
		Name_and_Surname, 
		Position, 
		Work_experience, 
		1,  
		ID_Beauty_Salon, 
		Age 
		FROM vETLDimEmployee


DROP VIEW vETLDimEmployee

