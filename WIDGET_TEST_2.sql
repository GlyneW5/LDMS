---### check that salary is now 15 percent larger
DECLARE

    v_sal number;
    v_sal_new number ;
    v_percentage number ;

BEGIN

    SELECT e.emp_salary INTO v_sal FROM employees e WHERE e.emp_id = 90002;
    
    pkg_emp.incr_emp_salary(90002,15);
    
    SELECT e.emp_salary INTO v_sal_new FROM employees e WHERE e.emp_id = 90002;
    dbms_output.put_line('old '||v_sal||' new '||v_sal_new );   
 
    v_percentage := (((v_sal_new / v_sal ) - 1 )* 100);
    
	IF v_percentage = 15 THEN
		dbms_output.put_line('Procedure incr_emp_salary was succeeded');
	ELSE
		dbms_output.put_line('Procedure incr_emp_salary was failed');
	END IF ;
    ROLLBACK;   
END ;
