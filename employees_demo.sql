CREATE DATABASE choco;
USE choco;

CREATE TABLE employees(
employee_id INT PRIMARY KEY NOT NULL,
name VARCHAR(20) NOT NULL,
role VARCHAR(20) NOT NULL,
salary VARCHAR(20) NOT NULL,
dept VARCHAR(20) NOT NULL
);

SELECT * FROM employees;
DESC employees;
INSERT INTO employees
VALUES(9, 'Prerit', 'Data Scientist', '99000', 'Data');

INSERT INTO employees
VALUES(10, 'aman1', 'Data Scientist', '99000', 'Data'),
(11, 'aman2', 'Data Scientist', '99000', 'Data');

ALTER TABLE employees
MODIFY COLUMN salary INT; -- used to convert the data type  

DELETE FROM employees WHERE employee_id IN (10,11); -- used to delete two rows at the same time using 'in'

SELECT salary FROM employees
WHERE employee_id = 9; 

UPDATE employees
SET salary = 50000
WHERE employee_id = 1;

ALTER TABLE employees
ADD COLUMN company VARCHAR(20) NOT NULL; -- used to adding a new column in the table

UPDATE employees -- used to update existing data in table
SET company = 'American Express'; -- set is used to set the values in the cells

ALTER TABLE employees
ADD COLUMN Gender VARCHAR(20);

UPDATE employees -- used to update existing data in table
SET Gender = 'Not Defined'; -- set is used to set the values in the cells

UPDATE employees -- used to update existing data in table
SET Gender = 'Male' -- set is used to set the values in the cells
WHERE name = 'Prerit'; -- where is used to put the condition where we want to update the data

ALTER TABLE employees
ADD COLUMN `Office Loc` VARCHAR(10);

ALTER TABLE employees
CHANGE `Office Loc` `Office Location` VARCHAR(20); -- used to change the name of the column with new data type(name or size)
 
UPDATE employees
SET `Office Loc` = 'Delhi';

 UPDATE employees -- used to update the existing value with new value
 SET Gender = CASE -- used to fill the entries randomly in gender column using RAND() with case-end method
			      WHEN RAND() < 0.6 THEN 'Male'  
                  ELSE 'Female'
              END;
 
SELECT * FROM employees;

-- second max salary
select name,salary as second_max_salary from employees
order by salary desc
limit 1 offset 1;
