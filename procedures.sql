CREATE OR REPLACE PROCEDURE Insert_Customer AS
    p_first_name VARCHAR2(50);
    p_last_name VARCHAR2(50);
    p_phone_number VARCHAR2(20);
    p_house_address VARCHAR2(20);
    p_road_address VARCHAR2(20);
    p_block_address VARCHAR2(20);
    p_city VARCHAR2(50);
    p_email_address VARCHAR2(100);
    p_cpr_number VARCHAR2(20);
BEGIN
    p_first_name := '&first_name';
    p_last_name := '&last_name';
    p_phone_number := '&phone_number';
    p_house_address := '&house_address';
    p_road_address := '&road_address';
    p_block_address := '&block_address';
    p_city := '&city';
    p_email_address := '&email_address';
    p_cpr_number := '&cpr_number';

    INSERT INTO Customer (
        customer_id,
        first_name,
        last_name,
        phone_number,
        house_address,
        road_address,
        block_address,
        city,
        email_address,
        cpr_number
    ) VALUES (
        CUSTOMER_SEQ.nextval,
        p_first_name,
        p_last_name,
        p_phone_number,
        p_house_address,
        p_road_address,
        p_block_address,
        p_city,
        p_email_address,
        p_cpr_number
    );
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Data inserted successfully!');
END;
/
--------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE Insert_Staff AS
    p_first_name VARCHAR2(50);
    p_last_name VARCHAR2(50);
    p_road_address VARCHAR2(20);
    p_phone_number VARCHAR2(20);
    p_house_address VARCHAR2(20);
    p_block_address VARCHAR2(20);
    p_city VARCHAR2(50);
    p_cpr_number VARCHAR2(20);
    p_job_id NUMBER;
    p_location_id NUMBER;
BEGIN
    p_first_name := '&first_name';
    p_last_name := '&last_name';
    p_road_address := '&road_address';
    p_phone_number := '&phone_number';
    p_house_address := '&house_address';
    p_block_address := '&block_address';
    p_city := '&city';
    p_cpr_number := '&cpr_number';
    p_job_id := '&job_id';
    p_location_id := '&location_id';

    INSERT INTO Staff (
        staff_id,
        first_name,
        last_name,
        road_address,
        phone_number,
        house_address,
        block_address,
        city,
        cpr_number,
        job_id,
        location_id
    ) VALUES (
        staff_seq.nextval,
        p_first_name,
        p_last_name,
        p_road_address,
        p_phone_number,
        p_house_address,
        p_block_address,
        p_city,
        p_cpr_number,
        p_job_id,
        p_location_id
    );
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Data inserted successfully!');
END;
/
EXECUTE Insert_Staff;


--------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE updatecarstatustorented (
    p_car_id IN NUMBER
) IS
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
        dbms_output.put_line('Car status updated to rented'); 
    ELSE
        dbms_output.put_line('Car is not available for rent');
    END IF;
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Car not found');
END updatecarstatustorented;
/
----------------------------------------
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
----------------------------------------
CREATE OR REPLACE PROCEDURE rentals_per_status (o_rental_status_report OUT SYS_REFCURSOR) IS
BEGIN
  OPEN o_rental_status_report FOR
    SELECT rent_status, COUNT(rental_id) as total_rentals
    FROM Car_rental
    GROUP BY rent_status;
END rentals_per_status;
/
