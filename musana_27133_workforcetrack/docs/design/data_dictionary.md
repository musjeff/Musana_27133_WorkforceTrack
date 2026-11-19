# Data dictionary (logical – data types are added in Phase IV, see `database/scripts/tables.sql`)
R = required, U = unique, PK/FK = keys.

**SUPERVISORS** – people who manage a department.
| Column | Meaning | Req | Key |
|---|---|---|---|
| supervisor_id | Identifier | R | PK |
| name | Supervisor full name | R | |

**DEPARTMENTS** – 1 supervisor manages 1 department; 1 department has many employees.
| dept_code | Short code (PROD, ITIS, SALES, SWE, ADMIN, EXEC) | R | PK |
| dept_name | Department name | R, U | |
| supervisor_id | Managing supervisor | R, U | FK → supervisors |

**EMPLOYEES** – each employee belongs to exactly one department.
| employee_id | Employee number (from dataset EmpID) | R | PK |
| name | Full name | R | |
| job_title | Position | | |
| dept_code | Department | R | FK → departments |
| hire_date | Start date | | |
| contact | Work email | U | |

**ATTENDANCE** – one row per employee per working day.
| attendance_id | Identifier | R | PK |
| employee_id | Who | R | FK → employees |
| attendance_date | Working day | R | U with employee_id |
| check_in / check_out | Times (null when absent); check_out ≥ check_in | | |
| hours_worked | Derived hours | | |
| status | Present, Late or Absent | R | |

**TASKS** – work assigned to an employee by the supervisor.
| task_id | Identifier | R | PK |
| employee_id | Assignee | R | FK → employees |
| task_title | What to do | R | |
| assigned_date / due_date / completed_date | Dates (due ≥ assigned; completed null until done) | assigned R | |
| status | Pending, In Progress, Completed | R | |

**PRODUCTIVITY_RECORDS** – evaluations (zero or many per employee).
| record_id | Identifier | R | PK |
| employee_id | Evaluated employee | R | FK → employees |
| productivity_score | 0–100 | R | |
| performance_rating | Letter A–D | R | |

*Known limitation:* the 100 loaded records carry the letter from the dataset's own *Performance Score* category (Exceeds/Fully Meets/…), whereas records created through `RecordProductivity` derive the letter from score thresholds (A ≥ 85, B ≥ 70, C ≥ 55, else D). Phase IV cleaning can recompute the loaded letters from the score if one rule is preferred.

**PUBLIC_HOLIDAYS** – holiday_date (PK): dates on which the restriction trigger blocks changes.
**AUDIT_LOG** – audit_id (PK), table_name, operation (INSERT/UPDATE/DELETE/DENIED-…), changed_by, change_timestamp, old_value, new_value. Written only by triggers.

## Relationships (cardinality / optionality)
- SUPERVISORS 1—1 DEPARTMENTS (both mandatory)
- DEPARTMENTS 1—M EMPLOYEES (a department has ≥1 employees; employee has exactly 1 department)
- EMPLOYEES 1—M ATTENDANCE, TASKS, PRODUCTIVITY_RECORDS (an employee may have zero or many; each row has exactly one employee)
- No many-to-many relationship exists, so no junction table is needed; AUDIT_LOG and PUBLIC_HOLIDAYS are standalone support tables.
