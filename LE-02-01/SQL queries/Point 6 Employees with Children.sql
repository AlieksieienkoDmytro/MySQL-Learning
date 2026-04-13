# By changing the number of children, you can filter for families of different sizes.
SELECT name, vorname, anzahlkinder
FROM mitarbeiter
WHERE anzahlkinder > 0;