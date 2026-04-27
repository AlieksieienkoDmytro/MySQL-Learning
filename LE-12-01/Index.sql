-- Speed up searching for customers by their last name
CREATE INDEX kunden_nachname ON kunden(nachname);

-- Speed up product searches by their name
CREATE INDEX artikel_bezeichnung ON artikel(bezeichnung);

-- Speed up reporting by sales date
CREATE INDEX verkauf_datum ON verkauf(datum);