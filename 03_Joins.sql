-- =========================
-- CREATE TABLES
-- =========================
-- Department Table
CREATE TABLE department (
    dept_id VARCHAR(20) PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Manager Table
CREATE TABLE manager (
    manager_id VARCHAR(20) PRIMARY KEY,
    manager_name VARCHAR(50),
    dept_id VARCHAR(20)
);

-- Employee Table
CREATE TABLE employee (
    emp_id VARCHAR(20) PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INTEGER,
    dept_id VARCHAR(20),
    manager_id VARCHAR(20)
);

-- Project Table
CREATE TABLE project (
    project_id VARCHAR(20),
    project_name VARCHAR(100),
    team_member_id VARCHAR(20)
);

-- =========================
-- INSERT DATA
-- =========================

-- Department Data
INSERT INTO department (dept_id, dept_name) VALUES
('D1', 'IT'),
('D2', 'HR'),
('D3', 'Finance'),
('D4', 'Admin');

-- Manager Data
INSERT INTO manager (manager_id, manager_name, dept_id) VALUES
('M1', 'Prem', 'D3'),
('M2', 'Shripadh', 'D4'),
('M3', 'Nick', 'D1'),
('M4', 'Cory', 'D1');

-- Employee Data
INSERT INTO employee (emp_id, emp_name, salary, dept_id, manager_id) VALUES
('E1', 'Rahul', 15000, 'D1', 'M1'),
('E2', 'Manoj', 15000, 'D1', 'M1'),
('E3', 'James', 55000, 'D2', 'M2'),
('E4', 'Michael', 25000, 'D2', 'M2'),
('E5', 'Ali', 20000, 'D10', 'M3'),
('E6', 'Robin', 35000, 'D10', 'M3');

-- Project Data
INSERT INTO project (project_id, project_name, team_member_id) VALUES
('P1', 'Data Migration', 'E1'),
('P1', 'Data Migration', 'E2'),
('P1', 'Data Migration', 'M3'),
('P2', 'ETL Tool', 'E1'),
('P2', 'ETL Tool', 'M4');


--Inner join
--Q1 - Fetch all the employee name and their department name
select e.emp_name, d.dept_name
from employee e
join department d on e.dept_id = d.dept_id;

--Left join
--Q1 - Fetch all the employee name and their department name
select e.emp_name, d.dept_name
from employee e
left join department d on e.dept_id = d.dept_id;

--Right join
--Q1 - Fetch all the employee name and their department name
select e.emp_name, d.dept_name
from employee e
right join department d on e.dept_id = d.dept_id;

--Combined Queries
select e.emp_name, d.dept_name, m.manager_name, p.project_name
from employee e
left join department d on e.dept_id = d.dept_id
left join manager m on e.manager_id = m.manager_id
left join project p on e.emp_id = p.team_member_id;

--Full Outer join = Inner Join + Left Join + Right Join
select e.emp_name, d.dept_name
from employee e
full join department d on e.dept_id = d.dept_id;

--Cross join = Cartesian Product
select e.emp_name, d.dept_name
from employee e
cross join department d;

CREATE TABLE family (
    member_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50),
    age INTEGER,
    parent_id VARCHAR(10)
);

INSERT INTO family (member_id, name, age, parent_id) VALUES
('F1', 'David', 4, 'F5'),
('F2', 'Carol', 10, 'F5'),
('F3', 'Michael', 12, 'F5'),
('F4', 'Johnson', 36, NULL),
('F5', 'Maryam', 40, 'F6'),
('F6', 'Stewart', 70, NULL),
('F7', 'Rohan', 6, 'F4'),
('F8', 'Asha', 8, 'F4');

-- Self Join - Join on itself
-- write a query to fetch the childname and their age corresponding to their parenst name and parent age

select child.name as c_name, child.age, parent.name as p_name, parent.age
from family as child
left join family as parent on child.parent_id=parent.member_id;

--Natural Join - Same as inner Join but SQL auto detects the same column based on name (not reliable)
