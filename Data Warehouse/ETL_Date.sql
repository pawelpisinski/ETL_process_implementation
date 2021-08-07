USE SalonDW
GO

DECLARE @StartDate DATE;
DECLARE @EndDate DATE;

SET @StartDate = '2019-01-01';
SET @EndDate = '2021-12-31';

DECLARE @DateInProcess DATE = @StartDate

WHILE @DateInProcess <= @EndDate
	BEGIN
		INSERT INTO Date
		( 
		  [Date],
		  [Year],
		  [Month],
		  [Month_number],
		  [Season],
		  [Season_number],
		  [Holiday],
		  [Vacation]
		)
		VALUES
		(
		  @DateInProcess,
		  CAST( YEAR(@DateInProcess) AS VARCHAR(4)),
		  CAST( DATENAME(month, @DateInProcess) AS VARCHAR(10)),
		  CAST( MONTH(@DateInProcess) AS INT),
		  CASE
		      WHEN (CAST(MONTH(@DateInProcess) AS INT) = 3 AND CAST(DAY(@DateInProcess) AS INT) >= 21) OR
				   CAST(MONTH(@DateInProcess) AS INT) = 4 OR
				   CAST(MONTH(@DateInProcess) AS INT) = 5 OR
				   (CAST(MONTH(@DateInProcess) AS INT) = 6 AND CAST(DAY(@DateInProcess) AS INT) <= 21)
			  THEN 'Spring'
			  WHEN (CAST(MONTH(@DateInProcess) AS INT) = 6 AND CAST(DAY(@DateInProcess) AS INT) >= 22) OR
				   CAST(MONTH(@DateInProcess) AS INT) = 7 OR
				   CAST(MONTH(@DateInProcess) AS INT) = 8 OR
				   (CAST(MONTH(@DateInProcess) AS INT) = 9 AND CAST(DAY(@DateInProcess) AS INT) <= 22)
			  THEN 'Summer'
			  WHEN (CAST(MONTH(@DateInProcess) AS INT) = 9 AND CAST(DAY(@DateInProcess) AS INT) >= 23) OR
				   CAST(MONTH(@DateInProcess) AS INT) = 10 OR
				   CAST(MONTH(@DateInProcess) AS INT) = 11 OR
				   (CAST(MONTH(@DateInProcess) AS INT) = 12 AND CAST(DAY(@DateInProcess) AS INT) <= 21)
			  THEN 'Autumn'
			  ELSE 'Winter'
		  END,
		  CASE
		      WHEN (CAST(MONTH(@DateInProcess) AS INT) = 3 AND CAST(DAY(@DateInProcess) AS INT) >= 21) OR
				   CAST(MONTH(@DateInProcess) AS INT) = 4 OR
				   CAST(MONTH(@DateInProcess) AS INT) = 5 OR
				   (CAST(MONTH(@DateInProcess) AS INT) = 6 AND CAST(DAY(@DateInProcess) AS INT) <= 21)
			  THEN 1
			  WHEN (CAST(MONTH(@DateInProcess) AS INT) = 6 AND CAST(DAY(@DateInProcess) AS INT) >= 22) OR
				   CAST(MONTH(@DateInProcess) AS INT) = 7 OR
				   CAST(MONTH(@DateInProcess) AS INT) = 8 OR
				   (CAST(MONTH(@DateInProcess) AS INT) = 9 AND CAST(DAY(@DateInProcess) AS INT) <= 22)
			  THEN 2
			  WHEN (CAST(MONTH(@DateInProcess) AS INT) = 9 AND CAST(DAY(@DateInProcess) AS INT) >= 23) OR
				   CAST(MONTH(@DateInProcess) AS INT) = 10 OR
				   CAST(MONTH(@DateInProcess) AS INT) = 11 OR
				   (CAST(MONTH(@DateInProcess) AS INT) = 12 AND CAST(DAY(@DateInProcess) AS INT) <= 21)
			  THEN 3
			  ELSE 4
		  END,
		  CASE
			  --ADD Easter
		      WHEN CAST(MONTH(@DateInProcess) AS INT) = 12 AND CAST(DAY(@DateInProcess) AS INT) = 30
			  THEN 'New Year’s Eve'
			  WHEN CAST(MONTH(@DateInProcess) AS INT) = 12 AND CAST(DAY(@DateInProcess) AS INT) = 25
			  THEN 'Christmas'
			  WHEN CAST(MONTH(@DateInProcess) AS INT) = 3 AND CAST(DAY(@DateInProcess) AS INT) = 8
			  THEN 'Woman’s Day'
			  WHEN CAST(MONTH(@DateInProcess) AS INT) = 3 AND CAST(DAY(@DateInProcess) AS INT) = 10
			  THEN 'Man’s Day'
			  WHEN CAST(MONTH(@DateInProcess) AS INT) = 6 AND CAST(DAY(@DateInProcess) AS INT) = 1
			  THEN 'Child’s Day'
			  WHEN CAST(MONTH(@DateInProcess) AS INT) = 5 AND CAST(DAY(@DateInProcess) AS INT) = 26 
			  THEN 'Mother’s Day'
			  WHEN CAST(MONTH(@DateInProcess) AS INT) = 6 AND CAST(DAY(@DateInProcess) AS INT) = 23
			  THEN 'Father’s Day'
			  ELSE NULL
		  END,
		  CASE
		      WHEN CAST(MONTH(@DateInProcess) AS INT) = 5 AND 
				   CAST(DAY(@DateInProcess) AS INT) >=1 AND CAST(DAY(@DateInProcess) AS INT) <=3
			  THEN 'May’s break'
			  ELSE NULL
		  END
		);
		SET @DateInProcess = DATEADD(d, 1, @DateInProcess);
	END;


--ADDING Easter, Summer break, Winter break, Spring break, Thanksgiving
--FOR 2019
--Summer break
SET @StartDate = '2019-06-20';
SET @EndDate = '2019-08-31';
SET @DateInProcess = @StartDate;

WHILE @DateInProcess <= @EndDate
	BEGIN
		UPDATE Date
			SET Vacation = 'Summer break'
			WHERE Date.Date = @DateInProcess
		SET @DateInProcess = DATEADD(d, 1, @DateInProcess);
	END;

--Winter break
SET @StartDate = '2019-01-14';
SET @EndDate = '2019-02-24';
SET @DateInProcess = @StartDate;

WHILE @DateInProcess <=@EndDate
	BEGIN
		UPDATE Date
			SET Vacation = 'Winter break'
			WHERE Date.Date = @DateInProcess
		SET @DateInProcess = DATEADD(d, 1, @DateInProcess);
	END;

--Spring break
SET @StartDate = '2019-04-18';
SET @EndDate = '2019-04-23';
SET @DateInProcess = @StartDate;

WHILE @DateInProcess <=@EndDate
	BEGIN
		UPDATE Date
			SET Vacation = 'Spring break'
			WHERE Date.Date = @DateInProcess
		SET @DateInProcess = DATEADD(d, 1, @DateInProcess);
	END;

--Easter
UPDATE Date 
	SET Holiday = 'Easter'
	WHERE Date.Date = '2019-04-21'

--Thanksgiving
UPDATE Date 
	SET Holiday = 'Thanksgiving'
	WHERE Date.Date = '2019-11-28'




--FOR 2020
--Summer break
SET @StartDate = '2020-06-27';
SET @EndDate = '2020-08-31';
SET @DateInProcess = @StartDate;

WHILE @DateInProcess <=@EndDate
	BEGIN
		UPDATE Date
			SET Vacation = 'Summer break'
			WHERE Date.Date = @DateInProcess
		SET @DateInProcess = DATEADD(d, 1, @DateInProcess);
	END;

--Winter break
SET @StartDate = '2020-01-12';
SET @EndDate = '2020-02-23';
SET @DateInProcess = @StartDate;

WHILE @DateInProcess <=@EndDate
	BEGIN
		UPDATE Date
			SET Vacation = 'Winter break'
			WHERE Date.Date = @DateInProcess
		SET @DateInProcess = DATEADD(d, 1, @DateInProcess);
	END;

--Spring break
SET @StartDate = '2020-04-09';
SET @EndDate = '2020-04-14';
SET @DateInProcess = @StartDate;

WHILE @DateInProcess <=@EndDate
	BEGIN
		UPDATE Date
			SET Vacation = 'Spring break'
			WHERE Date.Date = @DateInProcess
		SET @DateInProcess = DATEADD(d, 1, @DateInProcess);
	END;

--Easter
UPDATE Date 
	SET Holiday = 'Easter'
	WHERE Date.Date = '2020-04-12'

--Thanksgiving
UPDATE Date 
	SET Holiday = 'Thanksgiving'
	WHERE Date.Date = '2020-11-26'




--FOR 2021
--Summer break
SET @StartDate = '2021-06-26';
SET @EndDate = '2021-08-31';
SET @DateInProcess = @StartDate;

WHILE @DateInProcess <=@EndDate
	BEGIN
		UPDATE Date
			SET Vacation = 'Summer break'
			WHERE Date.Date = @DateInProcess
		SET @DateInProcess = DATEADD(d, 1, @DateInProcess);
	END;

--Winter break
SET @StartDate = '2021-01-04';
SET @EndDate = '2019-01-17';
SET @DateInProcess = @StartDate;

WHILE @DateInProcess <=@EndDate
	BEGIN
		UPDATE Date
			SET Vacation = 'Winter break'
			WHERE Date.Date = @DateInProcess
		SET @DateInProcess = DATEADD(d, 1, @DateInProcess);
	END;

--Spring break
SET @StartDate = '2021-04-01';
SET @EndDate = '2021-04-06';
SET @DateInProcess = @StartDate;

WHILE @DateInProcess <=@EndDate
	BEGIN
		UPDATE Date
			SET Vacation = 'Spring break'
			WHERE Date.Date = @DateInProcess
		SET @DateInProcess = DATEADD(d, 1, @DateInProcess);
	END;

--Easter
UPDATE Date 
	SET Holiday = 'Easter'
	WHERE Date.Date = '2021-04-04'

--Thanksgiving
UPDATE Date 
	SET Holiday = 'Thanksgiving'
	WHERE Date.Date = '2021-11-25'


