-- DELIVERABLE 1

DROP TABLE IF EXISTS employees_close_to_retirement_by_title;

SELECT e.emp_no,
e.first_name,
e.last_name,
t.title,
t.from_date,
t.to_date
INTO employees_close_to_retirement_by_title
FROM employees as e
INNER JOIN titles as t
	ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

SELECT * FROM employees_close_to_retirement_by_title;

-- Use Dictinct with Orderby to remove duplicate rows
DROP TABLE IF EXISTS employees_close_to_retirement_by_title_duplicates_removed;

SELECT DISTINCT ON (ectrbt.emp_no) ectrbt.emp_no,
ectrbt.first_name,
ectrbt.last_name,
ectrbt.title
INTO employees_close_to_retirement_by_title_duplicates_removed
FROM employees_close_to_retirement_by_title as ectrbt
WHERE ectrbt.to_date = '9999-01-01'
ORDER BY ectrbt.emp_no, ectrbt.to_date DESC;

SELECT * FROM employees_close_to_retirement_by_title_duplicates_removed;

-- Which employees are about to
-- retire based off their job titles?

SELECT COUNT(ectrbtdr.emp_no) as emp_count,
ectrbtdr.title
FROM employees_close_to_retirement_by_title_duplicates_removed as ectrbtdr
GROUP BY ectrbtdr.title
ORDER BY emp_count DESC;

-- DELIVERABLE 2
DROP TABLE IF EXISTS mentorship_eligibility;

SELECT DISTINCT ON (e.emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
t.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
	ON e.emp_no = de.emp_no
INNER JOIN titles as t
	ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01');

SELECT * FROM mentorship_eligibility;


-- DELIVERABLE 3 QUERIES

SELECT DISTINCT ON (e.emp_no) e.emp_no,
e.first_name,
e.last_name,
t.title,
t.from_date,
t.to_date
FROM employees as e
INNER JOIN titles as t
	ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND NOT (to_date = '9999-01-01')
ORDER BY e.emp_no;

