/* TRANSACTION 1 (Create Sale):
   This transaction creates a new sale, adds multiple products,
   updates the stock levels, and calculates the total price.
*/
START TRANSACTION;

-- 1. Create a new sale with initial total price set to 0
INSERT INTO verkauf (kunden_id, gesamtpreis, datum)
VALUES (1, 0, CURDATE());

-- Store generated sale ID
SET @verkauf_id = LAST_INSERT_ID();

-- 2. Insert products with quantities into the sale
INSERT INTO verkauf_artikel (verkauf_id, artikel_id, menge)
VALUES
    (@verkauf_id, 1, 2),
    (@verkauf_id, 3, 1);

-- 3. Update stock levels based on sold quantities
UPDATE artikel
    JOIN verkauf_artikel ON artikel.artikel_id = verkauf_artikel.artikel_id
SET artikel.lagerbestand = artikel.lagerbestand - verkauf_artikel.menge
WHERE verkauf_artikel.verkauf_id = @verkauf_id;

-- 4. Calculate total price of the sale
UPDATE verkauf
SET gesamtpreis = (
    SELECT SUM(artikel.preis * verkauf_artikel.menge)
    FROM verkauf_artikel
             JOIN artikel ON verkauf_artikel.artikel_id = artikel.artikel_id
    WHERE verkauf_artikel.verkauf_id = @verkauf_id
)
WHERE verkauf_id = @verkauf_id;

COMMIT;

/* TRANSACTION 2 (New Customer & Sale):
   This transaction creates a new customer, creates a sale for this customer,
   adds a product to the sale, and calculates the total price.
*/
START TRANSACTION;

-- 1. Insert new customer
INSERT INTO kunden (vorname, nachname, straße, hausnummer, postleitzahl, stadt, telefonnummer, email)
VALUES ('Viktor', 'Rauch', 'Tabakweg', '7', '10117', 'Berlin', '0151998877', 'v.rauch@online.de');

-- Store generated customer ID
SET @kunden_id = LAST_INSERT_ID();

-- 2. Create a new sale for this customer
INSERT INTO verkauf (kunden_id, gesamtpreis, datum)
VALUES (@kunden_id, 0, CURDATE());

-- Store generated sale ID
SET @verkauf_id = LAST_INSERT_ID();

-- 3. Insert product with quantity
INSERT INTO verkauf_artikel (verkauf_id, artikel_id, menge)
VALUES (@verkauf_id, 1, 2);

-- 4. Calculate total price for the sale
UPDATE verkauf
SET gesamtpreis = (
SELECT SUM(artikel.preis * verkauf_artikel.menge)
    FROM verkauf_artikel
             JOIN artikel ON verkauf_artikel.artikel_id = artikel.artikel_id
    WHERE verkauf_artikel.verkauf_id = @verkauf_id
)
WHERE verkauf_id = @verkauf_id;

COMMIT;


/* TRANSACTION 3 (Price Update):
   This transaction updates the price of a specific product.
*/
START TRANSACTION;

-- 1. Update the price of a specific article
UPDATE artikel
SET preis = 16.90
WHERE artikel_id = 1;

-- 2. Display updated product information
SELECT artikel_id, bezeichnung, preis
FROM artikel
WHERE artikel_id = 1;

COMMIT;