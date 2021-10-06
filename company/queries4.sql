
SELECT department, SUM(salary)
FROM employees
WHERE region_id IN ( 2, 3, 4)
GROUP BY department;

SELECT department, 
COUNT(employee_id) as total_employees, 
ROUND(AVG(salary)) as Average_salary, 
MAX(Salary) as Max_salary, 
MIN(Salary) as Min_Salary
FROM employees
WHERE salary > 70000
GROUP BY department
ORDER BY total_employees DESC;

SELECT department, gender,
COUNT(employee_id) as total_employees, 
ROUND(AVG(salary)) as Average_salary, 
MAX(Salary) as Max_salary, 
MIN(Salary) as Min_Salary
FROM employees
GROUP BY department, gender
ORDER BY department ASC
LIMIT 10;

SELECT department, COUNT(employee_id) as total_employees
FROM employees
GROUP BY department
HAVING COUNT(employee_id) > 35;

SELECT first_name, count(*)
FROM employees
GROUP BY first_name
HAVING count(*) > 2;

SELECT department
FROM employees
GROUP BY department;

SELECT SUBSTRING(email, 1+POSITION('@' IN email) ) as Domain, 
COUNT(*) AS QUANT
FROM employees
WHERE email IS NOT NULL
GROUP BY Domain
HAVING COUNT(*) > 1
ORDER BY QUANT DESC
LIMIT 5;

SELECT gender, region_id, 
MIN(salary), MAX(salary), ROUND(AVG(salary))
FROM employees
GROUP BY gender, region_id
ORDER BY gender ASC, region_id ASC
LIMIT 10;