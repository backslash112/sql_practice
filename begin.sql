create  database test; 

use test;
go
create table R(
A varchar(100) null,
B varchar(100) null,
C varchar(100) null);

create table S(
D varchar(100) null,
C varchar(100) null,
E varchar(100) null);

select * from R;
select * from S;

select * from R, S where R.C = S.C;
/*select * from R inner join S on R.C = S.C;/*select * from R natural join S;*/*/
select * from R left join S on R.C=S.C;
select * from R right join S on R.C=S.C;