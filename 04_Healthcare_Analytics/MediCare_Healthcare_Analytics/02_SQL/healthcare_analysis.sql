-- HEALTHCARE ANALYSIS QUERIES
-- SQL Dialect: MySQL
-- Assumed table name: hospital_patient_cleaned

-- 1) Condition-wise financial summary
SELECT
	condition,
	SUM(total_cost) AS sum_total_cost,
	ROUND(AVG(length_of_stay), 2) AS average_length_of_stay,
	ROUND(AVG(satisfaction), 2) AS average_satisfaction,
	COUNT(patient_id) AS patient_count
FROM hospital_patient_cleaned
GROUP BY condition
ORDER BY sum_total_cost DESC;

-- 2) Total treatment cost by condition
SELECT
	condition,
	SUM(total_cost) AS total_treatment_cost
FROM hospital_patient_cleaned
GROUP BY condition
ORDER BY total_treatment_cost DESC;

-- 3) Patients by medical condition
SELECT
	condition,
	COUNT(*) AS total_patients,
	ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_share
FROM hospital_patient_cleaned
GROUP BY condition
ORDER BY total_patients DESC;

-- 4) Average length of stay by condition
SELECT
	condition,
	ROUND(AVG(length_of_stay), 2) AS average_length_of_stay
FROM hospital_patient_cleaned
GROUP BY condition
ORDER BY average_length_of_stay DESC;

-- 5) Treatment cost root cause by gender and medication
SELECT
	gender,
	medication,
	SUM(total_cost) AS total_cost
FROM hospital_patient_cleaned
GROUP BY gender, medication
ORDER BY total_cost DESC;

-- 6) Readmission analysis by condition
SELECT
	condition,
	SUM(CASE WHEN readmission = 'Yes' THEN 1 ELSE 0 END) AS readmissions,
	COUNT(*) AS total_patients,
	ROUND(100 * SUM(CASE WHEN readmission = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS readmission_rate_pct
FROM hospital_patient_cleaned
GROUP BY condition
ORDER BY readmission_rate_pct DESC;

-- 7) State-wise patient concentration
SELECT
	patient_state,
	COUNT(*) AS total_patients,
	ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_share
FROM hospital_patient_cleaned
GROUP BY patient_state
ORDER BY total_patients DESC;

-- 8) Year and condition ranking by treatment cost
SELECT
	year_of_admission,
	condition,
	SUM(total_cost) AS total_cost
FROM hospital_patient_cleaned
GROUP BY year_of_admission, condition
ORDER BY year_of_admission, total_cost DESC;
