SELECT * from students LIMIT 5;
SELECT * from student_enrollment LIMIT 5;
SELECT * from courses LIMIT 5;
SELECT * from professors  LIMIT 5;
SELECT * from teach  LIMIT 5;

-- Write a query that finds students who do not take CS180
SELECT * FROM students
WHERE student_no IN (SELECT student_no
                     FROM student_enrollment
                     WHERE course_no != 'CS180')
                    ORDER BY student_no;
SELECT * FROM students
WHERE student_no NOT IN (SELECT student_no
                     FROM student_enrollment
                     WHERE course_no = 'CS180')
					 ORDER BY student_no;
SELECT s.student_no, s.student_name, s.age
FROM students s LEFT JOIN student_enrollment se
    ON s.student_no = se.student_no
GROUP BY s.student_no, s.student_name, s.age
HAVING MAX(CASE WHEN se.course_no = 'CS180' THEN 1 ELSE 0 END) = 0;

-- Write a query to find students who take CS110 or CS107 but not both
SELECT S.student_no
FROM students AS S
INNER JOIN student_enrollment AS SE
ON S.student_no = SE.student_no
WHERE SE.course_no = 'CS110' OR SE.course_no='CS180'
GROUP BY S.student_no
HAVING COUNT(S.student_no)=1;

--Write a query to find students who take CS220 and no other courses.
SELECT S.student_no, S.student_name
FROM students AS S
WHERE S.student_no IN (SELECT SE.student_no 
						FROM student_enrollment AS SE
				  	 WHERE SE.course_no='CS220')				 
AND S.student_no NOT IN (SELECT SE.student_no 
						FROM student_enrollment AS SE
				  	 WHERE SE.course_no!='CS220');

-- Write a query that finds those students who take at most 2 courses. 
-- Your query should exclude students that don't take any courses as well as those that take more than 2 course.
SELECT S.student_no
FROM students AS S, student_enrollment AS SE
WHERE S.student_no = SE.student_no
GROUP BY S.student_no
HAVING COUNT(S.student_no)<=2;

-- Write a query to find students who are older than at most two other students.
SELECT S1.student_name, S1.age
FROM students S1
WHERE ( SELECT COUNT(*)
	   FROM students S2	 
	   WHERE S1.age>S2.age
	  ) >=2 ;