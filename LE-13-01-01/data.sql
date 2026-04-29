INSERT INTO musikrichtung (musikrichtung)
VALUES ('EDM'), ('House'), ('Techno'), ('Garage'),
       ('UK Garage'), ('Ambient'), ('Future Bass'), ('Jungle');

INSERT INTO interpret (interpret)
VALUES ('Fred again..'), ('Skrillex'), ('Four Tet'), ('Overmono'),
       ('Flowdan'), ('The Streets'), ('Chase & Status'), ('Joy Orbison');

INSERT INTO titel (titel, interpret_id, beurteilung)
VALUES ('Delilah (pull me out of this)', 1, 5),
       ('Jungle', 1, 5),
       ('Baby again..', 1, 5),
       ('Turn On The Lights again..', 1, 5),
       ('Stayinit', 1, 5),
       ('Leavemealone', 1, 5),
       ('Rumble', 2, 5),
       ('Baddadan', 7, 5),
       ('Rumble (Overmono Remix)', 4, 5),
       ('Flight fm', 8, 5),
       ('Mike (desert island statue)', 1, 5),
       ('Strong', 1, 5),
       ('Places to Be', 1, 4);

INSERT INTO cd (cdname, interpret_id, mr_id)
VALUES ('Actual Life 3', 1, 2),
       ('Quest For Fire', 2, 1),
       ('USB', 1, 5),
       ('Boiler Room: London', 1, 5),
       ('Ten Days', 1, 7),
       ('Secret Life', 1, 6);

INSERT INTO cd_titel (cd_id, titel_id, titel_nr) VALUES
-- Actual Life 3
(1, 1, 1),
(1, 2, 2),

-- Quest For Fire
(2, 7, 1),

-- USB
(3, 3, 1),
(3, 4, 2),
(3, 1, 3),
(3, 8, 4),

-- Boiler Room: London
(4, 1, 1),
(4, 2, 2),
(4, 7, 3),
(4, 6, 4),
(4, 10, 5),
(4, 5, 6),

-- Ten Days
(5, 13, 1),
(5, 12, 2),
(5, 11, 3);