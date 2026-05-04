CREATE TABLE IF NOT EXISTS res_top_titles AS
SELECT songtitel, bewertung, `titel-interpret`
FROM cd_uebersicht
WHERE bewertung >= 3
ORDER BY bewertung DESC, songtitel ASC;

CREATE TABLE IF NOT EXISTS res_low_rating AS
SELECT albumtitel, songtitel, bewertung
FROM cd_uebersicht
WHERE albumtitel = 'USB' AND bewertung < 3;

CREATE TABLE IF NOT EXISTS res_full_collection AS
SELECT albumtitel, songtitel, `titel-interpret`, musikrichtung
FROM cd_uebersicht
ORDER BY Albumtitel ASC;

CREATE TABLE IF NOT EXISTS res_genre_stats AS
SELECT musikrichtung, COUNT(songtitel) AS Anzahl_Songs
FROM cd_uebersicht
GROUP BY musikrichtung;
