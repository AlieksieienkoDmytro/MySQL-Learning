-- Data Cleaning: Remove duplicates before altering structure
CREATE TABLE artikel_clean AS
SELECT DISTINCT * FROM artikel;

DROP TABLE artikel;

ALTER TABLE artikel_clean
    RENAME TO artikel;

# Punkt 1: Rename the table
RENAME TABLE artikel
    TO artikelaktuell;

# Punkt 2: Rename a specific column
ALTER TABLE artikelaktuell
    RENAME COLUMN bezeichnung_artikel
        TO bezeichnung;

# Punkt 3: Change data type of 'status' column
ALTER TABLE artikelaktuell
    MODIFY status VARCHAR(300);

# Punkt 4: Set 'artikelid' as Primary Key with Auto-Increment
ALTER TABLE artikelaktuell
    MODIFY artikelid INT PRIMARY KEY AUTO_INCREMENT;

# Punkt 5: Remove Primary Key from 'artikelinfo' table
ALTER TABLE artikelinfo
    DROP PRIMARY KEY;

# Punkt 6: Add NOT NULL constraint to 'tiefe' column
ALTER TABLE artikelaktuell
    MODIFY tiefe DECIMAL(8,2) NOT NULL;

# Punkt 7: Remove NOT NULL constraint (allow NULL values)
ALTER TABLE artikelaktuell
    MODIFY tiefe DECIMAL(8,2) NULL;

# Punkt 8: Set default value for 'preis' column
ALTER TABLE artikelaktuell
    MODIFY preis DECIMAL(8,2) DEFAULT 0.00;

# Punkt 9: Remove the default value from 'preis' column
ALTER TABLE artikelaktuell
    ALTER COLUMN preis DROP DEFAULT;

# Punkt 10: Add UNIQUE constraint to 'bezeichnung' column
ALTER TABLE artikelaktuell
    MODIFY bezeichnung VARCHAR(300) UNIQUE;

# Punkt 11: Add CHECK constraint for price limit
ALTER TABLE artikelaktuell
    ADD CONSTRAINT chk_preis CHECK (preis < 1000);

# Punkt 12: Remove the previously created CHECK constraint
ALTER TABLE artikelaktuell
    DROP CONSTRAINT chk_preis;

# Punkt 13: Add a new column 'kommentar'
ALTER TABLE artikelaktuell
    ADD COLUMN kommentar VARCHAR(300);

# Punkt 14: Remove the 'kommentar' column
ALTER TABLE artikelaktuell
    DROP COLUMN kommentar;

# Punkt 15: Create a 1:n relationship (Foreign Key)
ALTER TABLE positionartikel
    ADD CONSTRAINT fk_artikelid
        FOREIGN KEY (fk_artikelinfo_artikelid) REFERENCES artikelaktuell(artikelid);

# Punkt 16: Remove the Foreign Key relationship
ALTER TABLE positionartikel
    DROP FOREIGN KEY fk_artikelid;