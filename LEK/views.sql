DROP VIEW IF EXISTS aktive_hardware;

-- Create view to show all currently active devices with assigned employees
CREATE VIEW aktive_hardware AS
SELECT
    hardware.hardware_id,
    hardware.modell,
    hardware.seriennummer,
    mitarbeiter.vorname,
    mitarbeiter.nachname
FROM hardware
    -- Join with assignment table to connect devices and employees
    JOIN hardware_mitarbeiter ON hardware.hardware_id = hardware_mitarbeiter.hardware_id
    -- Join with employee table to get employee names
    JOIN mitarbeiter ON hardware_mitarbeiter.mitarbeiter_id = mitarbeiter.mitarbeiter_id
-- Filter only active devices that have not been returned yet
WHERE hardware.status_id = 2 AND hardware_mitarbeiter.rueckgabedatum IS NULL;

SELECT * FROM aktive_hardware;


DROP VIEW IF EXISTS inventarliste_abteilungen;

-- Create view to display all devices grouped by department
CREATE VIEW inventarliste_abteilungen AS
SELECT
    abteilung.name AS abteilung,
    hardware.hardware_id,
    hardware.modell,
    hardware.seriennummer,
    lieferant.name AS lieferant
FROM hardware
    -- Connect devices with assignments
    LEFT JOIN hardware_mitarbeiter ON hardware.hardware_id = hardware_mitarbeiter.hardware_id
    -- Get employee information
    LEFT JOIN mitarbeiter ON hardware_mitarbeiter.mitarbeiter_id = mitarbeiter.mitarbeiter_id
    -- Get department via employee
    LEFT JOIN abteilung ON mitarbeiter.abteilung_id = abteilung.abteilung_id
    -- Get supplier information
    LEFT JOIN lieferant ON hardware.lieferant_id = lieferant.lieferant_id
-- Sort results by department
ORDER BY abteilung.name;

SELECT * FROM inventarliste_abteilungen;


DROP VIEW IF EXISTS geraete_auslastung;

-- Create view to show devices that are either in repair or in storage
CREATE VIEW geraete_auslastung AS
SELECT
    abteilung.name AS abteilung,
    hardware.modell,
    hardware.seriennummer,
    status.name AS status
FROM hardware
    -- Join with status to filter device condition
    LEFT JOIN status ON hardware.status_id = status.status_id
    -- Connect devices with employees
    LEFT JOIN hardware_mitarbeiter ON hardware.hardware_id = hardware_mitarbeiter.hardware_id
    -- Get employee data
    LEFT JOIN mitarbeiter ON hardware_mitarbeiter.mitarbeiter_id = mitarbeiter.mitarbeiter_id
    -- Get department via employee
    LEFT JOIN abteilung ON mitarbeiter.abteilung_id = abteilung.abteilung_id
-- Filter only devices that are in repair or in storage
WHERE status.status_id = 3 -- In Reparatur
   OR status.status_id = 1 -- Lager
-- Sort by department
ORDER BY abteilung.name;

SELECT * FROM geraete_auslastung;


DROP VIEW IF EXISTS top_lieferanten;

-- Create view to show top 3 suppliers based on active devices
CREATE VIEW top_lieferanten AS
SELECT
    lieferant.name AS lieferant,
    COUNT(hardware.hardware_id) AS anzahl_geraete
FROM hardware
    -- Join with supplier to identify who provided the device
    JOIN lieferant ON hardware.lieferant_id = lieferant.lieferant_id
    -- Join with status to filter active devices
    JOIN status ON hardware.status_id = status.status_id
-- Only count active devices
WHERE status.status_id = 2
-- Group results by supplier
GROUP BY lieferant.name
-- Sort by number of devices (descending)
ORDER BY anzahl_geraete DESC
-- Limit to top 3 suppliers
LIMIT 3;

SELECT * FROM top_lieferanten;

DROP VIEW IF EXISTS hardware_anschaffungszeitraum;

-- Create view to show devices purchased within a specific time period
CREATE VIEW hardware_anschaffungszeitraum AS
SELECT
    hardware.modell,
    hardware.seriennummer,
    hardware.anschaffungsdatum,
    mitarbeiter.vorname,
    mitarbeiter.nachname
FROM hardware
    -- Join with assignment table
    LEFT JOIN hardware_mitarbeiter ON hardware.hardware_id = hardware_mitarbeiter.hardware_id
    -- Join with employee table to get names
    LEFT JOIN mitarbeiter ON hardware_mitarbeiter.mitarbeiter_id = mitarbeiter.mitarbeiter_id
-- Filter devices purchased between January 1, 2023 and December 31, 2024
WHERE hardware.anschaffungsdatum
BETWEEN '2023-01-01' AND '2024-12-31';

SELECT * FROM hardware_anschaffungszeitraum;


DROP VIEW IF EXISTS mitarbeiter_geraetehistorie;

-- Create view to show the full device history for all employees
CREATE VIEW mitarbeiter_geraetehistorie AS
SELECT
    mitarbeiter.mitarbeiter_id,
    mitarbeiter.vorname,
    mitarbeiter.nachname,
    hardware.modell,
    hardware.seriennummer,
    hardware_mitarbeiter.ausgabedatum,
    hardware_mitarbeiter.rueckgabedatum
FROM hardware_mitarbeiter
    -- Join with employee table
    JOIN mitarbeiter ON hardware_mitarbeiter.mitarbeiter_id = mitarbeiter.mitarbeiter_id
    -- Join with hardware table
    JOIN hardware ON hardware_mitarbeiter.hardware_id = hardware.hardware_id;

SELECT * FROM mitarbeiter_geraetehistorie
WHERE mitarbeiter_id = 1;


-- Lager
START TRANSACTION;

UPDATE hardware_mitarbeiter
SET rueckgabedatum = CURDATE()
WHERE hardware_id = 1 AND rueckgabedatum IS NULL;

UPDATE hardware
SET status_id = 1
WHERE hardware_id = 1;

COMMIT;


-- Aktiv
START TRANSACTION;

INSERT INTO hardware_mitarbeiter (hardware_id, mitarbeiter_id, ausgabedatum, rueckgabedatum)
VALUES (1, 1, CURDATE(), NULL);

UPDATE hardware
SET status_id = 2
WHERE hardware_id = 1;

COMMIT;


-- In Reparatur
START TRANSACTION;

UPDATE hardware_mitarbeiter
SET rueckgabedatum = CURDATE()
WHERE hardware_id = 1 AND rueckgabedatum IS NULL;

UPDATE hardware
SET status_id = 3
WHERE hardware_id = 1;

COMMIT;


-- Defekt
START TRANSACTION;

UPDATE hardware_mitarbeiter
SET rueckgabedatum = CURDATE()
WHERE hardware_id = 1 AND mitarbeiter_id = 1 AND rueckgabedatum IS NULL;

UPDATE hardware
SET status_id = 4
WHERE hardware_id = 1;

COMMIT;


-- Ausgesondert
START TRANSACTION;

UPDATE hardware_mitarbeiter
SET rueckgabedatum = CURDATE()
WHERE hardware_id = 1 AND rueckgabedatum IS NULL;

UPDATE hardware
SET status_id = 5
WHERE hardware_id = 1;

COMMIT;


-- Bestellt
START TRANSACTION;

INSERT INTO hardware (modell, geraetetyp, seriennummer, anschaffungsdatum, status_id, lieferant_id)
VALUES ('Apple Macbook', 'Laptop', 'SN011', CURDATE(), 6, 4);

COMMIT;


-- Verloren
START TRANSACTION;

UPDATE hardware_mitarbeiter
SET rueckgabedatum = CURDATE()
WHERE hardware_id = 1 AND rueckgabedatum IS NULL;

UPDATE hardware
SET status_id = 7
WHERE hardware_id = 1;

COMMIT;

SELECT * FROM hardware
WHERE hardware_id = 1;