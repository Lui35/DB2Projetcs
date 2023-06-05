set serveroutput on;

DECLARE
  v_max NUMBER;
  v_min NUMBER;
  v_return VARCHAR2(100);
BEGIN
  -- Retrieve the minimum and maximum rental IDs
  SELECT MIN(rental_id), MAX(rental_id)
  INTO v_min, v_max
  FROM car_rental;

  -- Handle inconsistent rental IDs with gaps
  FOR counter IN v_min .. v_max LOOP
    -- Call the function only if the rental ID exists in the table
    BEGIN
      SELECT rental_id INTO v_return
      FROM car_rental
      WHERE rental_id = counter;

      v_return := UPDATE_RENTAL_STATUS(counter);
      DBMS_OUTPUT.PUT_LINE(v_return);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Rental ID ' || counter || ' not found.');
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error updating rental ID ' || counter || ': ' || SQLERRM);
    END;
  END LOOP;
END;
/

---------------------------
DECLARE
  v_total_income NUMBER;
  v_rental_status_report SYS_REFCURSOR;
  v_rent_status VARCHAR2(20);
  v_total_rentals NUMBER;
BEGIN
  total_rental_income(v_total_income);
  DBMS_OUTPUT.PUT_LINE('Total Rental Income: ' || v_total_income);

  rentals_per_status(v_rental_status_report);

  DBMS_OUTPUT.PUT_LINE('Rent Status Report:');
  LOOP
    FETCH v_rental_status_report INTO v_rent_status, v_total_rentals;
    EXIT WHEN v_rental_status_report%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(v_rent_status || ': ' || v_total_rentals);
  END LOOP;
  CLOSE v_rental_status_report;
END;
/
-------------------------------------
DECLARE
    duration_in_days NUMBER := 7;
    daily_rental_rate NUMBER := 50;
    cost NUMBER;
BEGIN
    cost := calculateoriginalcost(duration_in_days, daily_rental_rate);
    DBMS_OUTPUT.PUT_LINE('The original cost for a rental duration of ' || duration_in_days || ' days is: $' || cost);
END;
/
------------------------------------
DECLARE
    start_date           DATE := TO_DATE('2023-06-01', 'YYYY-MM-DD');
    end_date             DATE := TO_DATE('2023-06-05', 'YYYY-MM-DD');
    daily_rental_rate    NUMBER := 50;
    penalty_percentage   NUMBER := 10;
    rent_duration        NUMBER := 3;
    penalty_cost         NUMBER;
BEGIN
    penalty_cost := calculatepenaltycost(start_date, end_date, daily_rental_rate, penalty_percentage, rent_duration);
    DBMS_OUTPUT.PUT_LINE('The penalty cost for the rental period is: $' || penalty_cost);
END;
/
-------------------------------------
BEGIN
    find_most_rented_car(6, 2023); 
END;
/








