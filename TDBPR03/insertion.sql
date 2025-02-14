BEGIN
    -- Create the accounts table
    -- EXECUTE IMMEDIATE 'CREATE TABLE accounts (
    --     account_id INT PRIMARY KEY,
    --     name VARCHAR2(100),
    --     age INT,
    --     email VARCHAR2(100),
    --     phone VARCHAR2(15),
    --     address VARCHAR2(255),
    --     balance NUMBER(10, 2)
    -- )';


    -- Insert 10 entries with realistic data
    INSERT INTO accounts (account_id, name, age, email, phone, address, balance)
    VALUES (1, 'Alice Johnson', 28, 'alice.johnson@example.com', '555-1234', '123 Maple Street, NY', 1500.00);

    INSERT INTO accounts (account_id, name, age, email, phone, address, balance)
    VALUES (2, 'Bob Smith', 35, 'bob.smith@example.com', '555-5678', '456 Oak Avenue, CA', 2000.00);

    INSERT INTO accounts (account_id, name, age, email, phone, address, balance)
    VALUES (3, 'Catherine Lee', 42, 'catherine.lee@example.com', '555-9876', '789 Pine Road, TX', 1750.00);

    INSERT INTO accounts (account_id, name, age, email, phone, address, balance)
    VALUES (4, 'David Brown', 29, 'david.brown@example.com', '555-1111', '321 Birch Lane, WA', 1300.00);

    INSERT INTO accounts (account_id, name, age, email, phone, address, balance)
    VALUES (5, 'Ella Wilson', 23, 'ella.wilson@example.com', '555-2222', '654 Cedar Boulevard, FL', 900.00);

    INSERT INTO accounts (account_id, name, age, email, phone, address, balance)
    VALUES (6, 'Franklin Davis', 37, 'frank.davis@example.com', '555-3333', '987 Elm Circle, MA', 2400.00);

    INSERT INTO accounts (account_id, name, age, email, phone, address, balance)
    VALUES (7, 'Grace Miller', 31, 'grace.miller@example.com', '555-4444', '246 Walnut Avenue, IL', 1800.00);

    INSERT INTO accounts (account_id, name, age, email, phone, address, balance)
    VALUES (8, 'Henry Adams', 27, 'henry.adams@example.com', '555-5555', '135 Spruce Street, GA', 1100.00);

    INSERT INTO accounts (account_id, name, age, email, phone, address, balance)
    VALUES (9, 'Isabella White', 30, 'isabella.white@example.com', '555-6666', '753 Fir Court, OH', 2200.00);

    INSERT INTO accounts (account_id, name, age, email, phone, address, balance)
    VALUES (10, 'Jack Thompson', 40, 'jack.thompson@example.com', '555-7777', '369 Aspen Drive, CO', 3000.00);

    -- Commit changes
    COMMIT;
END;
/
