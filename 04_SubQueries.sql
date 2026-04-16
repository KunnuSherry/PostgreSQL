CREATE TABLE employee (
    emp_id INTEGER PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_name VARCHAR(50),
    salary INTEGER
);

INSERT INTO employee (emp_id, emp_name, dept_name, salary) VALUES
(101, 'Mohan', 'Admin', 4000),
(102, 'Rajkumar', 'HR', 3000),
(103, 'Akbar', 'IT', 4000),
(104, 'Dorvin', 'Finance', 6500),
(105, 'Rohit', 'HR', 3000),
(106, 'Rajesh', 'Finance', 5000);

-- Create table
CREATE TABLE department (
    dept_id INTEGER,
    dept_name VARCHAR(50) PRIMARY KEY,
    location VARCHAR(100)
);

-- Insert values
INSERT INTO department (dept_id, dept_name, location) VALUES
(1, 'Admin', 'Bangalore'),
(2, 'HR', 'Bangalore'),
(3, 'IT', 'Bangalore'),
(4, 'Finance', 'Mumbai'),
(5, 'Marketing', 'Bangalore'),
(6, 'Sales', 'Mumbai');


-- How does SQL process statement?
-- Find the the employees who's salary is more than avg salary.
--1. Scalar Subquery - 1 Row and 1 Column
select emp_name
from employee
where salary > (select avg(salary)
from employee);

--2a. Multiple Row Subquery(Multiple row and column).
--Find the employees who has the max_salary in each department
select e.emp_name, e.dept_name, e.salary
from employee as e
join (select dept_name, max(salary) as max_salary
  from employee
  group by dept_name) as d
  on e.dept_name=d.dept_name and e.salary=d.max_salary;
 
--2b. Multiple Row Subquery(Multiple row and single column).
--Find the department who do not have an employee
select dept_name
from employee
group by dept_name;

select dept_name as No_Employee_Department
from department
where dept_name not in (select dept_name
                      from employee
                      group by dept_name);
                     

--3. Correlated Subquery
-- when subquery is related with the outer subquery
-- Find the employees in each department who earns more than the avaerage salary in that department

select *
from employee e1
where salary > (select avg(salary)
              from employee e2
              where e2.dept_name=e1.dept_name);
                 
--4. Nested subquery
-- Create table
CREATE TABLE store_sales (
    store_id INTEGER,
    store_name VARCHAR(50),
    product_name VARCHAR(50),
    quantity INTEGER,
    price INTEGER
);

-- Insert values
INSERT INTO store_sales (store_id, store_name, product_name, quantity, price) VALUES
(1, 'Apple Store 1', 'iPhone 13 Pro', 1, 1000),
(1, 'Apple Store 1', 'MacBook pro 14', 3, 6000),
(1, 'Apple Store 1', 'AirPods Pro', 2, 500),
(2, 'Apple Store 2', 'iPhone 13 Pro', 2, 2000),
(3, 'Apple Store 3', 'iPhone 12 Pro', 1, 750),
(3, 'Apple Store 3', 'MacBook pro 14', 1, 2000);

-- Find stores who's sales is better than avg sales across all stores.
select store_id, sum(price*quantity) as total_sales
from store_sales
group by store_id;

select avg(total_sales) as avg_sales
from (select store_id, sum(price*quantity) as total_sales
      from store_sales
      group by store_id);
     
select store_id, store_name, sum(price*quantity) as sum
from store_sales
group by store_id, store_name
having sum(price*quantity) > (select avg(total_sales) as avg_sales
from (select store_id, sum(price*quantity) as total_sales
      from store_sales
      group by store_id));
