CREATE DATABASE employee_db;

DROP TABLE IF EXISTS dept_emp CASCADE;
DROP TABLE IF EXISTS dept_manager CASCADE;
DROP TABLE IF EXISTS salaries CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS departments CASCADE;


        
CREATE TABLE departments
(
  dept_no   VARCHAR(10) NOT NULL,
  dept_name VARCHAR(30) NOT NULL,
  PRIMARY KEY (dept_no)
);

CREATE TABLE dept_emp
(
  emp_no  INT         NOT NULL,
  dept_no VARCHAR(10) NOT NULL
);

CREATE TABLE dept_manager
(
  dept_no VARCHAR(10) NOT NULL,
  emp_no  INT         NOT NULL
);

CREATE TABLE employees
(
  emp_no       INT         NOT NULL,
  emp_title_id VARCHAR(10) NOT NULL,
  birth_date   DATE        NOT NULL,
  first_name   VARCHAR(30) NOT NULL,
  last_name    VARCHAR(30) NOT NULL,
  sex          VARCHAR(1)  NULL    ,
  hire_date    DATE        NOT NULL,
  PRIMARY KEY (emp_no)
);

CREATE TABLE salaries
(
  emp_no INT NOT NULL,
  salary INT NOT NULL
);

CREATE TABLE titles
(
  title_id VARCHAR(10) NOT NULL,
  title    VARCHAR(30) NOT NULL,
  PRIMARY KEY (title_id)
);

ALTER TABLE salaries
  ADD CONSTRAINT FK_employees_TO_salaries
    FOREIGN KEY (emp_no)
    REFERENCES employees (emp_no);

ALTER TABLE dept_emp
  ADD CONSTRAINT FK_employees_TO_dept_emp
    FOREIGN KEY (emp_no)
    REFERENCES employees (emp_no);

ALTER TABLE dept_manager
  ADD CONSTRAINT FK_employees_TO_dept_manager
    FOREIGN KEY (emp_no)
    REFERENCES employees (emp_no);

ALTER TABLE dept_manager
  ADD CONSTRAINT FK_departments_TO_dept_manager
    FOREIGN KEY (dept_no)
    REFERENCES departments (dept_no);

ALTER TABLE dept_emp
  ADD CONSTRAINT FK_departments_TO_dept_emp
    FOREIGN KEY (dept_no)
    REFERENCES departments (dept_no);

ALTER TABLE employees
  ADD CONSTRAINT FK_titles_TO_employees
    FOREIGN KEY (emp_title_id)
    REFERENCES titles (title_id);


--IMPORT CSV FILES

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



---DATA ANALYSIS

--List the employee number, last name, first name, sex, and salary of each employee.

SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no;


--List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;


--List the manager of each department along with their department number, department name, employee number, last name, and first name.

SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM dept_manager dm
JOIN departments d ON dm.dept_no = d.dept_no
JOIN employees e ON dm.emp_no = e.emp_no;


--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT de.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN employees e ON de.emp_no = e.emp_no
JOIN departments d ON de.dept_no = d.dept_no;


--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';


--List each employee in the Sales department, including their employee number, last name, and first name.

SELECT e.emp_no, e.last_name, e.first_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';


--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');


--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

SELECT last_name, COUNT(*) as frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;
