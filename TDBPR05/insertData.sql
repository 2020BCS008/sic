CREATE TABLE big_data (
    id NUMBER PRIMARY KEY,
    value VARCHAR2(100)
);

-- Drop table  big_data;


INSERT INTO big_data (id, value) VALUES (11, 'Apple');
INSERT INTO big_data (id, value) VALUES (13, 'Cherry');
INSERT INTO big_data (id, value) VALUES (12, 'Banana');
INSERT INTO big_data (id, value) VALUES (140, 'Date');
INSERT INTO big_data (id, value) VALUES (15, 'Elderberry');
INSERT INTO big_data (id, value) VALUES (6, 'Fig');
INSERT INTO big_data (id, value) VALUES (17, 'Grape');
INSERT INTO big_data (id, value) VALUES (18, 'Honeydew');
INSERT INTO big_data (id, value) VALUES (19, 'Kiwi');
INSERT INTO big_data (id, value) VALUES (110, 'Lemon');

COMMIT;