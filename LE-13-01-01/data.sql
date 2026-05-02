INSERT INTO musikrichtung (musikrichtung)
VALUES ('EDM'), ('House'), ('Techno'), ('Garage'),
       ('UK Garage'), ('Ambient'), ('Future Bass'), ('Jungle');

INSERT INTO interpret (interpret)
VALUES ('Fred again..'), ('Skrillex'), ('Four Tet'), ('Overmono'),
       ('Flowdan'), ('The Streets'), ('Chase & Status'), ('Joy Orbison');

INSERT INTO titel (titel, beurteilung)
VALUES ('Delilah (pull me out of this)', 5), -- ID 1
       ('Jungle', 5),                         -- ID 2
       ('Baby again..', 5),                   -- ID 3
       ('Turn On The Lights again..', 5),      -- ID 4
       ('Stayinit', 5),                       -- ID 5
       ('Leavemealone', 5),                   -- ID 6
       ('Rumble', 5),                         -- ID 7
       ('Baddadan', 5),                       -- ID 8
       ('Rumble (Overmono Remix)', 5),        -- ID 9
       ('Flight fm', 5),                      -- ID 10
       ('Mike (desert island statue)', 5),    -- ID 11
       ('Strong', 5),                         -- ID 12
       ('Places to Be', 4);                   -- ID 13

INSERT INTO cd (cdname, mr_id)
VALUES ('Actual Life 3', 2),                  -- ID 1
       ('Quest For Fire', 1),                 -- ID 2
       ('USB', 5),                            -- ID 3
       ('Boiler Room: London', 5),            -- ID 4
       ('Ten Days', 7),                       -- ID 5
       ('Secret Life', 6);                    -- ID 6

INSERT INTO interpret_titel (interpret_id, titel_id) VALUES
-- Fred again
(1, 1), (1, 2),
(1, 3), (1, 4),
(1, 5), (1, 6),
(1, 11), (1, 12),
(1, 13),
-- Rumble (Skrillex)
(2, 7),
-- Baddadan (Chase & Status)
(7, 8),
-- Rumble Remix (Overmono)
(4, 9),
-- Flight fm (Joy Orbison)
(8, 10);

INSERT INTO cd_titel (cd_id, titel_id, titel_nr) VALUES
-- Actual Life 3
(1, 1, 1),
(1, 2, 2),
-- Quest For Fire
(2, 7, 1),
-- USB
(3, 3, 1), (3, 4, 2),
(3, 1, 3), (3, 8, 4),
-- Boiler Room
(4, 1, 1), (4, 2, 2), (4, 7, 3),
(4, 6, 4), (4, 10, 5), (4, 5, 6),
-- Ten Days
(5, 13, 1), (5, 12, 2), (5, 11, 3);

INSERT INTO interpret_cd (interpret_id, cd_id) VALUES
-- Actual Life 3 (Fred again..)
(1, 1),
-- Quest For Fire (Skrillex)
(2, 2),
-- USB (Fred again..)
(1, 3),
-- Boiler Room (Fred again..)
(1, 4),
-- Ten Days (Fred again..)
(1, 5),
-- Secret Life (Fred again..)
(1, 6),
-- Chase & Status
(7, 3);