-- *** Deliverable 1: The Number of Retiring Employees by Title ***
-- Steps 1-7
SELECT ee.emp_no,
	ee.first_name,
	ee.last_name,
	tl.title,
	tl.from_date,
	tl.to_date
INTO retirement_titles
FROM employees as ee
LEFT JOIN titles as tl
ON ee.emp_no = tl.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY ee.emp_no;

-- Steps 8-14 Use Distinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no, rt.to_date DESC;

-- *** Steps 15-20 retrieve the number of employees by their most recent title who are about to retire ***
SELECT count(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY count DESC;

-- Deliverable 2: The Employees Eligible for the Mentorship Program
-- Steps 1-11 create a mentorship eligiblity table
SELECT DISTINCT ON (ee.emp_no) ee.emp_no,
	ee.first_name,
	ee.last_name,
	ee.birth_date,
	de.from_date,
	de.to_date,
	tl.title
INTO mentorship_eligibility
FROM employees as ee
LEFT JOIN dept_emp as de
ON ee.emp_no = de.emp_no
LEFT JOIN titles as tl
ON ee.emp_no = tl.emp_no
WHERE (ee.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
		AND (de.to_date = '9999-01-01')
ORDER BY ee.emp_no;

--Additional Queries
-- Mentorship eligiblity by title
SELECT count(me.emp_no), me.title
INTO mentorship_titles
FROM mentorship_eligibility as me
GROUP BY me.title
ORDER BY count DESC;

--Unique titles with gender
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title,
	ee.gender
INTO retiring_gender
FROM retirement_titles as rt
LEFT JOIN employees as ee
ON rt.emp_no = ee.emp_no
ORDER BY rt.emp_no, rt.to_date DESC;

SELECT count(ee.emp_no), ee.gender
INTO gender_count
FROM employees as ee
GROUP BY ee.gender
ORDER BY count;

SELECT gc.gender, gc.count as "Totals by Gender", rt.count as "Retiring by Gender"
INTO gender_summary
FROM gender_count as gc
LEFT JOIN ret_count as rt
ON gc.gender = rt.gender

SELECT rt.title as "Title", rt.count as "Retiring Count", mt.count as "Mentorship Count"
INTO titles_summary
FROM retiring_titles as rt
LEFT JOIN mentorship_titles as mt
ON rt.title = mt.title







