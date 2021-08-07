--DROP FUNCTION checkAppointmentNumber, PreviousBeauticianIndex, PreviousAppointmentDate, TimeIndex, DateIndex
USE SalonDW
GO

--FUNCTIONS USED FOR CALCULATING MEASURES
CREATE FUNCTION checkAppointmentNumber(@customer_id AS INT)
RETURNS INT
AS 
BEGIN 
	RETURN (
			SELECT COUNT(*) 
			FROM BSSystem.dbo.Appointment 
			WHERE FK_Customer_ID = @customer_id  
			GROUP BY FK_Customer_ID
			)
END;


CREATE FUNCTION PreviousBeauticianIndex(@customer_id AS INT)
RETURNS INT
AS
BEGIN
	RETURN (
			SELECT FK_Employee_ID 
			FROM (
				  SELECT ROW_NUMBER() OVER(ORDER BY Date DESC) AS RowNumber, FK_Employee_ID 
			      FROM BSSystem.dbo.Appointment	
				  WHERE FK_Customer_ID=@customer_id) AS tmp 
				  WHERE RowNumber = 2
			)
END;


CREATE FUNCTION PreviousAppointmentDate(@customer_id AS INT)
RETURNS DATE
AS
BEGIN
	RETURN (
			SELECT Date 
			FROM (
				  SELECT ROW_NUMBER() OVER(ORDER BY Date DESC) AS RowNumber, Date 
				  FROM BSSystem.dbo.Appointment 
				  WHERE FK_Customer_ID=@customer_id) AS tmp 
				  WHERE RowNumber = 2
			)
END;


CREATE FUNCTION TimeIndex(@date AS DATETIME)
RETURNS INT
AS
BEGIN
	RETURN (
			SELECT Time_ID 
			FROM dbo.Time 
			WHERE Hour = DATEPART(HOUR, CAST(@date AS TIME)) AND 
				  Minute = DATEPART(MINUTE, CAST(@date AS TIME))
			)
END;


CREATE FUNCTION DateIndex(@date AS DATETIME)
RETURNS INT
AS
BEGIN
	RETURN (
			SELECT Date_ID 
			FROM dbo.Date 
			WHERE Date = CAST(@date AS DATE)
			)
END;