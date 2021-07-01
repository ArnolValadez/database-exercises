/*1. Find all the current employees with the same hire date as employee 101010 using a sub-query.*/
select *
from employees
where hire_date in (
	select hire_date
	from employees
	where emp_no = 101010
)
and emp_no in (
	select emp_no
	from dept_emp
	where to_date > curdate()
);
-- 55

/*2. Find all the titles ever held by all current employees with the first name Aamod.*/
SELECT 
	title
FROM titles
WHERE emp_no IN (
	SELECT emp_no
	FROM employees
	WHERE first_name = 'Aamod')
GROUP BY title;
-- Assistant Engineer
-- Engineer
-- Senior Engineer
-- Senior Staff
-- Staff
-- Technique Leader

SELECT 
	title,
	COUNT(title) AS number_of_employees
FROM titles
WHERE emp_no IN (
	SELECT emp_no
	FROM employees
	WHERE first_name = 'Aamod')
GROUP BY title
ORDER BY number_of_employees DESC;
-- Faith's query

SELECT title
FROM titles
WHERE emp_no IN
	(
		SELECT `emp_no`
		FROM `employees`
		WHERE first_name LIKE 'aamod' AND to_date > curdate());
-- Wrong...

SELECT
      t.title AS 'Titles Held by Aamods',
      COUNT(t.title) AS 'Total Aamods Who Held Title'
FROM titles AS t
WHERE
      t.emp_no IN
      (
            SELECT
                  e.emp_no
            FROM employees AS e
            JOIN salaries AS s
                  ON e.emp_no = s.emp_no
                        AND s.to_date > CURDATE()
            WHERE
                first_name LIKE 'Aamod'
      )
GROUP BY
      t.title
;
-- Differnt method, correct answer 251



/*3. How many people in the employees table are no longer working for the company? Give the answer 
in a comment in your code.*/
SELECT 
	COUNT(*) AS number_of_non_employees
FROM employees
WHERE emp_no NOT IN (
	SELECT emp_no
	FROM dept_emp
	WHERE to_date > curdate());
-- 59900

SELECT
	COUNT(*)
FROM employees
WHERE emp_no NOT IN (
					SELECT emp_no
					FROM salaries
					WHERE to_date = '9999-01-01'
					);
-- same answer, different to_date

/*4. Find all the current department managers that are female. List their names in a comment in your 
code.*/
SELECT first_name, last_name
FROM employees
WHERE emp_no IN(
	SELECT emp_no
	FROM dept_manager
	WHERE to_date > NOW()
	)
AND gender LIKE 'f';
-- Isamu	Legleitner
-- Karsten	Sigstam
-- Leon	DasSarma
-- Hilary	Kambil

/*5. Find all the employees who currently have a higher salary than the companies overall, historical 
average salary.*/
SELECT 
	e.emp_no,
	first_name,
	last_name,
	salary
FROM employees AS e
JOIN salaries AS s ON e.emp_no = s.emp_no
	AND to_date > curdate()
WHERE salary > (
	SELECT AVG(salary)
	FROM salaries);
-- 154,543

SELECT emp_no, salary
FROM salaries
WHERE to_date > now()
	AND salary > 
	(
		SELECT AVG(salary)
		FROM salaries
	)
ORDER BY salary;
-- other format

SELECT *
FROM salaries
WHERE salary > (SELECT AVG(salary) FROM salaries)
AND to_date > curdate();
-- other format

/*6. How many current salaries are within 1 standard deviation of the current highest salary? 
(Hint: you can use a built in function to calculate the standard deviation.) What percentage of 
all salaries is this?*/
SELECT
	COUNT(salary)
FROM salaries
WHERE to_date > CURDATE()
	AND salary >= (
		SELECT
		MAX(salary) - STDDEV(salary)
		FROM salaries
		WHERE to_date > CURDATE());
-- 83

SELECT
(SELECT
	COUNT(salary)
FROM salaries
WHERE to_date > CURDATE()
	AND salary >= (
		SELECT
		MAX(salary) - STDDEV(salary)
		FROM salaries
		WHERE to_date > CURDATE()))
/
(SELECT
	COUNT(salary)
FROM salaries
WHERE to_date > CURDATE()) * 100 AS percent_of_salaries;
-- 0.0346% or .03%

-- Bonus --

/*1. Find all the department names that currently have female managers.*/


/*2. Find the first and last name of the employee with the highest salary.*/


/*3. Find the department name that the employee with the highest salary works in.*/

