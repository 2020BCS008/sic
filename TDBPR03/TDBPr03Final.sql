SET ECHO OFF
SET VERIFY OFF
SET FEEDBACK OFF
SET SERVEROUTPUT ON

DECLARE
    v_from_account NUMBER := &from_account; -- Source account ID
    v_to_account NUMBER := &to_account;     -- Target account ID
    v_transfer_amount NUMBER := &amount;    -- Transfer amount
    v_balance_from NUMBER;
    v_balance_to NUMBER;
    v_continue VARCHAR2(10) := 'YES';
    v_lockhandle_from VARCHAR2(128);  -- Lock handle for source account
    v_lockhandle_to VARCHAR2(128);    -- Lock handle for target account
    v_result NUMBER;
BEGIN
    WHILE UPPER(TRIM(v_continue)) = 'YES' LOOP
        -- Allocate unique lock handles for both accounts
        DBMS_LOCK.ALLOCATE_UNIQUE(lockname => 'TRANSFER_LOCK_' || v_from_account, lockhandle => v_lockhandle_from);
        DBMS_LOCK.ALLOCATE_UNIQUE(lockname => 'TRANSFER_LOCK_' || v_to_account, lockhandle => v_lockhandle_to);

        v_result := DBMS_LOCK.REQUEST(lockhandle => v_lockhandle_from, lockmode => DBMS_LOCK.X_MODE, timeout => 10);
        IF v_result = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Lock successfully acquired for source account ' || v_from_account);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Unable to acquire lock on source account ' || v_from_account);
        END IF;

        v_result := DBMS_LOCK.REQUEST(lockhandle => v_lockhandle_to, lockmode => DBMS_LOCK.X_MODE, timeout => 10);
        IF v_result = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Lock successfully acquired for target account ' || v_to_account);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Unable to acquire lock on target account ' || v_to_account);
        END IF;
        -- Growing Phase: Lock both accounts and retrieve balances
        SELECT balance INTO v_balance_from
        FROM accounts
        WHERE account_id = v_from_account
        FOR UPDATE;

        SELECT balance INTO v_balance_to
        FROM accounts
        WHERE account_id = v_to_account
        FOR UPDATE;
    
        IF v_balance_from >= v_transfer_amount THEN
            v_balance_from := v_balance_from - v_transfer_amount;
            v_balance_to := v_balance_to + v_transfer_amount;
            -- Update both accounts
            UPDATE accounts
            SET balance = v_balance_from
            WHERE account_id = v_from_account;

            UPDATE accounts
            SET balance = v_balance_to
            WHERE account_id = v_to_account;

            DBMS_OUTPUT.PUT_LINE('Transfer Successful.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Insufficient Balance in Source Account.');
        END IF;
        -- Shrinking Phase: Commit transaction and release locks
        COMMIT;
        -- Release the locks explicitly
        v_result := DBMS_LOCK.RELEASE(lockhandle => v_lockhandle_from);
        IF v_result = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Lock released for source account ' || v_from_account);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error releasing lock for source account ' || v_from_account);
        END IF;
        
        v_result := DBMS_LOCK.RELEASE(lockhandle => v_lockhandle_to);
        IF v_result = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Lock released for target account ' || v_to_account);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error releasing lock for target account ' || v_to_account);
        END IF;
        v_continue := '&continue';
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('All transections completed!');
END;
/