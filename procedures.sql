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
---------------------------------------
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



