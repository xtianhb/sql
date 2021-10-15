SELECT * FROM student_enrollment;
SELECT * FROM professors;
-- They are not directly related. Not commont column. Use teach table.

SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM teach;

-- Write a query that shows the student's name, 
-- the courses the student is taking and the 
-- professors that teach that course.

SELECT 	S.student_name,
		SE.course_no,
		TE.last_name
	FROM students AS S
	INNER JOIN 
		student_enrollment AS SE
		ON S.student_no = SE.student_no
	INNER JOIN 
		teach AS TE
		ON SE.course_no = TE.course_no
ORDER BY S.student_name

-- Workaround to limit 1 professor

SELECT 	S.student_name,
		SE.course_no,
		(	SELECT TE.last_name FROM  teach AS TE
			WHERE SE.course_no = TE.course_no
			LIMIT 1)
	FROM students AS S
	INNER JOIN 
		student_enrollment AS SE
		ON S.student_no = SE.student_no
ORDER BY S.student_name;

-- Correlated subqueries are slower because they're evaluated for each row from outer query.

--Write a query that returns ALL of the students as well as any courses they may or may not be taking.
SSELECT s.student_no, S.student_name, Se.course_no
FROM students S
LEFT JOIN student_enrollment SE
ON s.student_no = se.student_no;
