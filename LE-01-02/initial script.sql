create table Referenten
(
    id           int auto_increment
        primary key,
    name         varchar(100) null,
    email        varchar(100) null,
    organisation varchar(100) null
);

create table Teilnehmer
(
    id           int auto_increment
        primary key,
    name         varchar(100) null,
    email        varchar(100) null,
    organisation varchar(100) null
);

create table Themen
(
    id           int auto_increment
        primary key,
    titel        varchar(255) null,
    beschreibung text         null,
    referent_id  int          null,
    constraint themen_ibfk_1
        foreign key (referent_id) references Referenten (id)
);

create table Teilnehmer_nach_Themen
(
    teilnehmer_id int not null,
    themen_id     int not null,
    primary key (teilnehmer_id, themen_id),
    constraint teilnehmer_nach_themen_ibfk_1
        foreign key (teilnehmer_id) references Teilnehmer (id),
    constraint teilnehmer_nach_themen_ibfk_2
        foreign key (themen_id) references Themen (id)
);

create index themen_id
    on Teilnehmer_nach_Themen (themen_id);

create index referent_id
    on Themen (referent_id);