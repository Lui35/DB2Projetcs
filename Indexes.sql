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