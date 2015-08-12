
use Company;

---- 34 SQL avg()

	SELECT * 
	FROM
		 Employee, Account
	WHERE
		 Account.Salary >= (Select avg(Salary) from Account) 
		  AND
		 Account.Id = Employee.EmployeeId;

---- 35 count()

	CREATE TABLE Department
	( 
	DepartmentName varchar(50),
	DepartmentId int,
	DepartmentLocation varchar(30)
	);


	insert into Department 
	values('HR', 1001,'DELHI');

	insert into Department 
	values('MANAGEMENT', 1002,'GOA');
	
	insert into Department 
	values('TESTING', 1003,'AGRA');
	
	insert into Department 
	values('DEVELOP', 1004,'PATNA');
	
	insert into Department 
	values('SALARY', 1005,'MUMBAI');

	select * from Employee;
	select * from Department;

	SELECT 
		DepartmentName, COUNT(EmployeeId) as NumberOfEmployee
	FROM
		Department, Employee
	WHERE
		Department.DepartmentId = Employee.DepartmentId 
	GROUP BY
		DepartmentName;


---- 36 MAX()

	SELECT 
		FirstName+' '+LastName NAME, Salary 
	FROM
		Employee, Account
	WHERE
		Employee.EmployeeId = Account.Id 
			AND 
		 Account.Salary <= (SELECT max(Salary) FROM Account);

---- 37 MIN()


	SELECT 
		FirstName+' '+LastName NAME,
		Salary
	FROM
		 Employee, Account
	where
		 Salary < (SELECT min(Salary) FROM Account)
			AND
		 Employee.EmployeeId = Account.Id;


---- 38 SUM()

	SELECT sum(Salary) FROM Account;

---- 39 GROUP BY

	select * from Department;
	Select * from Employee;

	SELECT 
		 DepartmentLocation,
		 count(*) as EmployeeNumber
	FROM 
		Department, Employee
	WHERE 
		Department.DepartmentId = Employee.DepartmentId 
	GROUP BY 
		Department.DepartmentLocation;


---- 40 HAVING

    CREATE TABLE Demand
	( 
      OrderId int,
	  OrderDate date,
	  OrderAmount int,
	  CustomerName varchar(30)
    );

    INSERT INTO Demand
    VALUES ( 50, '01/25/01', 500, 'Ajay');

	INSERT INTO Demand
    VALUES ( 51, '03/25/01', 750, 'Karan');

	INSERT INTO Demand
    VALUES ( 52, '09/07/01', 750, 'Praloy');

	INSERT INTO Demand
    VALUES ( 53, '08/25/01', 2750, 'Nitin');

	INSERT INTO Demand
	VALUES (55, '11/02/15', 5000, 'Nitin');

	SELECT
		 CustomerName, sum(OrderAmount) 
	FROM
		 Demand
	GROUP BY
		 CustomerName
	HAVING 
		sum(OrderAmount) > 200;



---- 41 UPPER()

	SELECT	
		FirstName+' '+UPPER(LastName) NAME
	FROM
		 Employee;

---- 42 LOWER()

	SELECT 
		FirstName+' '+Lower(LastName)
	FROM
		 Employee;

---- 43 Len()

select * from Employee;

	SELECT	
		FirstName+' '+CAST(LEN(FirstName) as varchar), LastName+' '+cast(LEN(LastName) as varchar)
	FROM
		 Employee;

---- 44 ROUND()

	SELECT 
		(FirstName+' '+ISNULL(LastName) AS Name, round(Salary,0)
    FROM 
		Account, Employee
    WHERE 
		Employee.EmployeeId = Account.Id;

---- 45 GETDATE()

	SELECT 
		* , FORMAT(GETDATE(),'dd/MM/yyyy') AS DATE
    FROM
		Employee;

---- 46 convert()

	SELECT
		EmployeeId, LOWER(FirstName+' '+LastName) AS Name, Sex, ActiveStatus, DepartmentId, Salary, CONVERT(DATE,GETDATE()) AS [Today's Date]
	FROM
		Employee, Account
	WHERE
		Employee.EmployeeId = Account.Id;

---- 47 CAST()

	SELECT 
		FirstName, CAST(EmployeeId AS VARCHAR(10)) AS EmployeeId
	FROM
		Employee;	 

---- 48 CASE STATEMENT

	SELECT
	   EmployeeId, 
	   Salary,
	   Age,
	CASE
	     WHEN 
			Salary >5000 AND AGE<35 
		 THEN 
			'YES'
		 ELSE 
			'NO'
	END AS Eligible
	FROM 
		Employee, Account
	WHERE
		Employee.EmployeeId = Account.Id;
	   
---- 49 RANKING FUNCTION
				
		SELECT DISTINCT Salary
		FROM ( SELECT Salary, Dense_rank() over (Order by Salary) as DENSERANK FROM Account) Result
		where DENSERANK IN (1,2,3,4,5);
		
---- 50 Common Expression Table(CTE)

		
---- 51 WITH CUBE and ROLLUP

		SELECT 
			DepartmentName, DepartmentLocation, SUM(Salary) as salary
		FROM
			Employee, Account, Department
		WHERE 
			Department.DepartmentId = Employee.DepartmentId
			 AND
			Employee.EmployeeId = Account.Id
		GROUP BY 
			DepartmentName, DepartmentLocation
		WITH CUBE;
	      			
	SELECT 
			DepartmentName, DepartmentLocation, SUM(Salary) as salary
		FROM
			Employee, Account, Department
		WHERE 
			Department.DepartmentId = Employee.DepartmentId
			 AND
			Employee.EmployeeId = Account.Id
		GROUP BY 
			DepartmentName, DepartmentLocation
		WITH ROLLUP;
	
--- 52 EXCEPT AND INTERSECT	
   
    SELECT * FROM Account
	   EXCEPT
	SELECT * FROM Account WHERE Exprience >=6

  
   SELECT * FROM Account
		INTERSECT
   SELECT * FROM Account WHERE Exprience <6;


--- 53 CORELATED QURIES

   SELECT FirstName+' '+LastName AS Name, Salary 
    FROM Employee, Account 
		where 
			EmployeeId = Account.Id
			 AND 
			Account.Salary 
			IN
			(
				 SELECT DISTINCT TOP 3 Salary
					FROM 
						Account
			); 

---- 54 RUNNING AGGREGATE 

	SELECT Id, 
	( SELECT SUM(Salary) FROM Account q WHERE p.Id >= q.Id )
	FROM Account p ORDER BY Id;

	