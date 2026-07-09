-- KPI QUERIES
-- SQL Dialect: MySQL
-- Assumed table name: hospital_patient_cleaned

-- 1) Executive KPI summary
SELECT
	COUNT(*) AS total_patients,
	SUM(total_cost) AS total_cost,
	ROUND(AVG(total_cost), 2) AS average_cost,
	SUM(CASE WHEN insurance_claimed = 'Yes' THEN 1 ELSE 0 END) AS total_insurance_claimed,
	ROUND(AVG(length_of_stay), 2) AS average_length_of_stay,
	ROUND(AVG(satisfaction), 2) AS average_satisfaction
FROM hospital_patient_cleaned;

-- 2) Outcome distribution
SELECT
	outcome,
	COUNT(*) AS patient_count,
	ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_share
FROM hospital_patient_cleaned
GROUP BY outcome
ORDER BY patient_count DESC;

-- 3) Insurance claim distribution
SELECT
	insurance_claimed,
	COUNT(*) AS patient_count,
	ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_share
FROM hospital_patient_cleaned
GROUP BY insurance_claimed
ORDER BY patient_count DESC;

-- 4) Patients and average cost by year
SELECT
	year_of_admission,
	COUNT(patient_id) AS total_patients,
	ROUND(AVG(total_cost), 2) AS average_total_cost
FROM hospital_patient_cleaned
GROUP BY year_of_admission
ORDER BY year_of_admission;

-- 5) Top states by total patients
SELECT
	patient_state,
	COUNT(*) AS total_patients
FROM hospital_patient_cleaned
GROUP BY patient_state
ORDER BY total_patients DESC;
