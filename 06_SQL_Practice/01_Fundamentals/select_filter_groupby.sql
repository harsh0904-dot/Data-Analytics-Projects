-- SQL PRACTICE: FUNDAMENTALS
-- Topics: SELECT, WHERE, ORDER BY, GROUP BY, HAVING

-- 1) View all records
SELECT *
FROM your_table_name;

-- 2) Filter rows by a business condition
SELECT *
FROM your_table_name
WHERE metric_column > 0;

-- 3) Aggregate by category
SELECT
    category_column,
    COUNT(*) AS total_records,
    SUM(value_column) AS total_value,
    AVG(value_column) AS average_value
FROM your_table_name
GROUP BY category_column
ORDER BY total_value DESC;

-- 4) Keep only high-volume groups
SELECT
    category_column,
    COUNT(*) AS total_records
FROM your_table_name
GROUP BY category_column
HAVING COUNT(*) >= 10;
