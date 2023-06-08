--users
create user employee IDENTIFIED BY "123";

grant create session to employee;

alter user employee QUOTA unlimited ON users;

--GRANT create session, create table, create sequence, create view, create trigger, create procedure to employee;

--GRANT UNLIMITED TABLESPACE TO employee;

--GRANT all on JOB to employee;
--GRANT all on MANUFACTURER to employee;
--GRANT all on MODEL to employee;
--GRANT all on EXTRA_EQUIPMENT to employee;
--GRANT all on CAR_CATEGORY to employee;
--GRANT all on LOCATION to employee;
--GRANT all on STAFF to employee;
--GRANT all on CAR to employee;
--GRANT all on customer to employee;
--GRANT all on CAR_RENTAL to employee;
--GRANT all on RENTAL_EQUIPMENT to employee;
--GRANT all on PAYMENT to employee;

GRANT SELECT, INSERT, UPDATE, DELETE ON Job TO employee;
GRANT SELECT, INSERT, UPDATE, DELETE ON Manufacturer TO employee;
GRANT SELECT, INSERT, UPDATE, DELETE ON Model TO employee;
GRANT SELECT, INSERT, UPDATE, DELETE ON extra_equipment TO employee;
GRANT SELECT, INSERT, UPDATE, DELETE ON Car_Category TO employee;
GRANT SELECT, INSERT, UPDATE, DELETE ON Location TO employee;
GRANT SELECT, INSERT, UPDATE, DELETE ON Staff TO employee;
GRANT SELECT, INSERT, UPDATE, DELETE ON Car TO employee;
GRANT SELECT, INSERT, UPDATE, DELETE ON Customer TO employee;
GRANT SELECT, INSERT, UPDATE, DELETE ON Car_rental TO employee;
GRANT SELECT, INSERT, UPDATE, DELETE ON Rental_Equipment TO employee;
GRANT SELECT, INSERT, UPDATE, DELETE ON Payment TO employee;

GRANT SELECT, INSERT, UPDATE, DELETE ON Most_Popular_Car_By_Location TO employee;
GRANT SELECT, INSERT, UPDATE, DELETE ON Total_Earned_In_June_2022 TO employee;


---------------------------------------------
create user manager IDENTIFIED BY "123";

grant create session to manager;

--grant select on employee to manager;
/*
GRANT SELECT ON employee.JOB TO manager;
GRANT SELECT ON employee.MANUFACTURER TO manager;
GRANT SELECT ON employee.MODEL TO manager;
GRANT SELECT ON employee.EXTRA_EQUIPMENT TO manager;
GRANT SELECT ON employee.CAR_CATEGORY TO manager;
GRANT SELECT ON employee.LOCATION TO manager;
GRANT SELECT ON employee.STAFF TO manager;
GRANT SELECT ON employee.CAR TO manager;
GRANT SELECT ON employee.CUSTOMER TO manager;
GRANT SELECT ON employee.CAR_RENTAL TO manager;
GRANT SELECT ON employee.RENTAL_EQUIPMENT TO manager;
GRANT SELECT ON employee.PAYMENT TO manager;


GRANT SELECT ON employee.Most_Popular_Car_By_Location TO manager;
GRANT SELECT ON employee.Total_Earned_In_June_2022 TO manager;
*/
GRANT SELECT ON Customer TO manager;
GRANT SELECT ON Car_rental TO manager;
GRANT SELECT ON Rental_Equipment TO manager;
GRANT SELECT ON Payment TO manager;
GRANT SELECT ON extra_equipment TO manager;



