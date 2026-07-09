# Data Model

- Model type: Single-table analytic model (flat schema).
- Main table: `IBM HR Analytics Employee Attrition`.
- Grain: One row per employee.
- Row count: 1,470 employees.

## Core Dimensions

- Employee profile: EmployeeNumber, Age, Gender, MaritalStatus, EducationField.
- Organization: Department, JobRole, JobLevel, BusinessTravel.
- Experience: TotalWorkingYears, YearsAtCompany, YearsInCurrentRole.
- Behavior and sentiment: JobSatisfaction, WorkLifeBalance, EnvironmentSatisfaction.

## Core Measures

- Headcount: Total Employees.
- Attrition volume: Employees Left.
- Attrition rate: Employees Left / Total Employees.
- Compensation: Average Monthly Income.
- Workforce quality: Average Performance Rating, Average Job Satisfaction.

## Calculated Flags

- `attrition_flag`: 1 for Yes, 0 for No.
- `overtime_flag`: 1 for Yes, 0 for No.

## Model Notes

- Keep text values standardized (`Yes/No`, department names).
- Use slicers for Department, JobRole, BusinessTravel, Attrition.
