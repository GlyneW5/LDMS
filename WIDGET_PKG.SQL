CREATE OR REPLACE PACKAGE pkg_emp AS

    PROCEDURE create_emp (p_emp_name			VARCHAR2,
                            p_emp_job_title		VARCHAR2,
                            p_emp_manager_id	NUMBER,	
                            p_emp_date_hired	DATE,		
                            p_emp_salary		NUMBER,	
                            p_emp_dep_id		NUMBER);
							
    PROCEDURE incr_emp_salary (p_emp_id			NUMBER,
                               p_percentage		NUMBER);
							  
    PROCEDURE transfer_to_dept (p_emp_id		NUMBER,
                                p_dep_id		NUMBER);
								
	FUNCTION get_emp_salary (p_emp_id		NUMBER) RETURN NUMBER ;
							  
END pkg_emp;							
/							
CREATE OR REPLACE PACKAGE BODY pkg_emp AS

    PROCEDURE create_emp (p_emp_name			VARCHAR2,
                            p_emp_job_title		VARCHAR2,
                            p_emp_manager_id	NUMBER,	
                            p_emp_date_hired	DATE,		
                            p_emp_salary		NUMBER,	
                            p_emp_dep_id		NUMBER) IS
							
	manager_does_not_exist EXCEPTION;
	PRAGMA exception_init(manager_does_not_exist, -20001);
	 
	v_manager_exists 	VARCHAR2(1) := 'N';
	
    BEGIN
		IF p_emp_manager_id IS NOT NULL THEN
			BEGIN
				SELECT 'Y' 
				INTO v_manager_exists
				FROM employees e
				WHERE e.emp_id = p_emp_manager_id;
            EXCEPTION
                WHEN NO_DATA_FOUND 
                    THEN v_manager_exists := 'N'; RAISE_APPLICATION_ERROR(-20001,'Manager does not exist');
			END ;
		END IF ;
        INSERT INTO EMPLOYEES (
                            EMP_ID			,
                            EMP_NAME		,
                            EMP_JOB_TITLE	,
                            EMP_MANAGER_ID	,
                            EMP_DATE_HIRED	,
                            EMP_SALARY		,
                            EMP_DEP_ID		
                            )
					VALUES
							(
                            emp_id_seq.nextval,
                            p_emp_name,		
							p_emp_job_title,	
							p_emp_manager_id,
							p_emp_date_hired,
							p_emp_salary,	
							p_emp_dep_id	
							);
	EXCEPTION
		WHEN manager_does_not_exist THEN
			dbms_output.put_line(sqlerrm);
		WHEN OTHERS THEN  
			dbms_output.put_line('Error while inserting employee '||sqlerrm);
    END create_emp ;
---------------------	
    PROCEDURE incr_emp_salary (p_emp_id			NUMBER,
                              p_percentage		NUMBER) IS
		v_new_salary 		NUMBER := 0 ;
		v_current_salary	NUMBER := 0 ;
	BEGIN
		BEGIN
			SELECT emp_salary 
			INTO   v_current_salary
			FROM   employees e
			WHERE  emp_id = p_emp_id;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN v_current_salary := 0 ;
		END ;
		
		IF v_current_salary > 0 THEN
		
			IF p_percentage > 0 THEN
				v_new_salary := v_current_salary+(v_current_salary*(p_percentage/100));
			END IF ;
			
			IF p_percentage < 0 THEN
				v_new_salary := v_current_salary-(v_current_salary*(p_percentage/100));
			END IF ;
			
		END IF ;
		
		IF v_new_salary > 0 THEN
			UPDATE employees E SET e.emp_salary = v_new_salary WHERE emp_id = p_emp_id;
		END IF ;
	END incr_emp_salary ;
---------------------	
    PROCEDURE transfer_to_dept (p_emp_id		NUMBER,
                                p_dep_id		NUMBER) IS
								
		dept_does_not_exist EXCEPTION;
		PRAGMA exception_init(dept_does_not_exist, -20002);
		
		v_department_exists VARCHAR2(1) := 'N' ;
	BEGIN
		BEGIN
			SELECT 'Y' 
			INTO   v_department_exists
			FROM   departments d
			WHERE  d.dep_id = p_dep_id;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN v_department_exists := 'N' ; RAISE_APPLICATION_ERROR(-20002,'Department does not exist');
		END ;
		
		IF v_department_exists = 'Y' THEN
			UPDATE employees SET emp_dep_id = p_dep_id WHERE emp_id = p_emp_id;
		END IF ;
	EXCEPTION	
        WHEN dept_does_not_exist THEN
            dbms_output.put_line(sqlerrm);
	END transfer_to_dept ;
---------------------		
	FUNCTION get_emp_salary (p_emp_id		NUMBER)  RETURN NUMBER IS
		v_current_salary	NUMBER := 0 ;
	BEGIN
		BEGIN
			SELECT emp_salary 
			INTO   v_current_salary
			FROM   employees e
			WHERE  emp_id = p_emp_id;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN v_current_salary := 0 ;
		END ;
		RETURN v_current_salary;
	END ;

END pkg_emp;