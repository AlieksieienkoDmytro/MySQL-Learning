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

INSERT INTO Referenten (id, name, email, organisation) VALUES (1, 'Dima', 'test@gmail.com', 'SZF');
INSERT INTO Referenten (id, name, email, organisation) VALUES (2, 'Volodia', 'volodia@gmail.com', 'SZF');

INSERT INTO Teilnehmer (id, name, email, organisation) VALUES (1, 'Dima', 'dima@gmail.com', null);
INSERT INTO Teilnehmer (id, name, email, organisation) VALUES (2, 'Nazar', 'nazar@gmail.com', null);
INSERT INTO Teilnehmer (id, name, email, organisation) VALUES (3, 'Michael', 'michael@gmail.com', null);
INSERT INTO Teilnehmer (id, name, email, organisation) VALUES (4, 'Bimbim', 'python@gmail.com', null);

INSERT INTO Themen (id, titel, beschreibung, referent_id) VALUES (1, 'C', 'C unterricht', 1);
INSERT INTO Themen (id, titel, beschreibung, referent_id) VALUES (2, 'Python', 'Python unterricht', 1);
INSERT INTO Themen (id, titel, beschreibung, referent_id) VALUES (3, 'JS', 'JS unterricht', 2);
INSERT INTO Themen (id, titel, beschreibung, referent_id) VALUES (4, 'C#', 'C# unterricht', 1);

INSERT INTO Teilnehmer_nach_Themen (teilnehmer_id, themen_id) VALUES (3, 1);
INSERT INTO Teilnehmer_nach_Themen (teilnehmer_id, themen_id) VALUES (4, 2);
INSERT INTO Teilnehmer_nach_Themen (teilnehmer_id, themen_id) VALUES (2, 3);
INSERT INTO Teilnehmer_nach_Themen (teilnehmer_id, themen_id) VALUES (1, 4);