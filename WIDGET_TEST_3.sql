--### check create_emp
DECLARE

    v_exists varchar2(1) := 'N';
    EMP_EXISTS EXCEPTION;
    PRAGMA EXCEPTION_init(EMP_EXISTS, -20005);
BEGIN

    BEGIN
        SELECT 'Y' INTO v_exists FROM employees e WHERE e.emp_name = 'Glenn Ford';
    EXCEPTION 
        when no_data_found then v_exists := 'N';
    END ;
	
	dbms_output.put_line('Employee already exist '||v_exists); 
	
	IF v_exists = 'N' THEN
        pkg_emp.create_emp('Glenn Ford','Actor',90001,'19-MAY-2019',15000,1);
    ELSE
         RAISE_APPLICATION_ERROR(-20005,'EMPLOYEE ALREADY EXISTS');
    END IF ;
	
    BEGIN
        SELECT 'Y' INTO v_exists FROM employees e WHERE e.emp_name = 'Glenn Ford';
    EXCEPTION 
        when no_data_found then v_exists := 'N';
    END ;
	
	dbms_output.put_line('Does Employee Glenn Ford now exist '||v_exists); 
    
	ROLLBACK ;
	
-- rollback so test can be run again	
END ;

