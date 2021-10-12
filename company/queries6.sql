SELECT category, COUNT(category)  FROM
   ( SELECT 
    CASE 
        WHEN salary < 100000 THEN 'under paid'
        WHEN salary > 100000 AND salary < 160000 THEN 'well paid'
        ELSE 'executive'
    END AS category
    FROM employees
    ) SubQ
GROUP BY category
;

SELECT  SUM ( CASE WHEN salary < 100000 THEN 1 ELSE 0 END) as under_paid,
        SUM ( CASE WHEN salary > 100000 and salary < 150000 THEN 1 ELSE 0 END) as well_paid,
        SUM ( CASE WHEN salary > 150000 THEN 1 ELSE 0 END) as executive 
FROM employees;

SELECT  SUM ( CASE WHEN department = 'Sports' THEN 1 ELSE 0 END) as Sports_Department,
        SUM ( CASE WHEN department = 'Tools' THEN 1 ELSE 0 END) as Tools_Department,
        SUM ( CASE WHEN department = 'Clothing' THEN 1 ELSE 0 END) as Clothing_Department,
        SUM ( CASE WHEN department = 'Computers' THEN 1 ELSE 0 END) as Computers_Department
FROM employees;

SELECT E.first_name,
(CASE WHEN region_id = 1 THEN (SELECT country FROM regions WHERE region_id = 1) ELSE NULL END) as region_1
FROM
employees as E;