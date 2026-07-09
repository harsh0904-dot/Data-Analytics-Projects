-- SQL PRACTICE: ADVANCED ANALYTICS
-- Topics: WINDOW FUNCTIONS, RANKING, RUNNING TOTALS

-- 1) Rank categories by performance
SELECT
    category_column,
    total_value,
    DENSE_RANK() OVER (ORDER BY total_value DESC) AS category_rank
FROM category_performance_table;

-- 2) Running total by month
SELECT
    month_column,
    revenue,
    SUM(revenue) OVER (ORDER BY month_column) AS running_revenue
FROM monthly_revenue_table;

-- 3) Compare each row to category average
SELECT
    category_column,
    entity_name,
    metric_value,
    AVG(metric_value) OVER (PARTITION BY category_column) AS category_avg
FROM performance_table;
