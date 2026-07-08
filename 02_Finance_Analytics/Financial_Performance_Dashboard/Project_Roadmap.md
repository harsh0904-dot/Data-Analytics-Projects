# Project Roadmap

This roadmap shows a practical end-to-end delivery plan for the Financial Performance Dashboard project.

## Phase 1: Project Framing and Data Intake
Timeline: Week 1

1. Confirm business goals and reporting audience.
2. Define primary success metrics and dashboard scope.
3. Ingest raw financial_loan dataset from Raw_Data folder.
4. Verify schema, row count, and data types.
5. Document initial data quality findings.

Deliverables:
1. Business questions document
2. Initial data audit notes
3. Data dictionary draft

## Phase 2: Data Cleaning and Feature Preparation
Timeline: Week 1 to Week 2

1. Build repeatable cleaning pipeline in Python.
2. Handle missing values and normalize data types.
3. Create derived fields such as term_months, issue_year, issue_month, payment_gap.
4. Save cleaned output into Cleaned_Data folder.
5. Validate cleaned dataset against quality checks.

Deliverables:
1. Data_Cleaning.py
2. Cleaning notebook (EDA.ipynb)
3. financial_loan_cleaned.csv

## Phase 3: SQL Analytics and KPI Computation
Timeline: Week 2

1. Write SQL queries for portfolio summary, risk segmentation, and repayment performance.
2. Build KPI-ready SQL outputs for dashboard visuals.
3. Create reusable query blocks for trend and cohort analysis.
4. Document findings in SQL_Analysis.md.

Deliverables:
1. SQL_Queries.sql
2. SQL_Analysis.md
3. Query output snapshots (optional)

## Phase 4: Dashboard Build and Storytelling
Timeline: Week 3

1. Design Power BI layout and visual hierarchy.
2. Implement KPI cards, trend charts, and risk segment visuals.
3. Add filters for state, grade, status, term, and verification.
4. Apply final theme and narrative annotations.

Deliverables:
1. Power BI dashboard file
2. Dashboard notes and DAX measures
3. Screenshot assets for portfolio use

## Phase 5: Validation, Portfolio Packaging, and Handover
Timeline: Week 3 to Week 4

1. Reconcile SQL, Python, and dashboard figures.
2. Perform visual QA and scenario testing.
3. Publish final README with business impact summary.
4. Package project artifacts for recruiters and interviews.

Deliverables:
1. Final README.md
2. Validated KPI catalog
3. Final presentation-ready project folder

## Risks and Mitigation
1. Risk: Inconsistent metric definitions across tools.
Mitigation: Use KPI catalog as the single source of truth.

2. Risk: Data quality drift in new extracts.
Mitigation: Add repeatable checks in cleaning and SQL validation.

3. Risk: Overly technical dashboard narrative.
Mitigation: Include business-facing summary labels and insight callouts.
