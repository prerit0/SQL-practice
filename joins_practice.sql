create database joins_practice;
use joins_practice;

select * from courses
limit 5 ;

select * from students
limit 5 ;

-- Q1: Show all students with their course names (if they have any).
select s.name, c.course_name
from students s
join courses c 
on s.student_id = c.student_id
where c.course_name is not null;

-- Q2: Show students who have not enrolled in any course.
select s.name
from students s
left join courses c 
on s.student_id = c.student_id
where c.course_id is null; -- we can also use course_name in where condition

-- Q3: Show all courses along with student names.
select c.course_name, s.name
from courses c
left join students s
on c.student_id = s.student_id;

-- Q4: Display students from 'Pune' along with their enrolled courses.
select s.name, c.course_name
from students s
join courses c 
on s.student_id = c.student_id
where s.city = 'Pune';

-- Q5: Display students who scored more than 80 marks and their courses
select s.name, c.course_name
from students s
join courses c 
on s.student_id = c.student_id
where s.marks > 80;

-- Q6: Find total number of students enrolled in each course.
select c.course_name, count(*) as total_students
from courses c
join students s
on s.student_id = c.student_id
group by c.course_name;

-- Q7: Show only those courses where more than 50 students are enrolled.
select c.course_name
from courses c
join students s
on s.student_id = c.student_id
group by c.course_name
having count(c.course_name) > 50;