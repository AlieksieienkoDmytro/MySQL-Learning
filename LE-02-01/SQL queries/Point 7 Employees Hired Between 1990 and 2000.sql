# By changing the dates in the BETWEEN clause, you can filter employees by different hiring periods.
SELECT name, vorname, eintrittsdatum, austrittsdatum
FROM mitarbeiter
WHERE eintrittsdatum BETWEEN '1990-01-01' AND '2000-01-01';