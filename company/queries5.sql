
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