

SELECT *
FROM employees
WHERE
(gender = 'M' AND salary BETWEEN 40000 AND 100000 and department = 'Automotive')
OR
(gender = 'F' AND department = 'Toys');

SELECT first_name, hire_date 
FROM employees
WHERE hire_date BETWEEN '2002-01-01' AND '2004-01-01';

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

SELECT first_name, email
FROM employees
WHERE gender = 'F'
AND department = 'Tools'
AND salary > 110000;

SELECT first_name, hire_date
FROM employees
WHERE salary > 165000
OR (department = 'Sports' AND gender='M');