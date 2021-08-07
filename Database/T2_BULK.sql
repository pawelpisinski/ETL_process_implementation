USE BSSystem
GO

BULK INSERT Appointment
FROM '\data\T2_Appointment.csv'
WITH
(
ROWTERMINATOR = '\n',
FIELDTERMINATOR = ',',
FIRSTROW = 2
)

BULK INSERT Cosmetic_Sale
FROM '\data\T2_Cosmetic_Sale.csv'
WITH
(
ROWTERMINATOR = '\n',
FIELDTERMINATOR = ',',
FIRSTROW = 2
)

BULK INSERT Customer
FROM '\data\T2_Customer.csv'
WITH
(
ROWTERMINATOR = '\n',
FIELDTERMINATOR = ',',
FIRSTROW = 2
)

BULK INSERT Employee
FROM '\data\T2_Employee.csv'
WITH
(
ROWTERMINATOR = '\n',
FIELDTERMINATOR = ',',
FIRSTROW = 2
)

BULK INSERT Service_Sale
FROM '\data\T2_Service_Sale.csv'
WITH
(
ROWTERMINATOR = '\n',
FIELDTERMINATOR = ',',
FIRSTROW = 2
)

BULK INSERT Bill
FROM '\data\T2_Bill.csv'
WITH
(
ROWTERMINATOR = '\n',
FIELDTERMINATOR = ',',
FIRSTROW = 2
)

BULK INSERT Beauty_Salon
FROM '\data\T2_Beauty_Salon.csv'
WITH
(
ROWTERMINATOR = '\n',
FIELDTERMINATOR = ',',
FIRSTROW = 2
)


