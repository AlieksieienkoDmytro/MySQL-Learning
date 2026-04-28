INSERT INTO status (name)
VALUES ('Lager'),
       ('Aktiv'),
       ('In Reparatur'),
       ('Defekt'),
       ('Ausgesondert'),
       ('Bestellt'),
       ('Verloren');

INSERT INTO lieferant (name)
VALUES ('Dell'),
       ('HP'),
       ('Lenovo'),
       ('Apple'),
       ('Asus');

INSERT INTO abteilung (name)
VALUES ('IT'),
       ('Marketing'),
       ('Vertrieb'),
       ('HR'),
       ('Finanzen');

INSERT INTO mitarbeiter (vorname, nachname, abteilung_id)
VALUES ('Dmitry', 'Ivanov', 1),
       ('Alexey', 'Petrov', 2),
       ('Sergey', 'Smirnov', 3),
       ('Ivan', 'Kuznetsov', 1),
       ('Andrey', 'Popov', 4),
       ('Nikita', 'Sokolov', 2),
       ('Vladimir', 'Lebedev', 3),
       ('Artem', 'Kozlov', 5),
       ('Denis', 'Novikov', 1),
       ('Maxim', 'Morozov', 2);

INSERT INTO hardware (modell, geraetetyp, seriennummer, anschaffungsdatum, status_id, lieferant_id)
VALUES ('Dell XPS 13', 'Laptop', 'SN001', '2023-02-10', 2, 1),
       ('HP EliteBook', 'Laptop', 'SN002', '2023-05-15', 2, 2),
       ('Lenovo ThinkPad', 'Laptop', 'SN003', '2024-01-20', 1, 3),
       ('MacBook Pro', 'Laptop', 'SN004', '2023-11-05', 2, 4),
       ('Asus ROG', 'Laptop', 'SN005', '2022-09-12', 3, 5),
       ('Dell Monitor 24"', 'Monitor', 'SN006', '2023-03-18', 2, 1),
       ('HP Monitor 27"', 'Monitor', 'SN007', '2024-02-22', 6, 2),
       ('HP Drucker', 'Drucker', 'SN008', '2023-07-30', 4, 2),
       ('Dell Drucker', 'Drucker', 'SN009', '2022-12-01', 5, 3),
       ('Lenovo Tablet', 'Tablet', 'SN010', '2024-04-10', 7, 3);

INSERT INTO hardware_mitarbeiter (hardware_id, mitarbeiter_id, ausgabedatum, rueckgabedatum)
VALUES (1, 1, '2023-02-15', DEFAULT),
       (7, 1, '2023-02-15', DEFAULT),
       (2, 2, '2023-05-20', DEFAULT),
       (4, 4, '2023-11-10', DEFAULT),
       (6, 6, '2023-03-20', DEFAULT),
       (1, 3, '2023-02-10', '2023-02-14'),
       (5, 5, '2022-09-20', '2023-01-10'),
       (8, 7, '2023-08-01', '2023-10-01'),
       (6, 9, '2023-03-25', '2023-04-10');