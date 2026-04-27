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

INSERT INTO kunden_konten (kunden_id, kontostand)
VALUES (1, 5000.00),
       (2, 250.50),
       (3, 1200.75);

INSERT INTO shop_kasse (kasse_id, kontostand)
VALUES (1, 25000.00);

INSERT INTO verkauf (kunden_id, datum)
VALUES (1, '2026-04-20'),
       (2, '2026-04-21'),
       (3, '2026-04-22');

INSERT INTO verkauf_positionen (verkauf_id, artikel_id, lieferanten_id, menge, einzelpreis)
VALUES (1, 1, 1, 2, 24.50),
       (1, 3, 1, 1, 35.00),
       (2, 2, 1, 5, 8.20),
       (3, 4, 2, 1, 12.90);