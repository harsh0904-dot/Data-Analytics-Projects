-- KPI QUERIES: IBM HR Analytics Employee Attrition
-- SQL Dialect: MySQL

-- 1) Workforce headcount KPIs
SELECT
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) AS active_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
	ROUND(100 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate_pct
FROM `IBM HR Analytics Employee Attrition`;

-- 2) Executive average KPIs
SELECT
	ROUND(AVG(MonthlyIncome), 2) AS avg_monthly_income,
	ROUND(AVG(Age), 2) AS avg_age,
	ROUND(AVG(TotalWorkingYears), 2) AS avg_working_years,
	ROUND(AVG(JobSatisfaction), 2) AS avg_job_satisfaction,
	ROUND(AVG(PerformanceRating), 2) AS avg_performance_rating,
	ROUND(AVG(WorkLifeBalance), 2) AS avg_work_life_balance
FROM `IBM HR Analytics Employee Attrition`;

-- 3) Attrition split (for donut chart)
SELECT
	Attrition,
	COUNT(*) AS employee_count,
	ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_share
FROM `IBM HR Analytics Employee Attrition`
GROUP BY Attrition
ORDER BY employee_count DESC;

-- 4) Department distribution
SELECT
	Department,
	COUNT(*) AS employee_count,
	ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_share
FROM `IBM HR Analytics Employee Attrition`
GROUP BY Department
ORDER BY employee_count DESC;

-- 5) Average monthly income by job level
SELECT
	JobLevel,
	ROUND(AVG(MonthlyIncome), 2) AS avg_monthly_income
FROM `IBM HR Analytics Employee Attrition`
GROUP BY JobLevel
ORDER BY JobLevel;
