SELECT s.student_name, x.course_title
FROM students s
JOIN (
    SELECT course_title
    FROM courses c
    WHERE c.course_id = s.enrolled_course
) x ON true;


-- This will throw an error as S is an outer table and we cant access that inside inner one.
-- Just add LATERAL keyword in start of Inner Subquery. It means that table is dependent on the outer table.

SELECT s.student_name, x.course_title
FROM students s
JOIN LATERAL (
    SELECT course_title
    FROM courses c
    WHERE c.course_id = s.enrolled_course
) x ON true;


CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO customers (id, name)
VALUES
    (1, 'Alice'),
    (2, 'Bob'),
    (3, 'Charlie'),
    (4, 'Diana');


    CREATE TABLE orders (
      id INT PRIMARY KEY,
      customer_id INT,
      amount DECIMAL(10,2),
      order_date DATE
  );
  
  INSERT INTO orders (id, customer_id, amount, order_date)
  VALUES
      (101, 1, 100.00, '2024-01-10'),
      (102, 1, 200.00, '2024-01-15'),
      (103, 1, 300.00, '2024-01-20'),
      (104, 2, 400.00, '2024-01-05'),
      (105, 2, 500.00, '2024-01-07'),
      (106, 2, 450.00, '2024-01-09'),
      (107, 3, 600.00, '2024-02-01'),
      (108, 3, 120.00, '2024-03-01'),
      (109, 4, 180.00, '2024-03-02'),
      (110, 4, 160.00, '2024-03-03');

-- select * from orders
-- select * from customers


-- For each customer, return the order(s) where they spent more than their average order amount. Display customer_name, av_order_amt and order_id.

select o.customer_id, o.id
from orders o
where amount > (select avg(amount) from orders where orders.customer_id=o.customer_id)

-- select o.customer_id, o.id, avg(amount) over(partition by o.customer_id) as av_order_amt
-- from orders o
-- where o.amount > avg(amount) over(partition by o.customer_id)
-- Windowed functions can only appear in the SELECT or ORDER BY clauses.

select o.customer_id, o.id, x.avg_amt
from orders o
join (select b.customer_id, avg(b.amount) as avg_amt
        from orders b
        group by b.customer_id
    ) as x on o.customer_id = x.customer_id 
where o.amount > x.avg_amt

--This worked without Lateral

SELECT 
    o.customer_id,
    o.id AS order_id,
    x.avg_amt
FROM orders AS o
JOIN LATERAL (
    SELECT AVG(b.amount) AS avg_amt
    FROM orders AS b
    WHERE b.customer_id = o.customer_id
) AS x ON TRUE
WHERE o.amount > x.avg_amt;

-- This needs lateral
--LATERAL is useful when the subquery needs to reference a column from the row currently being processed by the outer query.