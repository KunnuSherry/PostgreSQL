-- PRODUCTS TABLE

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50)
);

INSERT INTO products (product_id, product_name)
VALUES
    (1, 'Laptop'),
    (2, 'Smartphone'),
    (3, 'Headphones'),
    (4, 'Monitor'),
    (5, 'Keyboard');


-- SALES TABLE

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    city VARCHAR(50),
    sale_date DATE,
    amount INT
);

INSERT INTO sales (sale_id, product_id, city, sale_date, amount)
VALUES
    (1,  2, 'Philadelphia', '2024-01-20', 1200),
    (2,  2, 'New York',     '2024-02-11', 1300),
    (3,  1, 'Dallas',       '2024-08-01', 2200),
    (4,  3, 'Philadelphia', '2024-01-04', 1000),
    (5,  2, 'Chicago',      '2024-05-06', 1300),
    (6,  2, 'New York',     '2024-12-14', 500),
    (7,  3, 'Chicago',      '2024-02-22', 1350),
    (8,  3, 'Dallas',       '2024-11-16', 800),
    (9,  1, 'New York',     '2024-03-10', 2500),
    (10, 4, 'Chicago',      '2024-04-15', 1800),
    (11, 5, 'Dallas',       '2024-06-20', 700),
    (12, 1, 'Philadelphia', '2024-07-12', 2100),
    (13, 2, 'Chicago',      '2024-09-05', 1400),
    (14, 4, 'New York',     '2024-10-18', 1900),
    (15, 5, 'Philadelphia', '2024-10-25', 650),
    (16, 3, 'Dallas',       '2024-12-02', 900),
    (17, 1, 'Chicago',      '2024-11-11', 2300),
    (18, 4, 'Dallas',       '2024-12-20', 1750);


-- =========================================================
-- GROUPING SETS
-- =========================================================

-- Business use case:
-- Multi-level sales reporting based on different cities and products.

-- Calculate:
-- 1. Total sales per city
-- 2. Total sales per product
-- 3. Total sales overall
-- 4. Total sales per city + product combination

SELECT 
    s.city,
    p.product_name,
    SUM(s.amount) AS total_sales,
    GROUPING(s.city) AS grouping_city,
    GROUPING(p.product_name) AS grouping_product
FROM products p
JOIN sales s 
    ON s.product_id = p.product_id
GROUP BY GROUPING SETS (
    (s.city),
    (p.product_name),
    (),
    (s.city, p.product_name)
);


-- =========================================================
-- ROLLUP
-- =========================================================

-- ROLLUP creates hierarchical subtotals.
--
-- ROLLUP(city, product_name) produces:
--
-- 1. City + Product
-- 2. City total
-- 3. Grand total

SELECT 
    s.city,
    p.product_name,
    SUM(s.amount) AS total_sales,
    GROUPING(s.city) AS grouping_city,
    GROUPING(p.product_name) AS grouping_product
FROM products p
JOIN sales s 
    ON s.product_id = p.product_id
GROUP BY ROLLUP (
    s.city,
    p.product_name
);


-- =========================================================
-- CUBE
-- =========================================================

-- CUBE generates all possible combinations of
-- the grouping columns.
--
-- CUBE(city, product_name) produces:
--
-- 1. City + Product
-- 2. City
-- 3. Product
-- 4. Grand total

SELECT 
    s.city,
    p.product_name,
    SUM(s.amount) AS total_sales,
    GROUPING(s.city) AS grouping_city,
    GROUPING(p.product_name) AS grouping_product
FROM products p
JOIN sales s 
    ON s.product_id = p.product_id
GROUP BY CUBE (
    s.city,
    p.product_name
);