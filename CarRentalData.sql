INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3001, 1001, 7, TO_DATE('2022-06-01', 'YYYY-MM-DD'), 7001);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3002, 1002, 5, TO_DATE('2022-07-01', 'YYYY-MM-DD'), 7002);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3003, 1003, 12, TO_DATE('2022-6-23', 'YYYY-MM-DD'), 7003);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3004, 1004, 3, TO_DATE('2022-07-01', 'YYYY-MM-DD'), 7004);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3005, 1005, 7, TO_DATE('2021-12-06', 'YYYY-MM-DD'), 7005);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3006, 1006, 15, TO_DATE('2023-01-7', 'YYYY-MM-DD'), 7006);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3007, 1007, 14, TO_DATE('2022-6-27', 'YYYY-MM-DD'), 7007);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3008, 1008, 2, TO_DATE('2021-04-20', 'YYYY-MM-DD'), 7008);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3009, 1009, 8, TO_DATE('2022-04-03', 'YYYY-MM-DD'), 7009);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3010, 1010, 5, TO_DATE('2023-02-17', 'YYYY-MM-DD'), 7010);
--11
INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3011, 1011, 16, TO_DATE('2023-02-23', 'YYYY-MM-DD'), 7011);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3012, 1012, 15, TO_DATE('2022-07-30', 'YYYY-MM-DD'), 7012);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3013, 1013, 2, TO_DATE('2021-10-01', 'YYYY-MM-DD'), 7013);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3014, 1014, 5, TO_DATE('2023-08-09', 'YYYY-MM-DD'), 7014);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3015, 1015, 20, TO_DATE('2021-01-29', 'YYYY-MM-DD'), 7015);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3016, 1016, 11, TO_DATE('2022-02-09', 'YYYY-MM-DD'), 7016);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3017, 1017, 23, TO_DATE('2023-04-26', 'YYYY-MM-DD'), 7017);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3018, 1018, 5, TO_DATE('2023-05-04', 'YYYY-MM-DD'), 7018);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3019, 1019, 7, TO_DATE('2022-09-26', 'YYYY-MM-DD'), 7019);

INSERT INTO Car_rental (rental_id, customer_id, car_id, rent_duration, start_date, staff_id)
VALUES (rental_seq.nextval, 3020, 1020, 8, TO_DATE('2022-12-06', 'YYYY-MM-DD'), 7020);
--
INSERT INTO Rental_Equipment (rental_id, equipment_id, quantity)
VALUES (2010, 4002, 1);

INSERT INTO Rental_Equipment (rental_id, equipment_id, quantity)
VALUES (2013, 4007, 1);

INSERT INTO Rental_Equipment (rental_id, equipment_id, quantity)
VALUES (2012, 4013, 1);

INSERT INTO Rental_Equipment (rental_id, equipment_id, quantity)
VALUES (2015, 4015, 1);

INSERT INTO Rental_Equipment (rental_id, equipment_id, quantity)
VALUES (2002, 4011, 2);

INSERT INTO Rental_Equipment (rental_id, equipment_id, quantity)
VALUES (2006, 4012, 3);

INSERT INTO Rental_Equipment (rental_id, equipment_id, quantity)
VALUES (2023, 4001, 1);
--
update car_rental
set end_date = '12-JUN-22'
where rental_id = 2001;

update car_rental
set end_date = '06-JUL-22'
where rental_id = 2002;

update car_rental
set end_date = '07-JUL-22'
where rental_id = 2003;

update car_rental
set end_date = '04-JUL-22'
where rental_id = 2004;

update car_rental
set end_date = '13-DEC-21'
where rental_id = 2005;

update car_rental
set end_date = '30-JAN-23'
where rental_id = 2006;

update car_rental
set end_date = '11-JUL-22'
where rental_id = 2007;

update car_rental
set end_date = '22-APR-21'
where rental_id = 2008;

update car_rental
set end_date = '11-APR-22'
where rental_id = 2009;

update car_rental
set end_date = '22-FEB-23'
where rental_id = 2010;

update car_rental
set end_date = '14-MAR-23'
where rental_id = 2011;

update car_rental
set end_date = '14-AUG-22'
where rental_id = 2012;

update car_rental
set end_date = '06-OCT-21'
where rental_id = 2013;

update car_rental
set end_date = '14-AUG-23'
where rental_id = 2014;

update car_rental
set end_date = '18-FEB-21'
where rental_id = 2015;

update car_rental
set end_date = '21-FEB-22'
where rental_id = 2016;

update car_rental
set end_date = '19-MAY-23'
where rental_id = 2017;

update car_rental
set end_date = '09-MAY-23'
where rental_id = 2018;

update car_rental
set end_date = '04-OCT-22'
where rental_id = 2019;

update car_rental
set end_date = '14-DEC-22'
where rental_id = 2020;





