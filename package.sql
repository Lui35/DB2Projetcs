

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
