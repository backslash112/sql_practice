use test;
go


create table Hotel(
hotelNo int primary key,
hotelName varchar(100) null,
city varchar(100) null
);

create table Room(
roomNo int primary key,
hotelNo int not null,
roomType varchar(100) null,
price float null);

create table Guest(
guestNo int primary key,
guestName varchar(100) null,
guestAddress varchar(100) null);

create table Booking(
hotelNo int not null,
guestNo int not null,
dateForm date not null,
dateTo date not null,
roomNo int not null,
constraint fk_booking_hotelNo foreign key (hotelNo) references Hotel(hotelNo),
constraint fk_booking_guestNO foreign key (guestNo) references Guest(guestNo),
constraint fk_booking_roomNo foreign key (roomNo) references Room(roomNo)
);

alter table Booking
alter column dateTo date null

exec sp_rename 'Booking.dateForm', 'dateFrom', 'COLUMN'