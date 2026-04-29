CREATE OR REPLACE VIEW cd_uebersicht AS
SELECT
    cd.cdname AS 'Albumtitel',
    interpret_cd.interpret AS 'Album-Interpret',
    cd_titel.titel_nr AS 'Tracknummer',
    titel.titel AS 'Songtitel',
    interpret_titel.interpret AS 'Titel-Interpret',
    musikrichtung.musikrichtung AS 'Musikrichtung'
FROM cd_titel
         JOIN cd ON cd_titel.cd_id = cd.cd_id
         JOIN titel ON cd_titel.titel_id = titel.titel_id
         JOIN interpret AS interpret_cd ON cd.interpret_id = interpret_cd.interpret_id
         JOIN interpret AS interpret_titel ON titel.interpret_id = interpret_titel.interpret_id
         JOIN musikrichtung ON cd.mr_id = musikrichtung.mr_id
ORDER BY cd.cdname,  cd_titel.titel_nr;