# Workforce Monitoring and Productivity System (WorkforceTrack)

- **Student:** Musana Jean Bosco · **ID:** 27133 · **Group:** <your group>
- **Course:** INSY 8311 – Database Development with PL/SQL · **Instructor:** Eric Maniraguha · AUCA, 2026-2027 Semester I
- **Repository:** Musana_27133_WorkforceTrack

## Phase III – PDB creation
PDB `c_27133_musana_wftrack_db`, admin `musana_admin`, tablespaces `wftrack_data/idx/temp`, EM Express port 5533. Scripts: `database/setup/`, evidence: `screenshots/`.

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
**Published diagram link:** `https://viewer.diagrams.net/?tags=%7B%7D&lightbox=1&highlight=0000ff&edit=_blank&layers=1&nav=1&title=workforce-track-bussiness-process.io.drawio&dark=auto#R%3Cmxfile%3E%3Cdiagram%20name%3D%22Page-1%22%20id%3D%22OSYf2NrhQzPhhY8aSy27%22%3E7V1bd5u4Fv41WavnIVkS4vqYOEl71mpPe5o57fRplgxyzBQjH4ybuL9%2BJECOEXKMBcK4M3lojQBh69v69kV7iws0WTy%2FzfBy%2FoFGJLmwQPR8gW4vLMu3EfuXN2zKBttxy4bHLI7KJvjS8BD%2FJFUjqFrXcURWtQtzSpM8XtYbQ5qmJMxrbTjL6FP9shlN6k9d4kfSaHgIcdJs%2FRpH%2Bbz6WQ54aX9H4se5eDIE1ZkFFhdXDas5jujTThO6u0CTjNK8%2FLR4npCEj50Yl%2FK%2B%2Bz1nt18sI2ne5oZ3v1%2F%2B9%2BOXm8CGi%2BTtbfR1dr%2BKLqHV7KbqeZVvxCCsnuJFglN2dDOnWfyTpjlO2CnAGp7mcU4eljjk1z4xGeAX5Qt%2BGrKPszhJJjShWdETciPfc23ezvrYaZ8Vf6x9lWf0O9k5g64dG%2FGeym%2F1Ayfr6ls90ez7jGbswZaLF%2Fy56XS1LK4EeYbD7xfWhEsejpMNl4Y8J2mEU349b8%2Fx6jtvTiP%2B%2BzMarcM8%2FhHnm6vqSSTLyfPOkFTD%2BpbQBckz3uV8B3nbrXB%2B2hET6JdtVTdCFKq54FeHuJLRx23PLzCyDxWSR6Bq2U1UX4V%2FB2vWPZtb5DCyTJ6X5N%2Fpis3PqgWvluUUnMXPJGqCH0Zk6k%2BVILsoQJEK5K8M5Dh9LHDkQ06XJF1pAeQ18RFNohMY1PBxjOHj6uOT0XUa8dHVmH2zYOYVwBwBwGRO%2BEwCcao16opZIY26BeqjDo2NevUcEjUoX2OapNE1Vy%2FsKEzwahWH9ZGvwxSRGV4n%2BXs8JckNY6bH4rQY%2F1IH3ST87CccRVze%2BX0WsFWIHB50IbgZSTDjtPqv3UHiNQGvnvCJxmxoXqaIWwdLprAVXTNCrm7aVUZSP5Y01ZDUT46zR5I3%2Bilw3%2F5ofVFAQB95Jv15HWvVJMRJ%2FJhy4WD9EwbyDZ83MbMrrqsTiziKeJeSpDTn3wW65vZNRnDODCELXO%2FoMYZwSLNIT2E1ZyYEdn1qegNNTdRhJmZzupiuVzoKS6ZHPyRhqKLHqe%2FYjhKeLwxobkA81fUUNzBSygUe82Gn7CLWjO61kAoOIwXtOlLmdBfqYFu0mzr10U9pYXfuQlU19TbFwm4qDjXhcSUV5wyGjtNZxxUM3kIATqIMyXOc%2F86Pr6DrVcffimN3e3z7XD2oONjsHHwiWczGmQtL2ZayMS%2B78wNbNJT9Ic8XDS8dFkeb3SO5y3JsSvXVgvDGotYlokeyPm6t1y1J0mUDwbRi72BZG%2FR8CIwc4qk0S%2BB6CLsqVrpLSwnIyJ%2Bsb6Kn5BXmt8xN3gHE%2BuMmrzM3nYRytiRRJwjnAD20ZQJ3VEwge2PI0mUCWed5AzNBFXqpAoN4KiSnrekvxHVX6JjkFjJUl7UjDBGyin9WX4XLyJL%2F%2BmI8nJsL55a1xOmcaZT8t8JSKnrv1Xf8z8fWNKKULSEVrcVKXEJnsxUxA3Rg2iClbLRmScE1c4YkSRv8IjsS7M%2F3j4uzXFhuUnwXWPuK7v%2FXPEB8s2CzJU4vc7os%2FUGwfC56EefZp0f%2B%2F0NOM%2B4YYpWXWD6BjTJ%2FSHl9X1oF2rCmVmwRgxTT3zalVmzHNP6DOySv%2BvxGPBRHtgKMeSi2pw9Xl9hnGBJnzwrD3jl5zewKBpxYK9AYeac58lL403btK6c29tDc2PudLbCD3mFwSlNt6x06u77hq37hqKwv%2B1AYp631ZQdSR2BY68s2rpRPT8q%2FlQuIb1Y5zte84ROTdCaQ%2F9JiCuswR6M6pjAwxRNOl3DswOtT%2F1tGDI8tRwOBhgYEioi4TNbCOd7U7%2BgfAcs4U9sK%2F%2BYETO1Be5err6yjo3jjYvCmOteNpTlQ7mrgYJqDhiXx3WyPfXkjunS%2BL9%2BkySclza8LWtmh%2Bb4YRSZ1KWAqR0n6Y5QObtLQdrfIOaDrXGvYFf6OROSOP9DKpkh3M0jkQluflMhhjcSdV0l8VITtOHWVLhtVbdnaBa%2BbBqa5%2BkRuNUGhDxQEC4o%2F1bS%2FAYEDlGLQoN5aqsObYpn2knGCnoGt4GK%2FTgpu4A9ECv5pwJph90iwJh7aA9YEJ%2BE6KU3vOZsjHC%2BeBKG5UHXY9vYAqqGz1aT9w3OeiWI7q9m1texLcAV8eGC1qstithDnkTC6K%2FnJMhO3ZnTJRriU%2BcAwpQv5HpolMHAsS%2BmFu7fwXsUfR1jT%2FUeyJZpw%2FTqJI2Ms7o4jaU0jZlK5NCFdLBPCUws0E9MUKdVizuxZVzAX23a7R0xOl917kGKFrI2EYj1Qn2TaecCeI3U0cCKwW9kU2lkCrkJ4zj5L4NvdQ2s%2BUApXdcslT9ODXl2LWq2FzXzugNshmbWTIT4jrjrTOPKC6R6Dm6azOFu88HZMe8tXlRwhhOpxx8bqUX%2Bs3T1f9W9fk%2BFC%2F%2BoAXq2XDaWyDEvO%2FjJNx25XOnb%2BoeO9dAyuXA%2B4I2bjE8WwZgAjgI%2BKYd16oGUMS6wST7bGNhdmXqPKr9ALZSmySiS7W2ZwKE%2Fk%2Fhj8RLGsPgOPn6v8uFoZMNdK%2FBqsrWhVMEnJ18I53bdW2B9MZx7T2savvu0edEu9dscVt0JICnDKkYu2Whz59Y6gHCk1rMU96zSU4Nqe63uvhKeaIRJoI2ePQVcmy4Y04hHuKC7vEOm2SZ41c28bGUKf6nTSSMMtO%2B%2BQiHt4TQPaEsMYSxry0FkyzKgooGnKQzkhoLUpL6UqDZw74lWetbYlL8Tpl7LkefkFeBPirJApXlfA9RRl%2F6T8iUXxcHuT8EDoBViSEXiEsb%2Bp9Wne9PdOlJ3Sp8r4ygSnKL1YRzEfQ5IKWjVQmu%2FYdWwRcEzxevcMll%2BwbE8I7EgUh1xtB3UD8kjejWXggLx3ohjAFEbRTOk2QuChgCgjso0yHT7z%2F3hPH7Vm%2FeG1TVtyF82tbXony1CJPKzegsN2HbVS%2FRKTp2JSLWmW95b5LeVpQnnojS1ker%2BSpw6urL4Id1zOumPX6xuRLenf1lnegVQoGUgdGSZc%2F0S1HjqE%2B7kkXMa3Eafbu8UyoRvCqZfvt3MtbfDHI6%2FVqbojrkEQqopXKDGElACKjHnafpf4Sm%2BJJ8SNAD9385jhKCY18zlyGITKpJQgYD6uowJXCpYwkqGc1nEYkmXpP1ogIT%2B496eXreI3MZTDsVL5HTK2F4Z%2FnsGSnRRD5Fl1oge%2BdYDpu%2BQYCpkfCf1vwzL7JKX9hjlSRwPb2%2F6JMiAiTPxZqGYPj2CXKFWDG%2Fpkqkw0vE8w33yNVCrhgm%2F1y4MrIcXhvNyYrTjOMxynxbEGg7RYd5NC78hYkrJ%2FnpkT%2B9zyvsxEIc8j4QkklXfZutvpIHmHroG30%2FErv1w7nuv%2Fk5nxeqKcVN4AjxW1wWK1%2Fjj3WAPAAWR2TCgXAHjLF%2B0U2oQmzPq8XC%2BLb48zc9uvObL%2BNxZXEJpqZLC5AAfwqAi8deu5e1IkN2HhJoQJXWkiplDxTh0xWyoYtI0F4YQDeWYqvq2mDsalqaXMOFs3oIOcekdo4IBOUH8jxvGaWojdL6Wpu258t02hhK6Uz95eUZtXzUGXyFAHbw4AH79aGKbQvY63L889y7jGYPM5o4Xj1utC6oFyMWiZWkcNTrCbBhviyUShcxlYBSzD76ZRL%2BlOSZkCERGeGmuqrtuDEsbGIrMilm9wt4dAnRfzUB3SLJ%2FTR5ri5O6lVULv5Zr3lO8nWQjUnyTPN9X7l%2FA6p3Vxi5kuyfjVX%2FFmy91iz4fmlmvijHr%2FhwGMi3KUWnJ772IA24iBYteOHRyr3cs0oBo8Ne6QLQZfqx4qumOGafFyH3FBJWGvWVlQ8pt0469yP45tDWqtwTZhvPGLyr7VX6%2BnsJ6gx3EKo%2BwRWt6VpvOwTQIRXQ28HADbJHudrzj%2BHaVRfwf3QOpINptMy2Kb9wWcryz2teJxVsKoXZm6jZvu2xnXtDAqEuKasqfpp21fL7XvhVS6flpG87J8Dd1yx1dh0r37zI4%2F4JSJcHah434p9gAJ6u6XVIFiG4twQ0WEuzeMAHDvru%2BbGMEphsTqE6PWzvXDZpWTxYU1%2BZjhMvDNvGw8xSu9vXVUu7m8iiQytv2tKlbZG5LbLRYamzKEkeX3iaQit2E2w3uKUB%2FWS5L9iFfU1DyUN3UwFulqp6c10dumgOxLKDGJ3jYzpYHe3TbxZAjsoLFqD%2FEaj2ONrpMnkPT1OqZxrUrJ%2FiBydB1LqRywUS9k%2BoUAXTdastWW%2FnmvSvW4s4eo2xnFOpRIju9fAwzwogcpy%2FzTeprE4R%2Fvyne46tWXHN5yqVFfYmwnCL%2FNS2BGyPD98Ls%2Frtft2SKvWThHrm4ZCZI6ggNnHWjGsV%2BkqprGEV7NCzGCZpc1Wi4hjUZSHF8q%2BNV9NZCL5MrhYSMpgSJ98Gx0Ay8mKj6BSVH12Zc2kLICPXlFwZg2CBT1tmeDxuctGp%2FZYMTkhyk8XDmGZQ4PY3HGAfAozGRDM0JGQKM0ix1mlO%2FY80JnbKDmH2jEXYi7vwA%3D%3C%2Fdiagram%3E%3C%2Fmxfile%3E`
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


