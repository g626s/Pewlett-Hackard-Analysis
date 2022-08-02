-- Deliverable 1:
    --The Number of Retiring Employees by Title.
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees as e
JOIN titles as t
ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no

    --View the new table (retirement_titles)
SELECT * FROM retirement_titles

--There are duplicate entries for some employees because they have switched titles over the years.

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
    first_name,
    last_name,
    title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

	--View the new table (unique_titles)
SELECT * FROM unique_titles

--Retrieve the number of employees by their most recent job title who are about to retire.
SELECT COUNT(title) "count", title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

    --View the new table (retiring_titles)
SELECT * FROM retiring_titles

--Deliverable 2:
    --The Employees Eligible for the Mentorship Program
SELECT DISTINCT ON (emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
INTO mentorship_eligibility
FROM employees as e
JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no

    --View the new table (mentorship_eligibility)
SELECT * FROM mentorship_eligibility

--Retrieve the number of employees by their most recent job title who are eligible.
SELECT COUNT(title) "count", title
INTO eligible_mentorship_by_title
FROM mentorship_eligibility
GROUP BY title
ORDER BY count DESC;
	--View the new table (eligible_mentorship_by_title)
SELECT * FROM eligible_mentorship_by_title

-- Summary 1.Number of qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees.
SELECT SUM(retiring_titles.count)
FROM retiring_titles

-- Summary 2.Joining retiring_titles and eligible_mentorship_by_title tables
SELECT retiring_titles.count,
    retiring_titles.title,
    eligible_mentorship_by_title.count,
	eligible_mentorship_by_title.title,
retiring_titles.count - eligible_mentorship_by_title.count AS "Number of Roles that need to be Filled"
FROM retiring_titles
LEFT JOIN eligible_mentorship_by_title
ON retiring_titles.title = eligible_mentorship_by_title.title;