use test;
go


CREATE TABLE Hotel(
hotelNo int primary key,
hotelName varchar(100) null,
city varchar(100) null
);

CREATE TABLE Room(
roomNo int primary key,
hotelNo int not null,
roomType varchar(100) null,
price float null);

CREATE TABLE Guest(
guestNo int primary key,
guestName varchar(100) null,
guestAddress varchar(100) null);

-- CREATE TABLE with foreign key
CREATE TABLE Booking(
hotelNo int not null,
guestNo int not null,
dateForm date not null,
dateTo date not null,
roomNo int not null,
constraint fk_booking_hotelNo foreign key (hotelNo) references Hotel(hotelNo),
constraint fk_booking_guestNO foreign key (guestNo) references Guest(guestNo),
constraint fk_booking_roomNo foreign key (roomNo) references Room(roomNo)
);


-- add foreign key to a TABLE
alter TABLE Room add foreign key (hotelNo) references Hotel(hotelNo);

-- set column FROM 'not null' to 'null'
alter TABLE Booking
alter column dateTo date null

-- rename culum name
exec sp_rename 'Booking.dateForm', 'dateFrom', 'COLUMN'
