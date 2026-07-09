-- SQL PRACTICE: INTERMEDIATE QUERIES
-- Topics: JOIN, CASE WHEN, SUBQUERY, CTE

-- 1) Join transactional and dimension data
SELECT
    a.id,
    a.metric_value,
    b.category_name
FROM fact_table a
LEFT JOIN dimension_table b
    ON a.dimension_id = b.dimension_id;

-- 2) Create business segments with CASE
SELECT
    customer_id,
    revenue,
    CASE
        WHEN revenue >= 10000 THEN 'High Value'
        WHEN revenue >= 5000 THEN 'Mid Value'
        ELSE 'Low Value'
    END AS revenue_segment
FROM sales_table;

-- 3) Use a CTE for reusable logic
WITH category_summary AS (
    SELECT
        category_column,
        SUM(value_column) AS total_value
    FROM your_table_name
    GROUP BY category_column
)
SELECT *
FROM category_summary
ORDER BY total_value DESC;
