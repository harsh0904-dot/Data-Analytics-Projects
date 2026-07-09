-- HR ANALYSIS QUERIES: IBM HR Analytics Employee Attrition
-- SQL Dialect: MySQL

-- 1) Attrition by department (stacked 100% view)
SELECT
	Department,
	Attrition,
	COUNT(*) AS employee_count,
	ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY Department), 2) AS department_attrition_pct
FROM `IBM HR Analytics Employee Attrition`
GROUP BY Department, Attrition
ORDER BY Department, Attrition;

-- 2) Employees leaving by business travel
SELECT
	BusinessTravel,
	COUNT(*) AS employees_left
FROM `IBM HR Analytics Employee Attrition`
WHERE Attrition = 'Yes'
GROUP BY BusinessTravel
ORDER BY employees_left DESC;

-- 3) Attrition contribution by department (waterfall support)
SELECT
	Department,
	COUNT(*) AS attrition_count
FROM `IBM HR Analytics Employee Attrition`
WHERE Attrition = 'Yes'
GROUP BY Department
ORDER BY attrition_count DESC;

-- 4) Attrition flow: Department -> JobRole -> BusinessTravel (sankey support)
SELECT
	Department,
	JobRole,
	BusinessTravel,
	COUNT(*) AS employees_left
FROM `IBM HR Analytics Employee Attrition`
WHERE Attrition = 'Yes'
GROUP BY Department, JobRole, BusinessTravel
ORDER BY employees_left DESC;

-- 5) Attrition by education field
SELECT
	EducationField,
	COUNT(*) AS employees,
	ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_share
FROM `IBM HR Analytics Employee Attrition`
GROUP BY EducationField
ORDER BY employees DESC;

-- 6) Department performance comparison
SELECT
	Department,
	ROUND(AVG(PerformanceRating), 2) AS avg_performance_rating,
	ROUND(AVG(JobSatisfaction), 2) AS avg_job_satisfaction,
	ROUND(AVG(MonthlyIncome), 2) AS avg_monthly_income,
	ROUND(AVG(WorkLifeBalance), 2) AS avg_work_life_balance
FROM `IBM HR Analytics Employee Attrition`
GROUP BY Department
ORDER BY Department;

-- 7) High risk role segments (high attrition rate)
SELECT
	JobRole,
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attritions,
	ROUND(100 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate_pct
FROM `IBM HR Analytics Employee Attrition`
GROUP BY JobRole
HAVING COUNT(*) >= 20
ORDER BY attrition_rate_pct DESC, attritions DESC;

-- 8) Overtime impact on attrition
SELECT
	OverTime,
	COUNT(*) AS total_employees,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attritions,
	ROUND(100 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate_pct
FROM `IBM HR Analytics Employee Attrition`
GROUP BY OverTime
ORDER BY attrition_rate_pct DESC;
