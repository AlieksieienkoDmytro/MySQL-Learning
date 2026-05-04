-- Query 1: Create table for Players with Teams
CREATE TABLE IF NOT EXISTS report_players_teams AS
SELECT s.nachname, s.vorname, t.teamname
FROM spieler s
         JOIN spieler_teams st ON s.spieler_id = st.spieler_id
         JOIN teams t ON st.team_id = t.team_id
ORDER BY s.nachname ASC;

-- Query 2: Create table for Trainers by Education
CREATE TABLE IF NOT EXISTS report_trainers_education AS
SELECT a.bezeichnung AS Ausbildung, tr.nachname, tr.vorname
FROM ausbildungen a
         JOIN trainer_ausbildungen ta ON a.ausbildung_id = ta.ausbildung_id
         JOIN trainer tr ON ta.trainer_id = tr.trainer_id
ORDER BY a.bezeichnung ASC;

-- Query 3: Create table for Players and their Trainers
CREATE TABLE IF NOT EXISTS report_players_and_trainers AS
SELECT DISTINCT s.nachname AS Spieler_Nachname, s.vorname AS Spieler_Vorname, t.teamname, tr.nachname AS Trainer_Nachname
FROM spieler s
         JOIN spieler_teams st ON s.spieler_id = st.spieler_id
         JOIN teams t ON st.team_id = t.team_id
         JOIN trainer_teams tt ON t.team_id = tt.team_id
         JOIN trainer tr ON tt.trainer_id = tr.trainer_id;

-- Query 4: Create table for Salary Increase Report
CREATE TABLE IF NOT EXISTS report_salary_increase AS
SELECT vorname, nachname, gehalt AS neues_gehalt
FROM trainer;