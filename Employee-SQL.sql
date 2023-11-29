CREATE DATABASE employee_db;



COPY departments
FROM '/Users/alisonlove/Bootcamp/09-SQL-Challenge/Starter_Code/data/departments.csv'
DELIMITER ','
CSV HEADER;

COPY dept_emp
FROM '/Users/alisonlove/Bootcamp/09-SQL-Challenge/Starter_Code/data/dept_emp.csv'
DELIMITER ','
CSV HEADER;

COPY dept_manager
FROM '/Users/alisonlove/Bootcamp/09-SQL-Challenge/Starter_Code/data/dept_manager.csv'
DELIMITER ','
CSV HEADER;

COPY employees
FROM '/Users/alisonlove/Bootcamp/09-SQL-Challenge/Starter_Code/data/employees.csv'
DELIMITER ','
CSV HEADER;

COPY salaries
FROM '/Users/alisonlove/Bootcamp/09-SQL-Challenge/Starter_Code/data/salaries.csv'
DELIMITER ','
CSV HEADER;

COPY titles
FROM '/Users/alisonlove/Bootcamp/09-SQL-Challenge/Starter_Code/data/titles.csv'
DELIMITER ','
CSV HEADER;
