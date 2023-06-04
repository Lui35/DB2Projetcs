set serveroutput on;

declare
v_max number;
v_min number;
v_return varchar2(100);

begin
select MIN(rental_id), MAX(rental_id)
into v_min, v_max
from car_rental;

FOR counter in v_min .. v_max loop
v_return := UPDATE_RENTAL_STAUS(counter);
DBMS_OUTPUT.PUT_LINE(v_return);
end loop;
end;
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








