--DROP TABLE Appointment, Service_Sale, Employee, Beauty_Salon, Service, Customer, Date, Time
USE SalonDW
GO

CREATE TABLE Date (
	Date_ID INT IDENTITY(1,1) PRIMARY KEY,
	Date DATE, 
	Year INT,
	Month VARCHAR(10) CHECK (Month IN ('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December')),
	Month_number INT,
	Season VARCHAR(6) CHECK (Season IN ('Spring', 'Summer', 'Autumn', 'Winter')),
	Season_number INT,
	Holiday VARCHAR(20) CHECK (Holiday IN ('Christmas', 'New Year’s Eve', 'Easter', 'Woman’s Day', 'Man’s Day', 'Child’s Day', 'Mother’s Day', 'Father’s Day', 'Thanksgiving')),
	Vacation VARCHAR(15) CHECK (Vacation IN ('Winter break', 'Summer break', 'Spring break', 'May’s break'))
);

CREATE TABLE Time (
	Time_ID INT IDENTITY(1,1) PRIMARY KEY,
	Hour INT,
	Minute INT
);

CREATE TABLE Customer (
	Customer_ID INT IDENTITY(1,1) PRIMARY KEY,
	Name_and_Surname VARCHAR(50)
);

CREATE TABLE Service (
	Service_ID INT IDENTITY(1,1) PRIMARY KEY,
	Name VARCHAR(30),
	Duration VARCHAR(25) CHECK(Duration IN ('less than 30 min', 'between 30 min and 1 hour', 'more than 1 hour'))
);

CREATE TABLE Beauty_Salon (
	Salon_ID INT IDENTITY(1,1) PRIMARY KEY,
	Name VARCHAR(50),
	City VARCHAR(50),
	Street VARCHAR(30),
	Salon_Size VARCHAR(7) CHECK(Salon_Size IN ('small', 'average', 'big')),
);

CREATE TABLE Employee (
	Employee_ID INT  IDENTITY(1,1) PRIMARY KEY,
	Name_and_Surname VARCHAR(50),
	Position VARCHAR(15) CHECK (Position IN ('Cleaner', 'Recepcionist', 'Beautician', 'Manager')),
	Work_experience VARCHAR(30) CHECK (Work_experience IN ('up to one year', 'between one and five years', 'more than five years')),
	isCurrent BIT,
	ID_Beauty_Salon INT,
	Age VARCHAR(10) CHECK(Age IN ('young', 'mid age', 'old')),
	FOREIGN KEY (ID_Beauty_Salon) REFERENCES Beauty_Salon(Salon_ID)
); 

CREATE TABLE Appointment (
	ID_Made_Date INT,
	ID_Customer INT,
	ID_Beautician INT,
	ID_Date INT,
	ID_Time INT,
	isFirst BIT,
	Same_beautician BIT,
	Next_appointment BIT,
	ID_Service INT,
	FOREIGN KEY (ID_Made_Date) REFERENCES Date(Date_ID),
	FOREIGN KEY (ID_Customer) REFERENCES Customer(Customer_ID),
	FOREIGN KEY (ID_Beautician) REFERENCES Employee(Employee_ID),
	FOREIGN KEY (ID_Date) REFERENCES Date(Date_ID),
	FOREIGN KEY (ID_Time) REFERENCES Time(Time_ID),
	FOREIGN KEY (ID_Service) REFERENCES Service(Service_ID)
);

CREATE TABLE Service_Sale (
	Transaction_number INT IDENTITY(1,1),
	Price INT,
	Amount INT,
	ID_Time INT,
	ID_Date INT,
	ID_Service INT,
	ID_Receptionist INT,
	ID_Beautician INT,
	ID_Customer INT,
	Service_profit AS Price * Amount,
	FOREIGN KEY (ID_Beautician) REFERENCES Employee(Employee_ID),
	FOREIGN KEY (ID_Receptionist) REFERENCES Employee(Employee_ID),
	FOREIGN KEY (ID_Date) REFERENCES Date(Date_ID),
	FOREIGN KEY (ID_Time) REFERENCES Time(Time_ID),
	FOREIGN KEY (ID_Service) REFERENCES Service(Service_ID),
	FOREIGN KEY (ID_Customer) REFERENCES Customer(Customer_ID),
	PRIMARY KEY (Transaction_number, ID_Service)
);
