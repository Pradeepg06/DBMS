create database employee_db;
use employee_db;

/*creating tables*/

create table Department(dept_no int, d_name varchar(30), d_loc varchar(30),
						primary key (dept_no) );
desc Department;

create table Employee(emp_no int, e_name varchar(30), mgr_no int, hire_date date, sal real, dept_no int,
						primary key (emp_no),
                        foreign key (dept_no) references Department (dept_no));
desc Employee;

create table Incentives(emp_no int, incentive_date date, incentive_amount real,
						primary key(emp_no,incentive_date),
                        foreign key (emp_no) references Employee(emp_no));
desc Incentives;

create table Project(p_no int, p_loc varchar(30), p_name varchar(30),
						primary key (p_no));
desc Project;

create table Assigned_to(emp_no int, p_no int, job_role varchar(30),
					primary key (emp_no, p_no),
                    foreign key (emp_no) references Employee(emp_no),
                    foreign key (p_no) references Project(p_no));
desc Assigned_to;

/*inserting vales/details to table*/

insert into Department values(01,"sales","india");
insert into Department values(02,"quality assurance","america");
insert into Department values(03,"maintenance","japan");
insert into Department values(04,"marketing","srilanka");
insert into Department values(05,"production","china");
select * from Department;

insert into Employee values (10,"Avinash",100,"2019-02-21",20000,01);
insert into Employee values (11,"Bheema",101,"2019-04-15",25000,02);
insert into Employee values (12,"Cary",102,"2020-12-31",30000,03);
insert into Employee values (13,"Ravi",103,"2022-01-11",35000,04);
insert into Employee values (14,"Robin",104,"2024-09-01",100000,05);
select *from Employee;

insert into Incentives values (10,"2024-06-22",2000);
insert into Incentives values (11,"2022-04-24",5000);
insert into Incentives values (12,"2019-11-02",3000);
insert into Incentives values (13,"2022-12-09",9000);
insert into Incentives values (14,"2004-03-15",1000);
select *from Incentives;

insert into Project values (20,"india","bookbyte");
insert into Project values (21,"america","apartment");
insert into Project values (22,"india","wire harness");
insert into Project values (23,"japan","samsung");
insert into Project values (24,"japan","iphone");
select *from Project;

insert into Assigned_to values (10,20,"Manager");
insert into Assigned_to values (11,21,"HR");
insert into Assigned_to values (12,22,"Manager");
insert into Assigned_to values (13,23,"Team leader");
insert into Assigned_to values (14,24,"Employee");
select *from Assigned_to;

/* Query 3: Retrieve the employee numbers of all employees who work on
project located in Bengaluru, Hyderabad, or Mysuru */
select distinct a.emp_no
from Assigned_to a
Join Project p on a.p_no = p.p_no
where p.p_loc in ('india','america','srilanka');

/*Query 4: Get Employee ID’s of those employees who didn’t receive incentives */
select e.emp_no
from Employee e
left join Incentives i on e.emp_no = i.emp_no
where i.emp_no is NULL;

/*Query 5: Write a SQL query to find the employees name, number, dept, job_role, department location and project location who are working for
a project location same as his/her department location. */
select e.e_name, e.emp_no, d.d_name as dept, a.job_role, d.d_loc as department_location, p.p_loc as project_loaction
from Employee e
join Department d on e.dept_no = d.dept_no
join Assigned_to a on e.emp_no = a.emp_no
join Project p on a.p_no = p.p_no
where d.d_loc = p.p_loc;

/* updating Employee table mgr_no values*/
update Employee
set mgr_no = emp_no;

update Employee
set mgr_no=10
where emp_no in (11,12);

select *from Employee;

/* additional querys */

/*Query 6: List the name of the managers with the maximum employees */
SELECT e.e_name AS manager_name, COUNT(e2.emp_no) AS employee_count
FROM Employee e
JOIN Employee e2 ON e.emp_no = e2.mgr_no
GROUP BY e.e_name
ORDER BY employee_count DESC
LIMIT 1;

/*Query 7: Display those managers name whose salary is more than average salary of his employees */
select mgr_no,e_name
from Employee
WHERE sal >(select avg(sal)
			from Employee);
            
 /*Query 8: Find the name of the second top level managers of each department */           
SELECT dept_no, e_name AS Second_Top_Level_Manager, sal
FROM (
    SELECT dept_no, e_name, sal, 
           RANK() OVER (PARTITION BY dept_no ORDER BY sal DESC) AS salary_rank
    FROM Employee
) ranked_employees
WHERE salary_rank = 2;

/*Query 9. Find the employee details who got second maximum incentive in January 2024.*/
SELECT e.emp_no, e.e_name, e.sal, incentive_amount, i.incentive_date
FROM Employee e
JOIN Incentives i ON e.emp_no = i.emp_no
WHERE i.incentive_date BETWEEN '2024-01-01' AND '2024-12-31'
ORDER BY i.incentive_amount DESC;

/*Query 10: Display those employees who are working in the same department where his manager is working.*/
SELECT e.emp_no, e.e_name, e.dept_no AS employee_dept, m.e_name AS manager_name, m.dept_no AS manager_dept
FROM Employee e
JOIN Employee m ON e.mgr_no = m.emp_no
WHERE e.dept_no = m.dept_no;



