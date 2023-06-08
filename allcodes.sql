CREATE TABLE Job (
                Job_id NUMBER NOT NULL,
                staff_role_type_ VARCHAR2(50) NOT NULL,
                Role_description VARCHAR2(150) NOT NULL,
                CONSTRAINT JOB_PK PRIMARY KEY (Job_id)
);


CREATE TABLE Manufacturer (
                manufactuerer_id NUMBER NOT NULL,
                Manufacturer_name VARCHAR2(50) NOT NULL,
                CONSTRAINT MANUFACTURER_PK PRIMARY KEY (manufactuerer_id)
);


CREATE TABLE Model (
                model_id NUMBER NOT NULL,
                Model_name VARCHAR2(50) NOT NULL,
                manufactuerer_id NUMBER NOT NULL,
                engine_size NUMBER NOT NULL,
                CONSTRAINT MODEL_PK PRIMARY KEY (model_id)
);


CREATE TABLE extra_equipment (
                equipment_id NUMBER NOT NULL,
                description VARCHAR2(200) NOT NULL,
                equipment_name VARCHAR2(20) NOT NULL,
                price NUMBER NOT NULL,
                quantity NUMBER NOT NULL,
                CONSTRAINT EXTRA_EQUIPMENT_PK PRIMARY KEY (equipment_id)
);


CREATE TABLE Car_Category (
                Category_id NUMBER NOT NULL,
                category_name VARCHAR2(20) NOT NULL,
                CONSTRAINT CAR_CATEGORY_PK PRIMARY KEY (Category_id),
                CONSTRAINT CATEGORY_NAME_CHECK CHECK (category_name IN ('ECO', 'LUX', 'SUV'))
);


CREATE TABLE Location (
                location_id NUMBER NOT NULL,
                phone_number VARCHAR2(20) NOT NULL,
                address VARCHAR2(50) NOT NULL,
                city VARCHAR2(50) NOT NULL,
                CONSTRAINT LOCATION_PK PRIMARY KEY (location_id)
);


CREATE TABLE Staff (
                staff_id NUMBER NOT NULL,
                first_name VARCHAR2(50) NOT NULL,
                last_name VARCHAR2(50) NOT NULL,
                road_address VARCHAR2(20) NOT NULL,
                phone_number VARCHAR2(20) NOT NULL,
                house_address VARCHAR2(20) NOT NULL,
                block_address VARCHAR2(20) NOT NULL,
                city VARCHAR2(50) NOT NULL,
                email_address VARCHAR2(100),
                cpr_number VARCHAR2(20),
                Job_id NUMBER NOT NULL,
                location_id NUMBER NOT NULL,
                CONSTRAINT STAFF_PK PRIMARY KEY (staff_id)
);


CREATE TABLE Car (
                car_id NUMBER NOT NULL,
                model_id NUMBER NOT NULL,
                plate_number NUMBER NOT NULL,
                car_registration_due_date DATE NOT NULL,
                manufacturing_year NUMBER NOT NULL,
                color VARCHAR2(20) NOT NULL,
                current_mileage NUMBER NOT NULL,
                daily_hire_rate NUMBER(8,2) NOT NULL,
                daily_late_return_penalty NUMBER(8,2) NOT NULL,
                car_status VARCHAR2(20) NOT NULL,
                Category_id NUMBER NOT NULL,
                location_id NUMBER NOT NULL,
                CONSTRAINT CAR_PK PRIMARY KEY (car_id),
                CONSTRAINT CAR_STATUS_CHECK CHECK (car_status IN ('Available', 'Rented', 'Under Maintenance'))
);


CREATE TABLE Customer  (
                customer_id NUMBER NOT NULL,
                first_name VARCHAR2(50) NOT NULL,
                last_name VARCHAR2(50) NOT NULL,
                phone_number VARCHAR2(20) NOT NULL,
                house_address VARCHAR2(20) NOT NULL,
                road_address VARCHAR2(20) NOT NULL,
                block_address VARCHAR2(20) NOT NULL,
                city VARCHAR2(50) NOT NULL,
                email_address VARCHAR2(100),
                cpr_number VARCHAR2(20),
                CONSTRAINT CUSTOMER_PK PRIMARY KEY (customer_id)
);


CREATE TABLE Car_rental (
                rental_id NUMBER NOT NULL,
                customer_id NUMBER NOT NULL,
                car_id NUMBER NOT NULL,
                rent_duration NUMBER NOT NULL,
                Cost_rent NUMBER NOT NULL,
                rent_status VARCHAR2(20) NOT NULL,
                start_date DATE NOT NULL,
                end_date DATE ,
                penalty NUMBER ,
                staff_id NUMBER NOT NULL,
                CONSTRAINT CAR_RENTAL_PK PRIMARY KEY (rental_id),
                CONSTRAINT RENT_STATUS_CHECK CHECK (rent_status IN ('Confirmed', 'On-going', 'Cancelled', 'Completed'))
);


CREATE TABLE Rental_Equipment (
                rental_id NUMBER NOT NULL,
                equipment_id NUMBER NOT NULL,
                quantity NUMBER NOT NULL,
                CONSTRAINT RENTAL_EQUIPMENT_PK PRIMARY KEY (rental_id, equipment_id)
);


CREATE TABLE Payment (
                payment_id NUMBER(10) NOT NULL,
                payment_date DATE NOT NULL,
                Payment_Method VARCHAR2(50) NOT NULL,
                Total_amount NUMBER NOT NULL,
                rental_id NUMBER NOT NULL,
                CONSTRAINT PAYMENT_PK PRIMARY KEY (payment_id)
);


ALTER TABLE Staff ADD CONSTRAINT STAFF_ROLE_1_STAFF_FK
FOREIGN KEY (Job_id)
REFERENCES Job (Job_id)
NOT DEFERRABLE;

ALTER TABLE Model ADD CONSTRAINT MANUFACTURER_MODEL_FK
FOREIGN KEY (manufactuerer_id)
REFERENCES Manufacturer (manufactuerer_id)
NOT DEFERRABLE;

ALTER TABLE Car ADD CONSTRAINT MODEL_CAR_FK
FOREIGN KEY (model_id)
REFERENCES Model (model_id)
NOT DEFERRABLE;

ALTER TABLE Rental_Equipment ADD CONSTRAINT EXTRA_EQUIPMENT_RENTAL_EQUI657
FOREIGN KEY (equipment_id)
REFERENCES extra_equipment (equipment_id)
NOT DEFERRABLE;

ALTER TABLE Car ADD CONSTRAINT CAR_CATEGORY_CAR_FK
FOREIGN KEY (Category_id)
REFERENCES Car_Category (Category_id)
NOT DEFERRABLE;

ALTER TABLE Staff ADD CONSTRAINT LOCATION_STAFF_FK
FOREIGN KEY (location_id)
REFERENCES Location (location_id)
NOT DEFERRABLE;

ALTER TABLE Car ADD CONSTRAINT LOCATION_CAR_FK
FOREIGN KEY (location_id)
REFERENCES Location (location_id)
NOT DEFERRABLE;

ALTER TABLE Car_rental ADD CONSTRAINT STAFF_CAR_RENTAL_FK
FOREIGN KEY (staff_id)
REFERENCES Staff (staff_id)
NOT DEFERRABLE;

ALTER TABLE Car_rental ADD CONSTRAINT CAR_CAR_RENTAL_FK
FOREIGN KEY (car_id)
REFERENCES Car (car_id)
NOT DEFERRABLE;

ALTER TABLE Car_rental ADD CONSTRAINT CUSTOMER__CAR_RENTAL_FK
FOREIGN KEY (customer_id)
REFERENCES Customer  (customer_id)
NOT DEFERRABLE;

ALTER TABLE Payment ADD CONSTRAINT CAR_RENTAL_PAYMENT_FK
FOREIGN KEY (rental_id)
REFERENCES Car_rental (rental_id)
NOT DEFERRABLE;

ALTER TABLE Rental_Equipment ADD CONSTRAINT CAR_RENTAL_RENTAL_EQUIPMENT_FK
FOREIGN KEY (rental_id)
REFERENCES Car_rental (rental_id)
NOT DEFERRABLE;

--indexes

-- Job table
CREATE INDEX idx_job_staff_role_type ON Job(staff_role_type_);
-- Manufacturer table
CREATE INDEX idx_manufacturer_Manufacturer_name ON Manufacturer(Manufacturer_name);
-- Staff table
CREATE INDEX idx_staff_Job_id ON Staff(Job_id);
CREATE INDEX idx_staff_location_id ON Staff(location_id);
-- Car table
CREATE INDEX idx_car_model_id ON Car(model_id);
CREATE INDEX idx_car_Category_id ON Car(Category_id);
CREATE INDEX idx_car_location_id ON Car(location_id);
-- Car_rental table
CREATE INDEX idx_car_rental_customer_id ON Car_rental(customer_id);
CREATE INDEX idx_car_rental_car_id ON Car_rental(car_id);
CREATE INDEX idx_car_rental_staff_id ON Car_rental(staff_id);
-- Rental_Equipment table
CREATE INDEX idx_rental_equipment_rental_id ON Rental_Equipment(rental_id);
CREATE INDEX idx_rental_equipment_equipment_id ON Rental_Equipment(equipment_id);
-- Payment table
CREATE INDEX idx_payment_rental_id ON Payment(rental_id);


--views
CREATE or replace VIEW Most_Popular_Car_By_Location AS
SELECT location_id, city, model_id, Model_name, popularity
FROM (
  SELECT l.location_id, l.city, c.model_id, m.Model_name, COUNT(cr.car_id) AS popularity,
         ROW_NUMBER() OVER (PARTITION BY l.location_id ORDER BY COUNT(cr.car_id) DESC) AS row_num
  FROM Car c
  JOIN Location l ON c.location_id = l.location_id
  JOIN Model m ON c.model_id = m.model_id
  LEFT JOIN Car_rental cr ON c.car_id = cr.car_id
  GROUP BY l.location_id, l.city, c.model_id, m.Model_name
) sub
WHERE row_num = 1;



CREATE VIEW Total_Earned_In_June_2022 AS
SELECT SUM(p.Total_amount) AS total_earned
FROM Payment p
WHERE p.payment_date >= DATE '2022-06-01' AND p.payment_date < DATE '2022-07-01';

--sequences
CREATE SEQUENCE car_seq
     START WITH 1001
     INCREMENT BY 1
     MINVALUE 1
     MAXVALUE 9999999999999
     NOCYCLE
     NOCACHE;

CREATE SEQUENCE rental_seq
     START WITH 2001
     INCREMENT BY 1
     MINVALUE 1
     MAXVALUE 9999999999999
     NOCYCLE
     NOCACHE;

CREATE SEQUENCE customer_seq
     START WITH 3001
     INCREMENT BY 1
     MINVALUE 1
     MAXVALUE 99999
     CYCLE
     NOCACHE;

CREATE SEQUENCE equipment_seq
     START WITH 4001
     INCREMENT BY 1
     MINVALUE 1
     MAXVALUE 999999
     NOCYCLE
     NOCACHE;

CREATE SEQUENCE payment_seq
     START WITH 5001
     INCREMENT BY 1
     MINVALUE 1
     MAXVALUE 9999999999999
     CYCLE
     NOCACHE;

CREATE SEQUENCE staff_seq
     START WITH 7001
     INCREMENT BY 1
     MINVALUE 1
     MAXVALUE 999999
     NOCYCLE
     NOCACHE;

--functions

CREATE OR REPLACE FUNCTION calculateoriginalcost (
    durations IN NUMBER,
    daily_rate IN NUMBER
) RETURN NUMBER IS
    original_cost NUMBER;
BEGIN
    original_cost := durations * daily_rate;
    RETURN original_cost;
END calculateoriginalcost;
/
----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION calculatepenaltycost (
    start_date         IN DATE,
    end_date           IN DATE,
    daily_rate         IN NUMBER,
    penalty_percentage IN NUMBER,
    rent_duration IN NUMBER
) RETURN NUMBER IS
    v_day         INTEGER;
    penalty_cost NUMBER := 0;
BEGIN
    v_day := end_date - start_date - rent_duration;
    if v_day >0 then
    penalty_cost := v_day * daily_rate * (1+( penalty_percentage / 100 ) );
    RETURN penalty_cost;
    end if;
    RETURN penalty_cost;
END calculatepenaltycost;
/
----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION updatecarstatustorented (
    p_car_id IN NUMBER
) RETURN VARCHAR2 IS
    v_status car.car_status%TYPE;
BEGIN
    SELECT
        car_status
    INTO v_status
    FROM
        car
    WHERE
        car_id = p_car_id;
    IF v_status = 'Available' THEN
        UPDATE car
        SET
            car_status = 'Rented'
        WHERE
            car_id = p_car_id; 
        RETURN 'Car status updated to rented';
    ELSE
        RETURN 'Car is not available for rent';
    END IF;
EXCEPTION
    WHEN no_data_found THEN
        RETURN 'Car not found';
END updatecarstatustorented;
/
-----------------------------------------------
CREATE OR REPLACE FUNCTION update_rental_status(
  p_rental_id NUMBER
) RETURN VARCHAR2 IS
  v_start_date DATE;
  v_end_date DATE;
BEGIN
  -- Validate rental ID before updating
  SELECT Start_Date, End_date 
  INTO v_start_date, v_end_date
  FROM CAR_RENTAL 
  WHERE rental_id = p_rental_id;

  -- Check if the rental is within the valid period
  IF SYSDATE >= v_start_date AND v_end_date IS NULL THEN
    -- Update rental status to 'On-going'
    UPDATE car_rental
    SET rent_status = 'On-going'
    WHERE rental_id = p_rental_id;

    RETURN 'Rental ID ' || p_rental_id || ' status changed to on-going';
  ELSE
    RETURN 'Rental ID ' || p_rental_id || ' did not change the status';
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 'Rental ID ' || p_rental_id || ' not found.';
  WHEN OTHERS THEN
    RETURN 'Error updating rental ID ' || p_rental_id || ': ' || SQLERRM;
END;
/

-----------------------------------------
CREATE OR REPLACE FUNCTION calculate_extra_equipment_cost(p_rental_id IN NUMBER)
RETURN NUMBER
IS
  v_total_cost NUMBER := 0;
BEGIN
  FOR rec IN (
    SELECT re.rental_id, re.equipment_id, re.quantity, ee.price
    FROM Rental_Equipment re
    JOIN Extra_Equipment ee ON re.equipment_id = ee.equipment_id
    WHERE re.rental_id = p_rental_id
  )
  LOOP
    v_total_cost := v_total_cost + (rec.quantity * rec.price);
  END LOOP;

  RETURN v_total_cost;
END;
/

--package


CREATE OR REPLACE PACKAGE Rental_Management AS
  FUNCTION calculateoriginalcost (
    durations IN NUMBER,
    daily_rate IN NUMBER
  ) RETURN NUMBER;
  
  FUNCTION calculatepenaltycost (
    start_date         IN DATE,
    end_date           IN DATE,
    daily_rate         IN NUMBER,
    penalty_percentage IN NUMBER,
    rent_duration IN NUMBER
  ) RETURN NUMBER;
  
  FUNCTION updatecarstatustorented (
    p_car_id IN NUMBER
  ) RETURN VARCHAR2;
  
  FUNCTION update_rental_status(
    p_rental_id NUMBER
  ) RETURN VARCHAR2;
  
  FUNCTION calculate_extra_equipment_cost(p_rental_id IN NUMBER)
  RETURN NUMBER;
END Rental_Management;
/

CREATE OR REPLACE PACKAGE BODY Rental_Management AS
  -- Function to calculate original cost of rental
  FUNCTION calculateoriginalcost (
    durations IN NUMBER,
    daily_rate IN NUMBER
  ) RETURN NUMBER IS
    original_cost NUMBER;
  BEGIN
    original_cost := durations * daily_rate;
    RETURN original_cost;
  END calculateoriginalcost;

  -- Function to calculate penalty cost of rental
  FUNCTION calculatepenaltycost (
    start_date         IN DATE,
    end_date           IN DATE,
    daily_rate         IN NUMBER,
    penalty_percentage IN NUMBER,
    rent_duration IN NUMBER
  ) RETURN NUMBER IS
    v_day         INTEGER;
    penalty_cost NUMBER := 0;
  BEGIN
    v_day := end_date - start_date - rent_duration;
    if v_day >0 then
    penalty_cost := v_day * daily_rate * (1+( penalty_percentage / 100 ) );
    RETURN penalty_cost;
    end if;
    RETURN penalty_cost;
  END calculatepenaltycost;

  -- Function to update car status to rented
  FUNCTION updatecarstatustorented (
    p_car_id IN NUMBER
  ) RETURN VARCHAR2 IS
    v_status car.car_status%TYPE;
  BEGIN
    SELECT car_status INTO v_status
    FROM car
    WHERE car_id = p_car_id;
    IF v_status = 'Available' THEN
        UPDATE car
        SET car_status = 'Rented'
        WHERE car_id = p_car_id; 
        RETURN 'Car status updated to rented';
    ELSE
        RETURN 'Car is not available for rent';
    END IF;
  EXCEPTION
    WHEN no_data_found THEN
        RETURN 'Car not found';
  END updatecarstatustorented;

  -- Function to update rental status to returned
  FUNCTION update_rental_status(
    p_rental_id NUMBER
  ) RETURN VARCHAR2 IS
    v_start_date CAR_RENTAL.start_date%TYPE;
    v_end_date CAR_RENTAL.end_date%TYPE;
  BEGIN
    -- Validate rental ID before updating
    SELECT start_date, end_date INTO v_start_date, v_end_date
    FROM CAR_RENTAL 
    WHERE rental_id = p_rental_id;

    -- Check if the rental is within the valid period
    IF SYSDATE >= v_start_date AND v_end_date IS NULL THEN
        -- Update rental status to 'Returned'
        UPDATE car_rental
        SET rent_status = 'Returned'
        WHERE rental_id = p_rental_id;
        RETURN 'Rental ID ' || p_rental_id || ' status changed to returned';
    ELSE
        RETURN 'Rental ID ' || p_rental_id || ' did not change the status';
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Rental ID ' || p_rental_id || ' not found.';
    WHEN OTHERS THEN
        RETURN 'Error updating rental ID ' || p_rental_id || ': ' || SQLERRM;
  END update_rental_status;

  -- Function to calculate total cost of extra equipment rented for a rental
  FUNCTION calculate_extra_equipment_cost(p_rental_id IN NUMBER)
  RETURN NUMBER IS
    v_total_cost NUMBER := 0;
  BEGIN
    FOR rec IN (
      SELECT re.rental_id, re.equipment_id, re.quantity, ee.price
      FROM Rental_Equipment re
      JOIN Extra_Equipment ee ON re.equipment_id = ee.equipment_id
      WHERE re.rental_id = p_rental_id
    )
    LOOP
      v_total_cost := v_total_cost + (rec.quantity * rec.price);
    END LOOP;

    RETURN v_total_cost;
  END calculate_extra_equipment_cost;
END Rental_Management;
/

--triggers 
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
    else
    dbms_output.put_line('The car is not available');
    END IF;
END;
/


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
        :new.cost_rent := Rental_Management.calculateoriginalcost(:new.Rent_duration, daily_rate);
        dbms_output.put_line(Rental_Management.updatecarstatustorented(:new.Car_id));
        :new.rent_status := 'Confirmed';
    else
    dbms_output.put_line('The car is not available');
    END IF;
END;
/

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

     penalty := Rental_Management.calculatepenaltycost(:OLD.start_date, :NEW.end_date, v_daily_rate, v_penalty_rate,:old.rent_duration);
    :NEW.penalty := penalty ;
    UPDATE Car
    set car_status = 'Available'
    where :OLD.car_id = car_id;
    
    v_equipment_cost := calculate_extra_equipment_cost(:old.rental_id);
    INSERT INTO Payment (payment_id, payment_date, Payment_Method, Total_amount, rental_id)
    VALUES (PAYMENT_SEQ.nextval, TO_DATE('2023-06-05', 'YYYY-MM-DD'), null, v_equipment_cost + penalty + :old.cost_rent , :old.rental_id);

END;
/

--procedure
CREATE OR REPLACE PROCEDURE total_rental_income (o_total_income OUT NUMBER) IS
BEGIN
  SELECT SUM(Cost_rent)
  INTO o_total_income
  FROM Car_rental;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    o_total_income := 0;
END total_rental_income;
/

CREATE OR REPLACE PROCEDURE rentals_per_status (o_rental_status_report OUT SYS_REFCURSOR) IS
BEGIN
  OPEN o_rental_status_report FOR
    SELECT rent_status, COUNT(rental_id) as total_rentals
    FROM Car_rental
    GROUP BY rent_status;
END rentals_per_status;
/

CREATE OR REPLACE PROCEDURE find_most_rented_car(
    p_month IN NUMBER,
    p_year IN NUMBER
) IS
    v_start_date DATE;
    v_end_date DATE;
    v_most_rented_model VARCHAR2(100);
    v_rent_count NUMBER := 0;
BEGIN
    v_start_date := TO_DATE(p_year || '-' || p_month || '-01', 'YYYY-MM-DD');
    v_end_date := LAST_DAY(v_start_date);

    SELECT m.model_name, COUNT(cr.rental_id) AS rent_count
    INTO v_most_rented_model, v_rent_count
    FROM Car_rental cr
    JOIN Car c ON cr.car_id = c.car_id
    JOIN Model m ON m.model_id = c.model_id
    WHERE cr.start_date >= v_start_date AND cr.end_date <= v_end_date
    GROUP BY m.model_name
    ORDER BY COUNT(cr.rental_id) DESC
    FETCH FIRST ROW ONLY;

    DBMS_OUTPUT.PUT_LINE('The most rented car for ' || TO_CHAR(v_start_date, 'YYYY-MM') || ' is Model: ' || v_most_rented_model || ', Rent Count: ' || v_rent_count);
END;
/

--manufacturer data
INSERT INTO Manufacturer (manufactuerer_id, Manufacturer_name)
VALUES (1, 'Toyota');

INSERT INTO Manufacturer (manufactuerer_id, Manufacturer_name)
VALUES (2, 'Honda');

INSERT INTO Manufacturer (manufactuerer_id, Manufacturer_name)
VALUES (3, 'Ford');

INSERT INTO Manufacturer (manufactuerer_id, Manufacturer_name)
VALUES (4, 'Chevrolet');

INSERT INTO Manufacturer (manufactuerer_id, Manufacturer_name)
VALUES (5, 'BMW');

INSERT INTO Manufacturer (manufactuerer_id, Manufacturer_name)
VALUES (6, 'Mercedes-Benz');

INSERT INTO Manufacturer (manufactuerer_id, Manufacturer_name)
VALUES (7, 'Volkswagen');

INSERT INTO Manufacturer (manufactuerer_id, Manufacturer_name)
VALUES (8, 'Audi');

INSERT INTO Manufacturer (manufactuerer_id, Manufacturer_name)
VALUES (9, 'Nissan');

INSERT INTO Manufacturer (manufactuerer_id, Manufacturer_name)
VALUES (10, 'Hyundai');

--location data
INSERT INTO Location (location_id, phone_number, address, city) VALUES
(1, '36123456', '2834', 'Manama');

INSERT INTO Location (location_id, phone_number, address, city) VALUES
(2, '36234567', '7198', 'Riffa');

INSERT INTO Location (location_id, phone_number, address, city) VALUES
(3, '36345678', '5620', 'Muharraq');

INSERT INTO Location (location_id, phone_number, address, city) VALUES
(4, '36456789', '8931', 'Hamad Town');

INSERT INTO Location (location_id, phone_number, address, city) VALUES
(5, '36567890', '8012', 'A''ali');

--car category data
INSERT INTO Car_Category (Category_id, category_name)
VALUES (10, 'ECO');

INSERT INTO Car_Category (Category_id, category_name)
VALUES (20, 'LUX');

INSERT INTO Car_Category (Category_id, category_name)
VALUES (30, 'SUV');

--extra equipment data
INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'GPS Navigation System', 'GPS', 10, 5);

INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'Child Car Seat', 'Child Seat', 5, 10);

INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'Roof Rack', 'Roof Rack', 15, 3);

INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'Ski Rack', 'Ski Rack', 12, 2);

INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'Bike Rack', 'Bike Rack', 8, 4);

INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'Snow Chains', 'Snow Chains', 6, 6);

INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'Car Cover', 'Car Cover', 8, 7);

INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'Portable Wi-Fi Hotspot', 'Wi-Fi Hotspot', 10, 5);

INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'Roof Cargo Box', 'Cargo Box', 20, 2);

INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'Portable DVD Player', 'DVD Player', 5, 3);

INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'Car Phone Mount', 'Phone Mount', 3, 8);

INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'First Aid Kit', 'First Aid Kit', 4, 10);

INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'Car Vacuum Cleaner', 'Vacuum Cleaner', 7, 6);

INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'Car Air Freshener', 'Air Freshener', 2, 15);

INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'Portable Air Compressor', 'Air Compressor', 8, 4);
--job data
INSERT INTO Job (Job_id, staff_role_type_, Role_description) VALUES
(1, 'Manager', 'Responsible for overseeing daily operations, managing staff, and ensuring smooth functioning of the car rental company.');

INSERT INTO Job (Job_id, staff_role_type_, Role_description) VALUES
(2, 'Customer Service Representative', 'Assisting customers with inquiries, providing information about rental services, processing reservations, and resolving customer issues.');

INSERT INTO Job (Job_id, staff_role_type_, Role_description) VALUES
(3, 'Car Rental Agent', 'Handling rental transactions, checking vehicle availability, providing rental agreements, and coordinating vehicle pickups and returns.');

INSERT INTO Job (Job_id, staff_role_type_, Role_description) VALUES
(4, 'Mechanic', 'Performing routine maintenance and repairs on rental vehicles, ensuring their safety and functionality.');

INSERT INTO Job (Job_id, staff_role_type_, Role_description) VALUES
(5, 'Accountant', 'Handling financial transactions, managing accounts receivable and payable, and preparing financial reports for the car rental company.');

INSERT INTO Job (Job_id, staff_role_type_, Role_description) VALUES
(6, 'Sales Representative', 'Promoting rental services to potential customers, negotiating rental agreements, and achieving sales targets.');
-- model data
-- Toyota models
INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (1, 'Camry', 1, 2.5);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (2, 'Corolla', 1, 1.8);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (3, 'RAV4', 1, 2.5);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (4, 'Highlander', 1, 3.5);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (5, 'Prius', 1, 1.8);


-- Honda models
INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (6, 'Accord', 2, 2.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (7, 'Civic', 2, 1.5);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (8, 'CR-V', 2, 1.5);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (9, 'Pilot', 2, 3.5);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (10, 'Odyssey', 2, 3.5);


-- Ford models
INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (11, 'Mustang', 3, 5.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (12, 'Fusion', 3, 2.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (13, 'Escape', 3, 2.5);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (14, 'Explorer', 3, 3.3);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (15, 'Ranger', 3, 2.3);


-- Chevrolet models
INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (16, 'Cruze', 4, 1.4);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (17, 'Malibu', 4, 1.5);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (18, 'Equinox', 4, 1.5);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (19, 'Traverse', 4, 3.6);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (20, 'Silverado', 4, 5.3);


-- BMW models
INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (21, '3 Series', 5, 3.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (22, '5 Series', 5, 3.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (23, 'X3', 5, 3.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (24, 'X5', 5, 3.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (25, 'i8', 5, 1.5);

-- Mercedes-Benz models
INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (26, 'C-Class', 6, 2.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (27, 'E-Class', 6, 4.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (28, 'GLC', 6, 2.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (29, 'GLE', 6, 2.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (30, 'S-Class', 6, 3.0);


-- Volkswagen models
INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (31, 'Golf', 7, 2.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (32, 'Passat', 7, 2.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (33, 'Tiguan', 7, 2.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (34, 'Atlas', 7, 3.6);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (35, 'Arteon', 7, 2.0);


-- Audi models
INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (36, 'A3', 8, 1.4);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (37, 'A4', 8, 2.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (38, 'Q5', 8, 2.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (39, 'Q7', 8, 3.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (40, 'R8', 8, 5.2);


-- Nissan models
INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (41, 'Altima', 9, 2.5);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (42, 'Sentra', 9, 1.8);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (43, 'Rogue', 9, 2.5);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (44, 'Pathfinder', 9, 3.5);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (45, 'Titan', 9, 5.6);


-- Hyundai models
INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (46, 'Elantra', 10, 2.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (47, 'Sonata', 10, 2.5);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (48, 'Tucson', 10, 2.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (49, 'Santa Fe', 10, 2.5);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (50, 'Palisade', 10, 3.8);


--customer data
INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Ahmad', 'ahmad@mail.com', 'Khalil', '36678901', 'Manama', '031234567', '9876', '5678', '7856');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Sara', 'sara@mail.com', 'Ali', '36876543', 'Riffa', '032345678', '5432', '2100', '9821');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Muhammad', 'muhammad@mail.com', 'Abdullah', '36654321', 'Muharraq', '037890123', '6543', '1002', '210');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Fatima', 'fatima@mail.com', 'Ahmed', '36987654', 'Hamad Town', '039876543', '1234', '3497', '9734');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Ali', 'ali@mail.com', 'Hassan', '36654321', 'Hamad Town', '030987654', '5678', '8943', '4398');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Yasmin', 'yasmin@mail.com', 'Mohammed', '36789012', 'Isa Town', '033456789', '8765', '4523', '2354');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Hassan', 'hassan@mail.com', 'Ahmad', '36789012', 'Sitra', '038901234', '4321', '2120', '2012');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Layla', 'layla@mail.com', 'Mohamed', '36876543', 'Budaiya', '031098765', '7890', '3489', '8934');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Jaber', 'jaber@mail.com', 'Abdulaziz', '36901234', 'Jidhafs', '036543210', '3456', '6781', '8167');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Nour', 'nour@mail.com', 'Hussein', '36654321', 'Al-Malikiyah', '032109876', '9012', '5676', '7656');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Mariam', 'mariam@mail.com', 'Ali', '36789012', 'Jid Ali', '000123456', '2345', '7620', '2076');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Khalid', 'khalid@mail.com', 'Ibrahim', '36987654', 'Sanabis', '004567890', '6789', '2037', '3720');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Jana', 'jana@mail.com', 'Abdullah', '36654321', 'Tubli', '009876543', '4567', '3774', '7437');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Rania', 'rania@mail.com', 'Youssef', '36876543', 'Durrat Al Bahrain', '001234567', '7890', '2167', '6721');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Hamza', 'hamza@mail.com', 'Ali', '36654321', 'Gudaibiya', '007890123', '1234', '9850', '5098');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Zahra', 'zahra@mail.com', 'Hassan', '36789012', 'Salmabad', '005678901', '5678', '1117', '1711');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Hadi', 'hadi@mail.com', 'Ahmad', '36789012', 'Jurdab', '002345678', '8901', '2345', '4532');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Nadia', 'nadia@mail.com', 'Khalid', '36876543', 'Diyar Al Muharraq', '008901234', '3456', '1012', '1210');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Haider', 'haider@mail.com', 'Saeed', '36654321', 'Amwaj Islands', '003456789', '6789', '1853', '5318');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Laila', 'laila@mail.com', 'Abdulrahman', '36987654', 'Al Hidd', '006543210', '9012', '3287', '8732');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Yousef', 'yousef@mail.com', 'Mohammed', '36654321', 'Arad', '061234567', '2345', '5096', '9650');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Rasha', 'rasha@mail.com', 'Ahmad', '36789012', 'Busaiteen', '068901234', '6789', '4872', '7248');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Abdullah', 'abdullah@mail.com', 'Ibrahim', '36876543', 'Samaheej', '064567890', '3456', '7914', '7914');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Nora', 'nora@mail.com', 'Ali', '36789012', 'Al Dair', '060123456', '7890', '2775', '7527');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Ahmed', 'ahmed@mail.com', 'Hassan', '36654321', 'Zinj', '067890123', '1234', '8532', '3285');
--car data


INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 1, 778997, TO_DATE('2027-05-31', 'YYYY-MM-DD'), 2021, 'Red', 50000, 50.00, 'Available', 10, 1);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 2, 654321, TO_DATE('2024-06-15', 'YYYY-MM-DD'), 2020, 'Blue', 45000, 60.00, 'Available', 10, 1);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 3, 98765, TO_DATE('2025-07-01', 'YYYY-MM-DD'), 2022, 'Black', 60000, 55.00, 'Available', 10, 1);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 4, 54321, TO_DATE('2026-07-15', 'YYYY-MM-DD'), 2019, 'White', 90000, 65.00, 'Available', 30, 1);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 5, 987654, TO_DATE('2023-08-01', 'YYYY-MM-DD'), 2020, 'Silver', 55000, 60.00, 'Available', 10, 2);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 6, 12345, TO_DATE('2023-08-15', 'YYYY-MM-DD'), 2021, 'Gray', 48000, 70.00, 'Available', 30, 2);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 7, 67890, TO_DATE('2023-09-01', 'YYYY-MM-DD'), 2019, 'Red', 52000, 55.00, 'Available', 10, 2);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 8, 54321, TO_DATE('2023-09-15', 'YYYY-MM-DD'), 2020, 'Blue', 42000, 65.00, 'Available', 20, 2);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 9, 98765, TO_DATE('2023-10-01', 'YYYY-MM-DD'), 2021, 'Black', 58000, 60.00, 'Available', 30, 2);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 10, 12345, TO_DATE('2023-10-15', 'YYYY-MM-DD'), 2019, 'White', 40000, 70.00, 'Available', 10, 3);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 16, 18245, TO_DATE('2023-9-26', 'YYYY-MM-DD'), 2021, 'Brown', 30000, 56.00, 'Available', 10, 3);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 31, 94603, TO_DATE('2023-10-15', 'YYYY-MM-DD'), 2018, 'Red', 45000, 65.00, 'Available', 10, 3);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 30, 81540, TO_DATE('2024-8-8', 'YYYY-MM-DD'), 2023, 'Black', 12000, 80.00, 'Available', 20, 3);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 33, 63798, TO_DATE('2023-12-7', 'YYYY-MM-DD'), 2017, 'White', 64000, 58.00, 'Available', 30, 3);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 12, 62489, TO_DATE('2023-11-5', 'YYYY-MM-DD'), 2015, 'Grey', 100000, 50.00, 'Available', 10, 4);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 1, 63451, TO_DATE('2024-2-6', 'YYYY-MM-DD'), 2021, 'White', 48000, 60.00, 'Available', 10, 4);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 7, 65802, TO_DATE('2024-1-28', 'YYYY-MM-DD'), 2020, 'Blue', 30000, 59.00, 'Available', 10, 4);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 3, 67802, TO_DATE('2025-10-21', 'YYYY-MM-DD'), 2022, 'Silver', 21000, 62.00, 'Available', 30, 4);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 27, 40210, TO_DATE('2025-8-26', 'YYYY-MM-DD'), 2020, 'Grey', 29000, 71.00, 'Available', 20, 4);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 36, 45152, TO_DATE('2024-6-21', 'YYYY-MM-DD'), 2019, 'Blue', 52000, 58.00, 'Available', 10, 5);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 44, 59782, TO_DATE('2024-7-12', 'YYYY-MM-DD'), 2017, 'Brown', 70000, 57.00, 'Available', 30, 5);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 46, 54395, TO_DATE('2024-3-20', 'YYYY-MM-DD'), 2022, 'Silver', 32000, 53.00, 'Available', 10, 5);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 6, 16489, TO_DATE('2024-8-28', 'YYYY-MM-DD'), 2023, 'Black', 20000, 62.00, 'Available', 10, 5);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 11, 64239, TO_DATE('2025-6-16', 'YYYY-MM-DD'), 2023, 'White', 11000, 72.00, 'Available', 20, 5);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 25, 39267, TO_DATE('2025-12-30', 'YYYY-MM-DD'), 2023, 'Grey', 13000, 110.00, 'Available', 20, 5);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 40, 19360, TO_DATE('2025-10-23', 'YYYY-MM-DD'), 2023, 'Green', 16000, 123.00, 'Available', 20, 2);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 9, 16502, TO_DATE('2024-12-5', 'YYYY-MM-DD'), 2020, 'Brown', 62000, 57.00, 'Available', 30, 2);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 3, 62029, TO_DATE('2024-11-17', 'YYYY-MM-DD'), 2021, 'Black', 46000, 58.00, 'Available', 30, 3);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 3, 30269, TO_DATE('2024-11-17', 'YYYY-MM-DD'), 2021, 'Black', 43000, 58.00, 'Available', 30, 3);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 40, 19564, TO_DATE('2025-10-23', 'YYYY-MM-DD'), 2023, 'Purple', 20000, 119.00, 'Available', 20, 4);


-- staff data

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Ahmed', 'Ali', '018635906', 'Manama', '39654321', 1, 1, '8901', '2109', '7654');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Mohammed', 'Khalid', '191939729', 'Riffa', '39123456', 2, 1, '1234', '5678', '9012');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Abdullah', 'Saeed', '075003766', 'Muharraq', '39234567', 2, 1, '3456', '7890', '6543');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Fatima', 'Hassan', '341171842', 'Hamad Town', '39345678', 3, 1, '8765', '0987', '4321');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Ali', 'Mohammed', '370309445', 'A''ali', '39456789', 5, 1, '2109', '6543', '8901');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Hassan','Ahmed', '968634549', 'Isa Town', '39567890', 1, 2, '9876', '5432', '1098');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Omar', 'Khalifa', '599895419', 'Sitra', '39678901', 2, 2, '4567', '9012', '3456');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Sara', 'Abdulrahman', '890568600', 'Budaiya', '39789012', 2, 2, '7890', '2345', '6789');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Nora', 'Hamed', '673481775', 'Jidhafs', '39890123', 5, 2, '1234', '5678', '9012');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Yousef', 'Khaled', '916899167', 'Al-Malikiyah', '39901234', 4, 2, '3456', '7890', '6543');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Jassim', 'Saleh', '059124166', 'Jid Ali', '39123456', 1, 3, '9876', '5678', '7856');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Huda', 'Khalifa', '994665707', 'Sanabis', '39234567', 2, 3, '4567', '9087', '1234');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Ahmed', 'Mohammed', '872317579', 'Tubli', '39345678', 4, 3, '7890', '2345', '8765');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Rana', 'Ali', '773643662', 'Durrat Al Bahrain', '39456789', 5, 3, '3456', '6789', '4321');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Majed', 'Hassan', '655159297', 'Gudaibiya', '39567890', 6, 3, '8901', '2109', '7654');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Layla', 'Saeed', '884304216', 'Salmabad', '39678901', 1, 4, '1234', '5678', '9012');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Khalid', 'Abdulrahman', '789876543', 'Jurdab', '39789012', 2, 4, '3456', '7890', '6543');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Hanan', 'Mohammed', '898765432', 'Diyar Al Muharraq', '39890123', 2, 4, '8765', '0987', '4321');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Faisal', 'Ahmed', '987654321', 'Amwaj Islands', '39901234', 4, 4, '2109', '6543', '8901');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Qaima ', 'Dallal', '876543210', 'Al Hidd', '39123456', 1, 5, '9876', '5432', '1098');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Azahar', 'Amini', '754398308', 'Gudaibiya', '39123456', 2, 5, '9876', '5678', '7856');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Zahir ', 'Mourad', '871546754', 'Sanabis', '39123456', 2, 5, '4567', '9087', '1234');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Syed ', 'Arif', '924810701', 'Al Hidd', '39123456', 5, 5, '7890', '2345', '8765');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Aiza ', 'Karam', '963305637', 'Tubli', '39123456', 6, 5, '3456', '6789', '4321');

-- car rental data

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3001, 1001, 7, TO_DATE('2022-06-01', 'YYYY-MM-DD'), 7001);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3002, 1002, 5, TO_DATE('2022-07-01', 'YYYY-MM-DD'), 7002);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3003, 1003, 12, TO_DATE('2022-6-23', 'YYYY-MM-DD'), 7003);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3004, 1004, 3, TO_DATE('2022-07-01', 'YYYY-MM-DD'), 7004);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3005, 1005, 7, TO_DATE('2021-12-06', 'YYYY-MM-DD'), 7005);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3006, 1006, 15, TO_DATE('2023-01-7', 'YYYY-MM-DD'), 7006);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3007, 1007, 14, TO_DATE('2022-6-27', 'YYYY-MM-DD'), 7007);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3008, 1008, 2, TO_DATE('2021-04-20', 'YYYY-MM-DD'), 7008);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3009, 1009, 8, TO_DATE('2022-04-03', 'YYYY-MM-DD'), 7009);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3010, 1010, 5, TO_DATE('2023-02-17', 'YYYY-MM-DD'), 7010);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3011, 1011, 16, TO_DATE('2023-02-23', 'YYYY-MM-DD'), 7011);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3012, 1012, 15, TO_DATE('2022-07-30', 'YYYY-MM-DD'), 7012);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3013, 1013, 2, TO_DATE('2021-10-01', 'YYYY-MM-DD'), 7013);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3014, 1014, 5, TO_DATE('2023-08-09', 'YYYY-MM-DD'), 7014);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3015, 1015, 20, TO_DATE('2021-01-29', 'YYYY-MM-DD'), 7015);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3016, 1016, 11, TO_DATE('2022-02-09', 'YYYY-MM-DD'), 7016);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3017, 1017, 23, TO_DATE('2023-04-26', 'YYYY-MM-DD'), 7017);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3018, 1018, 5, TO_DATE('2023-05-04', 'YYYY-MM-DD'), 7018);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3019, 1019, 7, TO_DATE('2022-09-26', 'YYYY-MM-DD'), 7019);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3020, 1020, 8, TO_DATE('2022-12-06', 'YYYY-MM-DD'), 7020);
--
INSERT INTO Rental_Equipment (rental_id, equipment_id, quantity)
VALUES (2010, 4002, 1);

INSERT INTO Rental_Equipment (rental_id, equipment_id, quantity)
VALUES (2013, 4007, 1);

INSERT INTO Rental_Equipment (rental_id, equipment_id, quantity)
VALUES (2012, 4013, 1);

INSERT INTO Rental_Equipment (rental_id, equipment_id, quantity)
VALUES (2015, 4015, 1);

INSERT INTO Rental_Equipment (rental_id, equipment_id, quantity)
VALUES (2002, 4011, 2);

INSERT INTO Rental_Equipment (rental_id, equipment_id, quantity)
VALUES (2006, 4012, 3);

INSERT INTO Rental_Equipment (rental_id, equipment_id, quantity)
VALUES (2023, 4001, 1);
--
update car_rental
set end_date = '12-JUN-22'
where rental_id = 2001;

update car_rental
set end_date = '06-JUL-22'
where rental_id = 2002;

update car_rental
set end_date = '07-JUL-22'
where rental_id = 2003;

update car_rental
set end_date = '04-JUL-22'
where rental_id = 2004;

update car_rental
set end_date = '13-DEC-21'
where rental_id = 2005;

update car_rental
set end_date = '30-JAN-23'
where rental_id = 2006;

update car_rental
set end_date = '11-JUL-22'
where rental_id = 2007;

update car_rental
set end_date = '22-APR-21'
where rental_id = 2008;

update car_rental
set end_date = '11-APR-22'
where rental_id = 2009;

update car_rental
set end_date = '22-FEB-23'
where rental_id = 2010;

update car_rental
set end_date = '14-MAR-23'
where rental_id = 2011;

update car_rental
set end_date = '14-AUG-22'
where rental_id = 2012;

update car_rental
set end_date = '06-OCT-21'
where rental_id = 2013;

update car_rental
set end_date = '14-AUG-23'
where rental_id = 2014;

update car_rental
set end_date = '18-FEB-21'
where rental_id = 2015;

update car_rental
set end_date = '21-FEB-22'
where rental_id = 2016;

update car_rental
set end_date = '19-MAY-23'
where rental_id = 2017;

update car_rental
set end_date = '09-MAY-23'
where rental_id = 2018;

update car_rental
set end_date = '04-OCT-22'
where rental_id = 2019;

update car_rental
set end_date = '14-DEC-22'
where rental_id = 2020;
