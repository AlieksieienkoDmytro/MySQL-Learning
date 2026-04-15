CREATE DATABASE IF NOT EXISTS Banküberweisungen;
USE Banküberweisungen;

CREATE TABLE Accounts (
                          KontoID INT AUTO_INCREMENT PRIMARY KEY,
                          Kontonummer VARCHAR(20) NOT NULL UNIQUE,
                          Kontoinhaber VARCHAR(100) NOT NULL,
                          Kontostand DECIMAL(15, 2) NOT NULL
);

ALTER TABLE Accounts
    ADD CONSTRAINT chk_Kontostand
        CHECK (Kontostand >= 0);

CREATE TABLE Transactions (
                              transaction_id INT AUTO_INCREMENT PRIMARY KEY,
                              KontoID INT NOT NULL,
                              amount DECIMAL(15, 2) NOT NULL,
                              transaction_type ENUM('EINZAHLUNG', 'AUSZAHLUNG', 'ÜBERWEISUNG') NOT NULL,
                              transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                              FOREIGN KEY (KontoID) REFERENCES Accounts(KontoID)
);

INSERT INTO Accounts (Kontonummer, Kontoinhaber, Kontostand)
VALUES ('DE1234567890', 'Max Mustermann', 5000.00),
       ('DE0987654321', 'Erika Musterfrau', 3000.00),
       ('DE1122334455', 'Hans Müller', 7000.00);