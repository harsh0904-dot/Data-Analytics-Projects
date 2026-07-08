# Financial Performance Dashboard

An end-to-end portfolio project that analyzes financial loan performance and presents actionable insights through SQL, Python, and Power BI.

## Project Objective
This project evaluates loan portfolio health by tracking funding, repayments, risk concentration, and borrower behavior to support lending and credit strategy decisions.

## Business Goals
1. Measure overall collection efficiency and net payment gap.
2. Identify high-risk segments by grade, purpose, term, and geography.
3. Compare repayment outcomes across borrower and verification cohorts.
4. Build an executive-ready dashboard for performance monitoring.

## Tools and Tech Stack
1. SQL: Portfolio KPIs, risk segmentation, trend analysis
2. Python (Pandas): Data cleaning and feature engineering
3. Power BI: Dashboard development and storytelling
4. Excel/CSV: Raw and cleaned data handling

## Dataset
Raw source: 01_Dataset/Raw_Data/financial_loan.xlsx

Cleaned output: 01_Dataset/Cleaned_Data/financial_loan_cleaned.csv

Core columns:
1. Borrower profile: annual_income, dti, emp_length, home_ownership
2. Loan details: loan_amount, installment, int_rate, term, purpose, grade, sub_grade
3. Performance fields: loan_status, total_payment, issue_date

## Folder Structure
1. 01_Dataset
	Raw_Data: original source file
	Cleaned_Data: cleaned and analysis-ready file
	Data_Dictionary.md: column-level documentation

2. 02_SQL
	SQL_Queries.sql: reusable KPI and analysis queries
	SQL_Analysis.md: SQL analysis objective and mapping
	SQL_Output: optional exported query outputs

3. 03_Python
	Data_Cleaning.py: repeatable cleaning pipeline
	EDA.ipynb: notebook workflow for cleaning and validation
	requirements.txt: Python dependencies

4. 04_PowerBI
	Dashboard notes, measures, theme, and final visuals

## Cleaning and Preparation Summary
1. Standardized data types for dates, numeric fields, and categories.
2. Removed duplicate rows.
3. Filled missing employee title values with Unknown.
4. Added derived fields:
	term_months
	issue_year
	issue_month
	payment_gap
5. Exported cleaned dataset for SQL and BI consumption.

## Key KPIs Covered
1. Total Loans Issued
2. Total Funded Amount
3. Total Payment Collected
4. Net Payment Gap
5. Collection Efficiency
6. Charge-Off Rate
7. Fully Paid Rate

## How to Run
1. Install dependencies:
	pip install -r 03_Python/requirements.txt

2. Run data cleaning:
	python 03_Python/Data_Cleaning.py

3. Execute SQL queries from 02_SQL/SQL_Queries.sql in your SQL engine.

4. Use cleaned data and SQL outputs to build/update Power BI visuals.

## Recruiter-Ready Highlights
1. Business-first framing with clear financial KPIs.
2. End-to-end analytics pipeline from raw data to dashboard.
3. Practical SQL segmentation and risk analysis patterns.
4. Reproducible data cleaning workflow with documented outputs.
