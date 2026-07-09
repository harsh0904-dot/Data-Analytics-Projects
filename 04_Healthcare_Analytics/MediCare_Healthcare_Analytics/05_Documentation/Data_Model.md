# Data Model

- Model type: Single-table analytical model
- Main table: `hospital_patient_cleaned`
- Grain: One row per patient admission
- Row count: 984

## Core Dimensions

- Patient: patient_id, age, gender, patient_state
- Clinical: condition, medication, outcome, readmission
- Time: admission_date, discharge_date, year_of_admission
- Financial: total_cost, insurance_claimed

## Core Measures

- Total Patients
- Total Cost
- Average Cost
- Average Length of Stay
- Average Satisfaction
- Insurance Claimed Count

## Reporting Notes

- The project can be modeled as a flat fact table.
- Condition and state act as the main slicing dimensions.
