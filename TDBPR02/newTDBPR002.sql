
    -- Procedure to simulate a transaction and crash
    CREATE OR REPLACE PROCEDURE simulate_transaction(transaction_id NUMBER) AS
        old_value VARCHAR2(50);
        new_value VARCHAR2(50);
    BEGIN
        -- Fetch the current JobTitle of the first record
        SELECT JobTitle INTO old_value FROM MOCK_DATA WHERE employeeID = 1;

        -- Perform the update operation
        new_value := 'Updated Job Title';
       
        -- Simulate a constraint violation crash due to a duplicate employeeID
        INSERT INTO MOCK_DATA (employeeID, first_name, last_name, email, gender, JobTitle)
        VALUES (3, 'John', 'Doe', 'john.doe@example.com', 'Male', 'Engineer');  -- employeeID = 1 already exists


        -- Log Undo and Redo operations
        log_transaction(transaction_id, 'UNDO', 1, old_value, NULL);
        log_transaction(transaction_id, 'REDO', 1, NULL, new_value);

        -- Simulate a crash
        -- RAISE_APPLICATION_ERROR(-20001, 'Simulated crash!');
    END;
    /

-- Procedure for Undo Recovery
CREATE OR REPLACE PROCEDURE undo_recovery(transaction_id NUMBER) AS
BEGIN
    FOR rec IN (SELECT * FROM MOCK_LOG_TABLE WHERE transaction_id = transaction_id AND operation_type = 'UNDO') LOOP
        UPDATE MOCK_DATA SET JobTitle = rec.old_value WHERE employeeID = rec.record_id;
    END LOOP;
    COMMIT;
END;
/

-- Procedure for Redo Recovery
CREATE OR REPLACE PROCEDURE redo_recovery(transaction_id NUMBER) AS
BEGIN
    FOR rec IN (SELECT * FROM MOCK_LOG_TABLE WHERE transaction_id = transaction_id AND operation_type = 'REDO') LOOP
        UPDATE MOCK_DATA SET JobTitle = rec.new_value WHERE employeeID = rec.record_id;
    END LOOP;
    COMMIT;
END;
/

-- Procedure for Combined Undo and Redo Recovery
CREATE OR REPLACE PROCEDURE undo_redo_recovery(transaction_id NUMBER) AS
BEGIN
    undo_recovery(transaction_id);
    redo_recovery(transaction_id);
END;
/

-- Set server output to see the DBMS_OUTPUT messages
SET SERVEROUTPUT ON;

-- Clear existing data for a clean start
TRUNCATE TABLE MOCK_LOG_TABLE;
TRUNCATE TABLE MOCK_DATA;


COMMIT;

-- Simulate a transaction (this will raise a simulated crash error)
BEGIN
    DBMS_OUTPUT.PUT_LINE('Simulating a transaction...');
    simulate_transaction(101);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

-- Perform Undo Recovery
BEGIN
    DBMS_OUTPUT.PUT_LINE('Performing Undo Recovery...');
    undo_recovery(101);
END;
/

-- Perform Redo Recovery
BEGIN
    DBMS_OUTPUT.PUT_LINE('Performing Redo Recovery...');
    redo_recovery(101);
END;
/

-- Perform Combined Undo and Redo Recovery
BEGIN
    DBMS_OUTPUT.PUT_LINE('Performing Combined Undo and Redo Recovery...');
    undo_redo_recovery(101);
END;
/

-- Verify Logs and Data
SELECT log_id, transaction_id, operation_type, record_id, old_value, new_value 
FROM MOCK_LOG_TABLE;
SELECT employeeID, first_name, last_name, email, gender, JobTitle 
FROM MOCK_DATA;
