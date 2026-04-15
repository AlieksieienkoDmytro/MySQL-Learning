INSERT INTO verlag (verlag)
VALUES ('Programmieren Verlag'),
       ('IT Technik Verlag'),
       ('Elektrotechnik Verlag'),
       ('Automatisierung Verlag'),
       ('Medien Verlag');

INSERT INTO fachbereich (titel)
VALUES ('Applikationsentwicklung'),
       ('IT Technik'),
       ('Elektrotechnik'),
       ('Automatisierung');

INSERT INTO fachbuch (ISBN, titel, verlag_id)
VALUES ('1111', 'Applikationsentwicklung Fundamentals', 1),
       ('2222', 'Applikationsentwicklung Advanced', 1),
       ('3333', 'IT Technik - Betriebstechnik Fundamentals', 2),
       ('4444', 'IT Technik - Betriebstechnik Advanced', 2),
       ('5555', 'IT Technik - Systemtechnik Fundamentals', 2),
       ('6666', 'IT Technik - Systemtechnik Advanced', 2),
       ('7777', 'Elektrotechnik I',3),
       ('8888', 'Elektrotechnik II',3),
       ('9999', 'Robotik',4);

INSERT INTO ausleihe (exemplar_id, von, bis, ISBN, titel, fachbuch_id)
VALUES (101, '2026-04-01', '2026-04-15', '1111', 'Applikationsentwicklung Fundamentals', 1),
       (102, '2026-04-05', '2026-04-19', '3333', 'IT Technik - Betriebstechnik Fundamentals', 3);

INSERT INTO fachbereich_fachbuch (fachbereich_id, fachbuch_id)
VALUES (1, 1),
       (1, 2),
       (2, 3),
       (2, 4),
       (2, 5),
       (2, 6),
       (3, 7),
       (3, 8),
       (4, 9);