CREATE DATABASE IF NOT EXISTS shop_db_dmitry;
USE shop_db_dmitry;

CREATE TABLE IF NOT EXISTS kunden (
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

CREATE TABLE IF NOT EXISTS verkauf (
    verkauf_id INT AUTO_INCREMENT PRIMARY KEY,
    kunden_id INT,
    datum DATE,
    FOREIGN KEY (kunden_id) REFERENCES kunden(kunden_id)
);

CREATE TABLE IF NOT EXISTS verkauf_positionen (
    position_id INT AUTO_INCREMENT PRIMARY KEY,
    verkauf_id INT,
    artikel_id INT,
    lieferanten_id INT,
    menge INT,
    einzelpreis DECIMAL(10, 2),
    FOREIGN KEY (verkauf_id) REFERENCES verkauf(verkauf_id) ON DELETE CASCADE,
    FOREIGN KEY (artikel_id) REFERENCES artikel(artikel_id),
    FOREIGN KEY (lieferanten_id) REFERENCES lieferanten(lieferanten_id)
);

-- Table for customer bank accounts
CREATE TABLE IF NOT EXISTS kunden_konten (
    konto_id INT PRIMARY KEY AUTO_INCREMENT,
    kunden_id INT,
    kontostand DECIMAL(10,2),
    FOREIGN KEY (kunden_id) REFERENCES kunden(kunden_id)
);

-- Table for the shop's cash register (only one record needed)
CREATE TABLE IF NOT EXISTS shop_kasse (
    kasse_id INT PRIMARY KEY,
    kontostand DECIMAL(15,2) DEFAULT 0.00
);


# ----PROCEDURES----


/* verkauf_abwickeln: This procedure will handle the entire sales process, including checking stock levels,
   verifying customer funds, updating inventory, and recording the sale.
   It uses transactions to ensure data integrity throughout the process. */
DROP PROCEDURE IF EXISTS verkauf_abwickeln;

DELIMITER $$
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
    IF v_preis IS NULL THEN
        ROLLBACK;
        SELECT 'Artikel nicht gefunden.' AS erfolgsmeldung;
    ELSEIF v_lager_bestand < p_menge THEN
        ROLLBACK;
        SELECT 'Unzureichender Vorrat.' AS erfolgsmeldung;
    ELSEIF v_kunden_geld < v_gesamt_summe THEN
        ROLLBACK;
        SELECT 'Kundenkontostand zu niedrig.' AS erfolgsmeldung;
    ELSE
        -- Update Stock
        UPDATE artikel SET lagerbestand = lagerbestand - p_menge
        WHERE artikel_id = p_artikel_id;

        -- Deduct money from Customer Bank Account
        UPDATE kunden_konten SET kontostand = kontostand - v_gesamt_summe
        WHERE kunden_id = p_kunden_id;

        -- Add money to Shop Cash Register
        UPDATE shop_kasse SET kontostand = kontostand + v_gesamt_summe
        WHERE kasse_id = 1;

        -- Insert Sale Header (Verkauf)
        INSERT INTO verkauf (kunden_id, datum)
        VALUES (p_kunden_id, CURDATE());

        -- Insert Sale Position (Verkauf_Positionen)
        INSERT INTO verkauf_positionen (verkauf_id, artikel_id, lieferanten_id, menge, einzelpreis)
        VALUES (LAST_INSERT_ID(), p_artikel_id, p_lieferanten_id, p_menge, v_preis);

        SELECT 'Bestand aktualisiert und Zahlung überwiesen.' AS erfolgsmeldung;
        COMMIT;
    END IF;
END $$

/* update_price: This procedure updates the price of a specific article.
   It uses a transaction to ensure that the price update is atomic and can be rolled back if necessary. */
DROP PROCEDURE IF EXISTS update_price;

DELIMITER $$
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
END $$



-- Created a View to easily monitor customer loyalty and total revenue per person.
CREATE OR REPLACE VIEW view_customer_turnover AS
SELECT
    kunden.vorname,
    kunden.nachname,
    SUM(verkauf_positionen.menge * verkauf_positionen.einzelpreis) AS gesamtumsatz
FROM kunden
         JOIN verkauf ON kunden.kunden_id = verkauf.kunden_id
         JOIN verkauf_positionen ON verkauf.verkauf_id = verkauf_positionen.verkauf_id
GROUP BY kunden.kunden_id, kunden.vorname, kunden.nachname;