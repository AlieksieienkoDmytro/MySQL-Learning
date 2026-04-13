# Select female employees who are unmarried and have children
SELECT name, vorname, geschlecht, verheiratet, anzahlkinder
FROM mitarbeiter
WHERE geschlecht = 'w' and verheiratet = 'nein' and anzahlkinder > 0;