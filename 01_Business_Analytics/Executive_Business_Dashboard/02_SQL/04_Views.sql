/*
04_Views.sql
Purpose: Reusable views for dashboard and downstream SQL analysis.
*/

IF OBJECT_ID('dbo.vw_sales_summary', 'V') IS NOT NULL DROP VIEW dbo.vw_sales_summary;
GO
CREATE VIEW dbo.vw_sales_summary AS
SELECT
	COUNT(DISTINCT [Order ID]) AS total_orders,
	SUM([Sales]) AS total_sales,
	SUM([Profit]) AS total_profit,
	SUM([Quantity]) AS total_quantity,
	AVG([Discount]) AS average_discount
FROM dbo.retail_cleaned;
GO

IF OBJECT_ID('dbo.vw_customer_summary', 'V') IS NOT NULL DROP VIEW dbo.vw_customer_summary;
GO
CREATE VIEW dbo.vw_customer_summary AS
SELECT
	[Customer ID],
	[Customer Name],
	[Segment],
	COUNT(DISTINCT [Order ID]) AS total_orders,
	SUM([Sales]) AS total_sales,
	SUM([Profit]) AS total_profit
FROM dbo.retail_cleaned
GROUP BY [Customer ID], [Customer Name], [Segment];
GO

IF OBJECT_ID('dbo.vw_product_summary', 'V') IS NOT NULL DROP VIEW dbo.vw_product_summary;
GO
CREATE VIEW dbo.vw_product_summary AS
SELECT
	[Product ID],
	[Product Name],
	[Category],
	[Sub-Category],
	SUM([Sales]) AS total_sales,
	SUM([Profit]) AS total_profit,
	SUM([Quantity]) AS total_quantity
FROM dbo.retail_cleaned
GROUP BY [Product ID], [Product Name], [Category], [Sub-Category];
GO

IF OBJECT_ID('dbo.vw_region_summary', 'V') IS NOT NULL DROP VIEW dbo.vw_region_summary;
GO
CREATE VIEW dbo.vw_region_summary AS
SELECT
	[Region],
	[State],
	[City],
	SUM([Sales]) AS total_sales,
	SUM([Profit]) AS total_profit,
	COUNT(DISTINCT [Order ID]) AS total_orders
FROM dbo.retail_cleaned
GROUP BY [Region], [State], [City];
GO

IF OBJECT_ID('dbo.vw_monthly_sales', 'V') IS NOT NULL DROP VIEW dbo.vw_monthly_sales;
GO
CREATE VIEW dbo.vw_monthly_sales AS
SELECT
	YEAR([Order Date]) AS sales_year,
	MONTH([Order Date]) AS sales_month,
	DATEFROMPARTS(YEAR([Order Date]), MONTH([Order Date]), 1) AS month_start,
	SUM([Sales]) AS total_sales,
	SUM([Profit]) AS total_profit
FROM dbo.retail_cleaned
GROUP BY YEAR([Order Date]), MONTH([Order Date]), DATEFROMPARTS(YEAR([Order Date]), MONTH([Order Date]), 1);
GO

IF OBJECT_ID('dbo.vw_profit_analysis', 'V') IS NOT NULL DROP VIEW dbo.vw_profit_analysis;
GO
CREATE VIEW dbo.vw_profit_analysis AS
SELECT
	[Category],
	[Sub-Category],
	[Product ID],
	[Product Name],
	SUM([Sales]) AS total_sales,
	SUM([Profit]) AS total_profit,
	AVG([Discount]) AS average_discount,
	CASE WHEN SUM([Sales]) = 0 THEN NULL
		 ELSE (SUM([Profit]) * 100.0) / SUM([Sales])
	END AS profit_margin_pct
FROM dbo.retail_cleaned
GROUP BY [Category], [Sub-Category], [Product ID], [Product Name];
GO
