"""Phase II data-quality counts for the raw Kaggle files.
Usage: python quality_check.py <folder containing employee_data.csv and employee_engagement_survey_data.csv>
Read-only: never modifies the raw files."""
import sys, pandas as pd
src = sys.argv[1] if len(sys.argv) > 1 else "raw"
e = pd.read_csv(f"{src}/employee_data.csv", encoding="utf-8-sig"); e.columns = [c.strip() for c in e.columns]
s = pd.read_csv(f"{src}/employee_engagement_survey_data.csv", encoding="utf-8-sig"); s.columns = [c.strip() for c in s.columns]
print("employee rows:", len(e), "| survey rows:", len(s))
print("duplicate EmpID:", int(e.EmpID.duplicated().sum()), "| fully duplicated rows:", int(e.duplicated().sum()))
print("\nmissing values per column (employee file):"); print(e.isna().sum()[lambda x: x > 0].to_string())
print("\nmissing values per column (survey file):"); print(s.isna().sum()[lambda x: x > 0].to_string())
d = e["DepartmentType"].astype(str)
print("\nDepartmentType values:", d.nunique(), "| with extra spaces:", int((d != d.str.strip()).sum()), "| distinct after strip:", d.str.strip().nunique())
print("EmployeeStatus:", e.EmployeeStatus.value_counts().to_dict())
print("ExitDate present:", int(e.ExitDate.notna().sum()))
for c in ["StartDate", "ExitDate", "DOB"]:
    if c in e: print(f"{c} stored as text:", pd.api.types.is_string_dtype(e[c]), "| non-null:", int(e[c].notna().sum()))
print("survey Employee IDs not in employee file:", int((~s["Employee ID"].isin(e.EmpID)).sum()))
print("employees with no survey row:", int((~e.EmpID.isin(s["Employee ID"])).sum()))
for c in ["Current Employee Rating"]:
    if c in e: print(c, "out of 1-5:", int((~e[c].between(1, 5)).sum()))
print("Performance Score values:", e["Performance Score"].value_counts().to_dict())
