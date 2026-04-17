CREATE DATABASE IF NOT EXISTS Banküberweisungen;
USE Banküberweisungen;

CREATE TABLE Accounts (
                          KontoID INT AUTO_INCREMENT PRIMARY KEY,
                          Kontonummer VARCHAR(20) NOT NULL UNIQUE,
                          Kontoinhaber VARCHAR(100) NOT NULL,
                          Kontostand DECIMAL(15, 2) NOT NULL
);

CREATE TABLE Transactions (
                              transaction_id INT AUTO_INCREMENT PRIMARY KEY,
                              KontoID INT NOT NULL,
                              amount DECIMAL(15, 2) NOT NULL,
                              transaction_type VARCHAR(20) NOT NULL,
                              transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                              FOREIGN KEY (KontoID) REFERENCES Accounts(KontoID)
);

INSERT INTO Accounts (Kontonummer, Kontoinhaber, Kontostand)
VALUES ('DE1234567890', 'Max Mustermann', 5000.00),
       ('DE0987654321', 'Erika Musterfrau', 3000.00),
       ('DE1122334455', 'Hans Müller', 7000.00);

CREATE PROCEDURE transfer (
    IN sender_id INT,
    IN receiver_id INT,
    IN amount DECIMAL(15, 2)
)

BEGIN
    -- Local variable to check the balance after the update
    DECLARE sender_balance DECIMAL(15, 2);

    -- Ensure the operation is atomic (all steps must succeed or none at all)
    START TRANSACTION;

    -- Deduct the specified amount from the sender's balance
    UPDATE Accounts
    SET Kontostand = Kontostand - amount
    WHERE KontoID = sender_id;

    -- Fetch the updated balance to verify if the account has enough funds
    SELECT Kontostand
    INTO sender_balance
    FROM Accounts
    WHERE KontoID = sender_id;

    -- Validation logic
    IF sender_balance < 0 THEN
        -- If balance is insufficient, undo all changes and exit
        ROLLBACK;
        SELECT 'Unzureichender Kontostand für die Überweisung.' AS MESSAGE;
    ELSE
        -- Add the amount to the receiver's balance
        UPDATE Accounts
        SET Kontostand = Kontostand + amount
        WHERE KontoID = receiver_id;

        -- Record the withdrawal for the sender in the transaction history
        INSERT INTO Transactions (KontoID, amount, transaction_type)
        VALUES (sender_id, amount, 'ÜBERWEISUNG');

        -- Record the deposit for the receiver in the transaction history
        INSERT INTO Transactions (KontoID, amount, transaction_type)
        VALUES (receiver_id, amount, 'EINZAHLUNG');

        -- Provide a success message
        SELECT 'Überweisung erfolgreich.' AS MESSAGE;

        -- Display the final balances of both accounts after the transaction
        SELECT *
        FROM Accounts
        WHERE KontoID IN (sender_id, receiver_id);

        -- Finalize and save all changes permanently
        COMMIT;
    END IF;
end;