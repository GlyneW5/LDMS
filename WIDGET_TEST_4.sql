--### check transfer_to_dept 
DECLARE

    v_old_dept  number := 0;
    v_new_dept  number := 0;
    v_emp_id    number ;

BEGIN
    BEGIN
        SELECT e.emp_id,e.emp_dep_id INTO v_emp_id,v_old_dept FROM employees e WHERE e.emp_name = 'Tina Hart';
    EXCEPTION 
        WHEN no_data_found THEN v_old_dept := 0;
    END ;
	
	dbms_output.put_line('Old Department id '||v_old_dept); 
	
    pkg_emp.transfer_to_dept(v_emp_id,4);
    
    BEGIN
        SELECT e.emp_dep_id INTO v_new_dept FROM employees e WHERE e.emp_name = 'Tina Hart';
    EXCEPTION 
        WHEN no_data_found THEN v_new_dept := 0;
    END ;
    
	dbms_output.put_line('v_old_dept '||v_old_dept); 
	dbms_output.put_line('v_new_dept '||v_new_dept); 

	IF v_old_dept != v_new_dept AND v_new_dept = 4 THEN
		dbms_output.put_line('Procedure transfer_to_dept was succeeded');
	ELSE
		dbms_output.put_line('Procedure transfer_to_dept was failed');
	END IF ;
    
    ROLLBACK;
END ;
---### check that v_exists was iniitally 0 now is 1 
