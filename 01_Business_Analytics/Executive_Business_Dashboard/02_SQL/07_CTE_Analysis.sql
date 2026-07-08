/*
07_CTE_Analysis.sql
Purpose: Multi-step analytical logic using Common Table Expressions (CTEs).
*/

-- Monthly sales growth (MoM %).
WITH monthly_sales AS (
    SELECT
        DATEFROMPARTS(YEAR([Order Date]), MONTH([Order Date]), 1) AS month_start,
        SUM([Sales]) AS total_sales
    FROM dbo.retail_cleaned
    GROUP BY DATEFROMPARTS(YEAR([Order Date]), MONTH([Order Date]), 1)
),
monthly_growth AS (
    SELECT
        month_start,
        total_sales,
        LAG(total_sales, 1) OVER (ORDER BY month_start) AS previous_month_sales
    FROM monthly_sales
)
SELECT
    month_start,
    total_sales,
    previous_month_sales,
    CASE
        WHEN previous_month_sales IS NULL OR previous_month_sales = 0 THEN NULL
        ELSE ((total_sales - previous_month_sales) * 100.0) / previous_month_sales
    END AS mom_growth_pct
FROM monthly_growth
ORDER BY month_start;

-- Regional ranking by sales.
WITH region_sales AS (
    SELECT
        [Region],
        SUM([Sales]) AS total_sales,
        SUM([Profit]) AS total_profit
    FROM dbo.retail_cleaned
    GROUP BY [Region]
)
SELECT
    [Region],
    total_sales,
    total_profit,
    RANK() OVER (ORDER BY total_sales DESC) AS region_rank
FROM region_sales
ORDER BY region_rank;

-- Customer ranking by sales and profit.
WITH customer_perf AS (
    SELECT
        [Customer ID],
        [Customer Name],
        SUM([Sales]) AS total_sales,
        SUM([Profit]) AS total_profit
    FROM dbo.retail_cleaned
    GROUP BY [Customer ID], [Customer Name]
)
SELECT
    [Customer ID],
    [Customer Name],
    total_sales,
    total_profit,
    DENSE_RANK() OVER (ORDER BY total_sales DESC) AS sales_rank,
    DENSE_RANK() OVER (ORDER BY total_profit DESC) AS profit_rank
FROM customer_perf
ORDER BY sales_rank;

-- Running total sales by month.
WITH monthly_sales AS (
    SELECT
        DATEFROMPARTS(YEAR([Order Date]), MONTH([Order Date]), 1) AS month_start,
        SUM([Sales]) AS total_sales
    FROM dbo.retail_cleaned
    GROUP BY DATEFROMPARTS(YEAR([Order Date]), MONTH([Order Date]), 1)
)
SELECT
    month_start,
    total_sales,
    SUM(total_sales) OVER (ORDER BY month_start ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total_sales
FROM monthly_sales
ORDER BY month_start;

-- Profit analysis by category and sub-category.
WITH profit_summary AS (
    SELECT
        [Category],
        [Sub-Category],
        SUM([Sales]) AS total_sales,
        SUM([Profit]) AS total_profit
    FROM dbo.retail_cleaned
    GROUP BY [Category], [Sub-Category]
)
SELECT
    [Category],
    [Sub-Category],
    total_sales,
    total_profit,
    CASE
        WHEN total_sales = 0 THEN NULL
        ELSE (total_profit * 100.0) / total_sales
    END AS profit_margin_pct
FROM profit_summary
ORDER BY total_profit DESC;
