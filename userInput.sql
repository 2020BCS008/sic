SET SERVEROUTPUT ON;

-- Declare variables to store input data
DECLARE
    v_emp_id NUMBER;
    v_first_name VARCHAR2(50);
    v_last_name VARCHAR2(50);
    v_email VARCHAR2(50);
    v_gender VARCHAR2(50);
    v_job_title VARCHAR2(50);
    v_continue CHAR(1);
BEGIN
    -- Start a loop for continuous user input
    LOOP
        -- Prompt for input using SQL*Plus substitution variables
        v_emp_id := &v_emp_id;        -- Prompt for employee ID (NUMBER)
        v_first_name := '&v_first_name';  -- Prompt for first name (VARCHAR2)
        v_last_name := '&v_last_name';    -- Prompt for last name (VARCHAR2)
        v_email := '&v_email';          -- Prompt for email (VARCHAR2)
        v_gender := '&v_gender';        -- Prompt for gender (VARCHAR2)
        v_job_title := '&v_job_title';  -- Prompt for job title (VARCHAR2)

        -- Perform validation based on expected data types
        -- Ensure employee ID is numeric and valid
        IF NOT REGEXP_LIKE(v_emp_id, '^\d+$') THEN
            DBMS_OUTPUT.PUT_LINE('Invalid employee ID. It must be a numeric value.');
            RAISE_APPLICATION_ERROR(-20001, 'Invalid employee ID');
        END IF;

        -- Insert the data into the MOCK_DATA table
        INSERT INTO MOCK_DATA (employeeID, first_name, last_name, email, gender, JobTitle)
        VALUES (v_emp_id, v_first_name, v_last_name, v_email, v_gender, v_job_title);

        -- Commit the transaction
        COMMIT;

        -- Output success message
        DBMS_OUTPUT.PUT_LINE('Data inserted successfully.');

        -- Fetch and display the inserted data
        FOR rec IN (SELECT employeeID, first_name, last_name, email, gender, JobTitle 
                    FROM MOCK_DATA 
                    WHERE employeeID = v_emp_id) LOOP
            DBMS_OUTPUT.PUT_LINE('Inserted Employee ID: ' || rec.employeeID);
            DBMS_OUTPUT.PUT_LINE('First Name: ' || rec.first_name);
            DBMS_OUTPUT.PUT_LINE('Last Name: ' || rec.last_name);
            DBMS_OUTPUT.PUT_LINE('Email: ' || rec.email);
            DBMS_OUTPUT.PUT_LINE('Gender: ' || rec.gender);
            DBMS_OUTPUT.PUT_LINE('Job Title: ' || rec.JobTitle);
        END LOOP;

        -- Ask the user if they want to continue
        v_continue := '&v_continue';
        
        -- If the user enters 'N' or 'n', exit the loop
        IF LOWER(v_continue) = 'n' THEN
            EXIT;
        END IF;
    END LOOP;

    -- Output the completion message when the user exits the loop
    DBMS_OUTPUT.PUT_LINE('User has chosen to stop entering data. Exiting...');
END;
/


-- //sqlplus sys as sysdba
