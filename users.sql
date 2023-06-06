create user manager IDENTIFIED BY "123";

grant create session to manager;

grant select on employee to manager;

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


















--------------------


create user employee IDENTIFIED BY "123";


grant create session to employee;

GRANT  create session, create table, create sequence, create view, create trigger, create procedure,  to employee;

alter user employee QUOTA unlimited ON users;







