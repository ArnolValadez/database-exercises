/*1. Use the join_example_db. Select all the records from both the users and roles tables.*/
USE join_example_db;

SELECT *
FROM roles;

SELECT *
FROM users;

/*2. Use join, left join, and right join to combine results from the users and roles tables as 
we did in the lesson. Before you run each query, guess the expected number of results.*/
SELECT *
FROM users AS U
JOIN roles AS R ON U.role_id = R.id;
-- 4 results, no null values

SELECT *
FROM roles AS R
JOIN users AS U ON R.id = U.role_id;
-- 4 results, no null values

SELECT *
FROM users AS U
LEFT JOIN roles AS R ON U.role_id = R.id;
-- 6 results, 2 null values with users as left most column

SELECT *
FROM roles AS R
LEFT JOIN users AS U ON U.role_id = R.id;
-- 5 results, 1 null value with roles as left most column

SELECT *
FROM users AS U
RIGHT JOIN roles AS R ON U.role_id = R.id;
-- 5 results, 1 null value with users as left most column

SELECT *
FROM roles AS R
RIGHT JOIN users AS U ON U.role_id = R.id;
-- 6 results, 2 null values with roles as left most column

/*3. Although not explicitly covered in the lesson, aggregate functions like count can be used with 
join queries. Use count and the appropriate join type to get a list of roles along with the number 
of users that has the role. Hint: You will also need to use group by in the query.*/
SELECT 
	count(*) AS number_per_role, 
	R.`name` AS role_name
FROM roles AS R
JOIN users AS U ON U.role_id = R.id
GROUP BY role_name;


-- Employees Database --

/*2. Using the example in the Associative Table Joins section as a guide, write a query that shows 
each department along with the name of the current manager for that department.*/
SELECT dept_name AS "Department Name", concat(first_name, " ", last_name) AS "Department Manager"
FROM departments
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON employees.emp_no = dept_manager.emp_no
WHERE dept_manager.to_date > curdate()
ORDER BY dept_name;

/*3. Find the name of all departments currently managed by women.*/
SELECT dept_name AS "Department Name", concat(first_name, " ", last_name) AS "Department Manager"
FROM departments
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON employees.emp_no = dept_manager.emp_no
WHERE dept_manager.to_date > curdate() AND
	gender LIKE 'F'
ORDER BY dept_name;

/*4. Find the current titles of employees currently working in the Customer Service department.*/
SELECT title AS "Title", count(*) AS 'Count'
FROM departments
JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
JOIN titles ON titles.emp_no = dept_emp.emp_no
WHERE titles.to_date > curdate() AND 
	departments.dept_name LIKE "Customer Service" 
	AND dept_emp.to_date > curdate()
GROUP BY title;

/*5. Find the current salary of all current managers.*/
SELECT dept_name AS "Department Name", concat(first_name, " ", last_name) AS "Department Manager", salary AS 'Salary'
FROM departments
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON employees.emp_no = dept_manager.emp_no
JOIN salaries ON salaries.emp_no = employees.emp_no
WHERE dept_manager.to_date > curdate() AND
	salaries.to_date > curdate()
ORDER BY dept_name;

/*6. Find the number of current employees in each department.*/
SELECT departments.dept_no, departments.dept_name, count(*)
FROM departments
JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
JOIN titles ON titles.emp_no = dept_emp.emp_no
WHERE titles.to_date > curdate()  
	AND dept_emp.to_date > curdate()
GROUP BY departments.dept_no;

SELECT 
	d.`dept_no` AS dept_no,
	d.`dept_name` AS department, 
	count(de.emp_no) AS number_of_employees
FROM dept_emp AS de
JOIN departments AS d USING(`dept_no`)
WHERE de.`to_date` LIKE '9999%'
GROUP BY department
ORDER BY d.dept_no;

/*7. Which department has the highest average salary? Hint: Use current not historic information.*/
SELECT d.dept_name, AVG(s.salary) AS average_salary
FROM department AS d
JOIN dept_emp AS de ON d.dept_no = de.dept_no
    AND de.to_date > NOW()
JOIN salaries AS s ON s.emp_no = de.emp_no
    AND s.to_date > NOW()
GROUP BY dept_name
ORDER BY average_salary DESC LIMIT 1;

/*8. Who is the highest paid employee in the Marketing department?*/
SELECT e.first_name, e.last_name
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
    AND de.to_date > NOW()
JOIN salaries AS s ON de.emp_no = s.emp_no
    AND s.to_date > NOW()
JOIN departments AS d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Marketing'
ORDER BY s.salary DESC
LIMIT 1;

/*9. Which current department manager has the highest salary?*/
SELECT e.first_name,
e.last_name,
s.salary,
d.dept_name
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
    AND dm.to_date > NOW()
JOIN salaries AS s ON e.emp_no = s.emp_no
    AND s.to_date > NOW()
JOIN departments AS d ON d.dept_no = dm.dept_no
ORDER BY s.salary DESC
LIMIT 1;

/*10. Bonus Find the names of all current employees, their department name, and their current 
manager's name.*/


/*11. Bonus Who is the highest paid employee within each department.*/


-- RYAN' Note on how to setup a join problem
-- /* Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
--   Department Name    | Department Manager
--  --------------------+--------------------
--   Customer Service   | Yuchang Weedman
--   Development        | Leon DasSarma
--   Finance            | Isamu Legleitner */


--   # How to setup a join problem
--   # Step 1: list out the tables I know I'm going to need to talk to:
--   # Step 1: departments table get the dept_name
--   # Step 1: employees table to get the first_name and last_name (of manageer)
--   # Step 1: What keys do these tables have in common?
--   # Step 1: If no keys directly in common, then look for a j oiner table to find the relationship
--   # Step 1: We've found dept_manager has dept_no and emp_no for managers on it
--   # Step 1: departments, dept_manager, employees
--   # Step 1: A -> B -> C, C -> B -> A
--   # Step 2: start a "select *" from your first table?
-- /*   select *
--   from departments     */
--   # Step 3: Determine the type of join you might need
--   # Step 3: Make your first join, and try it out.
--   # Step 3: Small, tight feedback loops

--   select * 
--   from departments
--   join dept_manager on dept_manager.dept_no = departments.dept_no
--  join employees on employees.emp_no = dept_manager.emp_no;
--  # Step 4, do we need any more tables to join? no
--  # Step 5, do we need a where clause to whittle things down?

--   select * 
-- from departments
-- join dept_manager on dept_manager.dept_no = departments.dept_no
-- join employees on employees.emp_no = dept_manager.emp_no
-- where dept_manager.to_date > curdate();

-- # Step 6, let's whittle down our columns
-- select dept_name, first_name, last_name
-- from departments
-- join dept_manager on dept_manager.dept_no = departments.dept_no
-- join employees on employees.emp_no = dept_manager.emp_no
-- where dept_manager.to_date > curdate();

--   # Step 7: polish up any further output columns
--   select dept_name as "Department Name", 
--    concat(first_name, " ", last_name) as "Current Manager Name"
-- from departments 
-- join dept_manager on dept_manager.dept_no = departments.dept_no
-- join employees on employees.emp_no = dept_manager.emp_no
-- where to_date > curdate()
-- order by "Department Name";


-- # Get the highest current salary from each department
-- # department_name, $salary
-- # Step 1: What tables do we need?
-- # Step 1: departments to get dept_name, salary to get $
-- select dept_name, max(salary) as highest_dept_salary
-- from salaries
-- join dept_emp using(emp_no) -- same join dept_emp on dept_emp.emp_no = salaries.emp_no;
-- join departments using(dept_no)
-- where dept_emp.to_date > curdate()
-- and salaries.to_date > curdate()
-- group by dept_name
-- order by highest_dept_salary DESC;

-- select min(hire_date), first_name, count(*)
-- from employees
-- group by first_name;	


-- # Bonus Who is the highest paid employee within each department.
-- # Do you need the answer in 20 minutes?
-- # Do we need this query to run next year?
-- # Do you need one code query that we could run any time in the next 20 years?
-- # If there are only 9 departments, do we need a super squeeky clean solution?
-- # Quick answer: run 9 queries and stitch the answers together
-- (select dept_no, salary, emp_no, first_name, last_name
-- from salaries
-- join dept_emp using(emp_no)
-- join employees using(emp_no)
-- where dept_no = 'd001'
-- order by salary DESC
-- limit 1)
-- union
-- (select dept_no, salary, emp_no, first_name, last_name
-- from salaries
-- join dept_emp using(emp_no)
-- join employees using(emp_no)
-- where dept_no = 'd002'
-- order by salary DESC
-- limit 1);
  