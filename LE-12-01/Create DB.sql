CREATE DATABASE IF NOT EXISTS shop_db_dmitry;
USE shop_db_dmitry;

CREATE TABLE IF NOT EXISTS kunden (
    kunden_id INT AUTO_INCREMENT PRIMARY KEY,
    vorname VARCHAR(50),
    nachname VARCHAR(50),
    straße VARCHAR(100),
    hausnummer VARCHAR(10),
    postleitzahl VARCHAR(10),
    stadt VARCHAR(50),
    telefonnummer VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS lieferanten (
    lieferanten_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    straße VARCHAR(100),
    hausnummer VARCHAR(10),
    postleitzahl VARCHAR(10),
    stadt VARCHAR(50),
    telefonnummer VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS artikel (
    artikel_id INT AUTO_INCREMENT PRIMARY KEY,
    bezeichnung VARCHAR(100) NOT NULL,
    beschreibung TEXT,
    preis DECIMAL(10, 2),
    lagerbestand INT
);

ALTER TABLE artikel
ADD CONSTRAINT chk_lagerbestand CHECK (lagerbestand >= 0);

CREATE TABLE IF NOT EXISTS verkauf (
    verkauf_id INT AUTO_INCREMENT PRIMARY KEY,
    kunden_id INT,
    gesamtpreis DECIMAL(10, 2),
    datum DATE,
    FOREIGN KEY (kunden_id) REFERENCES kunden(kunden_id)
);

CREATE TABLE IF NOT EXISTS verkauf_artikel (
    verkauf_id INT,
    artikel_id INT,
    menge INT,
    FOREIGN KEY (verkauf_id) REFERENCES verkauf(verkauf_id),
    FOREIGN KEY (artikel_id) REFERENCES artikel(artikel_id)
);

CREATE TABLE IF NOT EXISTS lieferanten_artikel (
    artikel_id INT,
    lieferanten_id INT,
    FOREIGN KEY (artikel_id) REFERENCES artikel(artikel_id),
    FOREIGN KEY (lieferanten_id) REFERENCES lieferanten(lieferanten_id)
);