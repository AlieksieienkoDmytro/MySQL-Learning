# Sort employees by department first, then by last name and first name in ascending order
SELECT name, vorname, abteilung, bonus
FROM mitarbeiter
ORDER BY abteilung, name, vorname;