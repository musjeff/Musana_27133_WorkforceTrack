# Workforce-Monitoring-and-Productivity-Management-System-27133

# Workforce Monitoring and Productivity System

**Repository:** Musana_27133_WorkforceTrack

| | |
|---|---|
| **Student** | Musana Jean Bosco |
| **Student ID** | 27133 |
| **Course** | INSY 8311 - Database Development with PL/SQL |
| **Instructor** | Eric Maniraguha |
| **Academic year** | 2026-2027 (Semester I) |
| **Domain** | Business / Corporate Management |

---

## Problem Statement

Organizations often record attendance on paper, follow task progress only verbally, and cannot compare productivity between employees or departments. This leads to inaccurate working-hours records, late detection of absenteeism, and decisions taken without reliable data. Supervisors, HR managers and employees are all affected.

## Objectives

**Main objective:** build an Oracle database with PL/SQL that records attendance, working hours, tasks and productivity, and gives management reliable, auditable information.

**Specific objectives:**
1. Record daily attendance with check-in, check-out and hours worked.
2. Assign tasks to employees and track their completion.
3. Calculate a productivity score and performance rating per employee.
4. Block invalid entries on public holidays and weekdays and keep an audit log of every change.

## Data Source

Kaggle - [Employee/HR Dataset (All in One)](https://www.kaggle.com/datasets/ravindrasinghrana/employeedataset) by ravindrasinghrana (3,000 employee records with departments, titles, start dates, supervisor names, performance scores and engagement survey scores). Attendance check-in/check-out times and tasks are not in the dataset and will be generated for testing.

## Innovation

*Planned option (to confirm):* Analytics dashboard connected live to the Oracle database (Power BI), showing attendance, task completion and productivity per department.

## Planned Tables

Employees, Supervisors, Departments, Attendance, Tasks, Productivity_Records, Public_Holidays, Audit_Log.

## Planned PL/SQL Features

- **Procedures:** record check-in, check-out, assign task, update task status, record productivity.
- **Functions:** average productivity score, task completion rate.
- **Cursors:** list employees by department.
- **Packages:** one package grouping attendance and performance operations.
- **Triggers:** block changes on public holidays and weekdays; audit every change to attendance.
- **Exceptions:** handled in every procedure and function.

## References

*To be completed with the research log in `docs/research/research_log.md`.*

---

## Phase I – Business Process Modeling

**Selected business process:** Daily attendance recording, task assignment and productivity evaluation. An employee checks in on a valid working day, the supervisor assigns and confirms tasks, the system records check-out and hours worked and calculates a productivity score, and the HR manager reads the resulting reports. Every change is written to an audit log.

**Actors:** Employee, Supervisor, Oracle database system, HR Manager, Payroll (external stakeholder).

**Modeling tool:** diagrams.net (draw.io)

**Published diagram link:** ` PUBLISHED DRAW.IO LINK WILL BE HERE`

**Diagram (PDF):** [docs/business_process/business_process_diagram.pdf](docs/business_process/business_process_diagram.pdf)

**Supporting explanation:** [docs/business_process/business_process_explanation.pdf](docs/business_process/business_process_explanation.pdf)
