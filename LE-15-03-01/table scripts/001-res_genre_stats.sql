create table if not exists res_genre_stats
(
    musikrichtung varchar(255)     not null,
    Anzahl_Songs  bigint default 0 not null
);

