/*2. In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles 
have there ever been? Answer that in a comment in your SQL file.*/
SELECT DISTINCT 
	title
FROM titles;
-- 7 
/*Senior Engineer
Staff
Engineer
Senior Staff
Assistant Engineer
Technique Leader
Manager*/

SELECT count(DISTINCT 
	title)
FROM titles;
-- get count

/*3. Write a query to to find a list of all unique last names of all employees that start and end with 
'E' using GROUP BY.*/
SELECT last_name
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY last_name;
-- 5
/*Eldridge
Erbe
Erde
Erie
Etalle*/

/*4. Write a query to to find all unique combinations of first and last names of all employees whose 
last names start and end with 'E'.*/
SELECT first_name, last_name
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY first_name, last_name;
-- 846

/*5. Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a 
comment in your sql code.*/
SELECT last_name
FROM employees
WHERE last_name LIKE '%Q%' AND last_name NOT LIKE '%QU%'
GROUP BY last_name;
-- 3

/*6. Add a COUNT() to your results (the query above) to find the number of employees with the same 
last name.*/
SELECT last_name, count(*)
FROM employees
WHERE last_name LIKE '%Q%' AND last_name NOT LIKE '%QU%'
GROUP BY last_name
ORDER BY last_name;
-- Chleq	189
-- Lindqvist	190
-- Qiwen	168

SELECT first_name, last_name, count(*)
FROM employees
WHERE last_name LIKE '%Q%' AND last_name NOT LIKE '%QU%'
GROUP BY first_name, last_name
ORDER BY count(*), last_name;

/*7. Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY 
to find the number of employees for each gender with those names.*/
SELECT 
	first_name, gender, count(*)
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender;
-- Irena	M	144
-- Irena	F	97
-- Maya	M	146
-- Maya	F	90
-- Vidya	M	151
-- Vidya	F	81

/*8. Using your query that generates a username for all of the employees, generate a count employees for 
each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?*/
SELECT 
	lower(concat(substring(first_name, 1, 1), 
	substring(last_name, 1, 4), '_', 
	substring(birth_date, 6, 2), 
	substring(YEAR(birth_date), 3, 2)))
AS Username,
count(*)
FROM employees
GROUP BY username;
-- Yes, there are duplicate usernames.

SELECT 
	lower(concat(substring(first_name, 1, 1), 
	substring(last_name, 1, 4), '_', 
	substring(birth_date, 6, 2), 
	substring(YEAR(birth_date), 3, 2)))
AS Username,
count(*) AS number_of_duplicates
FROM employees
GROUP BY username
HAVING number_of_duplicates > 1
ORDER BY number_of_duplicates DESC;
-- Using HAVING as a clause to show duplicates