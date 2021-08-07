USE SalonDW
GO

IF (OBJECT_ID('vETLFServiceSale') IS NOT NULL) DROP VIEW vETLFServiceSale; 
GO
CREATE VIEW vETLFServiceSale 
AS
	SELECT 
		  Price = ST1.Price,	
		  Amount = ST1.Amount,
		  ID_Time = dbo.TimeIndex(ST2.Date),
		  ID_Date = SD.Date_ID,
		  ID_Service = t2.Service_ID,
		  ID_Receptionist = t4.Employee_ID,
		  ID_Beautician = t3.Employee_ID,
		  ID_Customer = t1.Customer_ID
	FROM BSSystem.dbo.Service_Sale AS ST1 
	JOIN BSSystem.dbo.Bill AS ST2 ON ST1.FK_Bill_ID = ST2.Bill_ID
	JOIN dbo.Date AS SD ON CONVERT(VARCHAR(10), SD.Date, 111) = CONVERT(VARCHAR(10), ST2.Date, 111)
	JOIN BSSystem.dbo.Customer AS ST3 ON ST2.FK_Customer_ID = ST3.Customer_ID
	JOIN dbo.Customer AS t1 ON t1.Name_and_Surname = CAST(ST3.Name + ' ' + ST3.Surname AS VARCHAR(100))
	JOIN BSSystem.dbo.Service AS ST4 ON ST1.FK_Service_ID = ST4.Service_ID
	JOIN dbo.Service AS t2 ON ST4.Name = t2.Name 
		AND t2.Duration = 
		CASE
			WHEN ST4.Duration <= 30 THEN 'less than 30 min'
			WHEN ST4.Duration > 30 AND ST4.Duration < 60 THEN 'between 30 min and 1 hour'
			ELSE 'more than 1 hour' 
		END
	JOIN BSSystem.dbo.Employee AS ST5 ON ST1.FK_Employee_ID = ST5.Employee_ID
	JOIN dbo.Employee AS t3 ON t3.Name_and_Surname = CAST(ST5.Name + ' ' + ST5.Surname AS VARCHAR(100))
		AND t3.isCurrent = 1
	JOIN BSSystem.dbo.Employee AS ST6 ON ST2.FK_Employee_ID = ST6.Employee_ID
	JOIN dbo.Employee AS t4 ON t4.Name_and_Surname = CAST(ST6.Name + ' ' + ST6.Surname AS VARCHAR(100))
		AND t4.isCurrent = 1
GO

MERGE INTO Service_Sale AS TT
	USING vETLFServiceSale AS ST
		ON
			TT.ID_Time = ST.ID_Time
		AND TT.ID_Date = ST.ID_Date
		AND TT.ID_Service = ST.ID_Service
		AND TT.ID_Receptionist = ST.ID_Receptionist
		AND TT.ID_Beautician = ST.ID_Beautician
		AND TT.ID_Customer = ST.ID_Customer
			WHEN NOT MATCHED
				THEN
					INSERT VALUES (
					ST.Price,
					ST.Amount,
					ST.ID_Time,
					ST.ID_Date,
					ST.ID_Service,
					ST.ID_Receptionist,
					ST.ID_Beautician,
					ST.ID_Customer
					);
					
DROP VIEW vETLFServiceSale
