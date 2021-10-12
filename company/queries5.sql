
SELECT COUNT(*) FROM employees
WHERE department NOT IN ('Clothing');

SELECT department FROM employees
WHERE department NOT IN (SELECT department FROM departments)
GROUP BY department
LIMIT 10;

SELECT department, SUM(Q.salary) FROM
(SELECT department, salary FROM employees WHERE salary > 160000) Q
GROUP BY department;

SELECT first_name, last_name, salary, 
(SELECT first_name FROM employees LIMIT 1)
FROM employees
LIMIT 10;

SELECT EMP.first_name, EMP.last_name, EMP.department
FROM employees EMP
WHERE EMP.department in (SELECT department FROM departments WHERE division='Electronics')
LIMIT 10;

SELECT EMP.first_name, EMP.last_name, EMP.region_id
FROM employees EMP
WHERE EMP.region_id in (SELECT region_id FROM regions WHERE Country='Asia' OR Country='Canada')
AND EMP.salary > 130000
LIMIT 10;

SELECT EMP.first_name, department, 
(SELECT MAX(salary) from employees)-EMP.salary as SalaryDiff
FROM employees EMP
WHERE EMP.region_id in (SELECT region_id FROM regions WHERE Country='Asia' OR Country='Canada')
LIMIT 10;



SELECT * FROM employees
WHERE region_id NOT IN (SELECT region_id FROM REGIONS WHERE country = 'Asia')
LIMIT 5;
SELECT * FROM employees
WHERE region_id > ANY (SELECT region_id FROM REGIONS WHERE country = 'Asia')
LIMIT 5;
SELECT * FROM employees
WHERE region_id > ALL (SELECT region_id FROM REGIONS WHERE country = 'Asia')
LIMIT 5;

-- Write a query that returns all employees that work at kids division
-- AND the dates at which those emp were hired is greater than all of the hire
-- dates of employees who work in the maintenance department
-- = ANY    .. IN ...
SELECT *
FROM EMPLOYEES E
WHERE E.department = ANY (SELECT department from departments WHERE division='Kids')
AND hire_date > ALL(SELECT hire_date from employees WHERE department='Maintenance')
LIMIT 20;

-- The Salaries that appear the most frequently. The same exact number.
SELECT salary, count(salary) SCount
FROM employees
GROUP BY salary
HAVING COUNT(*)>1
ORDER BY SCount DESC
LIMIT 1;


SELECT * from employees 
WHERE employee_id in ( SELECT min(employee_id)
    FROM employees
    GROUP BY department) ;


SELECT ROUND(AVG(salary)) FROM employees 
WHERE salary NOT IN ( (SELECT MIN(salary) from employees), (SELECT MAX(salary) from employees) ) ;
