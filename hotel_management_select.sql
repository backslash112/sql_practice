use test;
go
select * from Hotel;
select * from Room;
select * from Guest;
select * from Booking;

/*
alter table Room add foreign key (hotelNo) references Hotel(hotelNo);

delete from Booking;
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
insert into Booking values(1, 1, GETDATE(), (select (GETDATE()+3)), 1);
insert into Booking values(1, 1, (select (GETDATE()+5)), null, 1);
insert into Booking values(1, 1, (select (GETDATE()-11)), null, 1);
*/
/*2) List full details of all hotels in Fairfield. 
ANS:
*/
select * from Hotel where city = 'Fairfield';
/*
 
3) List the names and addresses of all guests in Fairfield, alphabetically ordered by name. 
ANS: 
*/
select guestName, guestAddress from Guest where guestNo in
(select guestNo from Booking where hotelNo in
	(select hotelNo from Hotel where city = 'Fairfield')) order by guestName;
/*
 
4) List all double or family rooms with a price below $40.00 per night, in ascending order of price.  
ANS: 
*/
select * from Room where roomType in ('Double', 'Family') and price < 40.0 order by price;
/*
  
5) List the bookings for which no dateTo has been specified.  
ANS: 
*/
select * from Booking where dateTo is null;
/*
 
6) How many hotels are there? 
ANS: 
 */
 select COUNT(*) from Hotel;
 /*
7) What is the average price of a room? 
ANS: 
*/
select AVG(price) from Room

/*
 
8) What is the total revenue per night from all double rooms? 
ANS: 
 */
 select SUM(price) from Room where roomType='Double';
 /*
 

 
 9) How many different guests have made bookings for August? 
ANS: 

*/
select distinct count(guestNo) as 'guest_number' from Booking where dateFrom>='2018-08-01' and dateFrom<='2018-08-31';
/*
 
10) List the number of rooms in each hotel. 
ANS: 
 
 */

select h.hotelName, count(h.hotelName) as 'room_number' from Hotel h join Room r on h.hotelNo=r.hotelNo group by h.hotelName;
 /*
11) List the number of rooms in each hotel in Fairfield.  
ANS: 
*/
select h.hotelName, count(h.hotelName) as 'room_number' from Hotel h join Room r on h.hotelNo=r.hotelNo where h.city = 'Fairfield' group by h.hotelName;

/*
 
12) What is the average number of bookings for each hotel in September, 2015?  
ANS: 
*/

/*select h.hotelName, count(h.hotelName)/COUNT(distinct h.hotelName) as avg_booking_number from Booking b join Hotel h on b.hotelNo = h.hotelNo where b.dateFrom >= '2018-01-01' and b.dateFrom <= '2018-01-30' group by h.hotelName;
*/
select count(*)/COUNT(distinct h.hotelName) as avg_booking_number from Booking b join Hotel h on b.hotelNo = h.hotelNo where b.dateFrom >= '2018-01-01' and b.dateFrom <= '2018-01-30';
