-- Name: Musana Jean Bosco | Student ID: 27133 | Group: C | Project: WorkforceTrack (Workforce Monitoring and Productivity System)
-- 01_create_pdb.sql  Run as SYSDBA in the CDB root (CDB$ROOT).
-- PDB name pattern: GroupName_StudentID_FirstName_ProjectName_DB (lowercase, <=30 chars)
-- Adjust the file-name convert paths to your own installation (SELECT name FROM v$datafile WHERE con_id=1;).
SHOW CON_NAME;

CREATE PLUGGABLE DATABASE c_27133_musana_wftrack_db
    ADMIN USER pdb_seed_admin IDENTIFIED BY "Temp#27133"   -- bootstrap admin; the real admin is created in 02
    FILE_NAME_CONVERT = ('pdbseed', 'c_27133_musana_wftrack_db');
-- If you use Oracle Managed Files (db_create_file_dest set), drop the FILE_NAME_CONVERT line.

ALTER PLUGGABLE DATABASE c_27133_musana_wftrack_db OPEN;
-- Save state so the PDB opens automatically after a CDB restart
ALTER PLUGGABLE DATABASE c_27133_musana_wftrack_db SAVE STATE;

SELECT con_id, name, open_mode FROM v$pdbs WHERE name = UPPER('c_27133_musana_wftrack_db');
