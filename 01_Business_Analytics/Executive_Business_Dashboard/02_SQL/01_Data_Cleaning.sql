/*
01_Data_Cleaning.sql
Purpose: Build and validate the cleaned retail table for analytics.
Dialect: T-SQL (SQL Server)
*/

-- 1) Create target table for cleaned NovaMart retail data.
IF OBJECT_ID('dbo.retail_cleaned', 'U') IS NOT NULL
	DROP TABLE dbo.retail_cleaned;
GO

CREATE TABLE dbo.retail_cleaned (
	[Row ID]        INT             NULL,
	[Order ID]      VARCHAR(30)     NULL,
	[Order Date]    DATE            NULL,
	[Year]          INT             NULL,
	[Months]        VARCHAR(20)     NULL,
	[Ship Date]     DATE            NULL,
	[Ship Mode]     VARCHAR(30)     NULL,
	[Customer ID]   VARCHAR(30)     NULL,
	[Customer Name] VARCHAR(150)    NULL,
	[Segment]       VARCHAR(30)     NULL,
	[Country]       VARCHAR(60)     NULL,
	[City]          VARCHAR(80)     NULL,
	[State]         VARCHAR(80)     NULL,
	[Postal Code]   VARCHAR(20)     NULL,
	[Region]        VARCHAR(30)     NULL,
	[Product ID]    VARCHAR(30)     NULL,
	[Category]      VARCHAR(50)     NULL,
	[Sub-Category]  VARCHAR(50)     NULL,
	[Product Name]  VARCHAR(255)    NULL,
	[Sales]         DECIMAL(18,4)   NULL,
	[Quantity]      INT             NULL,
	[Discount]      DECIMAL(10,4)   NULL,
	[Profit]        DECIMAL(18,4)   NULL
);
GO

-- 2) Import cleaned CSV.
-- Update @csv_path for your machine before execution.
DECLARE @csv_path NVARCHAR(4000) =
N'D:\GitHub\Data-Analyst-Projects\01_Business_Analytics\Executive_Business_Dashboard\01_Dataset\Clean_Data\NovaMart_Retail_Cleaned.csv';

DECLARE @sql NVARCHAR(MAX) = N'
BULK INSERT dbo.retail_cleaned
FROM ''' + REPLACE(@csv_path, '''', '''''') + N'''
WITH (
	FORMAT = ''CSV'',
	FIRSTROW = 2,
	FIELDQUOTE = ''"'',
	FIELDTERMINATOR = '','',
	ROWTERMINATOR = ''0x0a'',
	TABLOCK,
	CODEPAGE = ''65001''
);';

EXEC sp_executesql @sql;
GO

-- 3) Verify total row count after import.
SELECT COUNT(*) AS total_rows
FROM dbo.retail_cleaned;

-- 4) Check NULL values on critical analytical columns.
SELECT
	SUM(CASE WHEN [Order ID] IS NULL THEN 1 ELSE 0 END) AS null_order_id,
	SUM(CASE WHEN [Order Date] IS NULL THEN 1 ELSE 0 END) AS null_order_date,
	SUM(CASE WHEN [Customer ID] IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
	SUM(CASE WHEN [Product ID] IS NULL THEN 1 ELSE 0 END) AS null_product_id,
	SUM(CASE WHEN [Sales] IS NULL THEN 1 ELSE 0 END) AS null_sales,
	SUM(CASE WHEN [Profit] IS NULL THEN 1 ELSE 0 END) AS null_profit,
	SUM(CASE WHEN [Discount] IS NULL THEN 1 ELSE 0 END) AS null_discount,
	SUM(CASE WHEN [Quantity] IS NULL THEN 1 ELSE 0 END) AS null_quantity
FROM dbo.retail_cleaned;

-- 5) Detect duplicate business rows using Order ID + Product ID + Customer ID.
SELECT
	[Order ID],
	[Product ID],
	[Customer ID],
	COUNT(*) AS duplicate_count
FROM dbo.retail_cleaned
GROUP BY [Order ID], [Product ID], [Customer ID]
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

-- 6) Validate date format health (invalid date values become NULL at load).
SELECT
	SUM(CASE WHEN [Order Date] IS NULL THEN 1 ELSE 0 END) AS invalid_or_null_order_date,
	SUM(CASE WHEN [Ship Date] IS NULL THEN 1 ELSE 0 END) AS invalid_or_null_ship_date
FROM dbo.retail_cleaned;

-- 7) Check negative Sales and Profit records.
SELECT
	SUM(CASE WHEN [Sales] < 0 THEN 1 ELSE 0 END) AS negative_sales_rows,
	SUM(CASE WHEN [Profit] < 0 THEN 1 ELSE 0 END) AS negative_profit_rows
FROM dbo.retail_cleaned;

-- 8) Validate discount range (expected between 0 and 1).
SELECT
	SUM(CASE WHEN [Discount] < 0 OR [Discount] > 1 THEN 1 ELSE 0 END) AS out_of_range_discount_rows
FROM dbo.retail_cleaned;

-- 9) Add indexes on frequently queried columns for dashboard workloads.
CREATE INDEX IX_retail_cleaned_order_date ON dbo.retail_cleaned ([Order Date]);
CREATE INDEX IX_retail_cleaned_region ON dbo.retail_cleaned ([Region]);
CREATE INDEX IX_retail_cleaned_category ON dbo.retail_cleaned ([Category]);
CREATE INDEX IX_retail_cleaned_customer ON dbo.retail_cleaned ([Customer ID]);
CREATE INDEX IX_retail_cleaned_product ON dbo.retail_cleaned ([Product ID]);
GO

-- 10) Final validation snapshot.
SELECT TOP 20 *
FROM dbo.retail_cleaned
ORDER BY [Order Date] DESC;
