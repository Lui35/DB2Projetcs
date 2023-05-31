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


