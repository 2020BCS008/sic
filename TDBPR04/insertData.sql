SET SERVEROUTPUT ON;
SET VERIFY OFF;

DECLARE
    v_employee_id NUMBER;
    v_employee_name VARCHAR2(100);
    v_salary NUMBER;
    v_age NUMBER;

BEGIN
    v_employee_id := &v_employee_id;
    v_employee_name := '&v_employee_name';
    BEGIN
        v_salary := &v_salary;
    EXCEPTION
        WHEN VALUE_ERROR THEN
            DBMS_OUTPUT.PUT_LINE('Invalid input for salary. Transaction aborted.');
            ROLLBACK;
            RETURN;
    END;
    v_age := &v_age;

    -- Insert the new employee record into the EmployeeInfo table
    INSERT INTO EmployeeInfo (employee_id, employee_name, salary, age)
    VALUES (v_employee_id, v_employee_name, v_salary, v_age);

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Employee data inserted successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/