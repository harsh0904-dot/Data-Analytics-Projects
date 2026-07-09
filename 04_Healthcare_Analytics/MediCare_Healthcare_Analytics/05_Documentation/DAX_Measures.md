# DAX Measures

- `Total Patients = COUNTROWS('hospital_patient_cleaned')`
- `Total Cost = SUM('hospital_patient_cleaned'[total_cost])`
- `Average Cost = AVERAGE('hospital_patient_cleaned'[total_cost])`
- `Total Insurance Claimed = CALCULATE([Total Patients], 'hospital_patient_cleaned'[insurance_claimed] = "Yes")`
- `Average Length of Stay = AVERAGE('hospital_patient_cleaned'[length_of_stay])`
- `Average Satisfaction = AVERAGE('hospital_patient_cleaned'[satisfaction])`
- `Recovered Patients = CALCULATE([Total Patients], 'hospital_patient_cleaned'[outcome] = "Recovered")`
- `Stable Patients = CALCULATE([Total Patients], 'hospital_patient_cleaned'[outcome] = "Stable")`
- `Insurance Claim Rate % = DIVIDE([Total Insurance Claimed], [Total Patients], 0)`
- `Average Cost by Patient = DIVIDE([Total Cost], [Total Patients], 0)`

## Formatting

- Show Total Cost in M where appropriate.
- Show Average Cost in K where appropriate.
- Show rates as percentage with 2 decimals.
