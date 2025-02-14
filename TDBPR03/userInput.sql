   SET ECHO OFF
SET VERIFY OFF
SET FEEDBACK OFF
SET SERVEROUTPUT ON  -- Enable output from DBMS_OUTPUT

declare
   v_employeeid int;
   v_first_name varchar2(50);
   v_last_name  varchar2(50);
   v_email      varchar2(50);
   v_gender     varchar2(50);
   v_jobtitle   varchar2(50);
   v_continue   char(1);
begin
    -- Start a loop for continuous user input
   loop
        -- Take input from the user for each record
      v_employeeid := &v_employeeid; 
      v_first_name := '&v_first_name'; 
      v_last_name := '&v_last_name';   
      v_email := '&v_email';           
      v_gender := '&v_gender';      
      v_jobtitle := '&v_jobTitle';     


        -- Insert the record into MOCK_DATA table
      insert into mock_data (
         employeeid,
         first_name,
         last_name,
         email,
         gender,
         jobtitle
      ) values ( v_employeeid,
                 v_first_name,
                 v_last_name,
                 v_email,
                 v_gender,
                 v_jobtitle );

      dbms_output.put_line('');  -- This prints an empty line for space

        -- Ask the user if they want to continue
        -- Output the inserted data
      dbms_output.put_line('Inserted Employee ID: ' || v_employeeid);
      dbms_output.put_line('First Name: ' || v_first_name);
      dbms_output.put_line('Last Name: ' || v_last_name);
      dbms_output.put_line('Email: ' || v_email);
      dbms_output.put_line('Gender: ' || v_gender);
      dbms_output.put_line('Job Title: ' || v_jobtitle);
        -- DBMS_OUTPUT.PUT_LINE('Do you want to enter another record? (Y/N)');
      v_continue := '&v_continue'; -- Get user input for continuation

        -- Exit loop if user does not want to continue
      if lower(v_continue) = 'n' then
         exit;
      end if;
   end loop;
    -- Output the completion message when the user exits the loop
   dbms_output.put_line('User has chosen to stop entering data. Exiting...');

    -- Commit all the changes
   commit;
end;
/