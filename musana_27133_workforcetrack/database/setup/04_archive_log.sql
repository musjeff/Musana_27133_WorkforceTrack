-- Name: Musana Jean Bosco | Student ID: 27133 | Group: C | Project: WorkforceTrack (Workforce Monitoring and Productivity System)
-- 04_archive_log.sql  Run as SYSDBA.
-- WHY ARCHIVE LOGGING CANNOT BE ENABLED FOR ONE PDB:
-- All PDBs in a container share ONE set of redo logs and ONE control file, which belong to the CDB
-- instance. Archiving copies those shared redo logs, so ARCHIVELOG is a CDB-level setting changed only
-- while the CDB is mounted (needs SYSDBA and a restart). A PDB can only inherit the CDB's mode.

-- 1) Check the current mode (safe on any server)
SELECT name, log_mode FROM v$database;
ARCHIVE LOG LIST;

-- 2) LOCAL INSTALLATION ONLY - do NOT run on the shared lab server
-- SHUTDOWN IMMEDIATE;
-- STARTUP MOUNT;
-- ALTER DATABASE ARCHIVELOG;
-- ALTER DATABASE OPEN;
-- ALTER PLUGGABLE DATABASE ALL OPEN;
-- SELECT log_mode FROM v$database;   -- expect ARCHIVELOG
