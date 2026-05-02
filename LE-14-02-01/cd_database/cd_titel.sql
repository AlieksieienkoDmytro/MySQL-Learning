create table if not exists cd_titel
(
    cd_id    int not null,
    titel_id int not null,
    titel_nr int null,
    primary key (cd_id, titel_id),
    constraint cd_titel_ibfk_1
        foreign key (cd_id) references cd (cd_id),
    constraint cd_titel_ibfk_2
        foreign key (titel_id) references titel (titel_id)
);

create index titel_id
    on cd_titel (titel_id);

