# Dashboard Build Steps

## Data Setup

- Import `Hospital_Patient_Cleaned.xlsx` into Power BI.
- Confirm numeric data types for cost, satisfaction, and length of stay.
- Confirm date data types for admission and discharge dates.

## DAX Setup

- Create KPI measures for total patients, total cost, average cost, insurance claimed, average stay, and satisfaction.
- Format cost measures using K/M display where needed.

## Page 1: Hospital Executive Overview

- Add cards for Total Patients, Total Cost, Average Cost, and Total Insurance Claimed.
- Add combo chart for Admissions vs Average Cost by Year.
- Add bar chart for Total Patients by State.
- Add treemap for Total Treatment Cost by Condition.
- Add donut chart for Patients by Medical Condition.

## Page 2: Clinical & Patient Insights

- Add donut chart for Treatment Outcome Distribution.
- Add bar chart for Average Length of Stay by Condition.
- Add decomposition tree for Treatment Cost Root Cause Analysis.
- Add summary table for condition, stay, cost, and satisfaction.

## Page 3: Financial & Hospital Performance

- Add cards for Insurance Claimed, Total Patients, and Total Cost.
- Add donut chart for Insurance Claims Distribution.
- Add condition-wise financial summary table.
- Add waterfall chart for Treatment Cost Contribution by Condition.
- Add ranking visual for condition cost by year.
