-- Table Creation Commands

CREATE TABLE SCHOOL (
    SCHOOL_ID VARCHAR(20),
    SCHOOL_NAME VARCHAR(100) NOT NULL,
    SCHOOL_ADDRESS VARCHAR(200),
    PHONE VARCHAR(15),
    
    CONSTRAINT PK_SCHOOL PRIMARY KEY (SCHOOL_ID)
);

CREATE TABLE ADDRESS (
    ADDRESS_ID VARCHAR(20),
    STREET VARCHAR(100),
    CITY VARCHAR(50),
    STATE VARCHAR(50),
    PINCODE VARCHAR(10),
    
    CONSTRAINT PK_ADDRESS PRIMARY KEY (ADDRESS_ID)
);

-- Inserting Records into Tables
INSERT INTO SCHOOL (SCHOOL_ID, SCHOOL_NAME, SCHOOL_ADDRESS, PHONE) VALUES
('SCH001', 'Green Valley School', 'MG Road, Delhi', '9876543210'),
('SCH002', 'Sunrise Public School', 'Sector 62, Noida', '9123456780'),
('SCH003', 'Bright Future Academy', 'Indirapuram, Ghaziabad', '9988776655'),
('SCH004', 'Delhi International School', 'Dwarka, Delhi', '9090909090');

INSERT INTO ADDRESS (ADDRESS_ID, STREET, CITY, STATE, PINCODE) VALUES
('ADD001', 'Street 12, Raj Nagar', 'Ghaziabad', 'Uttar Pradesh', '201002'),
('ADD002', 'Sector 15', 'Noida', 'Uttar Pradesh', '201301'),
('ADD003', 'Karol Bagh', 'Delhi', 'Delhi', '110005'),
('ADD004', 'Laxmi Nagar', 'Delhi', 'Delhi', '110092'),
('ADD005', 'Vaishali Sector 4', 'Ghaziabad', 'Uttar Pradesh', '201010');

-- Creating STAFF table with constraints and relationships
CREATE TABLE STAFF (
    STAFF_ID VARCHAR(20),
    STAFF_TYPE VARCHAR(30),
    SCHOOL_ID VARCHAR(20),
    FIRST_NAME VARCHAR(100) NOT NULL,
    LAST_NAME VARCHAR(100) NOT NULL,
    AGE INT,
    DOB DATE,
    GENDER VARCHAR(10) CHECK (GENDER IN ('M', 'F')),
    JOIN_DATE DATE,
    ADDRESS_ID VARCHAR(20),

    CONSTRAINT PK_STAFF PRIMARY KEY (STAFF_ID),
    CONSTRAINT FK_STAFF_SCHOOL FOREIGN KEY (SCHOOL_ID) -- FK_STAFF_SCHOOL is the name of the foreign key constraint. We need to give a name to the constraint so that we can refer to it later if needed. i.e ALTER TABLE STAFF DROP CONSTRAINT FK_STAFF_SCHOOL;
        REFERENCES SCHOOL(SCHOOL_ID),
    CONSTRAINT FK_STAFF_ADDRESS FOREIGN KEY (ADDRESS_ID)
        REFERENCES ADDRESS(ADDRESS_ID)
);

--DQL Command to select data from tables

SELECT * FROM ADDRESS;
SELECT * FROM SCHOOL;
SELECT * FROM STAFF;

-- Inserting Records into STAFF table

INSERT INTO STAFF 
(STAFF_ID, STAFF_TYPE, SCHOOL_ID, FIRST_NAME, LAST_NAME, AGE, DOB, GENDER, JOIN_DATE, ADDRESS_ID)
VALUES 
('STF001', 'Teaching', 'SCH001', 'Rahul', 'Sharma', 30, '05/09/1994', 'M', '06/05/2015', 'ADD001');

INSERT INTO STAFF VALUES
('STF003', 'Teaching', 'SCH001', 'Amit', 'Kumar', 35, TO_DATE('02/02/1989','DD/MM/YYYY'), 'Male', TO_DATE('01/01/2020','DD/MM/YYYY'), 'ADD001');


INSERT INTO STAFF VALUES
('STF004', 'Teaching', 'SCH999', 'Riya', 'Singh', 29, TO_DATE('10/10/1995','DD/MM/YYYY'), 'F', TO_DATE('01/06/2021','DD/MM/YYYY'), 'ADD001');


-- OTHER DDL Commands

DROP TABLE STAFF;
SELECT * FROM STAFF;

ALTER TABLE STAFF DROP COLUMN JOIN_DATE; -- Drop a column.
ALTER TABLE STAFF ALTER COLUMN AGE TYPE VARCHAR(5); -- Change the data type of a column.
ALTER TABLE STAFF RENAME TO STAFF_NEW; -- Rename the table.
ALTER TABLE STAFF_NEW RENAME COLUMN FIRST_NAME TO FULL_NAME; -- Rename the column.
ALTER TABLE STAFF_NEW ADD CONSTRAINT UNQ_STF UNIQUE (STAFF_TYPE); -- Add a constraint to existing table.
DROP TABLE STAFF_NEW;

-- DML Commands

SELECT * FROM ADDRESS;

INSERT INTO ADDRESS (ADDRESS_ID, STREET, CITY, STATE, COUNTRY)
VALUES ('ADR1011','44940 Bluestem Circle','Baton Rouge','Louisiana','United States');

INSERT INTO ADDRESS
VALUES ('ADR1012','029 Kropf Point','Richmond','Virginia','United States');

INSERT INTO ADDRESS VALUES
('ADR1003','96 Jay Road','Dallas','Texas','United States'),
('ADR1004','15 Harbort Lane','Roanoke','Virginia','United States'),
('ADR1005','3 Vermont Plaza','Atlanta','Georgia','United States'),
('ADR1006','55 Sycamore Trail','Seattle','Washington','United States'); -- Insert multiple records using single INSERT statement.

UPDATE ADDRESS
SET COUNTRY = 'Malaysia'
WHERE ADDRESS_ID = 'ADR1003';

UPDATE ADDRESS
SET COUNTRY = 'India', CITY='Bangalore'
WHERE ADDRESS_ID = 'ADR1005'; -- Update multiple columns at once.

SELECT * FROM ADDRESS;
SELECT * FROM SCHOOL;

DELETE FROM ADDRESS WHERE COUNTRY = 'Malaysia';
DELETE FROM SCHOOL;
DELETE FROM ADDRESS;