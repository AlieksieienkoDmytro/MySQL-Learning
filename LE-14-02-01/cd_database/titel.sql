create table if not exists titel
(
    titel_id    int auto_increment
        primary key,
    titel       varchar(255) not null,
    beurteilung tinyint      null
);

