-- Name: Musana Jean Bosco | Student ID: 27133 | Group: C | Project: WorkforceTrack (Workforce Monitoring and Productivity System)
-- 05_verify.sql  Run as SYSDBA. Take screenshots showing the PDB name and the date.
SET LINESIZE 200 PAGESIZE 100
COLUMN name FORMAT A30
COLUMN con_name FORMAT A30
COLUMN username FORMAT A15
COLUMN default_tablespace FORMAT A20
COLUMN temporary_tablespace FORMAT A20
COLUMN tablespace_name FORMAT A15

-- Part A: from the root
CONNECT / AS SYSDBA
SELECT SYSDATE AS run_at FROM dual;
-- (a) the PDB exists and is open; its state is saved
SELECT con_id, name, open_mode FROM v$pdbs WHERE name = 'C_27133_MUSANA_WFTRACK_DB';
SELECT con_name, state FROM dba_pdb_saved_states WHERE con_name = 'C_27133_MUSANA_WFTRACK_DB';
-- (d) archive log mode (CDB-level)
SELECT log_mode FROM v$database;

-- Part B: inside the PDB
ALTER SESSION SET CONTAINER = c_27133_musana_wftrack_db;
-- (b) admin user defaults
SELECT username, default_tablespace, temporary_tablespace FROM dba_users WHERE username = 'MUSANA_ADMIN';
-- (c) tablespaces: size, autoextend, maximum size
SELECT tablespace_name, ROUND(bytes/1024/1024) AS size_mb, autoextensible, ROUND(maxbytes/1024/1024) AS max_mb FROM dba_data_files WHERE tablespace_name LIKE 'WFTRACK%';
SELECT tablespace_name, ROUND(bytes/1024/1024) AS size_mb, autoextensible, ROUND(maxbytes/1024/1024) AS max_mb FROM dba_temp_files WHERE tablespace_name LIKE 'WFTRACK%';

-- EM Express (HTTPS port 55xx, xx = last two digits of ID 27133 -> 5533)
EXEC DBMS_XDB_CONFIG.SETHTTPSPORT(5533);
SELECT DBMS_XDB_CONFIG.GETHTTPSPORT FROM dual;
-- open https://localhost:5533/em and log in as musana_admin / musana
