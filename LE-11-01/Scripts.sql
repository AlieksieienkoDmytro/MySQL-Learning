-- Insert sample data into arbeitszeit table
INSERT INTO arbeitszeit (arbeitstag, jahr, monat, tag, kommen, gehen, anzahlstunden, mitarbeiterid)
VALUES
    ('2026-04-21', 2026, 4, 21, '08:00:00', '17:00:00', 9.0, 101),
    ('2026-04-21', 2026, 4, 21, '09:00:00', '18:00:00', 9.0, 102);

-- Insert sample data into kreditinstitutneu table
INSERT INTO kreditinstitutneu (bankid, bankleitzahl, bezeichnung, plz, ort)
VALUES
    (1, '10020030', 'Berliner Sparkasse', 10789, 'Berlin'),
    (2, '20030040', 'Deutsche Bank', 10115, 'Berlin'),
    (3, '70080000', 'Commerzbank', 80331, 'Munich');


# Punkt 1: Create a simple index to improve query performance for employees
CREATE INDEX index_arbeitszeit_mitarbeiter
    ON arbeitszeit (mitarbeiterID);

-- Verify index usage, the EXPLAIN statement will show if the composite index is being used for the query
SELECT * FROM arbeitszeit WHERE mitarbeiterid = 101;

# Punkt 2: Create a composite index for bank queries using 'ort' and 'plz'
CREATE INDEX index_plzort
    ON kreditinstitutneu (ort, plz);

-- Verify index usage, the EXPLAIN statement will show if the composite index is being used for the query
SELECT * FROM kreditinstitutneu WHERE ort = 'Berlin' AND plz = 10789;

-- Cleanup: Remove the created indexes as per task instructions
DROP INDEX index_plzort ON kreditinstitutneu;
DROP INDEX index_arbeitszeit_mitarbeiter ON arbeitszeit;