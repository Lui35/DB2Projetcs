
CREATE TABLE Job (
                Job_id NUMBER(10) NOT NULL,
                staff_role_type_ VARCHAR2(30) NOT NULL,
                Role_description VARCHAR2(100) NOT NULL,
                CONSTRAINT JOB_PK PRIMARY KEY (Job_id)
);


CREATE TABLE Manufacturer (
                manufactuerer_id NUMBER NOT NULL,
                Manufacturer_name VARCHAR2(50) NOT NULL,
                CONSTRAINT MANUFACTURER_PK PRIMARY KEY (manufactuerer_id)
);


CREATE TABLE Model (
                model_id NUMBER NOT NULL,
                Model_name VARCHAR2(50) NOT NULL,
                manufactuerer_id NUMBER NOT NULL,
                engine_size NUMBER NOT NULL,
                CONSTRAINT MODEL_PK PRIMARY KEY (model_id)
);


CREATE TABLE extra_equipment (
                equipment_id NUMBER NOT NULL,
                description VARCHAR2(200) NOT NULL,
                equipment_name VARCHAR2(20) NOT NULL,
                price NUMBER NOT NULL,
                quantity NUMBER NOT NULL,
                CONSTRAINT EXTRA_EQUIPMENT_PK PRIMARY KEY (equipment_id)
);


CREATE TABLE Car_Category (
                Category_id NUMBER NOT NULL,
                category_name VARCHAR2(20) NOT NULL,
                CONSTRAINT CAR_CATEGORY_PK PRIMARY KEY (Category_id),
                CONSTRAINT CATEGORY_NAME_CHECK CHECK (category_name IN ('ECO', 'LUX', 'SUV'))
);


CREATE TABLE Location (
                location_id NUMBER NOT NULL,
                phone_number VARCHAR2(20) NOT NULL,
                address VARCHAR2(50) NOT NULL,
                city VARCHAR2(50) NOT NULL,
                CONSTRAINT LOCATION_PK PRIMARY KEY (location_id)
);


CREATE TABLE Store (
                store_id NUMBER NOT NULL,
                location_id NUMBER NOT NULL,
                store_name VARCHAR2(50) NOT NULL,
                CONSTRAINT STORE_PK PRIMARY KEY (store_id)
);


CREATE TABLE Staff (
                staff_id NUMBER NOT NULL,
                first_name VARCHAR2(50) NOT NULL,
                address VARCHAR2(50) NOT NULL,
                last_name VARCHAR2(50) NOT NULL,
                cpr_number VARCHAR2(20),
                city VARCHAR2(50) NOT NULL,
                phone_number VARCHAR2(20) NOT NULL,
                Job_id NUMBER(10) NOT NULL,
                store_id NUMBER NOT NULL,
                CONSTRAINT STAFF_PK PRIMARY KEY (staff_id)
);


CREATE TABLE Car (
                car_id NUMBER NOT NULL,
                model_id NUMBER NOT NULL,
                plate_number NUMBER NOT NULL,
                car_registration_due_date DATE NOT NULL,
                manufacturing_year NUMBER NOT NULL,
                color VARCHAR2(20) NOT NULL,
                current_mileage NUMBER NOT NULL,
                daily_hire_rate NUMBER(8,2),
                daily_late_return_penalty NUMBER(8,2),
                car_status VARCHAR2(20) NOT NULL,
                Category_id NUMBER NOT NULL,
                CONSTRAINT CAR_PK PRIMARY KEY (car_id),
                CONSTRAINT CAR_STATUS_CHECK CHECK (car_status IN ('Available', 'Rented', '‘Under Maintenance'))
);


CREATE TABLE Customer  (
                customer_id NUMBER NOT NULL,
                first_name VARCHAR2(50) NOT NULL,
                email_address VARCHAR2(100),
                last_name VARCHAR2(50) NOT NULL,
                phone_number VARCHAR2(20) NOT NULL,
                city VARCHAR2(50) NOT NULL,
                cpr_number VARCHAR2(20),
                house_address VARCHAR2(20) NOT NULL,
                road_address VARCHAR2(20) NOT NULL,
                block_address VARCHAR2(20) NOT NULL,
                CONSTRAINT CUSTOMER_PK PRIMARY KEY (customer_id)
);


CREATE TABLE Car_rental (
                rental_id NUMBER NOT NULL,
                customer_id NUMBER NOT NULL,
                car_id NUMBER NOT NULL,
                rent_duration NUMBER NOT NULL,
                Cost_rent NUMBER NOT NULL,
                rent_status VARCHAR2(20) NOT NULL,
                start_date DATE NOT NULL,
                end_date DATE NOT NULL,
                penalty NUMBER,
                staff_id NUMBER NOT NULL,
                CONSTRAINT CAR_RENTAL_PK PRIMARY KEY (rental_id),
                CONSTRAINT RENT_STATUS_CHECK CHECK (rent_status IN ('Confirmed', 'On-going', 'Cancelled', 'Completed'))
);


CREATE TABLE Rental_Equipment (
                rental_id NUMBER NOT NULL,
                equipment_id NUMBER NOT NULL,
                CONSTRAINT RENTAL_EQUIPMENT_PK PRIMARY KEY (rental_id, equipment_id)
);


CREATE TABLE Payment (
                bill_id NUMBER(10) NOT NULL,
                bill_date DATE NOT NULL,
                payment_id NUMBER(10) NOT NULL,
                rental_id NUMBER NOT NULL,
                Payment_Method VARCHAR2(50) NOT NULL,
                CONSTRAINT PAYMENT_PK PRIMARY KEY (bill_id)
);


ALTER TABLE Staff ADD CONSTRAINT STAFF_ROLE_1_STAFF_FK
FOREIGN KEY (Job_id)
REFERENCES Job (Job_id)
NOT DEFERRABLE;

ALTER TABLE Model ADD CONSTRAINT MANUFACTURER_MODEL_FK
FOREIGN KEY (manufactuerer_id)
REFERENCES Manufacturer (manufactuerer_id)
NOT DEFERRABLE;

ALTER TABLE Car ADD CONSTRAINT MODEL_CAR_FK
FOREIGN KEY (model_id)
REFERENCES Model (model_id)
NOT DEFERRABLE;

ALTER TABLE Rental_Equipment ADD CONSTRAINT EXTRA_EQUIPMENT_RENTAL_EQUI657
FOREIGN KEY (equipment_id)
REFERENCES extra_equipment (equipment_id)
NOT DEFERRABLE;

ALTER TABLE Car ADD CONSTRAINT CAR_CATEGORY_CAR_FK
FOREIGN KEY (Category_id)
REFERENCES Car_Category (Category_id)
NOT DEFERRABLE;

ALTER TABLE Store ADD CONSTRAINT LOCATION_STORE_FK
FOREIGN KEY (location_id)
REFERENCES Location (location_id)
NOT DEFERRABLE;

ALTER TABLE Staff ADD CONSTRAINT STORE_STAFF_FK
FOREIGN KEY (store_id)
REFERENCES Store (store_id)
NOT DEFERRABLE;

ALTER TABLE Car_rental ADD CONSTRAINT STAFF_CAR_RENTAL_FK
FOREIGN KEY (staff_id)
REFERENCES Staff (staff_id)
NOT DEFERRABLE;

ALTER TABLE Car_rental ADD CONSTRAINT CAR_CAR_RENTAL_FK
FOREIGN KEY (car_id)
REFERENCES Car (car_id)
NOT DEFERRABLE;

ALTER TABLE Car_rental ADD CONSTRAINT CUSTOMER__CAR_RENTAL_FK
FOREIGN KEY (customer_id)
REFERENCES Customer  (customer_id)
NOT DEFERRABLE;

ALTER TABLE Payment ADD CONSTRAINT CAR_RENTAL_PAYMENT_FK
FOREIGN KEY (rental_id)
REFERENCES Car_rental (rental_id)
NOT DEFERRABLE;

ALTER TABLE Rental_Equipment ADD CONSTRAINT CAR_RENTAL_RENTAL_EQUIPMENT_FK
FOREIGN KEY (rental_id)
REFERENCES Car_rental (rental_id)
NOT DEFERRABLE;