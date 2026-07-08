-- Financial Performance Dashboard SQL Queries
-- Assumption: table name is financial_loan

-- 1) Portfolio Summary KPI Block
SELECT
	COUNT(*) AS total_loans,
	SUM(loan_amount) AS total_funded_amount,
	SUM(total_payment) AS total_payment_collected,
	SUM(total_payment) - SUM(loan_amount) AS net_payment_gap,
	ROUND(SUM(total_payment) / NULLIF(SUM(loan_amount), 0), 4) AS collection_efficiency
FROM financial_loan;


-- 2) Loan Status Distribution
SELECT
	loan_status,
	COUNT(*) AS loan_count,
	ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS status_share_pct,
	SUM(loan_amount) AS funded_amount,
	SUM(total_payment) AS total_payment,
	SUM(total_payment) - SUM(loan_amount) AS payment_gap
FROM financial_loan
GROUP BY loan_status
ORDER BY loan_count DESC;


-- 3) Grade-Level Risk and Return Profile
SELECT
	grade,
	COUNT(*) AS loans,
	ROUND(AVG(int_rate), 4) AS avg_interest_rate,
	ROUND(AVG(dti), 4) AS avg_dti,
	SUM(loan_amount) AS total_funded,
	SUM(total_payment) AS total_collected,
	SUM(total_payment) - SUM(loan_amount) AS net_payment_gap,
	ROUND(
		100.0 * SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0),
		2
	) AS charged_off_rate_pct
FROM financial_loan
GROUP BY grade
ORDER BY grade;


-- 4) Sub-Grade Ranking by Charge-Off Rate (min 100 loans)
SELECT
	sub_grade,
	COUNT(*) AS loans,
	ROUND(AVG(int_rate), 4) AS avg_interest_rate,
	ROUND(
		100.0 * SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0),
		2
	) AS charged_off_rate_pct,
	SUM(total_payment) - SUM(loan_amount) AS net_payment_gap
FROM financial_loan
GROUP BY sub_grade
HAVING COUNT(*) >= 100
ORDER BY charged_off_rate_pct DESC, loans DESC;


-- 5) Purpose-Wise Performance
SELECT
	purpose,
	COUNT(*) AS loans,
	SUM(loan_amount) AS funded_amount,
	SUM(total_payment) AS payment_collected,
	SUM(total_payment) - SUM(loan_amount) AS payment_gap,
	ROUND(AVG(int_rate), 4) AS avg_interest_rate,
	ROUND(
		100.0 * SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0),
		2
	) AS charged_off_rate_pct
FROM financial_loan
GROUP BY purpose
ORDER BY funded_amount DESC;


-- 6) State-Level Portfolio Performance (Top 15 by funded amount)
SELECT
	address_state,
	COUNT(*) AS loans,
	SUM(loan_amount) AS funded_amount,
	SUM(total_payment) AS payment_collected,
	ROUND(SUM(total_payment) / NULLIF(SUM(loan_amount), 0), 4) AS collection_efficiency,
	ROUND(
		100.0 * SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0),
		2
	) AS charged_off_rate_pct
FROM financial_loan
GROUP BY address_state
ORDER BY funded_amount DESC
LIMIT 15;


-- 7) Verification Status Impact
SELECT
	verification_status,
	COUNT(*) AS loans,
	SUM(loan_amount) AS funded_amount,
	SUM(total_payment) AS payment_collected,
	SUM(total_payment) - SUM(loan_amount) AS payment_gap,
	ROUND(
		100.0 * SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0),
		2
	) AS charged_off_rate_pct
FROM financial_loan
GROUP BY verification_status
ORDER BY loans DESC;


-- 8) Term Comparison (36 vs 60 months)
SELECT
	term,
	COUNT(*) AS loans,
	ROUND(AVG(loan_amount), 2) AS avg_loan_amount,
	ROUND(AVG(installment), 2) AS avg_installment,
	ROUND(AVG(int_rate), 4) AS avg_interest_rate,
	ROUND(AVG(dti), 4) AS avg_dti,
	SUM(total_payment) - SUM(loan_amount) AS net_payment_gap,
	ROUND(
		100.0 * SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0),
		2
	) AS charged_off_rate_pct
FROM financial_loan
GROUP BY term
ORDER BY term;


-- 9) Monthly Disbursement and Collection Trend
SELECT
	DATE_TRUNC('month', issue_date)::date AS issue_month,
	COUNT(*) AS loans_issued,
	SUM(loan_amount) AS funded_amount,
	SUM(total_payment) AS payment_collected,
	SUM(total_payment) - SUM(loan_amount) AS net_payment_gap
FROM financial_loan
GROUP BY DATE_TRUNC('month', issue_date)::date
ORDER BY issue_month;


-- 10) DTI Band Risk Profiling
WITH dti_bands AS (
	SELECT
		CASE
			WHEN dti < 0.10 THEN 'Low (<0.10)'
			WHEN dti >= 0.10 AND dti < 0.20 THEN 'Moderate (0.10-0.19)'
			WHEN dti >= 0.20 AND dti < 0.30 THEN 'High (0.20-0.29)'
			ELSE 'Very High (>=0.30)'
		END AS dti_band,
		loan_status,
		loan_amount,
		total_payment
	FROM financial_loan
)
SELECT
	dti_band,
	COUNT(*) AS loans,
	SUM(loan_amount) AS funded_amount,
	SUM(total_payment) AS payment_collected,
	ROUND(
		100.0 * SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0),
		2
	) AS charged_off_rate_pct
FROM dti_bands
GROUP BY dti_band
ORDER BY dti_band;
