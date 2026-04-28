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

INSERT INTO lieferanten_artikel (artikel_id, lieferanten_id)
VALUES (1, 2),
       (2, 1),
       (3, 1),
       (4, 1),
       (5, 1);

INSERT INTO verkauf (kunden_id, gesamtpreis, datum)
VALUES (1, 49.00, '2026-04-20'),
       (2, 16.40, '2026-04-21'),
       (3, 35.00, '2026-04-22');

INSERT INTO verkauf_artikel (verkauf_id, artikel_id, menge)
VALUES (1, 1, 2),
       (2, 2, 2),
       (3, 3, 1);