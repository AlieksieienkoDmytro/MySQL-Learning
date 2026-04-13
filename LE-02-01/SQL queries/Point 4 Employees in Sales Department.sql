# By changing the value in parentheses from abteilung to Einkauf, Verkauf, Controlling,
# Personal, or Vertrieb, you can display employees from different departments.
SELECT name, vorname, abteilung
FROM mitarbeiter
WHERE abteilung='Vertrieb';