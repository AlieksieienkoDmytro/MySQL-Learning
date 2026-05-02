create table if not exists interpret_titel
(
    interpret_id int not null,
    titel_id     int not null,
    primary key (interpret_id, titel_id),
    constraint interpret_titel_ibfk_1
        foreign key (interpret_id) references interpret (interpret_id),
    constraint interpret_titel_ibfk_2
        foreign key (titel_id) references titel (titel_id)
);

create index titel_id
    on interpret_titel (titel_id);

