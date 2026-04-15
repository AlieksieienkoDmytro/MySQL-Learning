# Punkt 1: INNER JOIN
-- Retrieve matching rows from both fachbuch and verlag tables.
-- Columns: title, isbn, and verlag_id from fachbuch; verlag name and verlag_id from verlag.
SELECT fachbuch.titel, fachbuch.ISBN, verlag.verlag, fachbuch.verlag_id
FROM fachbuch
         INNER JOIN verlag ON fachbuch.verlag_id = verlag.verlag_id;

# Punkt 2: LEFT JOIN
-- Retrieve all rows from the verlag table, including those with no associated books in fachbuch.
-- This ensures publishers like "Medien Verlag" are shown even with NULL book data.
SELECT fachbuch.titel, fachbuch.ISBN, verlag.verlag, verlag.verlag_id
FROM verlag
         LEFT JOIN fachbuch ON verlag.verlag_id = fachbuch.verlag_id;

# Punkt 3: CROSS JOIN
-- Generate a Cartesian product: every book combined with every publisher.
SELECT fachbuch.titel, verlag.verlag
FROM fachbuch
         CROSS JOIN verlag;

# Punkt 4: JOIN across three tables
-- Connect books to their subject areas (Fachbereich) via the link table (fachbereich_fachbuch).
SELECT fachbuch.titel, fachbereich.titel
FROM fachbuch
         JOIN fachbereich_fachbuch ON fachbuch.fachbuch_id = fachbereich_fachbuch.fachbuch_id
         JOIN fachbereich on fachbereich_fachbuch.fachbereich_id = fachbereich.fachbereich_id;

# Punkt 5: Table Aliases and overlapping columns
-- Select ISBN and title from both tables using the join between fachbuch and ausleihe.
-- Includes loan dates (von/bis) from the borrowing table.
SELECT fachbuch.ISBN, fachbuch.titel, ausleihe.ISBN, ausleihe.titel, ausleihe.von, ausleihe.bis
FROM fachbuch
         INNER JOIN ausleihe ON fachbuch.fachbuch_id = ausleihe.fachbuch_id;