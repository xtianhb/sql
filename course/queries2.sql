SELECT student_name as "name", age
FROM students
ORDER BY age DESC
LIMIT 4;

SELECT student_name as "name"
FROM students
WHERE 
(student_name LIKE '%ae%' or student_name LIKE '%ph')
AND
age !=19;


SELECT student_name as "name"
FROM students
WHERE 
student_name LIKE '%ch%' or student_name LIKE '%nd';

SELECT student_name
FROM students
WHERE age BETWEEN 18 AND 20
LIMIT 10;

SELECT last_name || ' works in the ' || department || ' department'
FROM professors
LIMIT 20;

SELECT 'It is ' || (salary>95000) || ' that professor ' || last_name || ' is highly paid' AS "High_Salary"
FROM professors;

SELECT last_name, UPPER( SUBSTRING( department, 1,3 ) ) as department, salary, hire_date
FROM professors;

SELECT MIN(salary) as min_salary, MAX(salary) as high_salary 
FROM professors
WHERE last_name != 'Wilson';

select MIN(hire_date)
FROM professors;