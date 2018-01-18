CREATE  database test; 

use test;
go
CREATE TABLE R(
A varchar(100) null,
B varchar(100) null,
C varchar(100) null);

CREATE TABLE S(
D varchar(100) null,
C varchar(100) null,
E varchar(100) null);

SELECT * FROM R;
SELECT * FROM S;

SELECT * FROM R, S WHERE R.C = S.C;
/*SELECT * FROM R inner join S ON R.C = S.C;/*SELECT * FROM R natural join S;*/*/
SELECT * FROM R left join S ON R.C=S.C;
SELECT * FROM R right join S ON R.C=S.C;
