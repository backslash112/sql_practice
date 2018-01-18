USE test;
GO

SELECT * FROM Room;
SELECT * FROM Hotel;

--1. List the price AND type of all rooms at the Palace Hotel.
SELECT price, roomType
FROM Room
WHERE hotelNo =
	(SELECT hotelNo FROM Hotel WHERE hotelName = 'Palace');


--2. List all guests currently staying at the Palace Hotel.
SELECT * FROM guest
WHERE guestNo IN (
	SELECT guestNo FROM Booking
	WHERE hotelNo =
		(SELECT hotelNo FROM Hotel
		WHERE hotelName = 'Palace'
		and GETDATE() BETWEEN dateFrom AND dateTo));


--3. List the details of all occupied rooms at the Palace Hotel today,
--including the name of the guest staying in the room.
SELECT r.roomNo, r.hotelNo, r.roomType, r.price, g.guestName
FROM Booking b
JOIN Room r ON b.roomNo = r.roomNo
JOIN Guest g ON b.guestNo = g.guestNo
JOIN Hotel h ON b.hotelNo = h.hotelNo
WHERE GETDATE() BETWEEN b.dateFrom AND b.dateTo AND h.hotelName = 'Palace';


--4. List the details of all unoccupied rooms at the Palace Hotel today.
SELECT * FROM Room
WHERE roomNo NOT IN (
	SELECT r.roomNo
	FROM Booking b
	JOIN Room r ON b.roomNo = r.roomNo
	JOIN Hotel h ON b.hotelNo = h.hotelNo
	WHERE GETDATE() BETWEEN b.dateFrom AND b.dateTo)
and hotelNo = (SELECT hotelNo FROM Hotel WHERE hotelName = 'Palace');


--5. What is the lost income for each hotel?  (use current date)
SELECT h.hotelName, sum(price) AS 'lostIncome'
FROM Room r
JOIN Hotel h ON r.hotelNo = h.hotelNo
WHERE NOT roomNo IN (
	SELECT roomNo FROM Booking b
	WHERE GETDATE() BETWEEN b.dateFrom AND b.dateTo)
GROUP BY h.hotelName;


--6. List the hotel numbers, guest names, and guest cities for which more than
-- one guest having the same address is staying at the same hotel. (Use today�s date)
--Note: Here it is required to find out a hotel WHERE 2 or more different guests
-- are staying AND these guests are coming FROM the same city.
--Like, 2 guests FROM Fairfield are staying at a Palace hotel.
WITH x AS (
	SELECT g.guestAddress
	FROM Booking b
	JOIN Guest g ON b.guestNo = g.guestNo
		WHERE GETDATE() BETWEEN b.dateFrom AND b.dateTo
	GROUP BY g.guestAddress
	HAVING COUNT(*) > 1)
-- too hard, didn't finish this question.


--7. What is the most commonly booked room type for each hotel in Fairfield
-- over the whole history of the hotel? Include the number of bookings in the report.
(SELECT h.city, b.hotelNo, r.roomType, COUNT(r.roomType) AS 'bookedTimes'
INTO #temp_cities
FROM Booking b
JOIN Hotel h ON b.hotelNo = h.hotelNo
JOIN Room r ON b.roomNo = r.roomNo
GROUP BY h.city, b.hotelNo, r.roomType)

SELECT a.city, a.roomType, a.bookedTimes FROM #temp_cities a
LEFT OUTER JOIN #temp_cities b
ON a.city = b.city AND a.bookedTimes < b.bookedTimes
WHERE b.city IS NULL

--8. Write SQL statements to Insert rows INTO each of these tables.
-- (It�ll suffice if you show only 2 rows insertion)
INSERT INTO Guest values(3, 'Yang', '603 N, Fairfield, IOWA')
INSERT INTO Guest values(4, 'Cun', '604 N, Fairfield, IOWA')
INSERT INTO Hotel values(3, 'Holiday Center Hotel', 'Chicago')
INSERT INTO Hotel values(4, 'Home Hotel', 'Chicago')
INSERT INTO Room values(1, 3, 'Single', 100.0)
INSERT INTO Room values(2, 3, 'Double', 200.0)
INSERT INTO Booking values(3, 3, GETDATE(), GETDATE()+3, 1)
INSERT INTO Booking values(4, 4, GETDATE(), GETDATE()+3, 1)


--9. Update the price of every room in Palace Hotel by 5% more.
update  Room
set price=price*1.05
WHERE hotelNo = (SELECT hotelNo FROM Hotel WHERE hotelName = 'Palace');

--10. Create a separate table with the same structure AS the Booking table to hold
-- archive records. Using the INSERT statement, copy the records FROM the Booking
-- table to the archive table relating to bookings before 1st January 2016.
-- Delete all bookings before 1st January 2016 FROM the Booking table.
 CREATE TABLE Booking_History(
hotelNo INT NOT NULL,
guestNo INT NOT NULL,
dateForm DATE NOT NULL,
dateTo DATE NOT NULL,
roomNo INT NOT NULL,
CONSTRAINT fk_booking_history_hotelNo FOREIGN KEY (hotelNo) REFERENCES Hotel(hotelNo),
CONSTRAINT fk_booking_history_guestNO FOREIGN KEY (guestNo) REFERENCES Guest(guestNo),
CONSTRAINT fk_booking_history__roomNo FOREIGN KEY (roomNo) REFERENCES Room(roomNo)
);
INSERT INTO Booking_History
SELECT * FROM Booking
-- or
SELECT * INTO Booking_History FROM Booking

DELETE * FROM Booking WHERE dateForm < '2016-01-01'
