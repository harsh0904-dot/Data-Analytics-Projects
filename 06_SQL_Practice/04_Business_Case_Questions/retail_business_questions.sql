-- BUSINESS CASE QUESTIONS: RETAIL SQL

-- Q1) Which product categories generate the highest revenue?
SELECT
    category,
    SUM(revenue) AS total_revenue
FROM retail_sales
GROUP BY category
ORDER BY total_revenue DESC;

-- Q2) Which customers have the highest average order value?
SELECT
    customer_id,
    ROUND(AVG(order_value), 2) AS average_order_value
FROM retail_sales
GROUP BY customer_id
ORDER BY average_order_value DESC;

-- Q3) Which month had the strongest sales performance?
SELECT
    sales_month,
    SUM(revenue) AS total_revenue
FROM retail_sales
GROUP BY sales_month
ORDER BY total_revenue DESC;
