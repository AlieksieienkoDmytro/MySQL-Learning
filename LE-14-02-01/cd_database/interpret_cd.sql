create table if not exists interpret_cd
(
    interpret_id int not null,
    cd_id        int not null,
    primary key (interpret_id, cd_id),
    constraint interpret_cd_ibfk_1
        foreign key (interpret_id) references interpret (interpret_id),
    constraint interpret_cd_ibfk_2
        foreign key (cd_id) references cd (cd_id)
);

create index cd_id
    on interpret_cd (cd_id);

