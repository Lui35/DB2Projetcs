CREATE OR REPLACE FUNCTION calculateoriginalcost (
    start_date IN DATE,
    end_date   IN DATE,
    daily_rate IN NUMBER
) RETURN NUMBER IS
    days          INTEGER;
    original_cost NUMBER;
BEGIN
    days := end_date - start_date;
    original_cost := days * daily_rate;
    RETURN original_cost;
END calculateoriginalcost;
/

CREATE OR REPLACE FUNCTION calculatepenaltycost (
    start_date         IN DATE,
    end_date           IN DATE,
    daily_rate         IN NUMBER,
    penalty_percentage IN NUMBER
) RETURN NUMBER IS
    days         INTEGER;
    penalty_cost NUMBER;
BEGIN
    days := end_date - start_date;
    penalty_cost := days * daily_rate * ( ( penalty_percentage / 100 ) );
    RETURN penalty_cost;
END calculatepenaltycost;
/

CREATE OR REPLACE FUNCTION calculatetotalcost (
    orignal_cost IN NUMBER,
    panalty      IN NUMBER
) RETURN NUMBER IS
    payment_cost NUMBER;
BEGIN
    payment_cost := orignal_cost + panalty;
    RETURN payment_cost;
END calculatetotalcost;
/

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

        COMMIT;
        RETURN 'Car status updated to rented';
    ELSE
        RETURN 'Car is not available for rent';
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        RETURN 'Car not found';
END updatecarstatustorented;
/