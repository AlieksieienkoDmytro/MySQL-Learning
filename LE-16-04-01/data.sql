INSERT INTO teams (teamname)
VALUES ('Junioren U19'),
       ('Senioren'),
       ('Profis');

INSERT INTO spieler (vorname, nachname, geburtsdatum)
VALUES ('Alexander', 'Ivanov', '2005-05-15'),
       ('Nikolai', 'Sokolov', '2006-11-20'),
       ('Artem', 'Dzjuba', '1995-09-13'),
       ('Igor', 'Akinfeev', '1990-04-08'),
       ('Sergej', 'Petrov', '2000-03-10');

INSERT INTO trainer (vorname, nachname, gehalt)
VALUES ('Waleri', 'Karpin', 5000.00),
       ('Stanislaw', 'Tschertschessow', 7500.00),
       ('Sergej', 'Semak', 9000.00);

INSERT INTO ausbildungen (bezeichnung, datum)
VALUES ('UEFA-Pro-Lizenz', '2023-01-10'),
       ('Erste-Hilfe-Kurs', '2024-02-15'),
       ('Sportpsychologie', '2023-11-20');

INSERT INTO spieler_teams (spieler_id, team_id)
VALUES (1, 1),
       (2, 1),
       (3, 2),
       (3, 3),
       (4, 3),
       (5, 2);

INSERT INTO trainer_teams (trainer_id, team_id)
VALUES (1, 1),
       (2, 2),
       (2, 3),
       (3, 3);

INSERT INTO trainer_ausbildungen (trainer_id, ausbildung_id)
VALUES (1, 1),
       (1, 2),
       (2, 1),
       (2, 3),
       (3, 3);