CREATE DATABASE IF NOT EXISTS it_inventarverwaltung;
USE it_inventarverwaltung;

CREATE TABLE IF NOT EXISTS status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS lieferant (
    lieferant_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS abteilung (
    abteilung_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE DEFAULT 'Nicht zugeordnet'
);

CREATE TABLE IF NOT EXISTS hardware (
    hardware_id INT AUTO_INCREMENT PRIMARY KEY,
    modell VARCHAR(100) NOT NULL,
    geraetetyp VARCHAR(50),
    seriennummer VARCHAR(100) UNIQUE,
    anschaffungsdatum DATE,
    status_id INT,
    lieferant_id INT,
    FOREIGN KEY (status_id) REFERENCES status(status_id),
    FOREIGN KEY (lieferant_id) REFERENCES lieferant(lieferant_id)
);

CREATE TABLE IF NOT EXISTS mitarbeiter (
    mitarbeiter_id INT AUTO_INCREMENT PRIMARY KEY,
    vorname VARCHAR(50) NOT NULL,
    nachname VARCHAR(50) NOT NULL,
    abteilung_id INT,
    FOREIGN KEY (abteilung_id) REFERENCES abteilung(abteilung_id)
);

CREATE TABLE IF NOT EXISTS hardware_mitarbeiter (
    hardware_id INT,
    mitarbeiter_id INT,
    ausgabedatum DATE,
    rueckgabedatum DATE DEFAULT NULL,
    FOREIGN KEY (hardware_id) REFERENCES hardware(hardware_id),
    FOREIGN KEY (mitarbeiter_id) REFERENCES mitarbeiter(mitarbeiter_id)
);