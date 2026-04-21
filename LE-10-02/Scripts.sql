# Punkt 1: Create a view named 'v_urlaub'
# This view retrieves vacation data for employees
CREATE VIEW v_urlaub AS
SELECT name, vorname, urlaubstage, urlaubgenommen
FROM mitarbeiter;

SELECT * FROM v_urlaub;


# Punkt 2: Create a view named 'v_praemie'
# This view joins employee personal data with their specific bonuses and reasons
CREATE VIEW v_praemie AS
SELECT
    mitarbeiter.name,
    mitarbeiter.vorname,
    sachpraemie.praemie,
    sachpraemie.grund
FROM mitarbeiter
         INNER JOIN sachpraemie ON mitarbeiter.mitarbeiterid = sachpraemie.mitarbeiterid;

SELECT * FROM v_praemie;


# Punkt 3: Create a view for employee bonuses with ascending sort
# This view combines personal info with bonus values and sorts them
CREATE VIEW v_mitarbeiterbonus AS
SELECT
    mitarbeiter.name,
    mitarbeiter.vorname,
    bonus.bonuszahlung
FROM mitarbeiter
         INNER JOIN bonus ON mitarbeiter.mitarbeiterid = bonus.mitarbeiterid
ORDER BY bonus.bonuszahlung ASC;

SELECT * FROM v_mitarbeiterbonus;

# Punkt 4: Create a view for employee health insurance information
CREATE VIEW v_mitarbeiterkrankenkasse AS
SELECT name, vorname, krankenversicherung
FROM mitarbeiter;

SELECT * FROM v_mitarbeiterkrankenkasse;


# Punkt 5: Clean up by dropping the created views
DROP VIEW IF EXISTS v_urlaub;
DROP VIEW IF EXISTS v_praemie;
DROP VIEW IF EXISTS v_mitarbeiterbonus;
DROP VIEW IF EXISTS v_mitarbeiterkrankenkasse;