# Select employee contact details using descriptive column aliases (headers)
SELECT name AS Name,
       vorname AS Vorname,
       strasse AS Strasse,
       hausnummer AS Hausnummer,
       plz AS Postleizahl,
       ort AS Ort
FROM mitarbeiter;