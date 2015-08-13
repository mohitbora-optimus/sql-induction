use Company;

--	56 CLUSTERED INDEX
	
			CREATE CLUSTERED INDEX IndexOnEmployee
			ON Employee ( EmployeeId);	
			
			
--	57 NONCLUSTERD INDEX
			CREATE NONCLUSTERED	INDEX NonClustreIndexOnEmployee
			ON Employee (DepartmentId); 

--	58 TRIGGERS
			
			CREATE TABLE Salary 
			(
			  EmployeeId          INT,
			  HRA       DECIMAL(10,2),
			  [Basic]	DECIMAL(10,2),
			  DA		DECIMAL(10,2),
			  Total		DECIMAL(10,2) DEFAULT NULL
			);
						

			CREATE TRIGGER Trig_On_Employee
			ON Salary
			AFTER INSERT
			AS 
				DECLARE @Id  INT
						
				BEGIN
					 SET @Id= (SELECT EmployeeId FROM INSERTED)
										 
					 UPDATE Salary
					 SET Total =([Basic]+ HRA + DA)*12 
					 WHERE @Id = Salary.EmployeeId
            END;
		
			DROP TABLE Salary
			
			
			INSERT INTO Salary(EmployeeId, HRA, [Basic], DA)
			VALUES( 4, 7560, 10000, 5000); 

			DROP TRIGGER Trig_On_Employee

-- 59 CURSOR
		
		
			SELECT * FROM Salary;
		
		
	-- DECLARE CURSOR		
			DECLARE 
				Cursor_Employee12 CURSOR
			FOR
				SELECT [Basic],HRA,DA,EmployeeId FROM Salary


	-- PERFORMING OPERATION IN CURSOR

				DECLARE @BAS DECIMAL(10,2), @HRA DECIMAL(10,2), @DA DECIMAL(10,2), @Id INT
			OPEN 
				Cursor_Employee12
			WHILE @@FETCH_STATUS = 0
				BEGIN
					FETCH Cursor_Employee12 INTO @BAS, @HRA, @DA,@Id
					UPDATE Salary
					SET Total = ( @BAS + @HRA + @DA )*12
					WHERE EmployeeId = @Id	
				END

	-- CLOSING CURSOR

		CLOSE Cursor_Employee12; 

--	61 FUNCTIONS
		

		CREATE FUNCTION Leap(@Temp_Year INT)
		RETURNS VARCHAR(50)
		AS
			BEGIN
				 DECLARE @RESULT VARCHAR(50)
				IF @Temp_Year % 4 = 0 OR @Temp_year %100 = 0 OR @Temp_Year %400 = 0
					SET @RESULT= 'LEAP YEAR'
				ELSE
					SET @RESULT= 'NOT LEAP YEAR'
				RETURN @RESULT
			END;
	
		SELECT dbo.Leap(2000)

--	62	STORED PROCEDURE
		
		ALTER PROCEDURE spEmployeeDetail
		@EmployeeId INT
		WITH ENCRYPTION
		AS
		 BEGIN	
			SELECT EmployeeId, UPPER(FirstName)+' '+UPPER(LastName) AS Name, Sex, 
			ActiveStatus, Employee.DepartmentId, Age, Salary, Exprience, DepartmentLocation
			FROM Employee, Account, Department
			WHERE Employee.EmployeeId = Account.Id AND Employee.DepartmentId=Department.DepartmentId AND EmployeeId=@EmployeeId
		 END
		
		
		spEmployeeDetail 4
	


	CREATE FUNCTION FUN
	RETURNS VARCHAR(100)
	AS
	BEGIN
	 RETURN (SELECT FirstName+' '+LastName)
    END

	DROP PROC FUN
	SELECT dbo.FUN()
	FUN


	select * from Department