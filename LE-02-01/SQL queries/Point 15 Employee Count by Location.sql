# Count the number of employees in each city by grouping them by location
SELECT ort, COUNT(*)
FROM mitarbeiter
GROUP BY ort;