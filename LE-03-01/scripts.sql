# Punkt 1 Insert a new qualification with explicit column names
INSERT INTO qualifikationen (qid, bezeichnung, kuerzel, kategorie)
VALUES (1, 'SQL eintragen', 'ITE', 'Informatik');

# Punkt 2 Insert Sys-Admin qualification
INSERT INTO qualifikationen (qid, bezeichnung, kuerzel, kategorie)
VALUES (2, 'Sys-Admin', 'ADA', 'Support');

# Punkt 3 Insert Projektleitung qualification
INSERT INTO qualifikationen (qid, bezeichnung, kuerzel, kategorie)
VALUES (3, 'Projektleitung', 'PL', 'Management');

# Punkt 4 Update records in qualglobal for qid 2 and 3
-- Change designation and abbreviation for qid 2
UPDATE qualglobal
SET bezeichnung = 'Second Level Helpdesk', kuerzel = 'SLH'
WHERE qid = 2;
-- Change designation and abbreviation for qid 3
UPDATE qualglobal
SET bezeichnung = 'First Level Helpdesk', kuerzel = 'FLH'
WHERE qid = 3;
-- Verify the changes for qid 2 and 3
SELECT *
FROM qualglobal
WHERE qid IN (2, 3);

# Punkt 5 Mass update kuerzel from 'DAT' to 'DBE'
UPDATE qualglobal
SET kuerzel = 'DBE'
WHERE kuerzel = 'DAT';
-- Verify the updated values
SELECT *
FROM qualglobal
WHERE kuerzel = 'DBE';

# Punkt 6 Delete a specific record (qid 2) from archive
DELETE FROM qualglobalarchiv
WHERE qid = 2;
-- Verify remaining records
SELECT *
FROM qualglobalarchiv;

# Punkt 7 Delete multiple records (5, 6, and 7) from archive
DELETE FROM qualglobalarchiv
WHERE qid IN (5, 6, 7);
-- Verify remaining records
SELECT *
FROM qualglobalarchiv;

# Punkt 8 Delete all remaining records from archive
DELETE FROM qualglobalarchiv;
-- Verify that the table is empty
SELECT *
FROM qualglobalarchiv;