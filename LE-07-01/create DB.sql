CREATE DATABASE IF NOT EXISTS bibliothek;
USE bibliothek;

CREATE TABLE Verlag (
                        verlag_id INT AUTO_INCREMENT PRIMARY KEY,
                        verlag VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Fachbuch (
                          fachbuch_id INT AUTO_INCREMENT PRIMARY KEY,
                          ISBN VARCHAR(20) NOT NULL UNIQUE,
                          titel VARCHAR(255) NOT NULL,
                          verlag_id INT,
                          FOREIGN KEY (verlag_id) REFERENCES Verlag(verlag_id)
);

CREATE TABLE Fachbereich (
                             fachbereich_id INT AUTO_INCREMENT PRIMARY KEY,
                             titel VARCHAR(100) NOT NULL
);

CREATE TABLE Fachbereich_Fachbuch (
                                      fachbereich_id INT,
                                      fachbuch_id INT,
                                      FOREIGN KEY (fachbereich_id) REFERENCES Fachbereich(fachbereich_id),
                                      FOREIGN KEY (fachbuch_id) REFERENCES Fachbuch(fachbuch_id)
);