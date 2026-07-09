# DAX Measures

- `Total Employees = COUNTROWS('IBM HR Analytics Employee Attrition')`
- `Employees Left = CALCULATE([Total Employees], 'IBM HR Analytics Employee Attrition'[Attrition] = "Yes")`
- `Active Employees = [Total Employees] - [Employees Left]`
- `Attrition Rate % = DIVIDE([Employees Left], [Total Employees], 0)`
- `Average Monthly Income = AVERAGE('IBM HR Analytics Employee Attrition'[MonthlyIncome])`
- `Average Age = AVERAGE('IBM HR Analytics Employee Attrition'[Age])`
- `Average Working Years = AVERAGE('IBM HR Analytics Employee Attrition'[TotalWorkingYears])`
- `Average Job Satisfaction = AVERAGE('IBM HR Analytics Employee Attrition'[JobSatisfaction])`
- `Average Performance Rating = AVERAGE('IBM HR Analytics Employee Attrition'[PerformanceRating])`
- `Average Work-Life Balance = AVERAGE('IBM HR Analytics Employee Attrition'[WorkLifeBalance])`

## Formatting Notes

- Format `Attrition Rate %` as Percentage with 2 decimals.
- Format income measures as currency or thousands display.
- Use card abbreviations for executive page (example: 1.47K, 6.50K).
