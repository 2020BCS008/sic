SET SERVEROUTPUT ON;

DECLARE
    -- Define the Transaction type
    TYPE Transaction IS RECORD (
        tid NUMBER,          -- Transaction ID
        operation CHAR(1),   -- Operation: 'R' for read, 'W' for write
        dataitem CHAR(1)     -- Data item being accessed (e.g., A, B, C)
    );
    
    -- Define the Schedule type to hold a list of transactions
    TYPE Schedule IS TABLE OF Transaction;
    
    -- Sample schedule with read and write operations
    s Schedule := Schedule(
        Transaction(1, 'R', 'A'),
        Transaction(2, 'R', 'A'),
        Transaction(1, 'W', 'A'),
        Transaction(2, 'W', 'A')
    );
    
    last_tid NUMBER := -1;
    is_serial BOOLEAN := TRUE;
    cycle_detected BOOLEAN := FALSE;
    
    -- Graph to store precedence constraints (T1->T2)
    TYPE StringList IS TABLE OF VARCHAR2(100);
    graph StringList := StringList();

    -- Procedure to add edges in the graph (i.e., precedence constraint)
    PROCEDURE add_edge(t1 NUMBER, t2 NUMBER) IS
    BEGIN
        IF t1 != t2 THEN
            -- Insert edge in the form "T1->T2"
            graph.EXTEND;
            graph(graph.COUNT) := t1 || '->' || t2;
        END IF;
    END;

    -- Procedure to detect cycle in the precedence graph
    PROCEDURE detect_cycle IS
        visited SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST();
        stack SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST();

        -- Helper function to check if a cycle exists in the current stack path
        FUNCTION has_cycle(t NUMBER) RETURN BOOLEAN IS
        BEGIN
            IF stack.EXISTS(t) THEN
                RETURN TRUE;  -- Cycle detected
            END IF;
            RETURN FALSE;
        END;

    BEGIN
        -- Add basic cycle detection logic, which needs improvement based on your graph traversal
        FOR i IN 1..graph.COUNT LOOP
            -- For simplicity, assume detection here just for demonstration
            IF has_cycle(i) THEN
                cycle_detected := TRUE;
                EXIT;
            END IF;
        END LOOP;
    END;

BEGIN
    -- Check if the schedule is serial (based on transaction order)
    FOR i IN s.FIRST..s.LAST LOOP
        IF last_tid != -1 AND s(i).tid != last_tid THEN
            IF s(i).tid < last_tid THEN
                is_serial := FALSE;
            END IF;
        END IF;
        last_tid := s(i).tid;
    END LOOP;

    -- Output serial check
    IF is_serial THEN
        DBMS_OUTPUT.PUT_LINE('The schedule is serial.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('The schedule is not serial.');
    END IF;

    -- Create precedence graph for conflict serializability checking
    FOR i IN s.FIRST..s.LAST LOOP
        FOR j IN i+1..s.LAST LOOP
            -- Check for conflicts: R/W or W/W on the same data item by different transactions
            IF s(i).dataitem = s(j).dataitem AND s(i).tid != s(j).tid THEN
                IF s(i).operation = 'W' OR s(j).operation = 'W' THEN
                    add_edge(s(i).tid, s(j).tid);
                END IF;
            END IF;
        END LOOP;
    END LOOP;

    -- Detect cycle in precedence graph
    detect_cycle;

    -- Output conflict serializability check
    IF cycle_detected THEN
        DBMS_OUTPUT.PUT_LINE('The schedule is  conflict-serializable.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('The schedule is not conflict-serializable.');
    END IF;

    -- Output the precedence graph edges
    DBMS_OUTPUT.PUT_LINE('Precedence Graph Edges:');
    FOR i IN graph.FIRST..graph.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(graph(i));
    END LOOP;

END;
/
