# Punkt: 1 Retrieve employees who received at least one bonus
# Uses 'ANY' to match the ID against any ID present in the bonus table
SELECT vorname, name
FROM mitarbeiter
WHERE mitarbeiterid = ANY (
    SELECT mitarbeiterid
    FROM sachpraemie
);

# Punkt: 2 Calculate the total price of bonuses per employee
# Uses a correlated subquery for the SUM and 'EXISTS' to filter only
# those employees who actually have entries in the bonus table
SELECT
    mitarbeiter.vorname,
    mitarbeiter.name,
    (SELECT SUM(sachpraemie.preis)
     FROM sachpraemie
     WHERE sachpraemie.mitarbeiterid = mitarbeiter.mitarbeiterid) AS 'gesamt summe'
FROM mitarbeiter
WHERE EXISTS (
    SELECT *
    FROM sachpraemie
    WHERE sachpraemie.mitarbeiterid = mitarbeiter.mitarbeiterid
);

# Punkt: 3 Find employees with a tax class not listed in the reference table
# Uses 'NOT IN' to identify mismatches between the employee data and the tax class catalog
SELECT vorname, name
FROM mitarbeiter
WHERE steuerklasse NOT IN (
    SELECT steuerklasseid
    FROM steuerklasse
);

# Punkt: 4 Identify employees with invalid tax classes using EXISTS
# Uses 'NOT EXISTS' to find records in the employee table that have
# no corresponding match in the tax class reference table
SELECT mitarbeiter.vorname, mitarbeiter.name
FROM mitarbeiter
WHERE NOT EXISTS (
    SELECT *
    FROM steuerklasse
    WHERE steuerklasse.steuerklasseid = mitarbeiter.steuerklasse
);