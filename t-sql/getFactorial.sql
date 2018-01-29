
alter PROCEDURE getFactorial (@number INT)
AS
IF @number < 0
	BEGIN
		PRINT 'error, input less that zero!'
		return
	END
DECLARE @result INT = 1;
DECLARE @origin INT = @number;
WHILE @number > 1
	BEGIN
		SET @result = @result * @number;
		SET @number = @number - 1;
	END
PRINT (cast(@origin as varchar(10)))+'!='+(cast(@result as varchar(10)))

EXEC dbo.getFactorial -1
EXEC dbo.getFactorial 5

