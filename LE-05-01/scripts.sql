# Punkt 1: Combine data from Belgium and Holland without duplicates
SELECT name, vorname FROM niederlassungbelgien
UNION
SELECT name, vorname FROM niederlassungholland;

# Punkt 2: Combine data from Belgium and Holland including duplicates
SELECT name, vorname FROM niederlassungbelgien
UNION ALL
SELECT name, vorname FROM niederlassungholland;

# Punkt 3: Unique set of employees from Belgium, Holland, and Switzerland
SELECT name, vorname FROM niederlassungbelgien
UNION
SELECT name, vorname FROM niederlassungholland
UNION
SELECT name, vorname FROM niederlassungschweiz;

# Punkt 4: Intersection - Find employees working in both branches
SELECT name, vorname FROM niederlassungbelgien
INTERSECT
SELECT name, vorname FROM niederlassungholland;

# Punkt 5: Difference - Find employees working only in Holland
SELECT name, vorname FROM niederlassungholland
EXCEPT
SELECT name, vorname FROM niederlassungbelgien;

# Punkt 6: Unique list of active employees from both branches
SELECT name, vorname, status FROM niederlassungbelgien
WHERE status = 'aktiv'
UNION
SELECT name, vorname, status FROM niederlassungholland
WHERE status = 'aktiv';

# Punkt 7: Combined list sorted alphabetically by last name
SELECT name, vorname FROM niederlassungbelgien
UNION
SELECT name, vorname FROM niederlassungholland
ORDER BY name;