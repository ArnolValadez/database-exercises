/*1. Write a query that returns all employees (emp_no), their department number, their start date, 
their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with 
the company and 0 if not.*/
SELECT 
	emp_no, 
	dept_no, 
	from_date, 
	to_date, IF(to_date > curdate(), TRUE, False) AS is_current_employee
FROM dept_emp;

/*2. Write a query that returns all employee names (previous and current), and a new column 
'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.*/
SELECT first_name, last_name,
	CASE
		WHEN last_name BETWEEN 'a%' AND 'hz%' THEN 'A-H'
		WHEN last_name BETWEEN 'i%' AND 'qz%' THEN 'I-Q'
		WHEN last_name BETWEEN 'r%' AND 'zz%' THEN 'R-Z'
		ELSE 'other'
	END AS alpha_group,
	count(*)
FROM employees
GROUP BY alpha_group, last_name, first_name;

/*3. How many employees (current or previous) were born in each decade?*/
SELECT birth_date, first_name, last_name
FROM employees
ORDER BY birth_date DESC;

SELECT
	CASE
		WHEN birth_date LIKE '195%' THEN '50s baby'
		WHEN birth_date LIKE '196%' THEN '60s baby'
		ELSE 'other'
		END AS decade_baby,
		count(*)
FROM employees
GROUP BY decade_baby;

-- BONUS

/*1. What is the current average salary for each of the following department groups: R&D, 
Sales & Marketing, Prod & QM, Finance & HR, Customer Service?*/

