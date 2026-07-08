# SQL Analysis

## Objective
The SQL layer translates raw loan records into decision-ready portfolio performance metrics, risk signals, and repayment insights for the dashboard.

## Data Scope
Source table expected by queries: financial_loan

Key fields used:
1. Portfolio amount: loan_amount, total_payment
2. Risk and performance: loan_status, grade, sub_grade, int_rate
3. Borrower profile: dti, verification_status, home_ownership
4. Time and geography: issue_date, address_state

## Query Groups
1. Portfolio Overview
Goal: Measure funding, collections, and net payment gap.

2. Credit Risk Segmentation
Goal: Identify default-heavy cohorts by grade, purpose, and state.

3. Operational Trend Analysis
Goal: Track monthly volume and repayment behavior over time.

4. Cohort and Borrower Behavior
Goal: Compare term, verification status, and DTI bands.

## Recommended Dashboard Mapping
1. KPI Cards
Queries: Portfolio summary, charge-off rate, fully paid rate.

2. Trend Visuals
Queries: Monthly issuance and monthly repayment efficiency.

3. Risk Heatmaps/Tables
Queries: Grade and sub-grade charge-off analysis, purpose risk ranking.

4. Geographic Visuals
Queries: State-wise funding and collection efficiency.

## Insight Interpretation Framework
1. High funding + low collection efficiency indicates potential underwriting or recovery issues.
2. Rising charge-off rate in specific grades suggests tightening credit controls.
3. Strong verified-application performance supports stronger verification policies.
4. State-level outliers should be investigated for policy and portfolio mix decisions.

## Quality Checks
1. Confirm total row count and funded amount reconcile with cleaned dataset.
2. Validate that charge-off + fully-paid + current status shares sum to 100 percent.
3. Reconcile KPI cards in Power BI with SQL output aggregates.

## Next Steps
1. Materialize key query outputs into SQL_Output exports for auditability.
2. Add SQL views for repeated dashboard metrics.
3. Add scenario filters for grade, term, and verification status directly in SQL views.
