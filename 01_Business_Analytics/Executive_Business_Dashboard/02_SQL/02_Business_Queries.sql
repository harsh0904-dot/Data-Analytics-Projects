/*
02_Business_Queries.sql
Purpose: Business-facing analytical queries for Executive Dashboard.
*/

-- =========================
-- SALES ANALYSIS
-- =========================

-- Top 10 Products by Sales
SELECT TOP 10
	[Product ID],
	[Product Name],
	SUM([Sales]) AS total_sales
FROM dbo.retail_cleaned
GROUP BY [Product ID], [Product Name]
ORDER BY total_sales DESC;

-- Bottom 10 Products by Sales
SELECT TOP 10
	[Product ID],
	[Product Name],
	SUM([Sales]) AS total_sales
FROM dbo.retail_cleaned
GROUP BY [Product ID], [Product Name]
ORDER BY total_sales ASC;

-- Monthly Sales Trend
SELECT
	YEAR([Order Date]) AS sales_year,
	MONTH([Order Date]) AS sales_month,
	SUM([Sales]) AS total_sales
FROM dbo.retail_cleaned
GROUP BY YEAR([Order Date]), MONTH([Order Date])
ORDER BY sales_year, sales_month;

-- Quarterly Sales
SELECT
	YEAR([Order Date]) AS sales_year,
	DATEPART(QUARTER, [Order Date]) AS sales_quarter,
	SUM([Sales]) AS total_sales
FROM dbo.retail_cleaned
GROUP BY YEAR([Order Date]), DATEPART(QUARTER, [Order Date])
ORDER BY sales_year, sales_quarter;

-- Yearly Sales
SELECT
	YEAR([Order Date]) AS sales_year,
	SUM([Sales]) AS total_sales
FROM dbo.retail_cleaned
GROUP BY YEAR([Order Date])
ORDER BY sales_year;

-- Sales by Category
SELECT
	[Category],
	SUM([Sales]) AS total_sales
FROM dbo.retail_cleaned
GROUP BY [Category]
ORDER BY total_sales DESC;

-- Sales by Sub-Category
SELECT
	[Sub-Category],
	SUM([Sales]) AS total_sales
FROM dbo.retail_cleaned
GROUP BY [Sub-Category]
ORDER BY total_sales DESC;


-- =========================
-- CUSTOMER ANALYSIS
-- =========================

-- Top Customers by Sales
SELECT TOP 20
	[Customer ID],
	[Customer Name],
	SUM([Sales]) AS total_sales
FROM dbo.retail_cleaned
GROUP BY [Customer ID], [Customer Name]
ORDER BY total_sales DESC;

-- Customer Segment Performance
SELECT
	[Segment],
	SUM([Sales]) AS total_sales,
	SUM([Profit]) AS total_profit,
	COUNT(DISTINCT [Order ID]) AS total_orders
FROM dbo.retail_cleaned
GROUP BY [Segment]
ORDER BY total_sales DESC;

-- Repeat Customers
SELECT
	[Customer ID],
	[Customer Name],
	COUNT(DISTINCT [Order ID]) AS order_count
FROM dbo.retail_cleaned
GROUP BY [Customer ID], [Customer Name]
HAVING COUNT(DISTINCT [Order ID]) > 1
ORDER BY order_count DESC;

-- Customer Ranking by Sales
SELECT
	[Customer ID],
	[Customer Name],
	SUM([Sales]) AS total_sales,
	RANK() OVER (ORDER BY SUM([Sales]) DESC) AS sales_rank
FROM dbo.retail_cleaned
GROUP BY [Customer ID], [Customer Name]
ORDER BY sales_rank;


-- =========================
-- GEOGRAPHY ANALYSIS
-- =========================

-- Sales by Region
SELECT
	[Region],
	SUM([Sales]) AS total_sales
FROM dbo.retail_cleaned
GROUP BY [Region]
ORDER BY total_sales DESC;

-- Sales by State
SELECT
	[State],
	SUM([Sales]) AS total_sales
FROM dbo.retail_cleaned
GROUP BY [State]
ORDER BY total_sales DESC;

-- Sales by City
SELECT
	[City],
	SUM([Sales]) AS total_sales
FROM dbo.retail_cleaned
GROUP BY [City]
ORDER BY total_sales DESC;


-- =========================
-- PROFIT ANALYSIS
-- =========================

-- Highest Profit Products
SELECT TOP 20
	[Product ID],
	[Product Name],
	SUM([Profit]) AS total_profit
FROM dbo.retail_cleaned
GROUP BY [Product ID], [Product Name]
ORDER BY total_profit DESC;

-- Loss-Making Products
SELECT
	[Product ID],
	[Product Name],
	SUM([Profit]) AS total_profit
FROM dbo.retail_cleaned
GROUP BY [Product ID], [Product Name]
HAVING SUM([Profit]) < 0
ORDER BY total_profit ASC;

-- Discount vs Profit Analysis
SELECT
	[Discount],
	AVG([Profit]) AS avg_profit,
	SUM([Sales]) AS total_sales,
	COUNT(*) AS transaction_count
FROM dbo.retail_cleaned
GROUP BY [Discount]
ORDER BY [Discount];
