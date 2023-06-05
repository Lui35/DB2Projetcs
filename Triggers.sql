CREATE OR REPLACE TRIGGER generate_email
BEFORE INSERT ON Staff
FOR EACH ROW
BEGIN
    :NEW.email_address := LOWER(:NEW.first_name) || '.' || LOWER(:NEW.last_name) || '@CarRental.com';
END;
/
---------------------------------------------------------------------------------
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
----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER car_Rental_cost
BEFORE INSERT ON Car_rental
FOR EACH ROW
DECLARE
    daily_rate INTEGER;
    penalty_rate NUMBER(8,2);
    car_status VARCHAR2(20);
BEGIN
    -- Check if the car is available
    SELECT Car_status, Daily_hire_rate
    INTO car_status, daily_rate
    FROM car
    WHERE Car_id = :new.Car_id;

    -- If the car is available, perform the actions
    IF car_status = 'Available' THEN
        :new.cost_rent := calculateoriginalcost(:new.Rent_duration, daily_rate);
        dbms_output.put_line(updatecarstatustorented(:new.Car_id));
        :new.rent_status := 'Confirmed';
    END IF;
END;
/

----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER Total_cost
BEFORE UPDATE OF end_date ON Car_rental 
FOR EACH ROW
DECLARE
    v_daily_rate integer;
    v_penalty_rate NUMBER(8,2);
    v_equipment_cost integer;
    penalty integer;

BEGIN
    SELECT daily_hire_rate, daily_late_return_penalty
    INTO v_daily_rate, v_penalty_rate
    FROM Car
    WHERE :OLD.car_id = car_id;

    :NEW.rent_status := 'Completed';

     penalty := calculatepenaltycost(:OLD.start_date, :NEW.end_date, v_daily_rate, v_penalty_rate,:old.rent_duration);
    :NEW.penalty := penalty ;
    UPDATE Car
    set car_status = 'Available'
    where :OLD.car_id = car_id;
    
    v_equipment_cost := calculate_extra_equipment_cost(:old.rental_id);
    INSERT INTO Payment (payment_id, payment_date, Payment_Method, Total_amount, rental_id)
    VALUES (PAYMENT_SEQ.nextval, TO_DATE('2023-06-05', 'YYYY-MM-DD'), null, v_equipment_cost + penalty + :old.cost_rent , :old.rental_id);

END;
/




















