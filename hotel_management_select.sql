use test;
go

/*


insert into Hotel values(1, 'My Lucy Day', 'Fairfield');
insert into Hotel values(2, 'Like Home', 'Chicago');
insert into Room values(1, 1, 'Single', 100.0);
insert into Room values(2, 1, 'Double', 30.0);
insert into Room values(3, 1, 'Double', 200.0);
insert into Room values(4, 1, 'Family', 30.0);
insert into Room values(6, 1, 'Family', 20.0);
insert into Room values(5, 1, 'Family', 300.0);
insert into Room values(7, 2, 'Best', 1000.0);
insert into Guest values(1, 'Carl', '602 N, Fairfield, IOWA');
insert into Booking values(1, 1, GETDATE(), (SELECT (GETDATE()+3)), 1);
insert into Booking values(1, 1, (SELECT (GETDATE()+5)), null, 1);
insert into Booking values(1, 1, (SELECT (GETDATE()-11)), null, 1);
*/


-- 1) List full details of all hotels.
SELECT * FROM Hotel;


-- 2) List full details of all hotels in Fairfield.
SELECT * FROM Hotel WHERE city = 'Fairfield';


-- 3) List the names AND addresses of all guests in Fairfield,
-- alphabetically ordered by name.
SELECT guestName, guestAddress FROM Guest WHERE guestNo IN
(SELECT guestNo FROM Booking WHERE hotelNo IN
	(SELECT hotelNo FROM Hotel WHERE city = 'Fairfield')) ORDER BY guestName;


-- 4) List all double or family rooms with a price below $40.00 per night,
-- in ascending order of price.
SELECT * FROM Room
WHERE roomType IN ('Double', 'Family') AND price < 40.0
ORDER BY price;


-- 5) List the bookings for which no dateTo has been specified.
SELECT * FROM Booking WHERE dateTo IS NULL;


-- 6) How many hotels are there?
SELECT COUNT(*) FROM Hotel;


-- 7) What is the average price of a room?
SELECT AVG(price) FROM Room


-- 8) What is the total revenue per night FROM all double rooms?
SELECT SUM(price) FROM Room WHERE roomType='Double';


-- 9) How many different guests have made bookings for August?
SELECT distinct COUNT(guestNo) AS 'guest_number'
FROM Booking
WHERE dateFrom>='2018-08-01' AND dateFrom<='2018-08-31';


-- 10) List the number of rooms in each hotel.
SELECT h.hotelName, COUNT(h.hotelName) AS 'room_number'
FROM Hotel h join Room r ON h.hotelNo=r.hotelNo
GROUP BY h.hotelName;


-- 11) List the number of rooms in each hotel in Fairfield.
SELECT h.hotelName, COUNT(h.hotelName) AS 'room_number'
FROM Hotel h join Room r ON h.hotelNo=r.hotelNo
WHERE h.city = 'Fairfield'
GROUP BY h.hotelName;


-- 12) What is the average number of bookings for each hotel in September, 2015?
SELECT COUNT(*)/COUNT(distinct h.hotelName) AS avg_booking_number
FROM Booking b join Hotel h ON b.hotelNo = h.hotelNo
WHERE b.dateFrom >= '2018-01-01' AND b.dateFrom <= '2018-01-30';
