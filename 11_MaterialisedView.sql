-- Materialised view is a database object that contains the results of a query. It is similar to a regular view, but the data is stored on disk and can be refreshed periodically. Materialised views can improve query performance by precomputing and storing the results of complex queries.

-- Create table
CREATE TABLE sales (
    id SERIAL PRIMARY KEY,
    amount INT
);

-- Insert sample data
INSERT INTO sales(amount) VALUES (100), (200), (300);

-- Create materialized view
CREATE MATERIALIZED VIEW total_sales AS
SELECT SUM(amount) AS total FROM sales;

-- Query
SELECT * FROM total_sales;

-- Refresh (important)
REFRESH MATERIALIZED VIEW total_sales;