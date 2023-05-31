--tables
CREATE TABLE Job (
                Job_id NUMBER NOT NULL,
                staff_role_type_ VARCHAR2(50) NOT NULL,
                Role_description VARCHAR2(150) NOT NULL,
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


CREATE TABLE Staff (
                staff_id NUMBER NOT NULL,
                first_name VARCHAR2(50) NOT NULL,
                last_name VARCHAR2(50) NOT NULL,
                road_address VARCHAR2(20) NOT NULL,
                phone_number VARCHAR2(20) NOT NULL,
                house_address VARCHAR2(20) NOT NULL,
                block_address VARCHAR2(20) NOT NULL,
                city VARCHAR2(50) NOT NULL,
                email_address VARCHAR2(100),
                cpr_number VARCHAR2(20),
                Job_id NUMBER NOT NULL,
                location_id NUMBER NOT NULL,
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
                daily_hire_rate NUMBER(8,2) NOT NULL,
                daily_late_return_penalty NUMBER(8,2) NOT NULL,
                car_status VARCHAR2(20) NOT NULL,
                Category_id NUMBER NOT NULL,
                location_id NUMBER NOT NULL,
                CONSTRAINT CAR_PK PRIMARY KEY (car_id),
                CONSTRAINT CAR_STATUS_CHECK CHECK (car_status IN ('Available', 'Rented', 'Under Maintenance'))
);


CREATE TABLE Customer  (
                customer_id NUMBER NOT NULL,
                first_name VARCHAR2(50) NOT NULL,
                last_name VARCHAR2(50) NOT NULL,
                phone_number VARCHAR2(20) NOT NULL,
                house_address VARCHAR2(20) NOT NULL,
                road_address VARCHAR2(20) NOT NULL,
                block_address VARCHAR2(20) NOT NULL,
                city VARCHAR2(50) NOT NULL,
                email_address VARCHAR2(100),
                cpr_number VARCHAR2(20),
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
                penalty NUMBER NOT NULL,
                Total_amount NUMBER NOT NULL,
                staff_id NUMBER NOT NULL,
                CONSTRAINT CAR_RENTAL_PK PRIMARY KEY (rental_id),
                CONSTRAINT RENT_STATUS_CHECK CHECK (rent_status IN ('Confirmed', 'On-going', 'Cancelled', 'Completed'))
);


CREATE TABLE Rental_Equipment (
                rental_id NUMBER NOT NULL,
                equipment_id NUMBER NOT NULL,
                quantity NUMBER NOT NULL,
                CONSTRAINT RENTAL_EQUIPMENT_PK PRIMARY KEY (rental_id, equipment_id)
);


CREATE TABLE Payment (
                bill_id NUMBER NOT NULL,
                payment_id NUMBER(10) NOT NULL,
                bill_date DATE NOT NULL,
                Payment_Method VARCHAR2(50) NOT NULL,
                Total_amount NUMBER NOT NULL,
                rental_id NUMBER NOT NULL,
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

ALTER TABLE Staff ADD CONSTRAINT LOCATION_STAFF_FK
FOREIGN KEY (location_id)
REFERENCES Location (location_id)
NOT DEFERRABLE;

ALTER TABLE Car ADD CONSTRAINT LOCATION_CAR_FK
FOREIGN KEY (location_id)
REFERENCES Location (location_id)
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
--triggers 
CREATE OR REPLACE TRIGGER generate_email
BEFORE INSERT ON Staff
FOR EACH ROW
BEGIN
    :NEW.email_address := LOWER(:NEW.first_name) || '.' || LOWER(:NEW.last_name) || '@CarRental.com';
END;
/
--functions
--sequences
CREATE SEQUENCE car_seq
     START WITH 1001
     INCREMENT BY 1
     MINVALUE 1
     MAXVALUE 9999999999999
     NOCYCLE
     NOCACHE;

CREATE SEQUENCE rental_seq
     START WITH 2001
     INCREMENT BY 1
     MINVALUE 1
     MAXVALUE 9999999999999
     NOCYCLE
     NOCACHE;

CREATE SEQUENCE customer_seq
     START WITH 3001
     INCREMENT BY 1
     MINVALUE 1
     MAXVALUE 99999
     CYCLE
     NOCACHE;

CREATE SEQUENCE equipment_seq
     START WITH 4001
     INCREMENT BY 1
     MINVALUE 1
     MAXVALUE 999999
     NOCYCLE
     NOCACHE;

CREATE SEQUENCE bill_seq
     START WITH 5001
     INCREMENT BY 1
     MINVALUE 1
     MAXVALUE 9999999999999
     CYCLE
     NOCACHE;

CREATE SEQUENCE payment_seq
     START WITH 6001
     INCREMENT BY 1
     MINVALUE 1
     MAXVALUE 9999999999999
     CYCLE
     NOCACHE;

CREATE SEQUENCE staff_seq
     START WITH 7001
     INCREMENT BY 1
     MINVALUE 1
     MAXVALUE 999999
     NOCYCLE
     NOCACHE;

--manufacture
INSERT INTO Manufacturer (manufactuerer_id, Manufacturer_name)
VALUES (1, 'Toyota');

INSERT INTO Manufacturer (manufactuerer_id, Manufacturer_name)
VALUES (2, 'Honda');

INSERT INTO Manufacturer (manufactuerer_id, Manufacturer_name)
VALUES (3, 'Ford');

INSERT INTO Manufacturer (manufactuerer_id, Manufacturer_name)
VALUES (4, 'Chevrolet');

INSERT INTO Manufacturer (manufactuerer_id, Manufacturer_name)
VALUES (5, 'BMW');

INSERT INTO Manufacturer (manufactuerer_id, Manufacturer_name)
VALUES (6, 'Mercedes-Benz');

INSERT INTO Manufacturer (manufactuerer_id, Manufacturer_name)
VALUES (7, 'Volkswagen');

INSERT INTO Manufacturer (manufactuerer_id, Manufacturer_name)
VALUES (8, 'Audi');

INSERT INTO Manufacturer (manufactuerer_id, Manufacturer_name)
VALUES (9, 'Nissan');

INSERT INTO Manufacturer (manufactuerer_id, Manufacturer_name)
VALUES (10, 'Hyundai');

--location
INSERT INTO Location (location_id, phone_number, address, city) VALUES
(1, '36123456', '2834', 'Manama');

INSERT INTO Location (location_id, phone_number, address, city) VALUES
(2, '36234567', '7198', 'Riffa');

INSERT INTO Location (location_id, phone_number, address, city) VALUES
(3, '36345678', '5620', 'Muharraq');

INSERT INTO Location (location_id, phone_number, address, city) VALUES
(4, '36456789', '8931', 'Hamad Town');

INSERT INTO Location (location_id, phone_number, address, city) VALUES
(5, '36567890', '8012', 'A''ali');

--car category
INSERT INTO Car_Category (Category_id, category_name)
VALUES (10, 'ECO');

INSERT INTO Car_Category (Category_id, category_name)
VALUES (20, 'LUX');

INSERT INTO Car_Category (Category_id, category_name)
VALUES (30, 'SUV');
--extra equipment
INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'GPS Navigation System', 'GPS', 10, 5);

INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'Child Car Seat', 'Child Seat', 5, 10);

INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'Roof Rack', 'Roof Rack', 15, 3);

INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'Ski Rack', 'Ski Rack', 12, 2);

INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'Bike Rack', 'Bike Rack', 8, 4);

INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'Snow Chains', 'Snow Chains', 6, 6);

INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'Car Cover', 'Car Cover', 8, 7);

INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'Portable Wi-Fi Hotspot', 'Wi-Fi Hotspot', 10, 5);

INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'Roof Cargo Box', 'Cargo Box', 20, 2);

INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'Portable DVD Player', 'DVD Player', 5, 3);

INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'Car Phone Mount', 'Phone Mount', 3, 8);

INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'First Aid Kit', 'First Aid Kit', 4, 10);

INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'Car Vacuum Cleaner', 'Vacuum Cleaner', 7, 6);

INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'Car Air Freshener', 'Air Freshener', 2, 15);

INSERT INTO extra_equipment (equipment_id, description, equipment_name, price, quantity)
VALUES (equipment_seq.nextval, 'Portable Air Compressor', 'Air Compressor', 8, 4);
--job data
INSERT INTO Job (Job_id, staff_role_type_, Role_description) VALUES
(1, 'Manager', 'Responsible for overseeing daily operations, managing staff, and ensuring smooth functioning of the car rental company.');

INSERT INTO Job (Job_id, staff_role_type_, Role_description) VALUES
(2, 'Customer Service Representative', 'Assisting customers with inquiries, providing information about rental services, processing reservations, and resolving customer issues.');

INSERT INTO Job (Job_id, staff_role_type_, Role_description) VALUES
(3, 'Car Rental Agent', 'Handling rental transactions, checking vehicle availability, providing rental agreements, and coordinating vehicle pickups and returns.');

INSERT INTO Job (Job_id, staff_role_type_, Role_description) VALUES
(4, 'Mechanic', 'Performing routine maintenance and repairs on rental vehicles, ensuring their safety and functionality.');

INSERT INTO Job (Job_id, staff_role_type_, Role_description) VALUES
(5, 'Accountant', 'Handling financial transactions, managing accounts receivable and payable, and preparing financial reports for the car rental company.');

INSERT INTO Job (Job_id, staff_role_type_, Role_description) VALUES
(6, 'Sales Representative', 'Promoting rental services to potential customers, negotiating rental agreements, and achieving sales targets.');
-- model data
-- Toyota models
INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (1, 'Camry', 1, 2.5);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (2, 'Corolla', 1, 1.8);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (3, 'RAV4', 1, 2.5);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (4, 'Highlander', 1, 3.5);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (5, 'Prius', 1, 1.8);


-- Honda models
INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (6, 'Accord', 2, 2.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (7, 'Civic', 2, 1.5);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (8, 'CR-V', 2, 1.5);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (9, 'Pilot', 2, 3.5);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (10, 'Odyssey', 2, 3.5);


-- Ford models
INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (11, 'Mustang', 3, 5.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (12, 'Fusion', 3, 2.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (13, 'Escape', 3, 2.5);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (14, 'Explorer', 3, 3.3);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (15, 'Ranger', 3, 2.3);


-- Chevrolet models
INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (16, 'Cruze', 4, 1.4);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (17, 'Malibu', 4, 1.5);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (18, 'Equinox', 4, 1.5);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (19, 'Traverse', 4, 3.6);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (20, 'Silverado', 4, 5.3);


-- BMW models
INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (21, '3 Series', 5, 3.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (22, '5 Series', 5, 3.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (23, 'X3', 5, 3.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (24, 'X5', 5, 3.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (25, 'i8', 5, 1.5);

-- Mercedes-Benz models
INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (26, 'C-Class', 6, 2.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (27, 'E-Class', 6, 4.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (28, 'GLC', 6, 2.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (29, 'GLE', 6, 2.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (30, 'S-Class', 6, 3.0);


-- Volkswagen models
INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (31, 'Golf', 7, 2.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (32, 'Passat', 7, 2.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (33, 'Tiguan', 7, 2.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (34, 'Atlas', 7, 3.6);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (35, 'Arteon', 7, 2.0);


-- Audi models
INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (36, 'A3', 8, 1.4);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (37, 'A4', 8, 2.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (38, 'Q5', 8, 2.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (39, 'Q7', 8, 3.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (40, 'R8', 8, 5.2);


-- Nissan models
INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (41, 'Altima', 9, 2.5);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (42, 'Sentra', 9, 1.8);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (43, 'Rogue', 9, 2.5);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (44, 'Pathfinder', 9, 3.5);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (45, 'Titan', 9, 5.6);


-- Hyundai models
INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (46, 'Elantra', 10, 2.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (47, 'Sonata', 10, 2.5);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (48, 'Tucson', 10, 2.0);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (49, 'Santa Fe', 10, 2.5);

INSERT INTO Model (model_id, Model_name, manufactuerer_id, engine_size)
VALUES (50, 'Palisade', 10, 3.8);
--customer
INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Ahmad', 'ahmad@mail.com', 'Khalil', '36678901', 'Manama', '031234567', '9876', '5678', '7856');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Sara', 'sara@mail.com', 'Ali', '36876543', 'Riffa', '032345678', '5432', '2100', '9821');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Muhammad', 'muhammad@mail.com', 'Abdullah', '36654321', 'Muharraq', '037890123', '6543', '1002', '210');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Fatima', 'fatima@mail.com', 'Ahmed', '36987654', 'Hamad Town', '039876543', '1234', '3497', '9734');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Ali', 'ali@mail.com', 'Hassan', '36654321', 'Hamad Town', '030987654', '5678', '8943', '4398');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Yasmin', 'yasmin@mail.com', 'Mohammed', '36789012', 'Isa Town', '033456789', '8765', '4523', '2354');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Hassan', 'hassan@mail.com', 'Ahmad', '36789012', 'Sitra', '038901234', '4321', '2120', '2012');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Layla', 'layla@mail.com', 'Mohamed', '36876543', 'Budaiya', '031098765', '7890', '3489', '8934');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Jaber', 'jaber@mail.com', 'Abdulaziz', '36901234', 'Jidhafs', '036543210', '3456', '6781', '8167');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Nour', 'nour@mail.com', 'Hussein', '36654321', 'Al-Malikiyah', '032109876', '9012', '5676', '7656');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Mariam', 'mariam@mail.com', 'Ali', '36789012', 'Jid Ali', '000123456', '2345', '7620', '2076');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Khalid', 'khalid@mail.com', 'Ibrahim', '36987654', 'Sanabis', '004567890', '6789', '2037', '3720');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Jana', 'jana@mail.com', 'Abdullah', '36654321', 'Tubli', '009876543', '4567', '3774', '7437');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Rania', 'rania@mail.com', 'Youssef', '36876543', 'Durrat Al Bahrain', '001234567', '7890', '2167', '6721');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Hamza', 'hamza@mail.com', 'Ali', '36654321', 'Gudaibiya', '007890123', '1234', '9850', '5098');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Zahra', 'zahra@mail.com', 'Hassan', '36789012', 'Salmabad', '005678901', '5678', '1117', '1711');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Hadi', 'hadi@mail.com', 'Ahmad', '36789012', 'Jurdab', '002345678', '8901', '2345', '4532');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Nadia', 'nadia@mail.com', 'Khalid', '36876543', 'Diyar Al Muharraq', '008901234', '3456', '1012', '1210');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Haider', 'haider@mail.com', 'Saeed', '36654321', 'Amwaj Islands', '003456789', '6789', '1853', '5318');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Laila', 'laila@mail.com', 'Abdulrahman', '36987654', 'Al Hidd', '006543210', '9012', '3287', '8732');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Yousef', 'yousef@mail.com', 'Mohammed', '36654321', 'Arad', '061234567', '2345', '5096', '9650');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Rasha', 'rasha@mail.com', 'Ahmad', '36789012', 'Busaiteen', '068901234', '6789', '4872', '7248');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Abdullah', 'abdullah@mail.com', 'Ibrahim', '36876543', 'Samaheej', '064567890', '3456', '7914', '7914');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Nora', 'nora@mail.com', 'Ali', '36789012', 'Al Dair', '060123456', '7890', '2775', '7527');

INSERT INTO Customer (customer_id, first_name, email_address, last_name, phone_number, city, cpr_number, house_address, road_address, block_address)
VALUES (customer_seq.nextval, 'Ahmed', 'ahmed@mail.com', 'Hassan', '36654321', 'Zinj', '067890123', '1234', '8532', '3285');
--car 

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 1, 778997, TO_DATE('2027-05-31', 'YYYY-MM-DD'), 2021, 'Red', 50000, 50.00, 10.00, 'Available', 10, 1);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 2, 654321, TO_DATE('2024-06-15', 'YYYY-MM-DD'), 2020, 'Blue', 45000, 60.00, 12.00, 'Available', 10, 1);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 3, 98765, TO_DATE('2025-07-01', 'YYYY-MM-DD'), 2022, 'Black', 60000, 55.00, 11.00, 'Available', 10, 1);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 4, 54321, TO_DATE('2026-07-15', 'YYYY-MM-DD'), 2019, 'White', 90000, 65.00, 13.00, 'Available', 30, 1);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 5, 987654, TO_DATE('2023-08-01', 'YYYY-MM-DD'), 2020, 'Silver', 55000, 60.00, 12.00, 'Available', 10, 2);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 6, 12345, TO_DATE('2023-08-15', 'YYYY-MM-DD'), 2021, 'Gray', 48000, 70.00, 14.00, 'Available', 30, 2);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 7, 67890, TO_DATE('2023-09-01', 'YYYY-MM-DD'), 2019, 'Red', 52000, 55.00, 11.00, 'Available', 10, 2);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 8, 54321, TO_DATE('2023-09-15', 'YYYY-MM-DD'), 2020, 'Blue', 42000, 65.00, 13.00, 'Available', 20, 2);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 9, 98765, TO_DATE('2023-10-01', 'YYYY-MM-DD'), 2021, 'Black', 58000, 60.00, 12.00, 'Available', 30, 2);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 10, 12345, TO_DATE('2023-10-15', 'YYYY-MM-DD'), 2019, 'White', 40000, 70.00, 14.00, 'Available', 10, 3);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 16, 18245, TO_DATE('2023-9-26', 'YYYY-MM-DD'), 2021, 'Brown', 30000, 56.00, 13.00, 'Available', 10, 3);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 31, 94603, TO_DATE('2023-10-15', 'YYYY-MM-DD'), 2018, 'Red', 45000, 65.00, 15.00, 'Available', 10, 3);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 30, 81540, TO_DATE('2024-8-8', 'YYYY-MM-DD'), 2023, 'Black', 12000, 80.00, 8.00, 'Available', 20, 3);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 33, 63798, TO_DATE('2023-12-7', 'YYYY-MM-DD'), 2017, 'White', 64000, 58.00, 12.00, 'Available', 30, 3);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 12, 62489, TO_DATE('2023-11-5', 'YYYY-MM-DD'), 2015, 'Grey', 100000, 50.00, 4.00, 'Available', 10, 4);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 1, 63451, TO_DATE('2024-2-6', 'YYYY-MM-DD'), 2021, 'White', 48000, 60.00, 5.50, 'Available', 10, 4);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 7, 65802, TO_DATE('2024-1-28', 'YYYY-MM-DD'), 2020, 'Blue', 30000, 59.00, 5.00, 'Available', 10, 4);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 3, 67802, TO_DATE('2025-10-21', 'YYYY-MM-DD'), 2022, 'Silver', 21000, 62.00, 6.00, 'Available', 30, 4);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 27, 40210, TO_DATE('2025-8-26', 'YYYY-MM-DD'), 2020, 'Grey', 29000, 71.00, 7.00, 'Available', 20, 4);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 36, 45152, TO_DATE('2024-6-21', 'YYYY-MM-DD'), 2019, 'Blue', 52000, 58.00, 5.30, 'Available', 10, 5);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 44, 59782, TO_DATE('2024-7-12', 'YYYY-MM-DD'), 2017, 'Brown', 70000, 57.00, 3.60, 'Available', 30, 5);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 46, 54395, TO_DATE('2024-3-20', 'YYYY-MM-DD'), 2022, 'Silver', 32000, 53.00, 4.00, 'Available', 10, 5);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 6, 16489, TO_DATE('2024-8-28', 'YYYY-MM-DD'), 2023, 'Black', 20000, 62.00, 5.00, 'Available', 10, 5);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 11, 64239, TO_DATE('2025-6-16', 'YYYY-MM-DD'), 2023, 'White', 11000, 72.00, 7.00, 'Available', 20, 5);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 25, 39267, TO_DATE('2025-12-30', 'YYYY-MM-DD'), 2023, 'Grey', 13000, 110.00, 10.00, 'Available', 20, 5);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 40, 19360, TO_DATE('2025-10-23', 'YYYY-MM-DD'), 2023, 'Green', 16000, 123.00, 11.00, 'Available', 20, 2);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 9, 16502, TO_DATE('2024-12-5', 'YYYY-MM-DD'), 2020, 'Brown', 62000, 57.00, 5.00, 'Available', 30, 2);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 3, 62029, TO_DATE('2024-11-17', 'YYYY-MM-DD'), 2021, 'Black', 46000, 58.00, 5.00, 'Available', 30, 3);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 3, 30269, TO_DATE('2024-11-17', 'YYYY-MM-DD'), 2021, 'Black', 43000, 58.00, 5.00, 'Available', 30, 3);

INSERT INTO Car (car_id, model_id, plate_number, car_registration_due_date, manufacturing_year, color, current_mileage, daily_hire_rate, daily_late_return_penalty, car_status, Category_id,location_id)
VALUES (car_seq.nextval, 40, 19564, TO_DATE('2025-10-23', 'YYYY-MM-DD'), 2023, 'Purple', 20000, 119.00, 11.00, 'Available', 20, 4);
-- staff

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Ahmed', 'Ali', '018635906', 'Manama', '39654321', 1, 1, '8901', '2109', '7654');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Mohammed', 'Khalid', '191939729', 'Riffa', '39123456', 2, 1, '1234', '5678', '9012');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Abdullah', 'Saeed', '075003766', 'Muharraq', '39234567', 2, 1, '3456', '7890', '6543');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Fatima', 'Hassan', '341171842', 'Hamad Town', '39345678', 3, 1, '8765', '0987', '4321');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Ali', 'Mohammed', '370309445', 'A''ali', '39456789', 5, 1, '2109', '6543', '8901');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Hassan','Ahmed', '968634549', 'Isa Town', '39567890', 1, 2, '9876', '5432', '1098');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Omar', 'Khalifa', '599895419', 'Sitra', '39678901', 2, 2, '4567', '9012', '3456');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Sara', 'Abdulrahman', '890568600', 'Budaiya', '39789012', 2, 2, '7890', '2345', '6789');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Nora', 'Hamed', '673481775', 'Jidhafs', '39890123', 5, 2, '1234', '5678', '9012');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Yousef', 'Khaled', '916899167', 'Al-Malikiyah', '39901234', 4, 2, '3456', '7890', '6543');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Jassim', 'Saleh', '059124166', 'Jid Ali', '39123456', 1, 3, '9876', '5678', '7856');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Huda', 'Khalifa', '994665707', 'Sanabis', '39234567', 2, 3, '4567', '9087', '1234');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Ahmed', 'Mohammed', '872317579', 'Tubli', '39345678', 4, 3, '7890', '2345', '8765');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Rana', 'Ali', '773643662', 'Durrat Al Bahrain', '39456789', 5, 3, '3456', '6789', '4321');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Majed', 'Hassan', '655159297', 'Gudaibiya', '39567890', 6, 3, '8901', '2109', '7654');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Layla', 'Saeed', '884304216', 'Salmabad', '39678901', 1, 4, '1234', '5678', '9012');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Khalid', 'Abdulrahman', '789876543', 'Jurdab', '39789012', 2, 4, '3456', '7890', '6543');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Hanan', 'Mohammed', '898765432', 'Diyar Al Muharraq', '39890123', 2, 4, '8765', '0987', '4321');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Faisal', 'Ahmed', '987654321', 'Amwaj Islands', '39901234', 4, 4, '2109', '6543', '8901');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Qaima ', 'Dallal', '876543210', 'Al Hidd', '39123456', 1, 5, '9876', '5432', '1098');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Azahar', 'Amini', '754398308', 'Gudaibiya', '39123456', 2, 5, '9876', '5678', '7856');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Zahir ', 'Mourad', '871546754', 'Sanabis', '39123456', 2, 5, '4567', '9087', '1234');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Syed ', 'Arif', '924810701', 'Al Hidd', '39123456', 5, 5, '7890', '2345', '8765');

INSERT INTO Staff (staff_id, first_name, last_name, cpr_number, city, phone_number, Job_id, location_id, house_address, road_address, block_address) VALUES
(staff_seq.nextval, 'Aiza ', 'Karam', '963305637', 'Tubli', '39123456', 6, 5, '3456', '6789', '4321');











