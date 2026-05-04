UPDATE musikrichtung
SET musikrichtung = 'Electronic Dance Music'
WHERE musikrichtung = 'EDM';

UPDATE musikrichtung
SET musikrichtung = 'Deep House'
WHERE musikrichtung = 'House';

DELETE FROM cd WHERE mr_id IS NULL;