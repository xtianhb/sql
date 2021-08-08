SELECT * 
FROM employees 
WHERE department LIKE '%oo%';

SELECT * 
FROM employees
WHERE (department != 'Clothing' or department != 'Tools')
AND salary > 120000;

SELECT * 
FROM employees
WHERE email is NULL
AND department = 'Tools';

SELECT * 
FROM employees
WHERE department in ('Sports', 'Tools', 'Clothing')
AND salary BETWEEN 80000 AND 100000;
