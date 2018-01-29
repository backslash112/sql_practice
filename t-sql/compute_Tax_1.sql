create proc Compute_Tax
as
begin
if OBJECT_ID('dbo.Tax', 'U') is not null
	drop table dbo.Tax
create table Tax(empSSN int, incomeTax decimal);

insert into Tax(empSSN, incomeTax)
select ssn, 15000*0.1 as netSalary
from Employee
where annualSalary-(7000+dependentNo*950) >= 0 and annualSalary-(7000+dependentNo*950) < 15000

insert into Tax(empSSN, incomeTax)
select ssn, 15000*0.1+15000*0.15 as netSalary
from Employee
where annualSalary-(7000+dependentNo*950) >= 15000 and annualSalary-(7000+dependentNo*950) < 30000

insert into Tax(empSSN, incomeTax)
select ssn, 15000*0.1+15000*0.15+(annualSalary-(7000+dependentNo*950))*0.28 as netSalary
from Employee
where annualSalary-(7000+dependentNo*950) >= 30000

end

exec Compute_Tax

select * from Employee;
select * from Tax
