-- 5 CREATE DATABASE

CREATE DATABASE Company;

-- 6 CREATE TABLE Employee

USE Company;
GO

CREATE TABLE Employee
	(
		EmployeeId INT,
		FirstName  VARCHAR(50),
		LastName   VARCHAR(50),
		Sex		   CHAR,
		ActiveStatus BIT
	); 
	

-- INSERTING DATA

   INSERT INTO Employee
   VALUES(2,'AJAY','SINGH','M','true');
   
   INSERT INTO Employee(EmployeeId,FirstName,Sex,ActiveStatus)
   VALUES(5,'RAGHAV','M','TRUE');

   INSERT INTO Employee
   VALUES(3,'AMIT','KOLHI','M','false');

   INSERT INTO Employee
   VALUES(1,'SUDHIR','SHARMA','M','true');

   INSERT INTO Employee
   VALUES(4,'ASH','RAI','F','true');

   SELECT * FROM Employee ORDER BY EmployeeId;



	CREATE TABLE Account
	(
		Id INT PRIMARY KEY,
		Salary DECIMAL(10,2) CHECK (Salary>10000),
	); 
	

   INSERT INTO Account
   VALUES(1,45000.00);

   INSERT INTO Account
   VALUES(2,35000.00);

-- 7 CONSTRAINTS

	CREATE TABLE Employee
	(
		EmployeeId INT PRIMARY KEY,
		FirstName  VARCHAR(50) NOT NULL,
		LastName   VARCHAR(50) UNIQUE,
		Sex		   CHAR,
		ActiveStatus BIT DEFAULT 0
	);	

-- 8 NOT NULL	
	
	ALTER TABLE Employee 
		ALTER COLUMN Sex BIT NOT NULL;

-- 9 UNIQUE

	ALTER TABLE Employee
		ADD UNIQUE(EmployeeId);

-- 10 PRIMARY KEY

	ALTER TABLE Employee
		ADD PRIMARY KEY(EmployeeID);

-- 11 FOREIGN KEY

	ALTER TABLE Account
		ADD FOREIGN KEY(Id) REFERENCES Employee(EmployeeId);

-- 12 CHECK

	ALTER TABLE Employee
		ADD CHECK(EmployeeId>0);

-- 13 DEFAULT

	ALTER TABLE Employee
		ADD DEFAULT 

-- 14 DROP TABLE

	CREATE TABLE Designation
	(
		Id INT,
		Position VARCHAR(50)
	);

	DROP TABLE Designation;

-- 15 CREATE INDEX

	CREATE UNIQUE INDEX PIndex
		ON Employee (FirstName, LastName));

-- 16 ALTER TABLE

	ALTER TABLE Employee
		ADD Designation VARCHAR(50); 

	ALTER TABLE Employee
		ALTER COLUMN Designation INT;

	CREATE TABLE Designation
	(
	Id INT FOREIGN KEY REFERENCES Employee(EmployeeId)
	);

-- 17 IN OPERATION

	SELECT * 
		FROM 
			Employee, Account
		WHERE 
			Employee.EmployeeId = Account.Id 
				AND 
			Salary IN (10000,20000,30000,40000);

-- 18 BETWEEN

	SELECT * 
		FROM 
			Employee, Account
		WHERE 
			Employee.EmployeeId = Account.Id 
			AND 
			Account.Salary BETWEEN 10000 AND 40000; 

-- 19 ALIAS NAME

	SELECT 
		EmployeeId Id, FirstName+ ',' +LastName AS Name 
	FROM Employee;

-- CREATING SLABS TABLE

	CREATE TABLE Slabs
	(
	 Id INT,
	 Project VARCHAR(30),
	 Location VARCHAR(30)
   );
   
-- 20, 21 SQL JOINS (INNER JOIN)  

	SELECT 
		EmployeeId, FirstName+LastName AS Name, Sex
    FROM 
		Employee ,Slabs 
	WHERE 
		Employee.EmployeeId = Slabs.Id;

-- 22 LEFT JOIN

		-- CREATING SAMPLE EMPLOYEE MANAGEMENT SYSTEM

		       CREATE TABLE Department
			   (
				 DepartmentId INT,
				 DepartmentName VARCHAR(30),
				 Location VARCHAR(30)
			   );

			   SELECT * FROM Department
			 INSERT INTO Department
			 VALUES(1001,'SECURITY','DELHI');

			 INSERT INTO Department
			 VALUES(1002,'DEVELOP','MUMBAI');

			 INSERT INTO Department
			 VALUES(1003,'DEVELOP','MUMBAI');

	SELECT * 
		FROM Employee 
			LEFT JOIN Department ON 
			Employee.DepartmentId = Department.DepartmentId ; 

-- 23 FULL JOIN

		SELECT * 
		FROM 
			Employee
		FULL JOIN
			Department
		ON 
			Employee.EmployeeId = Department.EmployeeId;

-- 24 UNION
 
	CREATE TABLE EmployeeOfABC
	(
		EmployeeId INT,
		FirstName  VARCHAR(50),
		LastName   VARCHAR(50),
		Sex		   CHAR,
		ActiveStatus BIT
	);

   INSERT INTO EmployeeOfABC
   VALUES(2,'AJAY','SINGH','M','true');
   
   INSERT INTO EmployeeOfABC
   VALUES(3,'AMIT','KOLHI','M','FALSE');

   INSERT INTO EmployeeOfABC
   VALUES(1,'SUDHIR','SHARMA','M','true');

   INSERT INTO EmployeeOfABC
   VALUES(4,'ASH','RAI','F','true');

   SELECT * FROM EmployeeOfABC; 

	CREATE TABLE EmployeeOfXYZ
	(
		EmployeeId INT,
		FirstName  VARCHAR(50),
		LastName   VARCHAR(50),
		Sex		   CHAR,
		ActiveStatus BIT
	);

	INSERT INTO EmployeeOfXYZ
    VALUES(433,'ANJALI','MATHUR','F','FALSE');

    INSERT INTO EmployeeOfXYZ
    VALUES(431,'PRIYANKA','MALOTHRA','F','TRUE');

    INSERT INTO EmployeeOfXYZ
    VALUES(430,'ROHIT','MATHUR','M','FALSE');


	SELECT * FROM EmployeeOfXYZ;

	CREATE TABLE EmployeeOfLMN
	(
		EmployeeId INT,
		FirstName  VARCHAR(50),
		LastName   VARCHAR(50),
		Sex		   CHAR,
		ActiveStatus BIT
	);

	INSERT INTO EmployeeOfLMN
    VALUES(33,'JACK','CHAN','M','FALSE');

	INSERT INTO EmployeeOfLMN
    VALUES(35,'TIGER','TIGER','M','TRUE');

	SELECT * FROM EmployeeOfLMN;


	SELECT * FROM EmployeeOfABC
		UNION
	SELECT * FROM EmployeeOfXYZ
		UNION
	SELECT * FROM EmployeeOfLMN;

-- 26 SELECT INTO

		SELECT * 
			INTO 
				EmployeeBackUp
			FROM 
				Employee;

	SELECT * FROM EmployeeBackUp;

-- 27 SQL INCREMENT

	UPDATE 
		Account
	SET 
		Salary =Salary + 5000;

	SELECT *
	FROM 
		Employee LEFT JOIN Account
	ON 
		Employee.EmployeeID = Account.Id;

-- 28  SQL VIEWS

	CREATE VIEW EmployeeView 
	AS 
		SELECT * FROM Employee, Account
		WHERE
			 Account.Salary >=6000 
				AND 
			Employee.EmployeeId = Account.Id;

SELECT * FROM EmployeeView;

	ALTER TABLE Employee 
		ADD DateOfJoining DATE;

-- 29 DATE
	SELECT 
		concat
		(
			   format(getdate(),'ddd'),
			   ' ',
			   format(getdate(),'dd'),
			   'th',
			   ' ',
			   format(getdate(),'mmm'),
			   ' ',
			   format(getdate(),'yy'),
			   ', ',
			   format(getdate(),
			   'hh:ss tt')
		);

	SELECT 
		format(getdate()+2,'ddd')+
		' '+
		format(getdate()+2,'dd')+
		'th'+
		' '+
		format(getdate(),'mmm')+
		' '+
		format(getdate(),'yy')+
		', '+
		format(getdate(),'hh:ss tt');

-- 30 null

	SELECT COUNT(*) 
	FROM 
		Employee 
	WHERE 
		COL IS NULL;

-- 31 ISNULL()

	SELECT * 
		FROM Employee
	WHERE 
		LastName IS NULL;

-- 32 DATA TYPES
	
	SELECT 
		cast(0.125*Salary AS decimal(36,2)) 
		AS
			 PF 
		FROM 
			Account;

 
