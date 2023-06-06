create user manager IDENTIFIED BY "123";

grant create session to manager;

grant select on users to manager;

--------------------
create user employee IDENTIFIED BY "123";

GRANT ALTER on users TO employee;

grant create session to employee;

alter user employee QUOTA unlimited ON users;
