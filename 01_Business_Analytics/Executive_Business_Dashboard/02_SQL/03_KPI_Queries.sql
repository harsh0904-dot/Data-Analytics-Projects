/*
03_KPI_Queries.sql
Purpose: KPI computation queries for executive scorecards.
*/

-- Total Sales
SELECT SUM([Sales]) AS total_sales
FROM dbo.retail_cleaned;

-- Total Profit
SELECT SUM([Profit]) AS total_profit
FROM dbo.retail_cleaned;

-- Total Orders
SELECT COUNT(DISTINCT [Order ID]) AS total_orders
FROM dbo.retail_cleaned;

-- Total Customers
SELECT COUNT(DISTINCT [Customer ID]) AS total_customers
FROM dbo.retail_cleaned;

-- Profit Margin (%): Profit / Sales * 100
SELECT
	CASE WHEN SUM([Sales]) = 0 THEN NULL
		 ELSE (SUM([Profit]) * 100.0) / SUM([Sales])
	END AS profit_margin_pct
FROM dbo.retail_cleaned;

-- Average Order Value: Sales / Distinct Orders
SELECT
	CASE WHEN COUNT(DISTINCT [Order ID]) = 0 THEN NULL
		 ELSE SUM([Sales]) * 1.0 / COUNT(DISTINCT [Order ID])
	END AS average_order_value
FROM dbo.retail_cleaned;

-- Average Discount
SELECT AVG([Discount]) AS average_discount
FROM dbo.retail_cleaned;

-- Average Shipping Days
SELECT AVG(DATEDIFF(DAY, [Order Date], [Ship Date]) * 1.0) AS average_shipping_days
FROM dbo.retail_cleaned
WHERE [Order Date] IS NOT NULL
  AND [Ship Date] IS NOT NULL;

-- Quantity Sold
SELECT SUM([Quantity]) AS total_quantity_sold
FROM dbo.retail_cleaned;

-- Sales per Customer
SELECT
	[Customer ID],
	[Customer Name],
	SUM([Sales]) AS sales_per_customer
FROM dbo.retail_cleaned
GROUP BY [Customer ID], [Customer Name]
ORDER BY sales_per_customer DESC;

-- Profit per Customer
SELECT
	[Customer ID],
	[Customer Name],
	SUM([Profit]) AS profit_per_customer
FROM dbo.retail_cleaned
GROUP BY [Customer ID], [Customer Name]
ORDER BY profit_per_customer DESC;
