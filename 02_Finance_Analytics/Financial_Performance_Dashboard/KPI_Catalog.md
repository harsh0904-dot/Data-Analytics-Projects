# KPI Catalog

This KPI catalog is designed for portfolio performance, credit risk monitoring, and repayment effectiveness.

## KPI List
1. Total Loans Issued
2. Total Funded Amount
3. Total Payment Collected
4. Net Payment Gap
5. Collection Efficiency
6. Charge-Off Rate
7. Fully Paid Rate
8. Average Interest Rate
9. Average Loan Amount
10. Average Installment
11. Average DTI
12. Verified Application Share

## KPI Definitions
1. Total Loans Issued
Formula: COUNT(id)
Interpretation: Number of loans in scope.

2. Total Funded Amount
Formula: SUM(loan_amount)
Interpretation: Total principal disbursed.

3. Total Payment Collected
Formula: SUM(total_payment)
Interpretation: Total amount recovered from borrowers.

4. Net Payment Gap
Formula: SUM(total_payment) - SUM(loan_amount)
Interpretation: Net gain or shortfall after repayments.

5. Collection Efficiency
Formula: SUM(total_payment) / NULLIF(SUM(loan_amount), 0)
Interpretation: Repayment effectiveness ratio.

6. Charge-Off Rate
Formula: COUNT(CASE WHEN loan_status = 'Charged Off' THEN 1 END) / COUNT(*)
Interpretation: Share of loans charged off.

7. Fully Paid Rate
Formula: COUNT(CASE WHEN loan_status = 'Fully Paid' THEN 1 END) / COUNT(*)
Interpretation: Share of loans closed with full repayment.

8. Average Interest Rate
Formula: AVG(int_rate)
Interpretation: Portfolio pricing level.

9. Average Loan Amount
Formula: AVG(loan_amount)
Interpretation: Typical disbursement size.

10. Average Installment
Formula: AVG(installment)
Interpretation: Typical periodic borrower burden.

11. Average DTI
Formula: AVG(dti)
Interpretation: Portfolio leverage profile.

12. Verified Application Share
Formula: COUNT(CASE WHEN verification_status IN ('Verified', 'Source Verified') THEN 1 END) / COUNT(*)
Interpretation: Portion of applications with stronger documentation.

## Data Source Mapping
Table/View: financial_loan

1. Total Loans Issued -> id
2. Total Funded Amount -> loan_amount
3. Total Payment Collected -> total_payment
4. Net Payment Gap -> loan_amount, total_payment
5. Collection Efficiency -> loan_amount, total_payment
6. Charge-Off Rate -> loan_status
7. Fully Paid Rate -> loan_status
8. Average Interest Rate -> int_rate
9. Average Loan Amount -> loan_amount
10. Average Installment -> installment
11. Average DTI -> dti
12. Verified Application Share -> verification_status

## Slice Dimensions
1. Time: issue_date (year, quarter, month)
2. Geography: address_state
3. Risk: grade, sub_grade, loan_status
4. Product: term, purpose
5. Borrower Profile: home_ownership, emp_length, verification_status

## Refresh Cadence and Ownership
1. Refresh Frequency: Monthly or per data load cycle.
2. Data Owner: Analyst/Project Owner.
3. QA Owner: Dashboard Developer.
4. Validation Rule: Reconcile counts and sums between SQL outputs and dashboard cards at each refresh.
