SELECT 
		d.dep_name "Department Name"	,
		SUM(e.emp_salary) "Salary Total"
FROM 	departments d ,
		employees e
WHERE 	d.dep_id = e.emp_dep_id
AND 	d.dep_id = &id
GROUP BY d.dep_name
ORDER BY d.dep_name
;