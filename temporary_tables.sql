
/*1. Using the example from the lesson, re-create the employees_with_departments table.*/
CREATE TEMPORARY TABLE employees_with_departments
SELECT employees.employees.emp_no, 
employees.employees.first_name, 
employees.employees.last_name, 
employees.departments.dept_no, 
employees.departments.dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100;

    /*a. Add a column named full_name to this table. It should be a VARCHAR whose length is the 
    sum of the lengths of the first name and last name columns*/
    ALTER TABLE employees_with_departments ADD full_name VARCHAR(31);

    /*b. Update the table so that full name column contains the correct data*/
    UPDATE employees_with_departments
    SET full_name = concat(first_name, " ", last_name);

    /*c. Remove the first_name and last_name columns from the table.*/
    ALTER TABLE employees_with_departments DROP COLUMN first_name, DROP COLUMN last_name;

    /*d. What is another way you could have ended up with this same table?*/
    CREATE TEMPORARY TABLE employees_with_departments
    SELECT employees.employees.emp_no, 
    concat(employees.employees.first_name, " ", employees.employees.last_name) AS full_name, 
    employees.departments.dept_no, 
    employees.departments.dept_name
    FROM employees.employees
    JOIN employees.dept_emp USING(emp_no)
    JOIN employees.departments USING(dept_no)
    LIMIT 100;

/*2. Create a temporary table based on the payment table from the sakila database.*/
CREATE TEMPORARY TABLE Payment
SELECT *
FROM sakila.payment;

    /*Write the SQL necessary to transform the amount column such that it is stored as an integer 
    representing the number of cents of the payment. For example, 1.99 should become 199.*/
    CREATE TEMPORARY TABLE Payment
    SELECT *, amount * 100 AS amount_in_pennies
    FROM sakila.payment;

    SELECT *
    FROM Payment;

    ALTER TABLE Payment MODIFY COLUMN amount_in_pennies INT;

    ALTER TABLE Payment MODIFY COLUMN amount_in_pennies INT NOT null;

/*3. Find out how the current average pay in each department compares to the overall, historical 
average pay. In order to make the comparison easier, you should use the Z-score for salaries. 
In terms of salary, what is the best department right now to work for? The worst?*/

CREATE TEMPORARY TABLE current_avg_sal_by_dept AS
(
      SELECT
            d.dept_no AS dept_no,
            AVG(s.salary) AS avg_sal
      FROM employees.salaries AS s
      JOIN employees.dept_emp AS de
            ON s.emp_no = de.emp_no
                  AND de.to_date > CURDATE()
      JOIN employees.departments AS d
            ON d.dept_no = de.dept_no
      WHERE
            s.to_date > CURDATE()
      GROUP BY
            d.dept_no
);

SELECT
      d.dept_name,
      (ca.avg_sal - AVG(s.salary)) / STDDEV(s.salary) AS z_score
FROM employees.departments AS d
JOIN employees.dept_emp AS de
      ON d.dept_no = de.dept_no
JOIN employees.salaries AS s
      ON de.emp_no = s.emp_no
JOIN current_avg_sal_by_dept AS ca
      ON de.dept_no = ca.dept_no
GROUP BY
      d.dept_name,
      ca.avg_sal
ORDER BY
      z_score DESC
;
