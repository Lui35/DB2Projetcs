CREATE OR REPLACE TRIGGER generate_email
BEFORE INSERT ON Staff
FOR EACH ROW
BEGIN
    :NEW.email_address := LOWER(:NEW.first_name) || '.' || LOWER(:NEW.last_name) || '@CarRental.com';
END;
/

CREATE OR REPLACE TRIGGER check_for_cusid
BEFORE INSERT ON car_rental
FOR EACH ROW
declare 
v_id integer;
BEGIN

    SELECT customer_id
    into v_id
    from customer
    where customer_id = :NEW.customer_id;
    
    if  v_id is null then
    
    
    end if;
    
     
END;
/

