USE SalonDW
GO

IF (OBJECT_ID('AppointmentView') IS NOT NULL) DROP VIEW AppointmentView; 
GO
CREATE VIEW AppointmentView AS 
	SELECT 
		dbo.DateIndex(Made_Date) AS MadeDateID,
		t1.Customer_ID AS CustomerID,
		t3.Employee_ID AS BeauticianID,
		CASE
			WHEN (SELECT dbo.checkAppointmentNumber(ST1.FK_Customer_ID)) = 1
			THEN 1
			ELSE 0
		END AS First,
		CASE
			WHEN (SELECT dbo.PreviousBeauticianIndex(ST1.FK_Customer_ID)) = FK_Employee_ID
			THEN 1
			WHEN (SELECT dbo.PreviousBeauticianIndex(ST1.FK_Customer_ID)) = NULL
			THEN 0
			ELSE 0
		END AS SameBeautician,
		CASE
			WHEN (SELECT dbo.PreviousAppointmentDate(ST1.FK_Customer_ID)) = Made_Date
			THEN 1
			ELSE 0
		END AS NextAppointment,
		dbo.DateIndex(ST1.Date) AS DateID,
		dbo.TimeIndex(ST1.Date) AS TimeID,
		t2.Service_ID AS ServiceID
	FROM 
		BSSystem.dbo.Appointment AS ST1	
		JOIN BSSystem.dbo.Customer AS ST2 ON ST1.FK_Customer_ID = ST2.Customer_ID
		JOIN dbo.Customer AS t1 ON t1.Name_and_Surname = CAST(ST2.Name + ' ' + ST2.Surname AS VARCHAR(100))
		JOIN BSSystem.dbo.Service AS ST3 ON ST1.FK_Service_ID = ST3.Service_ID
		JOIN dbo.Service AS t2 ON ST3.Name = t2.Name
		AND t2.Duration = 
		CASE
			WHEN ST3.Duration <= 30 THEN 'less than 30 min'
			WHEN ST3.Duration > 30 AND ST3.Duration < 60 THEN 'between 30 min and 1 hour'
			ELSE 'more than 1 hour' 
		END
		JOIN BSSystem.dbo.Employee AS ST4 ON ST1.FK_Employee_ID = ST4.Employee_ID
		JOIN dbo.Employee AS t3 ON t3.Name_and_Surname = CAST(ST4.Name + ' ' + ST4.Surname AS VARCHAR(100))
			AND t3.isCurrent = 1
GO

MERGE INTO Appointment AS TT
	USING AppointmentView AS ST
		ON 
			TT.ID_Customer = ST.CustomerID 
		AND TT.ID_Made_Date = ST.MadeDateID
		AND TT.ID_Beautician = ST.BeauticianID
		AND TT.ID_Date = ST.DateID
		AND TT.ID_Time = ST.TimeID
		AND TT.ID_Service = ST.ServiceID
			WHEN NOT MATCHED BY TARGET 
				THEN 
					INSERT (
					ID_Customer, 
					ID_Made_Date, 
					ID_Beautician, 
					isFirst, 
					Same_beautician, 
					Next_appointment, 
					ID_Service, 
					ID_Date, 
					ID_Time)
					VALUES (
					ST.CustomerID, 
					ST.MadeDateID, 
					ST.BeauticianID, 
					First, 
					ST.SameBeautician, 
					ST.NextAppointment, 
					ST.ServiceID, 
					ST.DateID, 
					ST.TimeID
					);

DROP VIEW AppointmentView
