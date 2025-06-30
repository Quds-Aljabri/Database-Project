create database Training_Institute 

use Training_Institute 

          -----(DDL)-----
--Table 1:Trainee 

create Table Trainee (
  Trainee_ID int primary key,
  FullName VARCHAR(100),
  Gender bit default(0),
  Email varchar(100),
  Background Varchar (100)
);

--ALTER TABLE Trainee
--DROP COLUMN Gender;


ALTER TABLE Trainee
DROP CONSTRAINT DF__Trainee__Gender__24927208;

ALTER TABLE Trainee
DROP COLUMN Gender;

ALTER TABLE Trainee
ADD Gender VARCHAR(10) DEFAULT 'Male' CHECK (Gender IN ('Male', 'Female'));

--Table 2:Trainer

create Table Trainer (
  Trainer_ID int primary key,
  FullName VARCHAR(100),
  specialty varchar (100),
  Phone varchar (20),
  Email varchar(100)
);

--Table 3:Course 
CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    title VARCHAR(100),
    category VARCHAR(50),
    duration_hours INT,
    level VARCHAR(20) CHECK (level IN ('Beginner', 'Intermediate', 'Advanced'))
);

--create Table Course  (
  --Course_ID int primary key,
  --Title varchar(100),
  --Category varchar (100),
 -- Duration_Hour int,
 --level_type Enum('Beginner','Intermediate','Advanced')
  --level_type VARCHAR(20) CHECK (level_type IN ('Beginner','Intermediate','Advanced')
--);


--Table 4:Schedule 

create Table Schedule  (
  schedule_id int primary key,
  course_id int references Course(course_id),
  trainer_id int references Trainer(Trainer_ID),
  starts_date date,
  end_date date,
  time_slot  VARCHAR(20) CHECK (time_slot IN('Morning','Evening','Weekend')),
  --Foreign key course_id references Course(course_id),
  --Foreign key trainer_id references Trainer(Trainer_ID) 
);

--Table 5:Enrollment  

create Table Enrollment   (
  enrollment_id int primary key,
  trainee_id int,
  course_id int,
  enrollment_date date
  Foreign key (trainee_id) references Trainee(Trainee_ID),
  Foreign key (course_id) references Course(Course_ID)
 
);



                            -----(DML)-----
--Trainee Table 

select * from Trainee

insert into Trainee(Trainee_ID, FullName, Gender, Email, Background) 
values 
(1, 'Aisha Al-Harthy', 'Female', 'aisha@example.com', 'Engineering'), 
(2, 'Sultan Al-Farsi', 'Male', 'sultan@example.com', 'Business'),
(3, 'Mariam Al-Saadi', 'Female', 'mariam@example.com', 'Marketing'),
(4, 'Omar Al-Balushi', 'Male', 'omar@example.com', 'Computer Science'),
(5, 'Fatma Al-Hinai', 'Female', 'fatma@example.com', 'Data Science')

--Trainer Table 

select * from Trainer

insert into Trainer(Trainer_ID, FullName, specialty, Phone, Email )
values
(1, 'Khalid Al-Maawali', 'Databases', 96891234567 ,'khalid@example.com'), 
(2, 'Noura Al-Kindi' ,'Web Development', 96892345678, 'noura@example.com'), 
(3, 'Salim Al-Harthy', 'Data Science', 96893456789, 'salim@example.com')

--Course  Table 

select * from Course

insert into Course(course_id, Title, Category, Duration_Hours, level )
values 
(1, 'Database Fundamentals', 'Databases', 20, 'Beginner'), 
(2, 'Web Development Basics', 'Web' ,30, 'Beginner'),
(3, 'Data Science Introduction', 'Data Science', 25, 'Intermediate'), 
(4, 'Advanced SQL Queries',' Databases', 15, 'Advanced') 
 
--Schedule Table 

select * from Schedule

insert into  Schedule (schedule_id, course_id, trainer_id, starts_date, end_date, time_slot)
VALUES
(1, 1, 1, '2025-07-01', '2025-07-10', 'Morning'),
(2, 2, 2, '2025-07-05', '2025-07-20', 'Evening'),
(3, 3, 3, '2025-07-10', '2025-07-25', 'Weekend'),
(4, 4, 1, '2025-07-15', '2025-07-22', 'Morning');


--Enrollment Table 

select * from Enrollment

INSERT INTO Enrollment (enrollment_id, trainee_id, course_id, enrollment_date)
VALUES
(1, 1, 1, '2025-06-01'),
(2, 2, 1, '2025-06-02'),
(3, 3, 2, '2025-06-03'),
(4, 4, 3, '2025-06-04'),
(5, 5, 3, '2025-06-05'),
(6, 1, 4, '2025-06-06');




                               -----Trainee Perspective -----

------Query Challenges -------

----Q1: Show all available courses (title, level, category)---

Select title,level,category     ---select the colomns that i need to show it by using "SELECT"
From Course                              ---From is used to know from which table these columns are  

----Q2:View beginner-level Data Science courses---

Select course_id, title,category,duration_hours,level            ---select all columns from course table  
From Course
where level = 'Beginner' and category = 'Data Science'        --- using where condition to specify the level and category


----Q3:Show courses this trainee is enrolled in---

select T.Trainee_ID,C.title as course_title
from Course C Inner join Trainee T
on C.course_id = T.Trainee_ID



----Q4:View the schedule (start_date, time_slot) for the trainee's enrolled courses---

select C.title,S.starts_date, S.time_slot 
from Course C inner join  Schedule S
On  C.course_id = S.schedule_id

----Q5:Count how many courses the trainee is enrolled in---

select trainee_id ,count(course_id) as Num_of_Courses -- select the trainee id and count the noumber of courses for each trainee
From Enrollment                                         --from the enrollment table
Group by trainee_id                                     -- group all the enrollmeents by the id of the trainee


----Q6:Show course titles, trainer names, and time slots the trainee is attending---

select C.title,Tr.FullName,S.time_slot     ---select the columns that i want which are the course title , the name of the trainer and the time slot 
From Enrollment E inner join Course  C on  E.course_id = C.course_id inner join Schedule S on S.course_id = C.course_id  
inner join Trainer Tr on S.trainer_id = Tr.Trainer_ID 
Where E.trainee_id = 1

--just for practice(show the name of the trainee) --
select T.FullName as Trainee_Name,C.title,Tr.FullName as Trainer_Name,S.time_slot 
From Enrollment E inner join Trainee T on E.Trainee_ID = T.Trainee_ID inner join Course  C on  E.course_id = C.course_id inner join Schedule S on S.course_id = C.course_id 
inner join Trainer Tr on S.trainer_id = Tr.Trainer_ID 
Where E.trainee_id = 4



                           ----- Trainer Perspective-----

----Query Challenges---

---Q1: List all courses the trainer is assigned to ---
--select C.title ,Tr.Trainer_ID
--From Course C , Trainer Tr
--Where Trainer_ID = 3

select C.title
From Course C inner join Schedule  S  on C.course_id = S.course_id
where S.trainer_id = 2

--For practice: show the name of the trainer --
select C.title , Tr.FullName
From Course C inner join Schedule  S  on C.course_id = S.course_id inner join Trainer Tr on  Tr.trainer_id = S.trainer_id
where S.trainer_id = 1



---Q2: Show upcoming sessions (with dates and time slots) ---

select S.starts_date, S.end_date,S.time_slot 
From Schedule S
where S.trainer_id = 1 and starts_date>= '2025-07-15'  ---the condition here is to choose the trainer id and the start date should be bigger then the current date...
                                                      ----because we want  to filter only the sessions where the start date is after today



---Q3: See how many trainees are enrolled in each of your courses ---

select C.title , count(E.trainee_id) as Number_of_Trainee
From Schedule S inner join Course C on C.course_id = S.course_id left join Enrollment E on E.course_id = C.course_id
where S.trainer_id = 1
Group by  C.title


--practice--
select C.title ,Tr.FullName as Trainer_Name , count(E.trainee_id) as Number_of_Trainee
From Schedule S inner join Course C on C.course_id = S.course_id left join Enrollment E on E.course_id = C.course_id 
join Trainer Tr on Tr.Trainer_ID = S.trainer_id
Where S.trainer_id = 1
Group by  C.title,Tr.FullName




---Q4:List names and emails of trainees in each of your courses ---

select T.FullName as Trainee_Name,T.Email,C.title as Course_title       ---Select the colomns name .email and the course title 
From  Schedule S join  Enrollment E on S.course_id = E.course_id join  Trainee T on T.Trainee_ID = E.trainee_id join Course C on S.course_id = C.course_id
--where trainer_id = 1  -- to specify the id of the trainer and know who is  hvaing this course 


--practice--
select T.FullName as Trainee_Name,T.Email,C.title as Course_title       ---Select the colomns name .email and the course title 
From  Schedule S join  Enrollment E on S.course_id = E.course_id join  Trainee T on T.Trainee_ID = E.trainee_id join Course C on S.course_id = C.course_id
where trainer_id = 3  -- to specify the id of the trainer and know who is  hvaing this course 


---Q5:Show the trainer's contact info and assigned courses ---
select C.title as Course_title ,Tr.FullName as Trainer_Name,Tr.Phone,Tr.Email 
From Trainer  Tr inner join Schedule S  on Tr.Trainer_ID = S.trainer_id
inner join Course C on S.course_id = C.course_id

---practice-- add a condtion to show one trainer
select C.title as Course_title ,Tr.FullName as Trainer_Name,Tr.Phone,Tr.Email 
From Trainer  Tr inner join Schedule S  on Tr.Trainer_ID = S.trainer_id
inner join Course C on S.course_id = C.course_id
where Tr.Trainer_ID = 2

---Q6:Count the number of courses the trainer teaches ---
select count(distinct course_id) as number_of_course  --use count distinct to count the unique courses
From Schedule S
Where S.trainer_id = 2


--practice-- to show the name of the trainer and how many course he/she teach
select count(distinct course_id) as number_of_course, Tr.FullName
From Schedule S inner join Trainer Tr on S.trainer_id = Tr.Trainer_ID
Where S.trainer_id = 1
group by Tr.FullName






                         ----- Admin Perspective ----

---Query Challenges ---

---Q1:Add a new course (INSERT statement) ---

insert into  Course(course_id,title,category,duration_hours,level)
values (6,'Data Structure', 'Data Science',35,'Intermediate');  
--(5,'Data Structure', 'Data Science',35,'Intermediate');  --- the course id was 5 but i have exuted by mistake twice so i had to change the id again to 6


---Q2:Create a new schedule for a trainer ---

insert into Schedule (schedule_id, course_id, trainer_id, starts_date, end_date, time_slot)
VALUES
(5, 5, 2, '2025-07-27', '2025-07-31', 'Evening');

---Q3:View all trainee enrollments with course title and schedule info ---

select T.Trainee_ID ,T.FullName ,C.course_id, C.title, S.starts_date,S.end_date,S.time_slot
From Enrollment E  inner join Trainee T on E.trainee_id = T.Trainee_ID 
inner join Course C on E.course_id = C.course_id inner join Schedule S on C.course_id = S.course_id


---Q4:Show how many courses each trainer is assigned to ---

select Tr.Trainer_ID , Tr.FullName , count(S.course_id) as course_assign
From Trainer Tr left join Schedule S on Tr.Trainer_ID = S.trainer_id  ---using 'left join'  to ensure the  trainers with no
group by Tr.Trainer_ID , Tr.FullName                                 ---assigned courses still appear with a count of 0.


---Q5:List all trainees enrolled in "Data Basics" --- 

select T.FullName, T.Email, C.title
from Trainee T , Course C
where c.title = 'Data Basics'
---Group by C.category,T.FullName

---Q6:Identify the course with the highest number of enrollments ---

select top 1
C.course_id,c.title, count(E.enrollment_id)  as Enrollment_count
From Course C inner join Enrollment E on C.course_id = E.enrollment_id
group by C.course_id,c.title
order by Enrollment_count 

---Q7:Display all schedules sorted by start date ---

select * from Schedule
order by starts_date ASC;

