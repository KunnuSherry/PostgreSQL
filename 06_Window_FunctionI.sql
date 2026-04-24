CREATE TABLE employees (
    emp_id INTEGER PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_name VARCHAR(50),
    salary INTEGER
);

INSERT INTO employees (emp_id, emp_name, dept_name, salary) VALUES
(101, 'Mohan', 'Admin', 4000),
(102, 'Rajkumar', 'HR', 3000),
(103, 'Akbar', 'IT', 4000),
(104, 'Dorvin', 'Finance', 6500),
(105, 'Rohit', 'HR', 3000),
(106, 'Rajesh', 'Finance', 5000),
(107, 'Preet', 'HR', 7000),
(108, 'Maryam', 'Admin', 4000);

--SQL WINDOW function
SELECT dept_name, MAX(salary) AS max_salary
FROM employees
GROUP BY dept_name;

SELECT e.*,
       MAX(salary) OVER (PARTITION BY dept_name) AS max_salary
FROM employees e;

--1 Row_Number() : gives unqiue row number
SELECT e.*,
       Row_Number() OVER () AS rn
FROM employees e;

SELECT e.*,
       Row_Number() OVER (PARTITION BY dept_name) AS rn
FROM employees e;

--Fetch fist 2 employees from each department according to their joining date
select *
from (
  select e.*,
  Row_Number() over (partition by dept_name order by emp_id) as rn
  from employees e
) x
where x.rn<3;

--Rank() : give ranks acc to some conditions
--Fetch thr top three employees in each department based on salary max
select *
from (
  select e.*,
  rank() over (partition by dept_name order by salary desc) as rn
  from employees e
) x
where x.rn<4;

--Dense_Rank() : give ranks acc to some conditions but do not skip the next number
  select e.*,
  rank() over (partition by dept_name order by salary desc) as rnk
  --Dense_Rank() over (partition by dept_name order by salary desc) as d_rnk
  from employees e;

--lead and lag : give the previous or following VALUES
--lead(column_name, n(n records previous), x(null value))
--fetch the query to display if the salary of an employee is higher, lower or equal to the previous employee
with prev as (select e.emp_id, lag(salary) over(partition by dept_name order by emp_id) as prev_salary
from employees e)

select e.*,
case
  when prev_salary is null then 'First Employee'
  when e.salary > prev.prev_salary then 'high'
  when e.salary < prev.prev_salary then 'low'
  else 'equal'
end as sal_category
from employees e
join prev
on e.emp_id = prev.emp_id;