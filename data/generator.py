import numpy as np
import pandas as pd
from faker.providers.person.en import Provider
from faker import Faker
import random

def generate_id(size, low=1):
    return list(range(low,size+1))

def random_names(name_type, size):
    names = getattr(Provider, name_type)
    return np.random.choice(names, size=size) 

def random_number(size, max, min=1):
    return np.random.randint(low = min, high=max+1, size=size)

def random_price(size, max):
    return np.around(np.random.uniform(low=0.00, high=max, size=size),2)

def random_payment(size, prob=(0.5, 0.5)):
    payment_method = ("Cash", "Card")
    return np.random.choice(payment_method, size=size, p=prob)

def random_position(size, prob=(0.75, 0.05, 0.1, 0.1)):
    position = ("Beautician", "Manager", "Recepcionist", "Cleaner")
    return np.random.choice(position, size=size, p=prob)

def random_date(start, end, size):
    # Unix timestamp is in nanoseconds by default, so divide it by 24*60*60*10**9 to convert to days
    divide_by = 24 * 60 * 60 * 10**9
    start_u = start.value // divide_by
    end_u = end.value // divide_by
    return pd.to_datetime(np.random.randint(start_u, end_u, size), unit="D")

def random_datetime(start, end, size):
    # Unix timestamp is in nanoseconds by default, so divide it by 10**9 to convert to seconds
    divide_by = 10**9
    start_u = start.value // divide_by
    end_u = end.value // divide_by
    return pd.to_datetime(np.random.randint(start_u, end_u, size), unit='s')

def random_city(size):
    arr=list()
    for i in range(size):
        temp=Faker().city()
        arr.append(temp)
    return arr

def random_street(size):
    arr=list()
    for i in range(size):
        temp=Faker().street_address()
        arr.append(temp)
    return arr

def random_employee_index(size, indexes):
    arr = list()
    for i in range(size):
        arr.append(random.choice(indexes))
    return arr





#Set range of salon's opening date
Opening_date_T0 = '2019-01-01'
Opening_date_T1 = '2020-06-01'
Opening_date_T2 = '2021-12-31'

#Set range of date when bill was 
Bill_date_T0 = '2020-01-01'
Bill_date_T1 = '2021-01-01'
Bill_date_T2 = '2021-12-31'

#Set range of date when appointment was made
Appointment_made_date_T0 = '2019-01-01'
Appointment_made_date_T1 = '2020-06-01'
Appointment_made_date_T2 = '2021-12-31'

#Set range of date when appointment took place
Appointment_date_T0 = '2019-01-01'
Appointment_date_T1 = '2020-06-01'
Appointment_date_T2 = '2021-12-31'

#preparing products and services dataset for T1
products = pd.read_csv("products.csv")
products.to_csv('T1_Cosmetic.csv', index = False)
services = pd.read_csv("services.csv")
services.to_csv('T1_Service.csv', index = False)

#Number of rows in each table for T1
Cosmetic_size_T1 = len(products.index)
Service_size_T1 = len(services.index)
Beauty_Salon_size_T1 = 2
Employee_size_T1 = 50
Customer_size_T1 = 3000
Bill_size_T1 = 9000
Cosmetic_Sale_size_T1 = 9500
Service_Sale_size_T1 = 9000
Appointment_size_T1 = 10000

#Number of rows in each table for T2
Beauty_Salon_size_T2 = 2
Employee_size_T2 = 100
Customer_size_T2 = 3000
Bill_size_T2 = 9000
Cosmetic_Sale_size_T2 = 9500
Service_Sale_size_T2 = 9000
Appointment_size_T2 = 10000


# GENERATE DATA FOR T1
Beauty_Salon = pd.DataFrame()
Beauty_Salon['Salon_ID'] = generate_id(Beauty_Salon_size_T1)
Beauty_Salon['Name'] = 'Wioletta salon'
Beauty_Salon['Opening_Date'] = random_date(start=pd.to_datetime(Opening_date_T0), end=pd.to_datetime(Opening_date_T1), size=Beauty_Salon_size_T1)
Beauty_Salon['City'] = random_city(Beauty_Salon_size_T1)
Beauty_Salon['Street'] = random_street(Beauty_Salon_size_T1)
Beauty_Salon.to_csv('T1_Beauty_Salon.csv', index = False)

Employee = pd.DataFrame()
Employee = pd.DataFrame()
Employee['Employee_ID'] = generate_id(Employee_size_T1)
Employee['Name'] = random_names('first_names', Employee_size_T1)
Employee['Surname'] = random_names('last_names', Employee_size_T1)
Employee['PESEL'] = random_number(Employee_size_T1, 999999999, 100000000)
Employee['date_of_birth'] = random_date(start=pd.to_datetime('1985-01-01'), end=pd.to_datetime('2002-01-01'), size=Employee_size_T1)
Employee['Position'] = random_position(Employee_size_T1)
Employee['FK_Salon_ID'] = random_number(Employee_size_T1, Beauty_Salon_size_T1)
Employee['Promotion'] = random_date(start=pd.to_datetime('2019-01-01'), end=pd.to_datetime('2021-12-31'), size=Employee_size_T1)
Employee['Start_of_work'] = random_date(start=pd.to_datetime('2000-01-01'), end=pd.to_datetime('2021-12-31'), size=Employee_size_T1)
Employee['End_of_work'] = random_date(start=pd.to_datetime('2019-01-01'), end=pd.to_datetime('2021-12-31'), size=Employee_size_T1)

# remove promotions and ends of work
for i in range(Employee_size_T1):
    rand = np.random.randint(0,4)
    if rand != 2:
        Employee.loc[i,'Promotion'] = None
    rand = np.random.randint(0,4)
    if rand != 2:
        Employee.loc[i,'end_of_work'] = None
Employee.to_csv('T1_Employee.csv', index = False)

# create list of beauticians and receocionists, which would be used later
Beautician = list()
for i in range(Employee_size_T1):
    if Employee.loc[i]['Position'] == 'Beautician':
        Beautician.append(Employee.loc[i]['Employee_ID'])
Recepcionist = list()
for i in range(Employee_size_T1):
    if Employee.loc[i]['Position'] == 'Recepcionist':
        Recepcionist.append(Employee.loc[i]['Employee_ID'])

Customer = pd.DataFrame()
Customer['Customer_ID'] = generate_id(Customer_size_T1)
Customer['Name'] = random_names('first_names', Customer_size_T1)
Customer['Surname'] = random_names('last_names', Customer_size_T1)
Customer.to_csv('T1_Customer.csv', index = False)

Bill = pd.DataFrame()
Bill['Bill_ID'] = generate_id(Bill_size_T1)
Bill['Date'] = random_datetime(start=pd.to_datetime(Bill_date_T0), end=pd.to_datetime(Bill_date_T1), size=Bill_size_T1)
Bill['Payment'] = random_payment(Bill_size_T1)
Bill['FK_Salon_ID'] = random_number(Bill_size_T1, Beauty_Salon_size_T1)
Bill['FK_Employee_ID'] = random_employee_index(Bill_size_T1, Recepcionist)
Bill['FK_Customer_ID'] = random_number(Bill_size_T1, Customer_size_T1)
Bill.to_csv('T1_Bill.csv', index = False)

Cosmetic_Sale = pd.DataFrame()
Cosmetic_Sale['Cosmetic_Sale_ID'] = generate_id(Cosmetic_Sale_size_T1)
Cosmetic_Sale['Price'] = random_price(Cosmetic_Sale_size_T1, 100.00)
Cosmetic_Sale['Amount'] = random_number(Cosmetic_Sale_size_T1, 50, 0)
Cosmetic_Sale['FK_Cosmetic_ID'] = random_number(Cosmetic_Sale_size_T1, Cosmetic_size_T1)
Cosmetic_Sale['FK_Bill_ID'] =  random_number(Cosmetic_Sale_size_T1, Bill_size_T1)
Cosmetic_Sale.to_csv('T1_Cosmetic_Sale.csv', index = False)

Service_Sale = pd.DataFrame()
Service_Sale['Service_Sale_ID'] = generate_id(Service_Sale_size_T1)
Service_Sale['Price'] = random_price(Service_Sale_size_T1, 1000.00)
Service_Sale['Amount'] = random_number(Service_Sale_size_T1, 50, 0)
Service_Sale['FK_Employee_ID'] = random_employee_index(Service_Sale_size_T1, Beautician)
Service_Sale['FK_Service_ID'] = random_number(Service_Sale_size_T1, Service_size_T1)
Service_Sale['FK_Bill_ID'] = random_number(Service_Sale_size_T1, Bill_size_T1)
Service_Sale.to_csv('T1_Service_Sale.csv', index = False)

Appointment = pd.DataFrame()
Appointment['Appointment_ID'] = generate_id(Appointment_size_T1)
Appointment['Made_Date'] = random_date(start=pd.to_datetime(Appointment_made_date_T0), end=pd.to_datetime(Appointment_made_date_T1), size=Appointment_size_T1)
Appointment['Date'] = random_datetime(start=pd.to_datetime(Appointment_date_T0), end=pd.to_datetime(Appointment_date_T1), size=Appointment_size_T1)
Appointment['FK_Customer_ID'] = random_number(Appointment_size_T1, Customer_size_T1)
Appointment['FK_Employee_ID'] = random_employee_index(Appointment_size_T1, Beautician)
Appointment['FK_Service_ID'] = random_number(Appointment_size_T1, Service_size_T1)
Appointment.to_csv('T1_Appointment.csv', index = False)



# GENERATE DATA FOR T2
Beauty_Salon = pd.DataFrame()
Beauty_Salon['Salon_ID'] = generate_id(Beauty_Salon_size_T1+Beauty_Salon_size_T2, Beauty_Salon_size_T1+1)
Beauty_Salon['Name'] = 'Wioletta salon'
Beauty_Salon['Opening_Date'] = random_date(start=pd.to_datetime(Opening_date_T1), end=pd.to_datetime(Opening_date_T2), size=Beauty_Salon_size_T2)
Beauty_Salon['City'] = random_city(Beauty_Salon_size_T2)
Beauty_Salon['Street'] = random_street(Beauty_Salon_size_T2)
Beauty_Salon.to_csv('T2_Beauty_Salon.csv', index = False)

Employee = pd.DataFrame()
Employee['Employee_ID'] = generate_id(Employee_size_T1+Employee_size_T2, Employee_size_T1+1)
Employee['Name'] = random_names('first_names', Employee_size_T2)
Employee['Surname'] = random_names('last_names', Employee_size_T2)
Employee['PESEL'] = random_number(Employee_size_T2, 999999999, 100000000)
Employee['date_of_birth'] = random_date(start=pd.to_datetime('1985-01-01'), end=pd.to_datetime('2002-01-01'), size=Employee_size_T2)
Employee['Position'] = random_position(Employee_size_T2)
Employee['FK_Salon_ID'] = random_number(Employee_size_T2, Beauty_Salon_size_T1+Beauty_Salon_size_T2)
Employee['Promotion'] = random_date(start=pd.to_datetime('2019-01-01'), end=pd.to_datetime('2021-12-31'), size=Employee_size_T2)
Employee['Start_of_work'] = random_date(start=pd.to_datetime('2000-01-01'), end=pd.to_datetime('2021-12-31'), size=Employee_size_T2)
Employee['End_of_work'] = random_date(start=pd.to_datetime('2019-01-01'), end=pd.to_datetime('2021-12-31'), size=Employee_size_T2)

# remove promotions and ends of work
for i in range(Employee_size_T2):
    rand = np.random.randint(0,4)
    if rand != 2:
        Employee.loc[i,'Promotion'] = None
    rand = np.random.randint(0,4)
    if rand != 2:
        Employee.loc[i,'end_of_work'] = None
Employee.to_csv('T2_Employee.csv', index = False)

# create list of beauticians and receocionists, which would be used later
for i in range(Employee_size_T2):
    if Employee.loc[i]['Position'] == 'Beautician':
        Beautician.append(Employee.loc[i]['Employee_ID'])
for i in range(Employee_size_T2):
    if Employee.loc[i]['Position'] == 'Recepcionist':
        Recepcionist.append(Employee.loc[i]['Employee_ID'])

Customer = pd.DataFrame()
Customer['Customer_ID'] = generate_id(Customer_size_T1+Customer_size_T2, Customer_size_T1+1)
Customer['Name'] = random_names('first_names', Customer_size_T2)
Customer['Surname'] = random_names('last_names', Customer_size_T2)
Customer.to_csv('T2_Customer.csv', index = False)

Bill = pd.DataFrame()
Bill['Bill_ID'] = generate_id(Bill_size_T1+Bill_size_T2, Bill_size_T1+1)
Bill['Date'] = random_datetime(start=pd.to_datetime(Bill_date_T1), end=pd.to_datetime(Bill_date_T2), size=Bill_size_T2)
Bill['Payment'] = random_payment(Bill_size_T1)
Bill['FK_Salon_ID'] = random_number(Bill_size_T2, Beauty_Salon_size_T1+Beauty_Salon_size_T2)
Bill['FK_Employee_ID'] = random_employee_index(Bill_size_T2, Recepcionist)
Bill['FK_Customer_ID'] = random_number(Bill_size_T2, Customer_size_T1+Customer_size_T2)
Bill.to_csv('T2_Bill.csv', index = False)

Cosmetic_Sale = pd.DataFrame()
Cosmetic_Sale['Cosmetic_Sale_ID'] = generate_id(Cosmetic_Sale_size_T1+Cosmetic_Sale_size_T2, Cosmetic_Sale_size_T1+1)
Cosmetic_Sale['Price'] = random_price(Cosmetic_Sale_size_T2, 100.00)
Cosmetic_Sale['Amount'] = random_number(Cosmetic_Sale_size_T2, 50, 0)
Cosmetic_Sale['FK_Cosmetic_ID'] = random_number(Cosmetic_Sale_size_T2, Cosmetic_size_T1)
Cosmetic_Sale['FK_Bill_ID'] =  random_number(Cosmetic_Sale_size_T2, Bill_size_T1+Bill_size_T2)
Cosmetic_Sale.to_csv('T2_Cosmetic_Sale.csv', index = False)

Service_Sale = pd.DataFrame()
Service_Sale['Service_Sale_ID'] = generate_id(Service_Sale_size_T1+Service_Sale_size_T2, Service_Sale_size_T1+1)
Service_Sale['Price'] = random_price(Service_Sale_size_T2, 1000.00)
Service_Sale['Amount'] = random_number(Service_Sale_size_T2, 50, 0)
Service_Sale['FK_Employee_ID'] = random_employee_index(Service_Sale_size_T2, Beautician)
Service_Sale['FK_Service_ID'] = random_number(Service_Sale_size_T2, Service_size_T1)
Service_Sale['FK_Bill_ID'] = random_number(Service_Sale_size_T2, Bill_size_T1+Bill_size_T2)
Service_Sale.to_csv('T2_Service_Sale.csv', index = False)

Appointment = pd.DataFrame()
Appointment['Appointment_ID'] = generate_id(Appointment_size_T1+Appointment_size_T2, Appointment_size_T1+1)
Appointment['Made_Date'] = random_date(start=pd.to_datetime(Appointment_made_date_T1), end=pd.to_datetime(Appointment_made_date_T2), size=Appointment_size_T2)
Appointment['Date'] = random_datetime(start=pd.to_datetime(Appointment_date_T1), end=pd.to_datetime(Appointment_date_T2), size=Appointment_size_T2)
Appointment['FK_Customer_ID'] = random_number(Appointment_size_T2, Customer_size_T1+Customer_size_T2)
Appointment['FK_Employee_ID'] = random_employee_index(Appointment_size_T2, Beautician)
Appointment['FK_Service_ID'] = random_number(Appointment_size_T2, Service_size_T1)
Appointment.to_csv('T2_Appointment.csv', index = False)