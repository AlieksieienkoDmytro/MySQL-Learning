-- Create the 'Kunden' (Customers) table with specified columns
CREATE TABLE Kunden (
    -- Unique identifier for each customer, auto-incremented
    kunden_id int auto_increment primary key,
    -- Last name of the customer, cannot be empty
    name varchar(100) NOT NULL,
    -- First name of the customer, cannot be empty
    vorname varchar(100) NOT NULL,
    -- Email address, optional (can be NULL)
    email varchar(255) DEFAULT NULL,
    -- Phone number, cannot be empty
    telefon varchar(20) NOT NULL,
    -- Date of birth, cannot be empty
    geburtsdatum date NOT NULL
);
-- Delete the 'Kunden' table from the database
DROP TABLE Kunden;