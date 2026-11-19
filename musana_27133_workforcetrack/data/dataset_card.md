# Dataset card – WorkforceTrack

| Item | Value |
|---|---|
| Name | Employee/HR Dataset (All in One) |
| Source | https://www.kaggle.com/datasets/ravindrasinghrana/employeedataset (author: ravindrasinghrana) |
| Licence | **WRITE HERE the licence shown on the Kaggle page** (must allow educational use) |
| Format | CSV (UTF-8) |
| Files used | `employee_data.csv` (3,000 rows × 26 columns), `employee_engagement_survey_data.csv` (3,000 rows) |
| Size | employee file about 760 KB |
| Date collected | 19 November 2026 |
| One record represents | One employee (employee file); one engagement survey response for one employee (survey file) |
| Files not used | `recruitment_data.csv`, `training_and_development_data.csv` (not needed for attendance and productivity) |
| Personal data | Names, e-mails and dates of birth are present but the dataset is synthetic (fictional people). DOB, gender, race, marital status and state are not loaded into the database. |

Raw files are stored unchanged in `data/raw/`.

## Quality report (counts; nothing is fixed in Phase II – cleaning happens in Phase IV)
| # | Check | Count | Phase IV fix |
|---|---|---|---|
| 1 | Employee rows / survey rows | 3,000 / 3,000 | – |
| 2 | Duplicate EmpID values | 0 | – |
| 3 | Duplicate e-mail addresses | 2 | Check before making `contact` unique |
| 4 | Missing ExitDate and TerminationDescription | 1,467 each (employees who never left) | Keep as NULL |
| 5 | DepartmentType with extra spaces ("Production" has trailing spaces) | 2,020 rows | TRIM; 6 distinct departments after trimming |
| 6 | StartDate, ExitDate and DOB stored as text | 3,000 / 1,533 / 3,000 | TO_DATE; StartDate/ExitDate use `DD-Mon-YY`, DOB uses `DD-MM-YYYY` |
| 7 | EmployeeStatus "Active" but ExitDate filled in | 991 rows | Load only Active employees with no ExitDate |
| 8 | TerminationType = "Unk" (unknown placeholder) | 1,467 | Not loaded |
| 9 | Supervisor names per department | about one different name per employee (e.g. 1,998 names for 2,020 Production rows) | Simplified: one supervisor per department |
| 10 | Survey Employee IDs with no matching employee | 0 | – |
| 11 | Employees with no survey row | 0 | – |
| 12 | Ratings outside 1–5 | 0 | – |

Other facts: 6 departments (Production 2,020; IT/IS 430; Sales 331; Software Engineering 115; Admin Offices 80; Executive Office 24); EmployeeStatus: Active 2,458, Voluntarily Terminated 321, Leave of Absence 86, Future Start 69, Terminated for Cause 66; Performance Score: Fully Meets 2,361, Exceeds 369, Needs Improvement 177, PIP 93.

Missing from the dataset (generated and labelled by a script written in Phase IV): daily attendance, tasks, public holidays.
