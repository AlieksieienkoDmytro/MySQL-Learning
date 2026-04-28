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
    verkauf_artikel.menge,
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
    verkauf_artikel.menge,
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
SELECT SUM(verkauf_artikel.menge * artikel.preis) AS gesamtumsatz
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
    verkauf_artikel.menge,
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

-- Check sales details view
SELECT * FROM view_verkauf_details;