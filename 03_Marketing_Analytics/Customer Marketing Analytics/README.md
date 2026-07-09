# Customer Marketing Analytics

This project analyzes digital advertising campaign performance across platforms, audience segments, and campaign objectives to support budget optimization and ROI improvement.

## Project Goals

- Evaluate campaign efficiency using spend, conversion, and revenue metrics.
- Identify top and low performing channels, placements, and audience groups.
- Build a Power BI dashboard for executive decision-making.

## Project Structure

- `01_Dataset/Raw_Data`: Original dataset files.
- `01_Dataset/Cleaned_Data`: Final cleaned file for Power BI.
- `01_Dataset/Analysis_Outputs`: EDA and feature-engineering output workbooks.
- `02_SQL`: SQL analysis and KPI query scripts.
- `03_Python`: Data cleaning, EDA, and feature engineering scripts.
- `04_Power_BI`: Dashboard notes and build steps.
- `05_Documentation`: Business and analytical documentation.
- `06_Screenshots`: Dashboard snapshots.

## Dataset

- Input file: `tech_advertising_campaigns_dataset.csv`
- Final Power BI file: `01_Dataset/Cleaned_Data/AdNova_Digital_Marketing.xlsx`

## Tools & Technologies

- SQL (campaign and KPI analysis)
- Python (pandas) for cleaning and feature engineering
- Power BI for dashboard development

## Dashboard Preview

![Marketing Executive Overview](06_Screenshots/Marketing%20Executive%20Overview.jpg)
![Campaign Performance Analytics](06_Screenshots/Campaign%20Performance%20Analytics.jpg)
![Audience Performance Overview](06_Screenshots/Audience%20Performnace%20Overview.jpg)
![Marketing ROI and Budget Optimization](06_Screenshots/Marketing%20ROI%20%26%20budget%20Optimization.jpg)

## How To Use

1. Keep the raw CSV in `01_Dataset/Raw_Data`.
2. Run `03_Python/data_cleaning.py` to generate the final cleaned dataset.
3. Optionally run `exploratory_analysis.py` and `feature_engineering.py` for analysis outputs.
4. Load `AdNova_Digital_Marketing.xlsx` into Power BI.

## Documentation Links

- `05_Documentation/BRD.md`
- `05_Documentation/Business_Questions.md`
- `05_Documentation/Project_Approach.md`
- `05_Documentation/Data_Model.md`
- `05_Documentation/DAX_Measures.md`
- `05_Documentation/Insights.md`
