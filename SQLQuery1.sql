-- 5 CREATE DATABASE

CREATE DATABASE Company;

-- 6 CREATE TABLE Employee

CREATE TABLE Employee(
	EmployeeId INT,
	FirstName  VARCHAR(50),
	LastName   VARCHAR(50),
	Sex		   CHAR,
	ActiveStatus BIT);


CREATE TABLE Account(
	Id INT PRIMARY KEY,
	Salary DECIMAL(10,2) CHECK (Salary>10000),
	); 
	

-- 7 CONSTRAINTS

CREATE TABLE Employee(
    EmployeeId INT PRIMARY KEY,
	FirstName  VARCHAR(50) NOT NULL,
	LastName   VARCHAR(50) UNIQUE,
	Sex		   CHAR,
	ActiveStatus BIT DEFAULT 0);	

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

-- DROP TABLE

CREATE TABLE Designation(
	Id INT,
	Position VARCHAR(50));

DROP TABLE Designation;

