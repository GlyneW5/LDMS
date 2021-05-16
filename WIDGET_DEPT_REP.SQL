SELECT 
		d.dep_name     "Department"	,
		d.dep_location "Location"	,
		e.emp_name     "Employee name"	,
		e.emp_job_title  "Job Title"	,
		e.emp_date_hired "Date Hired"	,
		e.emp_salary     "Employee Salary"	
FROM 	departments d ,
		employees e
WHERE 	d.dep_id = e.emp_dep_id
AND 	d.dep_id = &id
ORDER BY d.dep_id,e.emp_manager_id
;