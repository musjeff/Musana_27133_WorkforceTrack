# Workforce Monitoring and Productivity System (WorkforceTrack)

- **Student:** Musana Jean Bosco · **ID:** 27133 · **Group:** <your group>
- **Course:** INSY 8311 – Database Development with PL/SQL · **Instructor:** Eric Maniraguha · AUCA, 2026-2027 Semester I
- **Repository:** Musana_27133_WorkforceTrack

## Problem statement
Organisations that record attendance, hours and tasks on paper or spreadsheets get inaccurate, alterable data and cannot compare productivity between departments. Long-term absence reduces firm revenue and productivity (Aarstad & Kvitastein, 2023). Supervisors and HR managers need a reliable, auditable record.

## Objectives
**Main:** build a secure, auditable Oracle database that tracks attendance, tasks and productivity per employee and department.
**Specific:** (1) model the attendance → task → evaluation process and normalise to 3NF; (2) implement procedures, functions, a cursor and a package; (3) enforce rules with triggers and audit every change; (4) give users a web interface and dashboard on the live database.

## Data source
Kaggle – [Employee/HR Dataset (All in One)](https://www.kaggle.com/datasets/ravindrasinghrana/employeedataset) (`employee_data.csv`, `employee_engagement_survey_data.csv`). Real: 100 active employees, 6 departments, supervisors, titles, start dates, ratings, engagement. **Generated (not in dataset):** 1,900 attendance rows (April 2025), 181 tasks, demo public holidays – a script written in Phase IV. Details and quality report: [data/dataset_card.md](data/dataset_card.md).

## Innovation
Option **User interface + security view**: a Python Streamlit app connected to the Oracle database that calls the PL/SQL procedures, with a dashboard of KPIs and an audit tab showing denied actions (to be built and demonstrated in Phase VII).

## Planned tables and PL/SQL features
Tables: Supervisors, Departments, Employees, Attendance, Tasks, Productivity_Records, Public_Holidays, Audit_Log (3NF – [docs/design](docs/design/)).
PL/SQL: procedures InsertAttendance, CheckOut, AssignTask, UpdateTaskStatus, RecordProductivity; functions AvgProductivityScore, TaskCompletionRate; parameterised cursor; package EmployeeManagement; restriction trigger (no attendance changes Mon–Fri or on public holidays, denied attempts logged); audit triggers on Attendance and Tasks.

## Repository map
| Phase | Where |
|---|---|
| 0 Research, proposal, slides | `docs/research/research_log.md`, `docs/proposal/`, `docs/presentation/` |
| I Business process | `docs/business_process/` |
| II Data sourcing, normalisation, ERD, dictionary | `data/`, `docs/design/` |

## Phase I – Business Process Modeling
**Selected process:** daily attendance recording, task assignment and productivity evaluation. An employee checks in on a valid working day, the supervisor assigns and confirms tasks, the system records check-out and hours and the supervisor records a productivity evaluation; HR reads the reports; every change is audited.
**Actors:** Employee, Supervisor, Oracle database system, HR Manager, Payroll (external).
**Modeling tool:** diagrams.net (draw.io)
**Published diagram link:** `PASTE YOUR PUBLISHED DRAW.IO LINK HERE`
**Diagram (PDF):** [docs/business_process/business_process_diagram.pdf](docs/business_process/business_process_diagram.pdf)
**Explanation:** [docs/business_process/business_process_explanation.pdf](docs/business_process/business_process_explanation.pdf) · **Mapping:** [process_to_database_mapping.md](docs/business_process/process_to_database_mapping.md)

## Phase II – Normalisation and logical design
[normalization.md](docs/design/normalization.md) (UNF→3NF with real rows and field mapping) · [erd.png](docs/design/erd.png) · [data_dictionary.md](docs/design/data_dictionary.md)

## Tools
Oracle Database 21c, SQL Developer, draw.io, Python (pandas, Streamlit, python-oracledb), GitHub.

## References (APA)
- Aarstad, J., & Kvitastein, O. A. (2023). Effect of long-term absenteeism on the operating revenues, productivity, and employment of enterprises. *Administrative Sciences, 13*(6), 156. https://doi.org/10.3390/admsci13060156
- Madyatmadja, E. D., & Adora, C. (2019). Designing and using a MySQL database for human resource management. *Advances in Science, Technology and Engineering Systems Journal, 4*(6), 285–290. https://doi.org/10.25046/aj040636
- Oracle. (n.d.). *Oracle Database PL/SQL language reference, 21c: PL/SQL triggers*. https://docs.oracle.com/en/database/oracle/oracle-database/21/lnpls/plsql-triggers.html
- ravindrasinghrana. (n.d.). *Employee/HR dataset (All in One)* [Data set]. Kaggle. https://www.kaggle.com/datasets/ravindrasinghrana/employeedataset

*"Whatever you do, work at it with all your heart." – Colossians 3:23*
