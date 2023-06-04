update car_rental
set end_date = '25-jun-23'
where rental_id = 2008;
rollback;



INSERT INTO Rental_Equipment (rental_id, equipment_id, quantity)
VALUES (2007, 4001, 2);

