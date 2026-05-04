create table if not exists res_full_collection
(
    albumtitel        varchar(255) not null,
    songtitel         varchar(255) not null,
    `titel-interpret` text         null,
    musikrichtung     varchar(255) not null
);

