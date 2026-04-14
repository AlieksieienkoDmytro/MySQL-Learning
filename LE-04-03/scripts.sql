# Punkt 1: Composite Primary Key
CREATE TABLE produktionsmaschinen (
    maschinen_id INT,
    variante INT,
    bezeichnung VARCHAR(200),
    -- Define a composite primary key using two columns
    PRIMARY KEY (maschinen_id, variante)
);

-- Insert initial data for machines and their variants
INSERT INTO produktionsmaschinen (maschinen_id, variante, bezeichnung)
VALUES  (100, 1, 'Stanzmaschine Typ-A (Basis)'),
        (100, 2, 'Stanzmaschine Typ-A (Erweitert)'),
        (200, 1, 'Laserschneider (Standard)'),
        (200, 2, 'Laserschneider (Profi)');


# Punkt 2: Surrogate Key and Unique Constraint
DROP TABLE produktionsmaschinen;

CREATE TABLE produktionsmaschinen (
    global_id INT PRIMARY KEY AUTO_INCREMENT,
    maschinen_id INT,
    variante INT,
    bezeichnung VARCHAR(200),
    -- Ensure the combination of ID and variant remains unique
    UNIQUE (maschinen_id, variante)
);

INSERT INTO produktionsmaschinen (maschinen_id, variante, bezeichnung)
VALUES  (300, 1, 'Förderband V1'),
        (300, 2, 'Förderband V2'),
        (400, 1, 'Verpackungsmaschine S1'),
        (400, 2, 'Verpackungsmaschine S2');


# Punkt 3: Plausibility Rule (CHECK Constraint)
DROP TABLE produktionsmaschinen;

CREATE TABLE produktionsmaschinen (
    global_id INT PRIMARY KEY AUTO_INCREMENT,
    maschinen_id INT,
    variante INT,
    bezeichnung VARCHAR(200),
    laufzeit INT,
    maxlaufzeit INT,
    UNIQUE (maschinen_id, variante),
    -- Plausibility rule: runtime must be less than maximum runtime
    CONSTRAINT check_laufzeit
        CHECK (laufzeit < maxlaufzeit)
);

INSERT INTO produktionsmaschinen (maschinen_id, variante, bezeichnung, laufzeit, maxlaufzeit)
VALUES  (500, 1, 'Schweißroboter Modell X', 120, 1000),
        (500, 2, 'Schweißroboter Modell Y', 850, 2000);