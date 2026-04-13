# Select female employees working in the Sales (Vertrieb) department
SELECT name, vorname, abteilung
FROM mitarbeiter
WHERE abteilung = 'Vertrieb' and geschlecht = 'w';