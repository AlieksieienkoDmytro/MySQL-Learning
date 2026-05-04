CREATE DATABASE IF NOT EXISTS sportverein;
USE sportverein;

CREATE TABLE IF NOT EXISTS teams (
    team_id INT AUTO_INCREMENT PRIMARY KEY,
    teamname VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS spieler (
    spieler_id INT AUTO_INCREMENT PRIMARY KEY,
    vorname VARCHAR(100) NOT NULL,
    nachname VARCHAR(100) NOT NULL,
    geburtsdatum DATE
);

CREATE TABLE IF NOT EXISTS trainer (
    trainer_id INT AUTO_INCREMENT PRIMARY KEY,
    vorname VARCHAR(100) NOT NULL,
    nachname VARCHAR(100) NOT NULL,
    gehalt DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS ausbildungen (
    ausbildung_id INT AUTO_INCREMENT PRIMARY KEY,
    bezeichnung VARCHAR(255),
    datum DATE
);

CREATE TABLE IF NOT EXISTS spieler_teams (
    spieler_id INT,
    team_id INT,
    PRIMARY KEY (spieler_id, team_id),
    FOREIGN KEY (spieler_id) REFERENCES Spieler(spieler_id),
    FOREIGN KEY (team_id) REFERENCES Teams(team_id)
);

CREATE TABLE IF NOT EXISTS trainer_teams (
    trainer_id INT,
    team_id INT,
    PRIMARY KEY (trainer_id, team_id),
    FOREIGN KEY (trainer_id) REFERENCES Trainer(trainer_id),
    FOREIGN KEY (team_id) REFERENCES Teams(team_id)
);

CREATE TABLE IF NOT EXISTS trainer_ausbildungen (
    trainer_id INT,
    ausbildung_id INT,
    PRIMARY KEY (trainer_id, ausbildung_id),
    FOREIGN KEY (trainer_id) REFERENCES Trainer(trainer_id),
    FOREIGN KEY (ausbildung_id) REFERENCES Ausbildungen(ausbildung_id)
);