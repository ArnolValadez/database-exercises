# 3. Use the employees database
USE employees;

# 4. List all the tables in the database
SHOW TABLES;

# 5. Explore the employees table. What different data types are present on this table?
DESCRIBE employees;
-- INT, DATE, VARCHAR(14) & (16), ENUM('M','F') 

# 6. Which table(s) do you think contain a numeric type column?
/* AT FIRST glance I would think `salaries` but upon further research, the TABLES `current_dept_emp`,
  `dept_emp`, `dept_emp_latest_date`, `dept_manager`, `employees`, `salaries`, AND `titles` have a 
  NUMERIC TYPE column. */

# 7. Which table(s) do you think contain a string type column?
/* I would think ALL except FOR `salaries` TABLES would have a STRING TYPE column. Actually `salaries`
   AND `dept_emp_latest_date` are the two TABLES that dont contain a STRING TYPE column. ALL other
   TABLES did have a STRING TYPE column. */

# 8. Which table(s) do you think contain a date type column?
/* I would think ALL would have a DATE TYPE column. ALL TABLES except FOR `departments` had a DATE
   TYPE column. */

# 9. What is the relationship between the employees and the departments tables?
/* The only relationship I saw was that they BOTH had a emp_no AND dept_no COLUMN respectively.
   I used SHOW CREATE TABLE employees; AND SHOW CREATE TABLE departments; AND 
   SHOW CREATE TABLE dept_emp; AND DESCRIBE dept_emp; TO discover this relationship. */

# 10. Show the SQL that created the dept_manager table.
    -SHOW CREATE TABLE dept_manager;
    -CREATE TABLE `dept_manager` (
    `emp_no` INT(11) NOT NULL,
    `dept_no` CHAR(4) NOT NULL,
    `from_date` DATE NOT NULL,
    `to_date` DATE NOT NULL,
    PRIMARY KEY (`emp_no`,`dept_no`),
    KEY `dept_no` (`dept_no`),
    CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE,
    CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE
)   ENGINE=INNODB DEFAULT CHARSET=latin1