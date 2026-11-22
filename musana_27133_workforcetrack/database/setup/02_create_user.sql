-- Name: Musana Jean Bosco | Student ID: 27133 | Group: C | Project: WorkforceTrack (Workforce Monitoring and Productivity System)
-- 02_create_user.sql  Run as SYSDBA, inside the new PDB.
ALTER SESSION SET CONTAINER = c_27133_musana_wftrack_db;

-- Lab-only convention: password = first name. Never use weak passwords on a real system.
CREATE USER musana_admin IDENTIFIED BY musana;
GRANT DBA TO musana_admin;
GRANT CREATE SESSION TO musana_admin;

-- Confirm: connect musana_admin/musana@//localhost:1521/c_27133_musana_wftrack_db  (take a screenshot)
-- SHOW USER;  SHOW CON_NAME;
