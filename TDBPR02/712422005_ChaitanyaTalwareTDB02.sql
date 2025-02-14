SET ECHO OFF
SET VERIFY OFF
SET FEEDBACK OFF
SET SERVEROUTPUT ON

-- Log Transaction Procedure
CREATE OR REPLACE PROCEDURE log_transaction(
    transaction_id NUMBER,
    operation_type VARCHAR2,
    record_id NUMBER,
    old_value VARCHAR2,
    new_value VARCHAR2
) AS
BEGIN
    INSERT INTO MOCK_LOG_TABLE (
        transaction_id, operation_type, record_id, old_value, new_value
    ) VALUES (
        transaction_id, operation_type, record_id, old_value, new_value
    );
END;
/

-- Simulate Transaction Procedure
CREATE OR REPLACE PROCEDURE simulate_transaction(transaction_id NUMBER) AS
    old_value VARCHAR2(50);
    new_value VARCHAR2(50);
BEGIN
    -- Fetch current JobTitle of the first record
    SELECT JobTitle INTO old_value FROM MOCK_DATA WHERE employeeID = 1;

    -- Perform update operation
    new_value := 'Updated Job Title';

    -- Log Undo and Redo operations
    log_transaction(transaction_id, 'UNDO', 1, old_value, NULL);
    log_transaction(transaction_id, 'REDO', 1, NULL, new_value);

    -- Simulate a crash with a duplicate insert
    INSERT INTO MOCK_DATA (employeeID, first_name, last_name, email, gender, JobTitle)
    VALUES (1, 'Simulated', 'Crash', 'crash@example.com', 'Other', 'Simulated Title'); -- Conflict
END;
/

-- Undo Recovery Procedure
CREATE OR REPLACE PROCEDURE undo_recovery(transaction_id NUMBER) AS
BEGIN
    FOR rec IN (SELECT * FROM MOCK_LOG_TABLE WHERE transaction_id = transaction_id AND operation_type = 'UNDO') LOOP
        UPDATE MOCK_DATA SET JobTitle = rec.old_value WHERE employeeID = rec.record_id;
    END LOOP;
    COMMIT;
END;
/

-- Redo Recovery Procedure
CREATE OR REPLACE PROCEDURE redo_recovery(transaction_id NUMBER) AS
BEGIN
    FOR rec IN (SELECT * FROM MOCK_LOG_TABLE WHERE transaction_id = transaction_id AND operation_type = 'REDO') LOOP
        UPDATE MOCK_DATA SET JobTitle = rec.new_value WHERE employeeID = rec.record_id;
    END LOOP;
    COMMIT;
END;
/

-- Combined Undo and Redo Recovery Procedure
CREATE OR REPLACE PROCEDURE undo_redo_recovery(transaction_id NUMBER) AS
BEGIN
    undo_recovery(transaction_id);
    redo_recovery(transaction_id);
END;
/

-- Main Block
DECLARE
    v_continue CHAR(1);
    v_transaction_id NUMBER := 101;
BEGIN
    LOOP
        -- User Input for MOCK_DATA
        DECLARE
            v_employeeID INT;
            v_first_name VARCHAR2(50);
            v_last_name VARCHAR2(50);
            v_email VARCHAR2(50);
            v_gender VARCHAR2(50);
            v_jobtitle VARCHAR2(50);
        BEGIN
            v_employeeID := &v_employeeID; 
            v_first_name := '&v_first_name'; 
            v_last_name := '&v_last_name';   
            v_email := '&v_email';           
            v_gender := '&v_gender';      
            v_jobtitle := '&v_jobtitle';     

            -- Insert into MOCK_DATA
            INSERT INTO MOCK_DATA (
                employeeID, first_name, last_name, email, gender, JobTitle
            ) VALUES (
                v_employeeID, v_first_name, v_last_name, v_email, v_gender, v_jobtitle
            );

            DBMS_OUTPUT.PUT_LINE('Record Inserted:');
            DBMS_OUTPUT.PUT_LINE('Employee ID: ' || v_employeeID || ', Name: ' || v_first_name || ' ' || v_last_name);
        END;

        v_continue := '&v_continue'; -- Continue?

        IF LOWER(v_continue) = 'n' THEN
            EXIT;
        END IF;
    END LOOP;

    -- Simulate a transaction
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Simulating a transaction...');
        simulate_transaction(v_transaction_id);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
    END;

    -- Perform Undo Recovery
    DBMS_OUTPUT.PUT_LINE('Performing Undo Recovery...');
    undo_recovery(v_transaction_id);

    -- Perform Redo Recovery
    DBMS_OUTPUT.PUT_LINE('Performing Redo Recovery...');
    redo_recovery(v_transaction_id);

    -- Perform Combined Undo and Redo Recovery
    DBMS_OUTPUT.PUT_LINE('Performing Combined Undo and Redo Recovery...');
    undo_redo_recovery(v_transaction_id);

    -- Verify Logs and Data
    DBMS_OUTPUT.PUT_LINE('Transaction Logs:');
    FOR log_rec IN (SELECT * FROM MOCK_LOG_TABLE ORDER BY log_id) LOOP
        DBMS_OUTPUT.PUT_LINE('Log ID: ' || log_rec.log_id || ', Transaction: ' || log_rec.transaction_id || 
                             ', Operation: ' || log_rec.operation_type || ', Record: ' || log_rec.record_id || 
                             ', Old: ' || log_rec.old_value || ', New: ' || log_rec.new_value);
    END LOOP;




    -- DBMS_OUTPUT.PUT_LINE('Final MOCK_DATA Table:');
    -- FOR mock_rec IN (SELECT * FROM MOCK_DATA ORDER BY employeeID) LOOP
    --     DBMS_OUTPUT.PUT_LINE('Employee ID: ' || mock_rec.employeeID || ', Job Title: ' || mock_rec.JobTitle);
    -- END LOOP;

END;
/
