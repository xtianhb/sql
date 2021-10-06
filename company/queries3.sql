SELECT LENGTH(last_name), UPPER(last_name), first_name 
FROM employees 
LIMIT 10;

SELECT LENGTH ( TRIM(' Data to trim.  ') );

SELECT first_name || ', ' || last_name AS "full_name", department
FROM employees
LIMIT 10;

SELECT first_name || ', ' || last_name AS "full_name", department, salary, (salary > 165000) AS high_salary
FROM employees
ORDER BY salary DESC
LIMIT 10;

SELECT department, ('Clothing' IN (department) ) as Is_Clothing
FROM employees
LIMIT 10;

SELECT department, (department LIKE '%othing%' )
FROM employees
LIMIT 10;

SELECT SUBSTRING('This is data example string ' FROM 1 FOR 4 ) test_data;

SELECT department, REPLACE(department, 'Clothing', 'clothing') department__
FROM departments;

SELECT first_name, last_name, email, SUBSTRING( email, 1+POSITION('@' IN email) ) AS domain
from employees
LIMIT 20;

SELECT COALESCE(email, 'NONE!') AS email
FROM employees
LIMIT 10;

SELECT ROUND(AVG(salary)) AS average_salary
FROM employees;

SELECT MAX(salary) AS max_salary
FROM employees;

SELECT COUNT(email) 
FROM employees;

SELECT department, SUM(salary) as budget
FROM employees
GROUP BY department;


