SELECT first_name, department, salary
FROM employees e1
WHERE salary > (SELECT AVG(salary) 
				FROM employees e2
				WHERE e1.department = e2.department)
LIMIT 10;

SELECT first_name, department, salary,
(SELECT ROUND(AVG(salary))
	FROM employees e2
	WHERE e1.department = e2.department) as avg_dept_sal
FROM employees e1
LIMIT 10;

SELECT D1.department as  __Department__
FROM departments as D1
WHERE ( SELECT COUNT(*) 
		FROM employees AS E1 
		WHERE E1.department = D1.department) > 38;

SELECT D1.department, 
(SELECT MAX(salary) 
	FROM employees as E2
	WHERE E2.department = D1.department)
FROM departments as D1
WHERE ( SELECT COUNT(*) 
		FROM employees AS E1 
		WHERE E1.department = D1.department) > 38;



SELECT E1.department, E1.first_name , E1.salary,
(
	CASE WHEN E1.salary >= 
		( 
			SELECT MAX(salary) 
			FROM employees 
			GROUP BY department 
			HAVING department=e1.department
		)
		THEN 'HIGHEST_SALARY' 
 		ELSE 'LOWEST_SALARY' 
 	END 
) AS category
FROM Employees as E1
WHERE E1.salary = (SELECT MAX(E2.salary) as sal
					FROM employees as E2
				   GROUP BY (E2.department)
					HAVING E1.department = E2.department
				  )
OR E1.salary = (SELECT MIN(E2.salary) as sal
					FROM employees as E2
				   GROUP BY (E2.department)
					HAVING E1.department = E2.department
				  )
ORDER BY E1.department ASC;


SELECT Q.department, Q.first_name, Q.salary,
CASE WHEN Q.salary >= Max_Dept 
	THEN 'HIGHEST_SALARY' 
	ELSE 'LOWEST_SALARY' 
 	END 
AS category
FROM 
(	SELECT E1.department, E1.first_name , E1.salary,
		(SELECT MAX(salary) 
		 FROM employees as E2
		 WHERE E1.department = E2.department) AS Max_Dept,
		(SELECT MIN(salary) 
		 FROM employees as E2
		WHERE E1.department = E2.department) AS Min_Dept
	FROM Employees as E1
	ORDER BY E1.department ASC
 ) as Q
 WHERE salary in (Max_Dept, Min_Dept);

