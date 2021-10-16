--VERY SLOW
SELECT E2.first_name, E2.department, 
	( SELECT count(*) from employees E1 
	 WHERE E1.department = E2.department)
FROM employees E2
GROUP BY E2.department, E2.first_name;

-- WINDOW FUNCTIONS
SELECT 	first_name, department,
		COUNT(*) OVER( PARTITION BY department)
FROM employees;
SELECT 	first_name, department,
		SUM(salary) OVER( PARTITION BY department)
FROM employees;

SELECT 	first_name, department, region_id
		COUNT(*) OVER( PARTITION BY department ) dept_count,
        COUNT(*) OVER( PARTITION BY region_id ) reg_count
FROM employees;

SELECT 	first_name, department,
		COUNT(*) OVER( PARTITION BY department )
FROM employees
WHERE region_id=3;

-- FRAMING

-- Running total
SELECT 	first_name, hire_date, salary ,
		SUM(salary) OVER( ORDER BY hire_date RANGE BETWEEN 
					UNBOUNDED PRECEDING AND CURRENT ROW)
		as RunningTotal
FROM employees;
-- Running total with partition
SELECT 	first_name, hire_date, salary ,
		SUM(salary) OVER( PARTITION BY department ORDER BY hire_date )
		as RunningTotal
FROM employees;
-- Adjacent
SELECT 	first_name, hire_date, department, salary,
		SUM(salary) OVER( 	ORDER BY hire_date ROWS 
						 	BETWEEN 1 PRECEDING AND CURRENT ROW)
		as RunningTotal
FROM employees;
SELECT 	first_name, hire_date, department, salary,
		SUM(salary) OVER( 	ORDER BY hire_date ROWS 
						 	BETWEEN 3 PRECEDING AND CURRENT ROW)
		as RunningTotal
FROM employees;
-- 

-- RANK
SELECT * FROM 
	(SELECT first_name, email, 
	 		department, salary,
			RANK() 
				OVER( 	PARTITION BY department 
						ORDER BY salary DESC )
	FROM employees ) AS Q
WHERE RANK = 3;

-- WHERE clause filters the table data. Views are executed at the end.
-- You can't use WHERE inside the RANK view.

-- Splits the partitioned column into NTILE groups of Desc value
SELECT first_name, email, 
		department, salary,
		NTILE(5) 
		OVER( 	PARTITION BY department 
				ORDER BY salary DESC ) as salary_bracket
FROM employees;

-- Get the first value of the partition the repeats for that group
SELECT first_name, email, 
		department, salary,
		FIRST_VALUE(salary)
		OVER( 	PARTITION BY department 
				ORDER BY salary DESC ) as salary_bracket
FROM employees;
SELECT first_name, email, 
		department, salary,
		NTH_VALUE(salary, 3)
		OVER( 	PARTITION BY department 
				ORDER BY salary DESC ) 
FROM employees;

SELECT first_name, email, 
		department, salary,
		MAX(salary)
		OVER( 	PARTITION BY department 
				ORDER BY salary DESC ) 
FROM employees;

-- Adds the next value in the column
SELECT first_name, last_name, salary,
	LEAD(salary) OVER() AS next_salay
FROM employees;
-- Adds the previous value in the column
SELECT first_name, last_name, salary,
	LAG(salary) OVER() AS prev_salay
FROM employees;

SELECT first_name, last_name, salary, department,
	LAG(salary) OVER (ORDER BY salary DESC) AS closest_higher_salary
FROM employees;
SELECT first_name, last_name, salary, department,
	LEAD(salary) OVER (ORDER BY salary DESC) AS closest_lower_salary
FROM employees;

-- Add column closest less salary, over department.
SELECT first_name, last_name, department, salary,
	LEAD(salary) OVER 
	(	PARTITION BY department 
	   ORDER BY salary DESC) AS closest_lower_salary
FROM employees;


