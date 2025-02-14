SET SERVEROUTPUT ON;
SET VERIFY OFF;
SET ECHO OFF;
SET FEEDBACK OFF;

DECLARE
    -- Declare variables for dynamic user input
    v_employee_id NUMBER;
    v_employee_name VARCHAR2(100);
    v_salary NUMBER;
    v_age NUMBER;
    v_transaction_id NUMBER := FLOOR(DBMS_UTILITY.GET_TIME / 100); -- Generate a sequential transaction ID based on time
    v_action VARCHAR2(3); -- For "Add" or "Update"
    v_update_salary VARCHAR2(100); -- Using VARCHAR2 to simulate a crash if non-numeric input
BEGIN
    DBMS_OUTPUT.PUT_LINE('Do you want to add new employee info? (yes/no):');
    v_action := '&v_action'; 

    IF v_action = 'yes' THEN
        v_employee_id := &v_employee_id;
        v_employee_name := '&v_employee_name';
        BEGIN
            v_salary := &v_salary;
        EXCEPTION
            WHEN VALUE_ERROR THEN
                DBMS_OUTPUT.PUT_LINE('Invalid input for salary. Rolling back transaction.');
                ROLLBACK;
                RETURN;
        END;
        v_age := &v_age;

        -- Log the transaction in the transaction_logs table
        INSERT INTO transaction_logs (transaction_id, operation, before_state, after_state, status)
        VALUES (v_transaction_id, 'INSERT', NULL, 'Employee ' || v_employee_name, 'In Progress');

        -- Insert employee data into EmployeeInfo table
        INSERT INTO EmployeeInfo (employee_id, employee_name, salary, age)
        VALUES (v_employee_id, v_employee_name, v_salary, v_age);

        -- Mark the transaction as committed
        UPDATE transaction_logs
        SET status = 'Committed'
        WHERE transaction_id = v_transaction_id;

        COMMIT;

        DBMS_OUTPUT.PUT_LINE('Transaction successfully committed.');

    ELSIF v_action = 'no' THEN
        DBMS_OUTPUT.PUT_LINE('No new employee info will be added.');
    END IF;

    -- Ask if the user wants to update employee salary
    DBMS_OUTPUT.PUT_LINE('Do you want to update employee salary? (yes/no):');
    v_action := '&v_action'; -- User provides input (yes/no)

    IF v_action = 'yes' THEN
        v_employee_id := &v_employee_id; -- User provides employee ID
        v_update_salary := '&v_update_salary'; -- User provides input as VARCHAR

        -- Simulate crash if the user enters non-numeric input
        BEGIN
            -- Check if salary is numeric, else simulate crash
            IF REGEXP_LIKE(v_update_salary, '^[0-9]+(\.[0-9]+)?$') = FALSE THEN
                DBMS_OUTPUT.PUT_LINE('Invalid salary input! Simulating crash!');
                RAISE_APPLICATION_ERROR(-20002, 'System crash due to invalid salary input!');
            ELSE
                v_salary := TO_NUMBER(v_update_salary);
            END IF;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Exception caught: ' || SQLERRM);
                -- If the crash is detected, begin the recovery process
                ROLLBACK;
                -- Now trigger the recovery process
                DBMS_OUTPUT.PUT_LINE('Initiating Recovery...');

                -- * Recovery Phase: Analysis *
                DBMS_OUTPUT.PUT_LINE('* Recovery Analysis Phase *');
                FOR log_rec IN (
                    SELECT transaction_id, status
                    FROM transaction_logs
                    WHERE status IN ('In Progress', 'Committed')
                ) LOOP
                    DBMS_OUTPUT.PUT_LINE('Analyzing transaction: ' || log_rec.transaction_id);
                END LOOP;

                -- * Redo Phase *
                DBMS_OUTPUT.PUT_LINE('* Redo Phase *');
                FOR log_rec IN (
                    SELECT *
                    FROM transaction_logs
                    WHERE status = 'Committed'
                    ORDER BY log_time
                ) LOOP
                    IF log_rec.operation = 'INSERT' THEN
                        BEGIN
                            INSERT INTO EmployeeInfo (employee_id, employee_name, salary, age)
                            VALUES (log_rec.transaction_id, 'RecoveredEmployee', 0, 0);
                        EXCEPTION
                            WHEN DUP_VAL_ON_INDEX THEN
                                DBMS_OUTPUT.PUT_LINE('Duplicate entry detected for recovery. Skipping...');
                        END;
                    END IF;
                END LOOP;

                -- * Undo Phase *
                DBMS_OUTPUT.PUT_LINE('* Undo Phase *');
                FOR log_rec IN (
                    SELECT *
                    FROM transaction_logs
                    WHERE status = 'In Progress'
                    ORDER BY log_time DESC
                ) LOOP
                    IF log_rec.operation = 'INSERT' THEN
                        DELETE FROM EmployeeInfo WHERE employee_id = log_rec.transaction_id;
                    END IF;
                    UPDATE transaction_logs
                    SET status = 'Aborted'
                    WHERE log_id = log_rec.log_id;
                END LOOP;

                -- Rollback the transaction to clean up
                ROLLBACK;
                DBMS_OUTPUT.PUT_LINE('Recovery completed.');
                RETURN;
        END;

        -- Log the transaction for updating salary in the transaction_logs table
        INSERT INTO transaction_logs (transaction_id, operation, before_state, after_state, status)
        VALUES (v_transaction_id, 'UPDATE', 'Salary update', 'Salary ' || v_salary, 'In Progress');

        -- Update the salary in EmployeeInfo table
        UPDATE EmployeeInfo
        SET salary = v_salary
        WHERE employee_id = v_employee_id;

        -- Mark the transaction as committed
        UPDATE transaction_logs
        SET status = 'Committed'
        WHERE transaction_id = v_transaction_id;

        COMMIT;

        DBMS_OUTPUT.PUT_LINE('Salary updated and transaction committed.');

    ELSIF v_action = 'no' THEN
        DBMS_OUTPUT.PUT_LINE('No salary update will be made.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected Error: ' || SQLERRM);
        ROLLBACK;
END;
/