# Phase II – Normalization (UNF → 1NF → 2NF → 3NF)

Real rows below come from the Kaggle *Employee/HR Dataset* (`employee_data.csv`, `employee_engagement_survey_data.csv`, stored in `data/raw/`). Attendance and task rows are not in the dataset; they are generated later (Phase IV) and shown here as examples of the planned structure.

## UNF – one wide record per employee
One employee record carries repeating lists (daily attendance, tasks) and department/supervisor facts.

| EmpID | Name | Title | Dept | DeptCode | Supervisor | Attendance (repeating) | Tasks (repeating) | Rating | Score |
|---|---|---|---|---|---|---|---|---|---|
| 1001 | Susan Exantus | Software Engineer | Software Engineering | SWE | Angela Carlson | {2025-04-01 Late 7.98h; 2025-04-02 Present 9.7h; …} | {Write unit tests – Completed; Develop feature module – In Progress; Fix reported bugs – Completed} | B | 52.0 |
| 1022 | Frederick Howe | Software Engineer | Software Engineering | SWE | Angela Carlson | {…} | {…} | B | 44.0 |
| 1029 | Brittany Hurley | Software Engineer | Software Engineering | SWE | Angela Carlson | {…} | {…} | B | – |

**Problem:** repeating groups (attendance days, tasks) in one row.

## 1NF – remove repeating groups
One row per employee per attendance day, and one row per employee per task; every cell holds one value.

| EmpID | Date | Check-in | Check-out | Hours | Status |
|---|---|---|---|---|---|
| 1001 | 2025-04-01 | 08:45 | 16:44 | 7.98 | Late |
| 1001 | 2025-04-02 | 08:26 | 18:08 | 9.70 | Present |

| EmpID | Task | Assigned | Due | Completed | Status |
|---|---|---|---|---|---|
| 1001 | Write unit tests | 2025-04-08 | 2025-04-13 | 2025-04-11 | Completed |
| 1001 | Develop feature module | 2025-04-11 | 2025-04-19 | – | In Progress |
| 1001 | Fix reported bugs | 2025-04-04 | 2025-04-09 | 2025-04-06 | Completed |

Keys: ATTENDANCE (EmpID, Date); TASKS (EmpID, Task, Assigned) – surrogate keys `attendance_id`, `task_id` are used instead.

## 2NF – remove partial dependencies
In the attendance/task rows, name, title, department and supervisor depend only on `EmpID` (part of the composite key), not on the whole key.
**Removed dependency:** partial dependency → employee facts move to **EMPLOYEES**; attendance facts (check-in, check-out, hours, status) stay in **ATTENDANCE**; task facts stay in **TASKS**; score and rating (one evaluation per employee/evaluation) go to **PRODUCTIVITY_RECORDS**.

| EMPLOYEES: employee_id | name | job_title | dept_code | dept_name | supervisor |
|---|---|---|---|---|---|
| 1001 | Susan Exantus | Software Engineer | SWE | Software Engineering | Angela Carlson |
| 1035 | Case Russell | Senior BI Developer | ADMIN | Admin Offices | Taylor Wright |
| 1022 | Frederick Howe | Software Engineer | SWE | Software Engineering | Angela Carlson |

## 3NF – remove transitive dependencies
`employee_id → dept_code → dept_name, supervisor`. Department name and supervisor depend on the department, not on the employee.
**Removed dependency:** transitive dependency → **DEPARTMENTS** (`dept_code`, `dept_name`, `supervisor_id`) and **SUPERVISORS** (`supervisor_id`, `name`).

| DEPARTMENTS: dept_code | dept_name | supervisor_id |
|---|---|---|
| SWE | Software Engineering | 4 |
| PROD | Production | 1 |
| ITIS | IT/IS | 2 |

| SUPERVISORS: supervisor_id | name |
|---|---|
| 4 | Angela Carlson |
| 1 | Margaret Lee |
| 2 | Tracey Clark |

**Design correction made in this phase:** the first version of the scripts also stored `Dept_Code` in ATTENDANCE, TASKS and PRODUCTIVITY_RECORDS and `Department` in SUPERVISORS. These were transitive dependencies (`employee_id → dept_code`; `supervisor → department` already held by DEPARTMENTS), so the columns were removed. Department is now reached by joining through EMPLOYEES.

**Documented derived columns (kept on purpose):** `attendance.hours_worked` (check_out − check_in) and `productivity_records.performance_rating` (from score) are computed by procedures and stored for fast reporting; they are the only controlled redundancy.

## Final 3NF tables
SUPERVISORS, DEPARTMENTS, EMPLOYEES, ATTENDANCE, TASKS, PRODUCTIVITY_RECORDS (+ PUBLIC_HOLIDAYS, AUDIT_LOG as support tables) – see `erd.png`.

## Field mapping (raw → target)
| Raw field (Kaggle) | Target | Conversion / note |
|---|---|---|
| EmpID | employees.employee_id | integer |
| FirstName + LastName | employees.name | concatenate; anonymise if required (see dataset card) |
| Title | employees.job_title | trim |
| DepartmentType | departments.dept_name (dept_code assigned) | trim spaces; map 6 names → codes |
| Supervisor | supervisors.name | one supervisor per department (first seen) |
| StartDate (`29-Aug-19`) | employees.hire_date | text → DATE (`DD-Mon-YY`) |
| ADEmail | employees.contact | – |
| Performance Score | productivity_records.performance_rating | Exceeds=A, Fully Meets=B, Needs Improvement=C, PIP=D |
| Current Employee Rating | productivity_records.productivity_score | 60 % of rating/5 + 40 % engagement/5, ×100 |
| Engagement Score (survey file) | productivity_records.productivity_score | joined on Employee ID |
| EmployeeStatus, ExitDate | – (filter) | only Active, no exit date loaded |
| (generated) | attendance.*, tasks.*, public_holidays.* | not in dataset – generated by a script written in Phase IV |
| DOB, State, GenderCode, RaceDesc, MaritalDesc, PayZone, BusinessUnit, Division, LocationCode, JobFunctionDescription, TerminationType/Description, EmployeeType, EmployeeClassificationType, Satisfaction Score, Work-Life Balance Score | dropped | personal/sensitive data or not needed for attendance & productivity |
