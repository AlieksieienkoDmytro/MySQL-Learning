create table if not exists cd
(
    cd_id  int auto_increment
        primary key,
    cdname varchar(255) not null,
    mr_id  int          null,
    constraint cd_ibfk_1
        foreign key (mr_id) references musikrichtung (mr_id)
);

create index mr_id
    on cd (mr_id);

