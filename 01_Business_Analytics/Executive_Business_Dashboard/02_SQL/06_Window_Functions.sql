/*
06_Window_Functions.sql
Purpose: Advanced analytics using SQL window functions.
*/

-- ROW_NUMBER: Sequential row ID for product sales ranking.
SELECT
    [Product ID],
    [Product Name],
    SUM([Sales]) AS total_sales,
    ROW_NUMBER() OVER (ORDER BY SUM([Sales]) DESC) AS row_num_sales
FROM dbo.retail_cleaned
GROUP BY [Product ID], [Product Name]
ORDER BY row_num_sales;

-- RANK: Rank products by sales with gaps for ties.
SELECT
    [Product ID],
    [Product Name],
    SUM([Sales]) AS total_sales,
    RANK() OVER (ORDER BY SUM([Sales]) DESC) AS rank_sales
FROM dbo.retail_cleaned
GROUP BY [Product ID], [Product Name]
ORDER BY rank_sales;

-- DENSE_RANK: Rank products by profit without gaps.
SELECT
    [Product ID],
    [Product Name],
    SUM([Profit]) AS total_profit,
    DENSE_RANK() OVER (ORDER BY SUM([Profit]) DESC) AS dense_rank_profit
FROM dbo.retail_cleaned
GROUP BY [Product ID], [Product Name]
ORDER BY dense_rank_profit;

-- LAG and LEAD: Compare monthly sales to previous/next month.
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
    LAG(total_sales, 1) OVER (ORDER BY month_start) AS previous_month_sales,
    LEAD(total_sales, 1) OVER (ORDER BY month_start) AS next_month_sales
FROM monthly_sales
ORDER BY month_start;

-- NTILE: Split customers into 4 spending segments.
WITH customer_sales AS (
    SELECT
        [Customer ID],
        [Customer Name],
        SUM([Sales]) AS total_sales
    FROM dbo.retail_cleaned
    GROUP BY [Customer ID], [Customer Name]
)
SELECT
    [Customer ID],
    [Customer Name],
    total_sales,
    NTILE(4) OVER (ORDER BY total_sales DESC) AS sales_quartile
FROM customer_sales
ORDER BY total_sales DESC;
