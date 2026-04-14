# Punkt 1: Create a new user named 'dima' with the password 'secret'
CREATE USER dima
IDENTIFIED BY 'secret';

-- Grant permissions to read, insert, and update the 'artikel' table
GRANT SELECT, INSERT, UPDATE
ON artikel
TO dima;


# Punkt 2: Revoke all previously granted permissions on the 'artikel' table
REVOKE ALL
ON artikel
FROM dima;

-- Remove the user 'dima' from the system
DROP USER dima;


# Punkt 3:
-- 1. Create a new role named 'vertrieb' (sales)
CREATE ROLE vertrieb;

-- 2. Grant permissions to the role for reading, inserting, and updating 'artikel'
GRANT SELECT, INSERT, UPDATE
ON artikel
TO vertrieb;

-- 3. Create two new users: 'franz' and 'maria'
CREATE USER franz IDENTIFIED BY 'secret',
            maria IDENTIFIED BY 'secret';

-- 4. Assign the 'vertrieb' role to both users and set it as their default role
GRANT vertrieb TO franz, maria;
SET DEFAULT ROLE vertrieb TO franz, maria;

-- 5. Modify role permissions: Revoke INSERT and UPDATE, leaving only SELECT (read-only)
REVOKE INSERT, UPDATE
ON artikel
FROM vertrieb;

-- 6. Cleanup: Revoke the role from users and remove all permissions from the role
REVOKE vertrieb
FROM franz, maria;

REVOKE ALL
ON artikel
FROM vertrieb;

-- 7. Final step: Delete the role and the users
DROP ROLE vertrieb;
DROP USER franz, maria;