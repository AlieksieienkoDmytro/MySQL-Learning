CREATE OR REPLACE VIEW cd_uebersicht AS
SELECT
    cd.cdname AS Albumtitel,
    GROUP_CONCAT(DISTINCT interpret_album.interpret SEPARATOR ', ') AS `Album-Interpret`,
    cd_titel.titel_nr AS Tracknummer,
    titel.titel AS Songtitel,
    GROUP_CONCAT(DISTINCT interpret_song.interpret SEPARATOR ', ') AS `Titel-Interpret`,
    musikrichtung.musikrichtung AS Musikrichtung
FROM cd
         JOIN musikrichtung
              ON cd.mr_id = musikrichtung.mr_id
         JOIN cd_titel
              ON cd.cd_id = cd_titel.cd_id
         JOIN titel
              ON cd_titel.titel_id = titel.titel_id
-- Communication for receiving album artists
         LEFT JOIN interpret_cd
                   ON cd.cd_id = interpret_cd.cd_id
         LEFT JOIN interpret AS interpret_album
                   ON interpret_cd.interpret_id = interpret_album.interpret_id
-- Communication for receiving song artists
         LEFT JOIN interpret_titel
                   ON titel.titel_id = interpret_titel.titel_id
         LEFT JOIN interpret AS interpret_song
                   ON interpret_titel.interpret_id = interpret_song.interpret_id
GROUP BY
    cd.cd_id,
    cd.cdname,
    cd_titel.titel_nr,
    titel.titel_id,
    titel.titel,
    musikrichtung.musikrichtung
ORDER BY
    Albumtitel,
    Tracknummer;