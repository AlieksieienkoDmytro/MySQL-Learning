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
SELECT
    verkauf.verkauf_id,
    kunden.vorname,
    kunden.nachname,
    artikel.bezeichnung,
    verkauf.menge,
    artikel.preis,
    verkauf.gesamtpreis,
    verkauf.datum
FROM verkauf
    JOIN verkauf_artikel ON verkauf.verkauf_id = verkauf_artikel.verkauf_id
    JOIN artikel ON verkauf_artikel.artikel_id = artikel.artikel_id
    JOIN kunden ON verkauf.kunden_id = kunden.kunden_id
WHERE verkauf.kunden_id = 1;

-- 6. Display all sales for a specific supplier
SELECT
    verkauf.verkauf_id,
    kunden.vorname,
    kunden.nachname,
    lieferanten.name AS lieferant,
    artikel.bezeichnung,
    verkauf.menge,
    artikel.preis,
    verkauf.gesamtpreis,
    verkauf.datum
FROM verkauf
    JOIN verkauf_artikel ON verkauf.verkauf_id = verkauf_artikel.verkauf_id
    JOIN artikel ON verkauf_artikel.artikel_id = artikel.artikel_id
    JOIN lieferanten_artikel ON artikel.artikel_id = lieferanten_artikel.artikel_id
    JOIN lieferanten ON lieferanten_artikel.lieferanten_id = lieferanten.lieferanten_id
    JOIN kunden ON verkauf.kunden_id = kunden.kunden_id
WHERE lieferanten.lieferanten_id = 1;

-- 7. Display all products cheaper than a certain value
SELECT * FROM artikel
WHERE preis < 10.00;

-- 8. Calculate the total revenue of the shop
SELECT SUM(verkauf.menge * artikel.preis) AS gesamtumsatz
FROM verkauf
    JOIN verkauf_artikel ON verkauf.verkauf_id = verkauf_artikel.verkauf_id
    JOIN artikel ON verkauf_artikel.artikel_id = artikel.artikel_id;

-- 9. Update the stock for a specific item
UPDATE artikel
SET lagerbestand = lagerbestand + 50
WHERE artikel_id = 2;

-- 10. Delete a customer and all their related sales
-- Delete positions linked to the customer's sales
DELETE FROM verkauf_artikel
WHERE verkauf_id IN (SELECT verkauf_id
                     FROM verkauf
                     WHERE kunden_id = 3);

-- Delete the sales headers
DELETE FROM verkauf WHERE kunden_id = 3;

-- Finally, delete the customer
DELETE FROM kunden WHERE kunden_id = 3;


-- 11. Delete a product and all its related sales positions
-- Remove the product from all transaction records first
DELETE FROM verkauf_artikel WHERE artikel_id = 5;

-- Remove the product from the supplier-product relationship
DELETE FROM lieferanten_artikel WHERE artikel_id = 5;

-- Now the product can be safely removed
DELETE FROM artikel WHERE artikel_id = 5;

-- 12. Display all sales with info about customer, supplier, and product
SELECT
    verkauf.verkauf_id,
    kunden.vorname,
    kunden.nachname,
    lieferanten.name AS lieferant,
    artikel.bezeichnung,
    verkauf.menge,
    artikel.preis,
    verkauf.gesamtpreis,
    verkauf.datum
FROM verkauf
         JOIN kunden ON verkauf.kunden_id = kunden.kunden_id
         JOIN verkauf_artikel ON verkauf.verkauf_id = verkauf_artikel.verkauf_id
         JOIN artikel ON verkauf_artikel.artikel_id = artikel.artikel_id
         JOIN lieferanten_artikel ON artikel.artikel_id = lieferanten_artikel.artikel_id
         JOIN lieferanten ON lieferanten_artikel.lieferanten_id = lieferanten.lieferanten_id;

-- 13. Display all products and their suppliers
SELECT DISTINCT
    artikel.bezeichnung,
    lieferanten.name AS lieferant
FROM artikel
         JOIN lieferanten_artikel ON artikel.artikel_id = lieferanten_artikel.artikel_id
         JOIN lieferanten ON lieferanten_artikel.lieferanten_id = lieferanten.lieferanten_id;


-- Call view to check customer turnover
SELECT * FROM view_customer_turnover;


-- TRANSACTION 1

-- Case 1: Testing Transaction 1 (Successful sale)
-- Dmitry buys 2 Cohiba cigars. Both tables will be updated.
CALL verkauf_abwickeln(1, 1, 2);

-- Case 2: Testing Transaction 1 (Rollback scenario)
-- Hans tries to buy 500 packs of Lucky Strike (only 200 in stock).
-- The procedure will ROLLBACK, and no data will be changed.
CALL verkauf_abwickeln(2, 1, 500);



/* TRANSACTION 2 (Manual Transaction) - Direct IDs */
START TRANSACTION;

-- 1. Insert the new customer
INSERT INTO kunden (vorname, nachname, straße, hausnummer, postleitzahl, stadt, telefonnummer, email)
VALUES ('Viktor', 'Rauch', 'Tabakweg', '7', '10117', 'Berlin', '0151998877', 'v.rauch@online.de');

-- 2. Insert the sale header (uses Customer ID from step 1)
INSERT INTO verkauf (kunden_id, menge, gesamtpreis, datum)
VALUES (LAST_INSERT_ID(), 2, 49,CURDATE());

-- 3. Insert the sale position (uses Sale ID from step 2)
-- IMPORTANT: Now LAST_INSERT_ID() points to the ID from the 'verkauf' table
INSERT INTO verkauf_artikel (verkauf_id, artikel_id)
VALUES (LAST_INSERT_ID(), 1);

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