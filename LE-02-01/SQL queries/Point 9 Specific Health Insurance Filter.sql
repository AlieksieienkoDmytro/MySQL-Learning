# Select employees insured by either 'MH Plus Bonn' or 'IKK gesund plus'
SELECT name, vorname, krankenversicherung
FROM mitarbeiter
WHERE (krankenversicherung = 'MH Plus Bonn') or (krankenversicherung = 'IKK gesund plus');