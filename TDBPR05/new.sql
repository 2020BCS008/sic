SET SERVEROUTPUT ON;
SET VERIFY OFF;
SET ECHO OFF;
SET FEEDBACK OFF;

DECLARE
    -- Variables to hold the chunk size
    CURSOR chunk_cursor IS
        SELECT * FROM big_data ORDER BY value;
        
    -- Temporary tables for chunking and merging
    TYPE temp_chunk IS TABLE OF big_data%ROWTYPE INDEX BY PLS_INTEGER;
    sorted_chunk temp_chunk;
    chunk_1 temp_chunk;
    merge_result temp_chunk;
    
    chunk_size CONSTANT NUMBER := 1000; -- Number of rows in a chunk
    counter NUMBER := 0;

    -- Procedure to merge two sorted chunks
    PROCEDURE merge_chunks(c1 IN temp_chunk, c2 IN temp_chunk, result OUT temp_chunk) IS
        i NUMBER := 1;
        j NUMBER := 1;
        k NUMBER := 1;
    BEGIN
        -- Merge two chunks into the result table
        WHILE i <= c1.COUNT AND j <= c2.COUNT LOOP
            IF c1(i).value <= c2(j).value THEN
                result(k) := c1(i);
                i := i + 1;
            ELSE
                result(k) := c2(j);
                j := j + 1;
            END IF;
            k := k + 1;
        END LOOP;

        -- Add remaining elements from c1 or c2
        WHILE i <= c1.COUNT LOOP
            result(k) := c1(i);
            i := i + 1;
            k := k + 1;
        END LOOP;

        WHILE j <= c2.COUNT LOOP
            result(k) := c2(j);
            j := j + 1;
            k := k + 1;
        END LOOP;
    END;

BEGIN
    -- Step 1: Chunking and Sorting
    OPEN chunk_cursor;
    LOOP
        FETCH chunk_cursor BULK COLLECT INTO sorted_chunk LIMIT chunk_size;
        EXIT WHEN sorted_chunk.COUNT = 0;

        -- If first chunk, initialize chunk_1
        IF counter = 0 THEN
            chunk_1 := sorted_chunk;
        ELSE
            -- Merge chunk_1 with the new sorted_chunk
            merge_chunks(chunk_1, sorted_chunk, merge_result);
            chunk_1 := merge_result; -- Update chunk_1 with merged result
        END IF;

        counter := counter + 1;
    END LOOP;

    CLOSE chunk_cursor;

    -- Step 2: Final Output
    FOR i IN 1..chunk_1.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Final Merged Result: ' || chunk_1(i).value);
    END LOOP;
END;
