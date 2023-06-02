CREATE OR REPLACE TRIGGER generate_email
BEFORE INSERT ON Staff
FOR EACH ROW
BEGIN
    :NEW.email_address := LOWER(:NEW.first_name) || '.' || LOWER(:NEW.last_name) || '@CarRental.com';
END;
/

CREATE OR REPLACE TRIGGER car_manufacturing_year_trigger
BEFORE INSERT ON Car
FOR EACH ROW
DECLARE
    penalty_rate NUMBER(8,2);
BEGIN
    IF :NEW.manufacturing_year >= 2010 AND :NEW.manufacturing_year <= 2021 THEN
        penalty_rate := 10;
    ELSIF :NEW.manufacturing_year >= 2000 AND :NEW.manufacturing_year <= 2009 THEN
        penalty_rate := 5; 
    ELSE
        penalty_rate := 3;
    END IF;
    
    :NEW.daily_late_return_penalty := penalty_rate;
END;
/


CREATE OR REPLACE TRIGGER car_Rental
BEFORE INSERT ON Car
FOR EACH ROW
DECLARE
    penalty_rate NUMBER(8,2);
BEGIN
    IF :NEW.manufacturing_year >= 2010 AND :NEW.manufacturing_year <= 2021 THEN
        penalty_rate := 10;
    ELSIF :NEW.manufacturing_year >= 2000 AND :NEW.manufacturing_year <= 2009 THEN
        penalty_rate := 5; 
    ELSE
        penalty_rate := 3;
    END IF;
    
    :NEW.daily_late_return_penalty := penalty_rate;
END;
/
