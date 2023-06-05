update car_rental
set end_date = '7-jun-23'
where rental_id = 2011;
rollback;



INSERT INTO Rental_Equipment (rental_id, equipment_id, quantity)
VALUES (2007, 4001, 2);

