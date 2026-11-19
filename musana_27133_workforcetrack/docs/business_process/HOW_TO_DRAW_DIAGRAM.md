# Phase I diagram – you must draw this yourself in draw.io (rules forbid AI-made or imported diagrams)
Your old `BPMN.png` was the *student attendance* diagram, so it was removed. Redraw it in https://app.diagrams.net/ (BPMN shapes, 4 swimlanes) following your own explanation PDF:

**Lanes:** Employee · Supervisor · System (Oracle DB) · HR Manager (Payroll as a small external box)
1. Employee – *Start: working day opens* → **Check in** [CREATE Attendance].
2. System – **Check date: valid working day / not holiday?** (gateway; reads Public_Holidays [RETRIEVE]). NO → *End: entry rejected (audited as DENIED)*. YES → **Store attendance record** [CREATE].
3. Supervisor – **Assign task** [CREATE Tasks, status Pending] → Employee **Update task status** [UPDATE Tasks].
4. Employee – **Check out** → System **Calculate hours worked** [UPDATE Attendance].
5. Supervisor – gateway **Task completed?** YES → **Confirm completion** [UPDATE Tasks: Completed]; NO → *carry over to next day* (loop back to step 3/4).
6. Supervisor – **Record productivity evaluation** [CREATE Productivity_Records].
7. System – **Write audit entry** [CREATE audit_log] (after every change).
8. HR Manager – **View reports** [RETRIEVE Employees, Attendance, Tasks, Productivity] → gateway **Productivity below acceptable level?** YES → **Flag for coaching/training**; NO → *End*. Payroll receives hours worked (message flow).
9. Mark every data activity with a small label C / R / U / D (colour-coded) and add a legend. Correction path: Supervisor **Correct wrong entry** [UPDATE, never delete].

**Publish:** File → Publish → Link, set "anyone with the link", test in an incognito window, export the PDF as `business_process_diagram.pdf` into this folder, and paste the link in the README.
Mapping of each activity to tables/procedures: `process_to_database_mapping.md` (already correct).
