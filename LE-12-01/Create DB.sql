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

CREATE TABLE IF NOT EXISTS verkauf (
    verkauf_id INT AUTO_INCREMENT PRIMARY KEY,
    kunden_id INT,
    menge INT,
    gesamtpreis DECIMAL(10, 2),
    datum DATE,
    FOREIGN KEY (kunden_id) REFERENCES kunden(kunden_id)
);

CREATE TABLE IF NOT EXISTS verkauf_artikel (
    verkauf_id INT,
    artikel_id INT,
    FOREIGN KEY (verkauf_id) REFERENCES verkauf(verkauf_id),
    FOREIGN KEY (artikel_id) REFERENCES artikel(artikel_id)
);

CREATE TABLE IF NOT EXISTS lieferanten_artikel (
    artikel_id INT,
    lieferanten_id INT,
    FOREIGN KEY (artikel_id) REFERENCES artikel(artikel_id),
    FOREIGN KEY (lieferanten_id) REFERENCES lieferanten(lieferanten_id)
);


# ----PROCEDURES----


DROP PROCEDURE IF EXISTS verkauf_abwickeln;

DELIMITER $$

CREATE PROCEDURE verkauf_abwickeln (
    IN p_kunden_id INT,
    IN p_artikel_id INT,
    IN p_menge INT
)
BEGIN
    DECLARE v_preis DECIMAL(10,2);
    DECLARE v_gesamtpreis DECIMAL(10,2);
    DECLARE v_lager_bestand INT;

    START TRANSACTION;

    -- 1. Check price and stock level
    SELECT preis, lagerbestand INTO v_preis, v_lager_bestand
    FROM artikel WHERE artikel_id = p_artikel_id;

    -- Logic check
    IF v_preis IS NULL THEN
        ROLLBACK;
        SELECT 'Artikel nicht gefunden.' AS erfolgsmeldung;

    ELSEIF v_lager_bestand < p_menge THEN
        ROLLBACK;
        SELECT 'Nicht genug Lagerbestand' AS erfolgsmeldung;

    ELSE
        SET v_gesamtpreis = v_preis * p_menge;

        INSERT INTO verkauf (kunden_id, menge, gesamtpreis, datum)
        VALUES (p_kunden_id, p_menge, v_gesamtpreis, CURDATE());

        INSERT INTO verkauf_artikel (verkauf_id, artikel_id)
        VALUES (LAST_INSERT_ID(), p_artikel_id);

        UPDATE artikel
        SET lagerbestand = lagerbestand - p_menge
        WHERE artikel_id = p_artikel_id;

        SELECT 'Bestand aktualisiert und Zahlung überwiesen.' AS erfolgsmeldung;
        COMMIT;
    END IF;
END $$

DELIMITER ;



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

DELIMITER ;



-- Created a View to easily monitor customer loyalty and total revenue per person.
DROP VIEW IF EXISTS view_customer_turnover;

CREATE VIEW view_customer_turnover AS
SELECT
    kunden.vorname,
    kunden.nachname,
    SUM(verkauf.menge * artikel.preis) AS gesamtumsatz
FROM kunden
    JOIN verkauf ON kunden.kunden_id = verkauf.kunden_id
    JOIN verkauf_artikel ON verkauf.verkauf_id = verkauf_artikel.verkauf_id
    JOIN artikel ON verkauf_artikel.artikel_id = artikel.artikel_id
GROUP BY kunden.kunden_id, kunden.vorname, kunden.nachname;