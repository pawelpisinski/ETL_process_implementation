USE BSSystem
GO

BULK INSERT Appointment
FROM '\data\T1_Appointment.csv'
WITH
(
ROWTERMINATOR = '\n',
FIELDTERMINATOR = ',',
FIRSTROW = 2
)

BULK INSERT Cosmetic_Sale
FROM '\data\T1_Cosmetic_Sale.csv'
WITH
(
ROWTERMINATOR = '\n',
FIELDTERMINATOR = ',',
FIRSTROW = 2
)

BULK INSERT Customer
FROM '\data\T1_Customer.csv'
WITH
(
ROWTERMINATOR = '\n',
FIELDTERMINATOR = ',',
FIRSTROW = 2
)

BULK INSERT Employee
FROM '\data\T1_Employee.csv'
WITH
(
ROWTERMINATOR = '\n',
FIELDTERMINATOR = ',',
FIRSTROW = 2
)

BULK INSERT Service_Sale
FROM '\data\T1_Service_Sale.csv'
WITH
(
ROWTERMINATOR = '\n',
FIELDTERMINATOR = ',',
FIRSTROW = 2
)

BULK INSERT Service
FROM '\data\T1_Service.csv'
WITH
(
ROWTERMINATOR = '\n',
FIELDTERMINATOR = ',',
FIRSTROW = 2
)

BULK INSERT Bill
FROM '\data\T1_Bill.csv'
WITH
(
ROWTERMINATOR = '\n',
FIELDTERMINATOR = ',',
FIRSTROW = 2
)

BULK INSERT Beauty_Salon
FROM '\data\T1_Beauty_Salon.csv'
WITH
(
ROWTERMINATOR = '\n',
FIELDTERMINATOR = ',',
FIRSTROW = 2
)

BULK INSERT Cosmetic
FROM '\data\T1_Cosmetic.csv'
WITH
(
ROWTERMINATOR = '\n',
FIELDTERMINATOR = ',',
FIRSTROW = 2
) 

