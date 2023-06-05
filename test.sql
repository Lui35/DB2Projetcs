update car_rental
set end_date = '21-jun-23'
where rental_id = 2010;
rollback;



INSERT INTO Rental_Equipment (rental_id, equipment_id, quantity)
VALUES (2010, 4002, 2);

