-- Join employees and titles table
SELECT
ee.emp_no,
ee.first_name,
ee.last_name,
tt.title,
tt.from_date,
tt.to_date
INTO retire_table
FROM employees as ee
LEFT JOIN titles as tt
ON (ee.emp_no = tt.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC, to_date DESC;  -- This additional sort criteria by to_date was not in the instructions but it didnt make sense to sort there on the unique table as that did not have that field

--View fields from retire table as test and sort by emp_no ascending
SELECT 
emp_no,
first_name,
last_name,
title
FROM retire_table
ORDER BY emp_no ASC;


--Get unique count and create new table; active employees only
SELECT DISTINCT ON (emp_no)
emp_no,
first_name,
last_name,
title
INTO unique_table
FROM retire_table as rt
WHERE rt.to_date = ('9999-01-01')
ORDER BY emp_no ASC; -- Did not include the additional sort criteria based on to_date since that field isnt present in this table and the value is already unique, added instead to the first table


-- Create new table grouped and counted by title
SELECT COUNT (emp_no), title
INTO retiring_table
FROM unique_table
GROUP BY title
ORDER BY count DESC;

--Create a mentorship eligibility table based on birth dates and active employees
SELECT DISTINCT ON (emp_no)
ee.emp_no,
ee.first_name,
ee.last_name,
ee.birth_date,
de.from_date,
de.to_date,
tt.title
INTO mentor_table
FROM employees as ee
LEFT JOIN dept_emp as de
ON (ee.emp_no = de.emp_no)
LEFT JOIN titles as tt
ON (ee.emp_no = tt.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01');

-- View number of potential mentors by position
SELECT COUNT (emp_no), title
FROM mentor_table
GROUP BY title
ORDER BY count DESC;





