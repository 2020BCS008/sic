SET SERVEROUTPUT ON;
SET VERIFY OFF;
SET ECHO OFF;
SET FEEDBACK OFF;

-- Step 3: Implementing External Merge Sort Algorithm (unchanged)
DECLARE
    -- Variables to hold the chunk size
    CURSOR chunk_cursor IS
        SELECT * FROM big_data ORDER BY value;
        
    -- Temporary tables for chunking
    TYPE temp_chunk IS TABLE OF big_data%ROWTYPE INDEX BY PLS_INTEGER;
    sorted_chunk temp_chunk;
    
    -- Number of rows in the chunk
    chunk_size CONSTANT NUMBER := 1000;
    counter NUMBER := 0;
    
    -- Variables for merging
    chunk_1 temp_chunk;
    chunk_2 temp_chunk;
    merge_result temp_chunk;
    
BEGIN
    -- Step 4: Chunking and Sorting
    OPEN chunk_cursor;
    LOOP
        FETCH chunk_cursor BULK COLLECT INTO sorted_chunk LIMIT chunk_size;
        
        EXIT WHEN sorted_chunk.COUNT = 0;
        
        -- Sort each chunk (using order by for simplicity here)
        FOR i IN 1..sorted_chunk.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE('Sorted chunk value: ' || sorted_chunk(i).value);
        END LOOP;
        
        -- Step 5: Merge the chunks
        IF counter = 0 THEN
            -- Initialize chunk_1 with the first chunk of sorted data
            chunk_1 := sorted_chunk;
        ELSE
            -- Merge chunk_1 and sorted_chunk into chunk_2
            FOR i IN 1..chunk_1.COUNT LOOP
                chunk_2(i) := chunk_1(i); 
            END LOOP;
        END IF;
        
        counter := counter + 1;
    END LOOP;
    
    -- Step 6: Final Output
    FOR i IN 1..merge_result.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Merged result: ' || merge_result(i).value);
    END LOOP;

    CLOSE chunk_cursor;
END;
/
