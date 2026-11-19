# Phase I process to database mapping

| # | Process activity (Phase I) | Actor | Operation | Table(s) | PL/SQL component |
|---|---|---|---|---|---|
| 1 | Check in | Employee | Create | Attendance | `InsertAttendance` / `EmployeeManagement.MarkAttendance` |
| 2 | Validate working day / holiday | System | Retrieve | Public_Holidays | Trigger `Block_Weekday_And_Holiday_Changes` |
| 3 | Assign task | Supervisor | Create | Tasks | `AssignTask` |
| 4 | Update task progress | Employee | Update | Tasks | `UpdateTaskStatus` |
| 5 | Check out, calculate hours | Employee / System | Update | Attendance | `CheckOut` |
| 6 | Confirm task completion | Supervisor | Update | Tasks | `UpdateTaskStatus` |
| 7 | Record productivity evaluation | Supervisor | Create | Productivity_Records | `RecordProductivity`, `AvgProductivityScore`, `TaskCompletionRate` |
| 8 | Audit every change | System | Create | audit_log | Trigger `trg_audit_attendance` |
| 9 | View reports | HR Manager | Retrieve | Employees, Departments, Attendance, Tasks, Productivity_Records | Cursor (employees by department), `GetPerformanceRating` |
| 10 | Correct a wrong entry | Supervisor | Update (never delete) | Attendance | Update, recorded by the audit trigger |
