-- Create a procedure to add a user
-- Create table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name TEXT,
    age INT
);

-- Procedure
CREATE OR REPLACE PROCEDURE add_user(p_name TEXT, p_age INT)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO users(name, age)
    VALUES (p_name, p_age);
END;
$$;
------------------------------------------------------------------------------------------------------

-- Create a procedure to update salary of an employee
-- Call
CALL add_user('Kunal', 22);

-- Create table
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name TEXT,
    salary INT
);

-- Insert sample
INSERT INTO employees(name, salary) VALUES
('A', 30000),
('B', 50000),
('C', 70000);

-- Procedure
CREATE OR REPLACE PROCEDURE update_salary(p_id INT, increment INT)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE employees
    SET salary = salary + increment
    WHERE id = p_id;
END;
$$;

-- Call
CALL update_salary(1, 5000);
-----------------------------------------------------------------------------------------------------------------

-- Create a procedure to transfer money between accounts
-- Create table
CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    name TEXT,
    balance INT
);

-- Insert sample
INSERT INTO accounts(name, balance) VALUES
('Alice', 10000),
('Bob', 5000);

-- Procedure
CREATE OR REPLACE PROCEDURE transfer_money(sender INT, receiver INT, amount INT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- deduct from sender
    UPDATE accounts
    SET balance = balance - amount
    WHERE id = sender;

    -- check balance
    IF (SELECT balance FROM accounts WHERE id = sender) < 0 THEN
        RAISE EXCEPTION 'Insufficient balance';
    END IF;

    -- add to receiver
    UPDATE accounts
    SET balance = balance + amount
    WHERE id = receiver;
END;
$$;

-- Call
CALL transfer_money(1, 2, 2000);