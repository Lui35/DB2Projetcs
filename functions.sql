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
create or replace function update_rental_staus (
p_rental_id number
) return varchar2
IS
v_start_date DATE;
v_end_date Date;
BEGIN

Select Start_Date, End_date
into v_start_date, v_end_date
from CAR_RENTAL 
where p_rental_id = rental_id;

if sysdate >= v_start_date AND v_end_date is null then
update car_rental
set rent_status = 'On-going'
where p_rental_id = rental_id;

return 'Statues changed to on going';
end if;
return 'Didnt change the stat';
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


