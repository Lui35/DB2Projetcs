update car_rental
set end_date = '7-jun-23'
where rental_id = 2004;
rollback;



INSERT INTO Rental_Equipment (rental_id, equipment_id, quantity)
VALUES (2016, 4001, 2);

