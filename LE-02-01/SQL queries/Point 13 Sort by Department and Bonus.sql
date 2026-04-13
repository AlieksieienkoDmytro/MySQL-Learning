# Sort employees by department and then by bonus amount in descending order
SELECT name, vorname, abteilung, bonus
FROM mitarbeiter
ORDER BY abteilung, bonus DESC;