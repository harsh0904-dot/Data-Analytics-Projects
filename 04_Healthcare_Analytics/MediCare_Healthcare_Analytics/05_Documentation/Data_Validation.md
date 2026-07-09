# Data Validation

## Validation Checks Performed

- Confirmed raw CSV was loaded successfully.
- Standardized column names and trimmed whitespace.
- Parsed admission and discharge dates.
- Recalculated length of stay from dates.
- Corrected inconsistent state naming (`Maharastra` to `Maharashtra`).
- Verified numeric conversion for age, stay, satisfaction, and cost.
- Removed duplicate records.

## Final Validation Totals

- Total rows after cleaning: 984
- Total patients: 984
- Total cost: 8,233,600
- Average cost: 8,367.48
- Insurance claimed: 351
- Average length of stay: 37.66
- Average satisfaction: 3.60

## Outcome Validation

- Recovered: 591
- Stable: 393

## Usage Note

- Re-run `data_cleaning.py` before refreshing Power BI if the raw CSV changes.
