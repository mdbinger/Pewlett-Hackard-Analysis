-- Retrieve the emp_no, first_name, and last_name columns from the Employees table.
SELECT emp_no, first_name, last_name FROM employees

-- Retrieve the title, from_date, and to_date columns from the Titles table.
SELECT title, from_date, to_date FROM titles

-- Create a new table using the INTO clause.
-- Join both tables on the primary key.
-- Filter the data on the birth_date column to retrieve the employees who were born 
-- between 1952 and 1955. Then, order by the employee number.

SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO employee_titles
-- Challenge instructions said to name this "Retirement Titles" but I didn't see that 
-- before making this table and didn't want to delete it and redo it
FROM employees as e
JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;

-- Copy the query from the Employee_Challenge_starter_code.sql and add it to your 
-- Employee_Database_challenge.sql file.

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM employee_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no ASC, to_date DESC;

-- Write another query in the Employee_Database_challenge.sql file to retrieve 
-- the number of employees by their most recent job title who are about to retire.

SELECT title,
	COUNT (title)
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

-- Deliverable 2 from Challenge starts here

-- Write a query to create a Mentorship Eligibility table that holds the employees 
-- who are eligible to participate in a mentorship program.

SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees as e
LEFT JOIN dept_employees as de
	ON (e.emp_no = de.emp_no) 
LEFT JOIN titles as t
	ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no ASC;

-- Extra code for analysis in Deliverable 3 for Challenge 

SELECT title,
	COUNT(title)
INTO mentor_title_count
FROM mentorship_eligibility
GROUP BY title;

SELECT rt.title,
	rt.count as retire_count,
	mtc.count as mentoree_count,
INTO comparison_table
FROM retiring_titles as rt
LEFT JOIN mentor_title_count as mtc
ON (rt.title = mtc.title);

SELECT title, mentoree_count, retire_count, 
       ROUND(mentoree_count * 100.0 / retire_count, 1) AS Percent
FROM comparison_table;

