/*2. Write a query to to find all employees whose last name starts and ends with 'E'. 
Use concat() to combine their first and last name together as a single column named full_name.*/
SELECT 
    concat(first_name, ' ', last_name) AS 'full_name' 
    FROM employees
WHERE last_name LIKE 'E%E';

/*3. Convert the names produced in your last query to all uppercase.*/
SELECT 
    upper(concat(first_name, ' ', last_name)) AS 'full_name' 
    FROM employees
WHERE last_name LIKE 'E%E';

/*4. Find all employees hired in the 90s and born on Christmas. Use datediff() function to find 
how many days they have been working at the company (Hint: You will also need to use NOW() or 
CURDATE()),*/
SELECT concat(first_name, ' ', last_name) AS 'Employee',
	datediff(curdate(), hire_date) AS 'Days_Employed'
FROM employees
WHERE birth_date LIKE '%-12-25' 
	AND hire_date LIKE '199%'
ORDER BY Days_Employed DESC;

/*5. Find the smallest and largest current salary from the salaries table.*/
SELECT min(salary) 
FROM salaries;
-- 38623

SELECT min(salary) 
FROM salaries
WHERE to_date like 9999%;
-- better way to find current

SELECT max(salary), min(salary) 
FROM salaries;
-- 158220, for both answers together

/*6. Use your knowledge of built in SQL functions to generate a username for all of the employees. 
A username should be all lowercase, and consist of the first character of the employees first name, 
the first 4 characters of the employees last name, an underscore, the month the employee was born, 
and the last two digits of the year that they were born. Below is an example of what the first 10 
rows will look like:*/
SELECT 
	lower(concat(substring(first_name, 1, 1), 
	substring(last_name, 1, 4), '_', 
	substring(birth_date, 6, 2), 
	substring(YEAR(birth_date), 3, 2)))
AS Username,
first_name, last_name, birth_date
FROM employees;

SELECT 
	lower(concat(substring(first_name, 1, 1), 
	substring(last_name, 1, 4), '_', 
	substring(birth_date, 6, 2), 
	substring(YEAR(birth_date), 3, 2)))
AS Username,
first_name, last_name, birth_date
FROM employees
LIMIT 10;
-- To only get the first 10 rows.

-- Ryan's Example, Has comment's to know what each row is doing.
select lower(concat(
    substr(first_name, 1, 1), # first initial of first name
    substr(last_name, 1, 4), # first 4 of last name
		 "_",
		 substr(hire_date, 6, 2), # month
		 substr(hire_date, 3, 2) # 2 yr
)) as username,first_name, last_name, birth_date
from employees