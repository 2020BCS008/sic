-- CREATE TABLE EmployeeInfo (
--     employee_id NUMBER PRIMARY KEY,
--     employee_name VARCHAR2(100),
--     salary NUMBER,
--     age NUMBER
-- );


-- CREATE TABLE transaction_logs (
--     log_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
--     transaction_id NUMBER,
--     operation VARCHAR2(50),
--     before_state VARCHAR2(100),
--     after_state VARCHAR2(100),
--     status VARCHAR2(20),  -- "In Progress", "Committed", "Aborted"
--     log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- );
-- COMMIT;
-- -- DROP TABLE EmployeeInfo;
-- -- DROP TABLE transaction_logs;



-- INSERT INTO EmployeeInfo (employee_id, employee_name, salary, age) VALUES (1, 'Employee_1', 31000, 25);
-- INSERT INTO EmployeeInfo (employee_id, employee_name, salary, age) VALUES (2, 'Employee_2', 32000, 26);
-- INSERT INTO EmployeeInfo (employee_id, employee_name, salary, age) VALUES (3, 'Employee_3', 33000, 27);
-- INSERT INTO EmployeeInfo (employee_id, employee_name, salary, age) VALUES (4, 'Employee_4', 34000, 28);
-- INSERT INTO EmployeeInfo (employee_id, employee_name, salary, age) VALUES (5, 'Employee_5', 35000, 29);
-- INSERT INTO EmployeeInfo (employee_id, employee_name, salary, age) VALUES (6, 'Employee_6', 36000, 30);
-- INSERT INTO EmployeeInfo (employee_id, employee_name, salary, age) VALUES (7, 'Employee_7', 37000, 31);
-- INSERT INTO EmployeeInfo (employee_id, employee_name, salary, age) VALUES (8, 'Employee_8', 38000, 32);
-- INSERT INTO EmployeeInfo (employee_id, employee_name, salary, age) VALUES (9, 'Employee_9', 39000, 33);
-- INSERT INTO EmployeeInfo (employee_id, employee_name, salary, age) VALUES (10, 'Employee_10', 40000, 34);
-- INSERT INTO EmployeeInfo (employee_id, employee_name, salary, age) VALUES (11, 'Employee_11', 41000, 35);
-- INSERT INTO EmployeeInfo (employee_id, employee_name, salary, age) VALUES (12, 'Employee_12', 42000, 36);
-- INSERT INTO EmployeeInfo (employee_id, employee_name, salary, age) VALUES (13, 'Employee_13', 43000, 37);
-- INSERT INTO EmployeeInfo (employee_id, employee_name, salary, age) VALUES (14, 'Employee_14', 44000, 38);
-- INSERT INTO EmployeeInfo (employee_id, employee_name, salary, age) VALUES (15, 'Employee_15', 45000, 39);
-- INSERT INTO EmployeeInfo (employee_id, employee_name, salary, age) VALUES (16, 'Employee_16', 46000, 40);
-- INSERT INTO EmployeeInfo (employee_id, employee_name, salary, age) VALUES (17, 'Employee_17', 47000, 41);
-- INSERT INTO EmployeeInfo (employee_id, employee_name, salary, age) VALUES (18, 'Employee_18', 48000, 42);
-- INSERT INTO EmployeeInfo (employee_id, employee_name, salary, age) VALUES (19, 'Employee_19', 49000, 43);
-- INSERT INTO EmployeeInfo (employee_id, employee_name, salary, age) VALUES (20, 'Employee_20', 50000, 44);

-- INSERT INTO transaction_logs (transaction_id, operation, before_state, after_state, status) VALUES (1, 'INSERT', NULL, 'Name: Employee_1, Salary: 31000, Age: 25', 'Committed');
-- INSERT INTO transaction_logs (transaction_id, operation, before_state, after_state, status) VALUES (2, 'INSERT', NULL, 'Name: Employee_2, Salary: 32000, Age: 26', 'Committed');
-- INSERT INTO transaction_logs (transaction_id, operation, before_state, after_state, status) VALUES (3, 'INSERT', NULL, 'Name: Employee_3, Salary: 33000, Age: 27', 'Committed');
-- INSERT INTO transaction_logs (transaction_id, operation, before_state, after_state, status) VALUES (4, 'INSERT', NULL, 'Name: Employee_4, Salary: 34000, Age: 28', 'Committed');
-- INSERT INTO transaction_logs (transaction_id, operation, before_state, after_state, status) VALUES (5, 'INSERT', NULL, 'Name: Employee_5, Salary: 35000, Age: 29', 'Committed');
-- INSERT INTO transaction_logs (transaction_id, operation, before_state, after_state, status) VALUES (6, 'INSERT', NULL, 'Name: Employee_6, Salary: 36000, Age: 30', 'Committed');
-- INSERT INTO transaction_logs (transaction_id, operation, before_state, after_state, status) VALUES (7, 'INSERT', NULL, 'Name: Employee_7, Salary: 37000, Age: 31', 'Committed');
-- INSERT INTO transaction_logs (transaction_id, operation, before_state, after_state, status) VALUES (8, 'INSERT', NULL, 'Name: Employee_8, Salary: 38000, Age: 32', 'Committed');
-- INSERT INTO transaction_logs (transaction_id, operation, before_state, after_state, status) VALUES (9, 'INSERT', NULL, 'Name: Employee_9, Salary: 39000, Age: 33', 'Committed');
-- INSERT INTO transaction_logs (transaction_id, operation, before_state, after_state, status) VALUES (10, 'INSERT', NULL, 'Name: Employee_10, Salary: 40000, Age: 34', 'Committed');
-- INSERT INTO transaction_logs (transaction_id, operation, before_state, after_state, status) VALUES (11, 'INSERT', NULL, 'Name: Employee_11, Salary: 41000, Age: 35', 'Committed');
-- INSERT INTO transaction_logs (transaction_id, operation, before_state, after_state, status) VALUES (12, 'INSERT', NULL, 'Name: Employee_12, Salary: 42000, Age: 36', 'Committed');
-- INSERT INTO transaction_logs (transaction_id, operation, before_state, after_state, status) VALUES (13, 'INSERT', NULL, 'Name: Employee_13, Salary: 43000, Age: 37', 'Committed');
-- INSERT INTO transaction_logs (transaction_id, operation, before_state, after_state, status) VALUES (14, 'INSERT', NULL, 'Name: Employee_14, Salary: 44000, Age: 38', 'Committed');
-- INSERT INTO transaction_logs (transaction_id, operation, before_state, after_state, status) VALUES (15, 'INSERT', NULL, 'Name: Employee_15, Salary: 45000, Age: 39', 'Committed');
-- INSERT INTO transaction_logs (transaction_id, operation, before_state, after_state, status) VALUES (16, 'INSERT', NULL, 'Name: Employee_16, Salary: 46000, Age: 40', 'Committed');
-- INSERT INTO transaction_logs (transaction_id, operation, before_state, after_state, status) VALUES (17, 'INSERT', NULL, 'Name: Employee_17, Salary: 47000, Age: 41', 'Committed');
-- INSERT INTO transaction_logs (transaction_id, operation, before_state, after_state, status) VALUES (18, 'INSERT', NULL, 'Name: Employee_18, Salary: 48000, Age: 42', 'Committed');
-- INSERT INTO transaction_logs (transaction_id, operation, before_state, after_state, status) VALUES (19, 'INSERT', NULL, 'Name: Employee_19, Salary: 49000, Age: 43', 'Committed');
-- INSERT INTO transaction_logs (transaction_id, operation, before_state, after_state, status) VALUES (20, 'INSERT', NULL, 'Name: Employee_20, Salary: 50000, Age: 44', 'Committed');

-- DROP TABLE EmployeeInfo;
-- DROP TABLE transaction_logs;
-- COMMIT;