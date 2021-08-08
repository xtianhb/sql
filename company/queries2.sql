SELECT first_name, last_name, salary as "Yearly Salary"
FROM employees
WHERE salary > 100000
ORDER BY salary DESC
FETCH FIRST 100 ROWS ONLY;

SELECT * 
FROM employees
WHERE salary > 100000
ORDER BY salary DESC
LIMIT 10;