CREATE DATABASE IF NOT EXISTS shop_db_dmitry;
USE shop_db_dmitry;

CREATE TABLE kunden (
    kunden_id INT AUTO_INCREMENT  PRIMARY KEY,
    vorname VARCHAR(50),
    nachname VARCHAR(50),
    straße VARCHAR(100),
    hausnummer VARCHAR(10),
    postleitzahl VARCHAR(10),
    stadt VARCHAR(50),
    telefonnummer VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE lieferanten (
    lieferanten_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    straße VARCHAR(100),
    hausnummer VARCHAR(10),
    postleitzahl VARCHAR(10),
    stadt VARCHAR(50),
    telefonnummer VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE artikel (
    artikel_id INT AUTO_INCREMENT PRIMARY KEY,
    bezeichnung VARCHAR(100) NOT NULL,
    beschreibung TEXT,
    preis DECIMAL(10, 2),
    lagerbestand INT
);

CREATE TABLE verkauf (
    verkauf_id INT AUTO_INCREMENT PRIMARY KEY,
    kunden_id INT,
    lieferanten_id INT,
    artikel_id INT,
    menge INT,
    datum DATE,
    FOREIGN KEY (kunden_id) REFERENCES kunden(kunden_id),
    FOREIGN KEY (lieferanten_id) REFERENCES lieferanten(lieferanten_id),
    FOREIGN KEY (artikel_id) REFERENCES artikel(artikel_id)
);

-- Table for customer bank accounts
CREATE TABLE kunden_konten (
    konto_id INT PRIMARY KEY AUTO_INCREMENT,
    kunden_id INT,
    kontostand DECIMAL(10,2),
    FOREIGN KEY (kunden_id) REFERENCES kunden(kunden_id)
);

-- Table for the shop's cash register (only one record needed)
CREATE TABLE shop_kasse (
    kasse_id INT PRIMARY KEY,
    kontostand DECIMAL(15,2) DEFAULT 0.00
);


-- Procedure to handle the sales process
CREATE PROCEDURE verkauf_abwickeln (
    IN p_kunden_id INT,
    IN p_lieferanten_id INT,
    IN p_artikel_id INT,
    IN p_menge INT
)
BEGIN
    DECLARE v_preis DECIMAL(10,2);
    DECLARE v_gesamt_summe DECIMAL(10,2);
    DECLARE v_lager_bestand INT;
    DECLARE v_kunden_geld DECIMAL(10,2);

    START TRANSACTION;

    -- 1. Check price and stock level
    SELECT preis, lagerbestand INTO v_preis, v_lager_bestand
    FROM artikel WHERE artikel_id = p_artikel_id;

    -- 2. Check customer's bank balance
    SELECT kontostand INTO v_kunden_geld
    FROM kunden_konten WHERE kunden_id = p_kunden_id;

    SET v_gesamt_summe = v_preis * p_menge;

    -- Logic check
    IF v_lager_bestand < p_menge THEN
        ROLLBACK;
        SELECT 'Unzureichender Vorrat.' AS erfolgsmeldung;
    ELSEIF v_kunden_geld < v_gesamt_summe THEN
        ROLLBACK;
        SELECT 'Kundenkontostand zu niedrig.' AS erfolgsmeldung;
    ELSE
        -- ACTION A: Update Stock
        UPDATE artikel SET lagerbestand = lagerbestand - p_menge
        WHERE artikel_id = p_artikel_id;

        -- ACTION B: Deduct money from Customer Bank Account
        UPDATE kunden_konten SET kontostand = kontostand - v_gesamt_summe
        WHERE kunden_id = p_kunden_id;

        -- ACTION C: Add money to Shop Cash Register
        UPDATE shop_kasse SET kontostand = kontostand + v_gesamt_summe
        WHERE kasse_id = 1;

        -- ACTION D: Log the sale
        INSERT INTO verkauf (kunden_id, lieferanten_id, artikel_id, menge, datum)
        VALUES (p_kunden_id, p_lieferanten_id, p_artikel_id, p_menge, CURDATE());

        SELECT 'Bestand aktualisiert und Zahlung überwiesen.' AS erfolgsmeldung;
        COMMIT;
    END IF;
END;

CREATE PROCEDURE update_price (
    IN p_artikel_id INT,
    IN p_price DECIMAL(10, 2)
)
BEGIN
    -- Start the transaction
    START TRANSACTION;

    -- 1. Update the price for the given article ID
    UPDATE artikel
    SET preis = p_price
    WHERE artikel_id = p_artikel_id;

    -- 2. Check if the article actually existed
    -- ROW_COUNT() returns the number of affected rows
    IF ROW_COUNT() > 0 THEN
        SELECT 'Preis erfolgreich aktualisiert.' AS erfolgsmeldung;
        COMMIT;
    ELSE
        -- If no rows were updated, the ID was wrong
        ROLLBACK;
        SELECT 'Artikel-ID nicht gefunden. Keine Änderungen vorgenommen.' AS erfolgsmeldung;
    END IF;
END;

INSERT INTO kunden (vorname, nachname, straße, hausnummer, postleitzahl, stadt, telefonnummer, email)
VALUES ('Dmitry', 'Mage', 'Levelstrasse', '10', '10115', 'Berlin', '01761234567', 'dmitry.mage@mail.de'),
       ('Hans', 'Müller', 'Reeperbahn', '22', '20359', 'Hamburg', '0409876543', 'h.mueller@web.de'),
       ('Elena', 'Fischer', 'Maximilianstraße', '5', '80333', 'München', '08911223344', 'elena.f@gmx.de');

INSERT INTO lieferanten (name, straße, hausnummer, postleitzahl, stadt, telefonnummer, email)
VALUES ('Tabak Großhandel Nord', 'Industriestraße', '45', '28195', 'Bremen', '0421-5556677', 'info@tabak-nord.de'),
       ('Zigarren Import GmbH', 'Königsallee', '12', '40212', 'Düsseldorf', '0211-8889900', 'service@zigarren-import.de');

INSERT INTO artikel (bezeichnung, beschreibung, preis, lagerbestand)
VALUES ('Cohiba Siglo II', 'Premium Zigarre aus Kuba', 24.50, 50),
       ('Lucky Strike Red', 'Zigaretten 20er Packung', 8.20, 200),
       ('Zippo Classic', 'Sturmfeuerzeug Chrom', 35.00, 15),
       ('Pfeifentabak Vanille', 'Mild und aromatisch, 50g', 12.90, 30),
       ('Drehtabak Javaanse', 'Halbschwarzer Tabak, 30g', 6.50, 100);

INSERT INTO Verkauf (kunden_id, lieferanten_id, artikel_id, menge, datum)
VALUES (1, 1, 1, 2, '2026-04-20'),
       (1, 1, 3, 1, '2026-04-20'),
       (2, 1, 2, 5, '2026-04-21'),
       (3, 2, 4, 1, '2026-04-22');

INSERT INTO kunden_konten (kunden_id, kontostand)
VALUES (1, 5000.00),
       (2, 250.50),
       (3, 1200.75);

INSERT INTO shop_kasse (kasse_id, kontostand) VALUES
    (1, 25000.00);