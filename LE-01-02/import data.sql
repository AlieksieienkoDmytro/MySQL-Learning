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