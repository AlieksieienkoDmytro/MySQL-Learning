create or replace definer = root@localhost view cd_uebersicht as
select `cd_database`.`cd`.`cdname`                                         AS `Albumtitel`,
       group_concat(distinct `interpret_album`.`interpret` separator ', ') AS `Album-Interpret`,
       `cd_database`.`cd_titel`.`titel_nr`                                 AS `Tracknummer`,
       `cd_database`.`titel`.`titel`                                       AS `Songtitel`,
       group_concat(distinct `interpret_song`.`interpret` separator ', ')  AS `Titel-Interpret`,
       `cd_database`.`musikrichtung`.`musikrichtung`                       AS `Musikrichtung`
from (((((((`cd_database`.`cd` join `cd_database`.`musikrichtung`
            on ((`cd_database`.`cd`.`mr_id` = `cd_database`.`musikrichtung`.`mr_id`))) join `cd_database`.`cd_titel`
           on ((`cd_database`.`cd`.`cd_id` = `cd_database`.`cd_titel`.`cd_id`))) join `cd_database`.`titel`
          on ((`cd_database`.`cd_titel`.`titel_id` =
               `cd_database`.`titel`.`titel_id`))) left join `cd_database`.`interpret_cd`
         on ((`cd_database`.`cd`.`cd_id` = `cd_database`.`interpret_cd`.`cd_id`))) left join `cd_database`.`interpret` `interpret_album`
        on ((`cd_database`.`interpret_cd`.`interpret_id` =
             `interpret_album`.`interpret_id`))) left join `cd_database`.`interpret_titel`
       on ((`cd_database`.`titel`.`titel_id` =
            `cd_database`.`interpret_titel`.`titel_id`))) left join `cd_database`.`interpret` `interpret_song`
      on ((`cd_database`.`interpret_titel`.`interpret_id` = `interpret_song`.`interpret_id`)))
group by `cd_database`.`cd`.`cd_id`, `cd_database`.`cd`.`cdname`, `cd_database`.`cd_titel`.`titel_nr`,
         `cd_database`.`titel`.`titel_id`, `cd_database`.`titel`.`titel`, `cd_database`.`musikrichtung`.`musikrichtung`
order by `Albumtitel`, `Tracknummer`;

