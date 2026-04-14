# Punkt 1: Create the initial table for managing gifts
CREATE TABLE Geschenke (
    geschenk_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
    artikel VARCHAR(200) NOT NULL,
    preis DECIMAL(5,2) NOT NULL,
    jahrzugehörigkeit SMALLINT NOT NULL
);

# Punkt 2: Drop the existing table to recreate it with additional constraints
DROP TABLE Geschenke;

-- Recreate the table with a UNIQUE constraint on the 'artikel' column
-- to ensure no duplicate gift names are allowed
CREATE TABLE Geschenke (
    geschenk_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
    artikel VARCHAR(200) NOT NULL UNIQUE,
    preis DECIMAL(5,2) NOT NULL,
    jahrzugehörigkeit SMALLINT NOT NULL
);

# Punkt 3: Modify the 'preis' column to set a default value of 0.00
# This ensures that if no price is provided, it defaults to zero
ALTER TABLE Geschenke
ALTER preis SET DEFAULT 0.00;

# Punkt 4: Add a CHECK constraint to the 'jahrzugehörigkeit' column
# This restricts the allowed values to only 5, 10, 15, or 20 years
ALTER TABLE Geschenke
ADD CONSTRAINT check_jahrzugehörigkeit
CHECK (jahrzugehörigkeit in (5, 10, 15, 20));