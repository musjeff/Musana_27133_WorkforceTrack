# Phase III – run order (Oracle XE 21c, PDB `c_27133_musana_wftrack_db`)
1. `01_create_pdb.sql` – as SYSDBA in the root: `sqlplus / as sysdba` (run Command Prompt as Administrator).
2. `02_create_user.sql` – creates `musana_admin` (DBA) inside the PDB.
3. `03_tablespaces.sql` – creates `wftrack_data`, `wftrack_idx`, `wftrack_temp` and sets the user's defaults and quotas.
4. `04_archive_log.sql` – checks the log mode (NOARCHIVELOG on this install) and explains why archive logging is a CDB setting.
5. `05_verify.sql` – the verification queries; EM Express on https://localhost:5533/em.
Note: the PDB was created and then opened with `ALTER PLUGGABLE DATABASE ... OPEN` after connecting with `sqlplus / as sysdba` (SYSDBA role), followed by `SAVE STATE`.
