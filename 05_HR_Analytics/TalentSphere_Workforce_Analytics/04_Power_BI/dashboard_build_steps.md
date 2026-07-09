# Dashboard Build Steps

## Setup

- Import cleaned Excel file into Power BI Desktop.
- Confirm table name: `IBM HR Analytics Employee Attrition`.
- Set data types for numeric and categorical fields.

## Measures

- Create measures listed in `05_Documentation/DAX_Measures.md`.
- Format KPI cards (K/M where needed, 2-decimal percentage for attrition).

## Page 1: HR Executive Analytics

- Add KPI cards: Total Employees, Active Employees, Employees Left, Avg Income, Avg Age.
- Add bar chart: Employee Distribution by Department.
- Add donut: Employee Attrition Status.
- Add bar chart: Average Monthly Income by Job Level.
- Add decomposition/sankey style flow for attrition path (Department -> JobRole -> BusinessTravel).

## Page 2: Employee Attrition Analysis

- Add 100% stacked bar: Attrition by Department.
- Add column chart: Employees Leaving by Business Travel.
- Add funnel: Total -> Active -> Left.
- Add waterfall: Attrition Contribution by Department.
- Add slicers for Department, JobRole, Attrition, and BusinessTravel.

## Page 3: Workforce Performance

- Add donut: Employees by Education Field.
- Add bar chart: Average Income by Job Level.
- Add table: Department performance comparison metrics.

## Finalization

- Apply dark theme and consistent color palette.
- Validate KPI totals against SQL outputs.
- Export screenshots and save PBIX.
