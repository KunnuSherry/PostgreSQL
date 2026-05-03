-- The Syntax of Recursive CTEs in SQL
With RECURSIVE cte_name (column1, column2, ...) AS (
    -- Anchor member: the initial query that does not reference the CTE itself
    SELECT ...
    FROM ...
    WHERE ...

    UNION ALL

    -- Recursive member: references the CTE itself to build upon the results of the anchor member
    SELECT ...
    FROM cte_name
    JOIN ...
    WHERE ...
)

-- Example of a recursive CTE to generate a sequence of numbers from 1 to 10
WITH RECURSIVE numbers AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num + 1
    FROM numbers
    WHERE num < 10
)
SELECT * FROM numbers;

-- Example of a recursive CTE to find hierarchy of employees under a manager
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name TEXT,
    manager_id INT
);

INSERT INTO employees (id, name, manager_id) VALUES
(1, 'CEO', NULL),
(2, 'CTO', 1),
(3, 'CFO', 1),
(4, 'Engineer 1', 2),
(5, 'Engineer 2', 2),
(6, 'Accountant', 3);

WITH RECURSIVE hierarchy AS (
    -- start from CEO
    SELECT id, name, manager_id, 1 AS level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    -- get employees under each manager
    SELECT e.id, e.name, e.manager_id, h.level + 1
    FROM employees e
    JOIN hierarchy h ON e.manager_id = h.id
)
SELECT * FROM hierarchy;