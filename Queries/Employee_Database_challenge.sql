-----------------------------------------------------------

--Deliverable 1: The Number of Retiring Employees by Title

-----------------------------------------------------------
DROP TABLE retirement_titles
-- Retirement Titles table
SELECT emp.emp_no,
	first_name,
	last_name,
	title,
	from_date,
	to_date
INTO retirement_titles
FROM Employees as emp
INNER JOIN titles
ON emp.emp_no=titles.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND to_date='1999-01-01'---those who have not yet retired
ORDER BY emp.emp_no;

DROP TABLE unique_titles
-- Unique Titles table	-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no)
	emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

DROP TABLE retiring_titles
-- Retiring Titles table
SELECT COUNT(emp_no) as Number_of_Titles, 
	title as Titles
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(emp_no) desc;


------------------------------------------------------------------

--Deliverable 2: The Employees Eligible for the Mentorship Program

-------------------------------------------------------------------
DROP TABLE mentorship_eligibilty
--Mentorship Eligibility table
SELECT DISTINCT ON (emp.emp_no)
	emp.emp_no,
	emp.first_name,
	emp.last_name,
	emp.birth_date,
	dept_emp.from_date,
	dept_emp.to_date,
	titles.title
INTO mentorship_eligibilty
FROM employees emp
INNER JOIN dept_emp
ON emp.emp_no=dept_emp.emp_no
INNER JOIN titles
ON emp.emp_no=titles.emp_no
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND dept_emp.to_date='1999-01-01'---actively employed 
ORDER BY emp.emp_no;


------------------------------------------------------------------------------------

--Deliverable 3: A written report on the employee database analysis (README.md)

-------------------------------------------------------------------------------------
SELECT * FROM retirement_titles ;
SELECT * FROM unique_titles ;
SELECT * FROM retiring_titles;
SELECT * FROM mentorship_eligibilty;