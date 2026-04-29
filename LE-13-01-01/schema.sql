CREATE DATABASE IF NOT EXISTS cd_database;
USE cd_database;

CREATE TABLE IF NOT EXISTS interpret (
    interpret_id INT AUTO_INCREMENT PRIMARY KEY,
    interpret VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS musikrichtung (
    mr_id INT AUTO_INCREMENT PRIMARY KEY,
    musikrichtung VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS titel (
    titel_id INT AUTO_INCREMENT PRIMARY KEY,
    titel VARCHAR(255) NOT NULL,
    interpret_id INT,
    beurteilung TINYINT,
    FOREIGN KEY (interpret_id) REFERENCES interpret(interpret_id)
);

CREATE TABLE IF NOT EXISTS cd (
    cd_id INT AUTO_INCREMENT PRIMARY KEY,
    cdname VARCHAR(255) NOT NULL,
    interpret_id INT,
    mr_id INT,
    FOREIGN KEY (interpret_id) REFERENCES interpret(interpret_id),
    FOREIGN KEY (mr_id) REFERENCES musikrichtung(mr_id)
);

CREATE TABLE IF NOT EXISTS cd_titel (
    cd_id INT,
    titel_id INT,
    titel_nr INT,
    PRIMARY KEY (cd_id, titel_id),
    FOREIGN KEY (cd_id) REFERENCES cd(cd_id),
    FOREIGN KEY (titel_id) REFERENCES titel(titel_id)
);