--DROP TABLE Appointment, Service_Sale, Cosmetic_Sale,Bill, Customer, Employee, Beauty_Salon, Service, Cosmetic
USE BSSystem
GO

CREATE TABLE Cosmetic (
	Cosmetic_ID INT IDENTITY (1,1) PRIMARY KEY,
	Brand VARCHAR(50),
	Name VARCHAR(100),
	Type VARCHAR(50)
 );

CREATE TABLE Service (
	Service_ID INT IDENTITY (1,1) PRIMARY KEY,
	Name VARCHAR(50),
	Description VARCHAR(250),
	Duration INT
);

CREATE TABLE Beauty_Salon (
	Salon_ID INT IDENTITY (1,1) PRIMARY KEY,
	Name VARCHAR(50),
	Opening_Date DATE,
	Address VARCHAR(100),

); 

CREATE TABLE Employee (
	Employee_ID INT IDENTITY (1,1) PRIMARY KEY,
	Name VARCHAR(50),
	Surname VARCHAR(50),
	PESEL INT,
	BirthDate DATE,
	Position VARCHAR(50),
	FK_Salon_ID INT REFERENCES Beauty_Salon(Salon_ID),
	Promotion DATETIME,
	[Start of work] DATE,
	[End of work] DATE
);

CREATE TABLE Customer (
	Customer_ID INT IDENTITY (1,1) PRIMARY KEY,
	Name VARCHAR(50),
	Surname VARCHAR(50),
);

CREATE TABLE Bill (
	Bill_ID INT IDENTITY (1,1) PRIMARY KEY,
	Date DATETIME,
	Payment VARCHAR(50),
	Salon_ID INT REFERENCES Beauty_Salon(Salon_ID),
	FK_Employee_ID INT REFERENCES Employee(Employee_ID),
	FK_Customer_ID INT REFERENCES Customer(Customer_ID)
); 

CREATE TABLE Cosmetic_Sale (
	Cosmetic_Sale_ID INT IDENTITY (1,1) PRIMARY KEY,
	Price DECIMAL(7,2),
	Amount INT,
	FK_Cosmetic_ID INT REFERENCES Cosmetic(Cosmetic_ID),
	FK_Bill_ID INT REFERENCES Bill(Bill_ID)
);

CREATE TABLE Service_Sale (
	Service_Sale_ID INT IDENTITY (1,1) PRIMARY KEY,
	Price DECIMAL(7,2),
	Amount INT,
	FK_Employee_ID INT  REFERENCES Employee(Employee_ID),
	FK_Service_ID INT  REFERENCES Service(Service_ID),
	FK_Bill_ID INT REFERENCES Bill(Bill_ID)
);

CREATE TABLE Appointment (
	Appointment_ID INT IDENTITY (1,1) PRIMARY KEY,
	Made_Date DATE,
	Date DATETIME,
	FK_Customer_ID INT REFERENCES Customer(Customer_ID),
	FK_Employee_ID INT REFERENCES Employee(Employee_ID),
	FK_Service_ID INT REFERENCES Service(Service_ID),
);