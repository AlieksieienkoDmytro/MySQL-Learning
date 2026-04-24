-- 1. Display all customers
SELECT * FROM kunden;

-- 2. Display all suppliers
SELECT * FROM lieferanten;

-- 3. Display all products
SELECT * FROM artikel;

-- 4. Check stock for a specific item
SELECT bezeichnung, lagerbestand
FROM artikel
WHERE bezeichnung = 'Cohiba Siglo II';

-- 5. Display all sales for a specific customer
SELECT * FROM verkauf
WHERE kunden_id = 1;

-- 6. Display all sales for a specific supplier
SELECT * FROM verkauf
WHERE lieferanten_id = 1;

-- 7. Display all products cheaper than a certain value
SELECT * FROM artikel
WHERE preis < 10.00;

-- 8. Calculate the total revenue of the shop
SELECT SUM(verkauf.menge * artikel.preis) AS gesamtumsatz
FROM verkauf
         JOIN artikel ON verkauf.artikel_id = artikel.artikel_id;

-- 9. Update the stock for a specific item
UPDATE artikel
SET lagerbestand = lagerbestand + 50
WHERE artikel_id = 2;

-- 10. Delete a customer and all their related sales
DELETE FROM kunden WHERE kunden_id = 3;
DELETE FROM verkauf WHERE kunden_id = 3;
DELETE FROM kunden WHERE kunden_id = 3;

-- 11. Delete a product and all its related sales
DELETE FROM verkauf WHERE artikel_id = 5;
DELETE FROM artikel WHERE artikel_id = 5;

-- 12. Display all sales with info about customer, supplier, and product
SELECT
    verkauf.verkauf_id,
    kunden.vorname,
    kunden.nachname,
    lieferanten.name,
    artikel.bezeichnung,
    verkauf.menge,
    verkauf.datum
FROM verkauf
         JOIN kunden ON verkauf.kunden_id = kunden.kunden_id
         JOIN lieferanten ON verkauf.lieferanten_id = lieferanten.lieferanten_id
         JOIN artikel ON verkauf.artikel_id = artikel.artikel_id;

-- 13. Display all products and their suppliers
SELECT DISTINCT
    artikel.bezeichnung,
    lieferanten.name
FROM artikel
         JOIN verkauf ON artikel.artikel_id = verkauf.artikel_id
         JOIN lieferanten ON verkauf.lieferanten_id = lieferanten.lieferanten_id;


-- Created a View to easily monitor customer loyalty and total revenue per person.
CREATE VIEW view_customer_turnover AS
SELECT
    kunden.vorname,
    kunden.nachname,
    SUM(verkauf.menge * artikel.preis) AS gesamtumsatz
FROM kunden
         JOIN verkauf ON kunden.kunden_id = verkauf.kunden_id
         JOIN artikel ON verkauf.artikel_id = artikel.artikel_id
GROUP BY kunden.kunden_id;

-- To see the result:
SELECT * FROM view_customer_turnover;


-- TRANSACTION 1

-- Case 1: Testing Transaction 1 (Successful sale)
-- Dmitry buys 2 Cohiba cigars. Both tables will be updated.
CALL verkauf_abwickeln(1, 1, 1, 2);

-- Case 2: Testing Transaction 1 (Rollback scenario)
-- Hans tries to buy 500 packs of Lucky Strike (only 200 in stock).
-- The procedure will ROLLBACK, and no data will be changed.
CALL verkauf_abwickeln(2, 1, 2, 500);


/* TRANSACTION 2 (Manual Transaction):
   This transaction manually inserts a new customer and records a sale for that customer.
*/
START TRANSACTION;

-- 1. Insert the new customer
INSERT INTO kunden (vorname, nachname, straße, hausnummer, postleitzahl, stadt, telefonnummer, email)
VALUES ('Viktor', 'Rauch', 'Tabakweg', '7', '10117', 'Berlin', '0151998877', 'v.rauch@online.de');

-- 2. Record the sale using the ID from the previous step
-- We use LAST_INSERT_ID() to get the primary key of the new customer
INSERT INTO verkauf (kunden_id, lieferanten_id, artikel_id, menge, datum)
VALUES (LAST_INSERT_ID(), 2, 1, 1, CURDATE());

COMMIT;


/* TRANSACTION 3 (Price Update):
   This transaction updates the price of a specific article and confirms the update.
*/
START TRANSACTION;

-- 1. Update the price of the article (e.g., Cohiba Siglo II)
UPDATE artikel
SET preis = 16.90
WHERE artikel_id = 1;

-- 2. Optional: In a real system, you might update a price_history table here.
-- For this task, we confirm the price update for future 'verkauf' calculations.
SELECT 'Hauptpreis erfolgreich aktualisiert' AS erfolgsmeldung;

COMMIT;
-- Alternatively, we can use the stored procedure for a more robust implementation:
-- Updating the price of article ID 1 to 26.90 Euro
CALL update_price(1, 26.90);


-- Speed up searching for customers by their last name
CREATE INDEX kunden_nachname ON kunden(nachname);

-- Speed up product searches by their name
CREATE INDEX artikel_bezeichnung ON artikel(bezeichnung);

-- Speed up reporting by sales date
CREATE INDEX verkauf_datum ON verkauf(datum);