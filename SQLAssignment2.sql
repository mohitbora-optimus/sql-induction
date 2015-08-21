-- ASSIGNMENT 2 SQL INDUCTION

	create database assignment2
	use assignment2

	-- Employee Master Table


	CREATE TABLE t_emp
	(
	  Emp_id	int	IDENTITY(1001,2)	PRIMARY KEY NOT NULL,
	  Emp_Code	varchar(20),
	  Emp_f_name	varchar(30)	NOT NULL,
	  Emp_m_name	varchar(30),
	  Emp_l_nam		varchar(30),
	  Emp_DOB		DATE check ( datediff(year, Emp_DOB, getdate()) >=18), 
	  Emp_DOJ		DATE	NOT NULL
	 );

	 INSERT INTO t_emp(Emp_Code,Emp_f_name, Emp_l_nam,Emp_DOB, Emp_DOJ)
	 VALUES('OPT2011010','Manmohan','Singh','02-10-1983','05-25-2010');

	 INSERT INTO t_emp(Emp_Code,Emp_f_name,Emp_m_name, Emp_l_nam,Emp_DOB, Emp_DOJ)
	 VALUES('OPT20100915','Alfred','Joseph','Lawrence','02-28-1988','12-15-2012');

	 SELECT * FROM t_emp;

	 
	 -- Activity Table

	 CREATE TABLE t_activity
	( 
	  Activity_id	INT	PRIMARY KEY,
	  Activity_description	VARCHAR(20)
	 );
	
   INSERT INTO t_activity
   VALUES(1, 'Code Analysis');
   
   INSERT INTO t_activity
   VALUES(2, 'Lunch');
   
   INSERT INTO t_activity
   VALUES(3, 'Coding');

	
   INSERT INTO t_activity
   VALUES(4, 'Knowledge Transition');

   
   INSERT INTO t_activity
   VALUES(5, 'Database');

   SELECT * FROM t_activity

   -- ATTENDENCE TABLE

   CREATE TABLE t_atten_det
  (
    Atten_id	INT IDENTITY(1001,1) ,
	Emp_id		INT FOREIGN KEY REFERENCES  t_emp(Emp_id),
	Activity_id	INT	FOREIGN KEY REFERENCES	t_activity(Activity_id),
	Atten_start_datetime	DATETIME,
	Atten_end_hrs	INT
   );

   
	INSERT INTO t_atten_det(Emp_id,Activity_id,Atten_start_datetime,Atten_end_hrs)
	VALUES(1001,5,'2/13/2011 10:00:00', 2);
 
	INSERT INTO t_atten_det(Emp_id,Activity_id,Atten_start_datetime,Atten_end_hrs)
	VALUES(1001,1,'1/14/2011 10:00:00', 3);

	INSERT INTO t_atten_det(Emp_id,Activity_id,Atten_start_datetime,Atten_end_hrs)
	VALUES(1001,3,'1/14/2011 13:00:00', 5);

	INSERT INTO t_atten_det(Emp_id,Activity_id,Atten_start_datetime,Atten_end_hrs)
	VALUES(1003,5,'2/16/2011 10:00:00', 8);

	INSERT INTO t_atten_det(Emp_id,Activity_id,Atten_start_datetime,Atten_end_hrs)
	VALUES(1003,5,'2/17/2011 10:00:00', 8);

	INSERT INTO t_atten_det(Emp_id,Activity_id,Atten_start_datetime,Atten_end_hrs)
	VALUES(1003,5,'2/19/2011 10:00:00', 7);

select * from t_atten_det
	

	CREATE TABLE t_salary
   (
     Salary_id	INT,
	 Emp_Id	INT,
	 Changed_date	DATE,
	 New_Salary	DECIMAL(10,2)
	);

	INSERT INTO t_salary
	VALUES(1001,1003,'2/16/2011',20000);

	INSERT INTO t_salary
	VALUES(1002,1003,'1/05/2011',25000);

	INSERT INTO t_salary
	VALUES(1003,1001,'2/16/2011',26000);

	SELECT * FROM t_salary


-- first query

	SELECT CONCAT(Emp_f_name, ' ', ISNULL(Emp_m_name, ' '), Emp_l_nam) AS Name, Emp_DOB 
	FROM t_emp WHERE Emp_DOB = EOMONTH(Emp_DOB);

-- Second Query

	  	------------------------------------------------
		
		SELECT CONCAT(Emp_f_name, ' ', ISNULL(Emp_m_name, ' '),' ', Emp_l_nam) AS Name, t_emp.Emp_id, 
	cast(
	  CASE 
	  WHEN [Previous Salary] =  [Present salary] 
		THEN 0
	   ELSE 
	     [Previous Salary]
	END
		AS INT)  
		AS [Previous Salary],
		 [Present salary],
		 [Total Worked Hour],
		 [Last Activity Worked],
		 [Hours Worked in that]
		FROM  t_emp join
		(SELECT Emp_id,Activity_description AS [Last Activity Worked],Atten_end_hrs AS [Hours Worked in that]
	FROM t_activity,
	(	
	  SELECT Emp_id , Activity_id, Atten_end_hrs
	  FROM (SELECT Emp_id,max( Atten_start_datetime) AS [date]
	  FROM t_atten_det
	   GROUP BY t_atten_det.Emp_id) AS a
	  join 
	  ( SELECT Activity_id, Atten_start_datetime, Atten_end_hrs
	    FROM t_atten_det
		) AS b
	  ON b.Atten_start_datetime = a.[date]
	) AS k  
	WHERE t_activity.Activity_id = k.Activity_id
	) AS p
	 ON 
	( p.Emp_id = t_emp.Emp_id)
	  join

		( SELECT  
			t_emp.Emp_id AS ID, 
			SUM(Atten_end_hrs) AS [Total Worked Hour]
		  FROM
			 t_atten_det 
			JOIN
			t_emp
		  ON
			t_emp.Emp_id = t_atten_det.Emp_id
		GROUP BY t_emp.Emp_id
		)As V 
	ON V.ID = p.Emp_id,
		(
	SELECT 
		-- 
		t_emp.Emp_Id, min([Previous Salary]) AS [Previous Salary], max([Present salary]) AS [Present salary] 
		FROM
		 t_emp 
	 JOIN
		
		( SELECT 
				t_salary.Emp_Id AS Emp_id,
				New_Salary AS [Present salary], 
				RANK() OVER(PARTITION BY t_salary.Emp_Id ORDER BY New_Salary DESC) AS ID
			FROM 
				t_salary
			 JOIN
				t_emp
			ON	
				t_emp.Emp_id = t_salary.Emp_Id
		) AS U
	ON (t_emp.Emp_id = U.Emp_id)
	JOIN
		(SELECT 
			t_emp.Emp_Id as Emp_Id, 
			New_Salary AS [Previous Salary],
			RANK() OVER(PARTITION BY t_salary.Emp_Id ORDER BY New_Salary DESC) AS ID
		 FROM 
			t_salary
			 JOIN
			t_emp
		 ON	
			t_emp.Emp_id = t_salary.Emp_Id
		 )
	AS t 
	 ON
		U.Emp_id = t.Emp_Id
	WHERE 
	    U.ID =1
		OR	
		t.ID =2
	GROUP BY t_emp.Emp_id
	)
	AS X
	WHERE
	 X.Emp_id = t_emp.Emp_id						