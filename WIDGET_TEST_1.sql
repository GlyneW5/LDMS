---### test function get_emp_salary
DECLARE 
   v_salary_1 number ;
   v_salary_2 number ;
   
BEGIN

	SELECT e.emp_salary INTO v_salary_1 FROM employees e WHERE e.emp_id = 90002;
	
	SELECT pkg_emp.get_emp_salary (90002) INTO v_salary_2 FROM dual;
	
	IF v_salary_1 = v_salary_2 THEN
		dbms_output.put_line('Function get_emp_salary was succeeded');
	ELSE
		dbms_output.put_line('Function get_emp_salary was failed');
	END IF ;
END ;