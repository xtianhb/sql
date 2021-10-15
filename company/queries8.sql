--

SELECT E.first_name, E.department, E.email, D.division, R.country
FROM employees E, departments D, regions R
WHERE E.department = D.department
AND E.region_id = R.region_id
AND E.email IS NOT NULL
LIMIT 10;

SELECT COUNT(*) FROM (
    SELECT E.First_Name, R.Country
    FROM Employees E, Regions R
    WHERE R.Region_Id = E.Region_Id
    ) Q
GROUP BY Q.Country;

SELECT COUNT(E.Employee_Id), R.Country
FROM Employees E, Regions R
WHERE R.Region_Id = E.Region_Id
GROUP BY R.Country;

-- JOINS

-- INNER JOIN
SELECT first_name, division, email, country
FROM employees 
INNER JOIN departments
ON employees.department = departments.department
INNER JOIN regions
ON employees.region_id = regions.region_id
WHERE email is NOT NULL
LIMIT 10;

-- INNER JOIN
SELECT DISTINCT employees.department, departments.department
FROM employees 
INNER JOIN departments 
ON employees.department = departments.department;

-- LEFT OUTER JOIN
SELECT DISTINCT employees.department, departments.department
FROM employees 
LEFT OUTER JOIN departments 
ON employees.department = departments.department;

-- RIGHT OUTER JOIN
SELECT DISTINCT employees.department, departments.department
FROM employees 
RIGHT OUTER JOIN departments 
ON employees.department = departments.department;

-- FULL OUTER JOIN
SELECT DISTINCT 
	employees.department as E_Dept,
	departments.department as D_Dept
FROM employees 
FULL OUTER JOIN departments
ON employees.department = departments.department;

-- UNIONS

SELECT MAX(salary)
FROM employees
UNION
SELECT MIN(salary)
FROM employees
;

SELECT department
FROM employees
UNION ALL
SELECT department
FROM departments
LIMIT 10;

SELECT DISTINCT department
FROM employees
EXCEPT
SELECT department
FROM departments;

SELECT DISTINCT department
FROM departments
EXCEPT
SELECT department
FROM employees;

SELECT department, count(employee_id)
FROM employees
GROUP BY department
UNION ALL
SELECT 'TOTAL', COUNT(*) AS total
FROM EMPLOYEES;

----- TEST INNER JOIN, MOVING RANGE

SELECT first_name, department, hire_date, country
FROM employees E
INNER JOIN regions R
ON E.region_id = R.region_id
WHERE
hire_date =  (SELECT MIN(hire_date) FROM employees E2) 
OR
hire_date = (SELECT MAX(hire_date) FROM employees E2);

SELECT 	hire_date, salary,
		(SELECT SUM(E2.salary) FROM employees AS E2
		WHERE E2.hire_date BETWEEN
		 	(E1.hire_date-90) AND E1.hire_date ) as pattern
FROM employees AS E1
ORDER BY hire_date
LIMIT 10;

-- VIEWS

CREATE VIEW v_employee_info AS
SELECT 	E.first_name, E.email, E.department, E.salary, D.division, R.region
FROM 	employees E, departments D,	regions R
WHERE 	e.department = d.department
AND		E.region_id = R.region_id;

SELECT first_name, region FROM v_employee_info LIMIT 10;

-- INLINE VIEWS

SELECT * 
FROM (SELECT * FROM departments) AS Q;

-- Write a query that returns employees whose salary is above average for their given department.
SELECT E1.first_name, E1.salary 
FROM employees AS E1
WHERE E1.salary > (	SELECT AVG(salary) 
					FROM employees AS E2
			   		GROUP BY E2.department
				 	HAVING E2.department = E1.department)
LIMIT 10;