/*
05_Stored_Procedures.sql
Purpose: Parameterized procedures for common dashboard analytics retrieval.
*/

IF OBJECT_ID('dbo.usp_GetKPIOverview', 'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_GetKPIOverview;
GO
CREATE PROCEDURE dbo.usp_GetKPIOverview
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        SUM([Sales]) AS total_sales,
        SUM([Profit]) AS total_profit,
        COUNT(DISTINCT [Order ID]) AS total_orders,
        COUNT(DISTINCT [Customer ID]) AS total_customers,
        CASE WHEN SUM([Sales]) = 0 THEN NULL
             ELSE (SUM([Profit]) * 100.0) / SUM([Sales])
        END AS profit_margin_pct,
        CASE WHEN COUNT(DISTINCT [Order ID]) = 0 THEN NULL
             ELSE SUM([Sales]) * 1.0 / COUNT(DISTINCT [Order ID])
        END AS average_order_value
    FROM dbo.retail_cleaned;
END;
GO

IF OBJECT_ID('dbo.usp_GetSalesByDateRange', 'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_GetSalesByDateRange;
GO
CREATE PROCEDURE dbo.usp_GetSalesByDateRange
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [Order Date],
        SUM([Sales]) AS total_sales,
        SUM([Profit]) AS total_profit,
        COUNT(DISTINCT [Order ID]) AS total_orders
    FROM dbo.retail_cleaned
    WHERE [Order Date] BETWEEN @StartDate AND @EndDate
    GROUP BY [Order Date]
    ORDER BY [Order Date];
END;
GO

IF OBJECT_ID('dbo.usp_GetTopProducts', 'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_GetTopProducts;
GO
CREATE PROCEDURE dbo.usp_GetTopProducts
    @TopN INT = 10
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (@TopN)
        [Product ID],
        [Product Name],
        SUM([Sales]) AS total_sales,
        SUM([Profit]) AS total_profit
    FROM dbo.retail_cleaned
    GROUP BY [Product ID], [Product Name]
    ORDER BY total_sales DESC;
END;
GO

IF OBJECT_ID('dbo.usp_GetRegionPerformance', 'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_GetRegionPerformance;
GO
CREATE PROCEDURE dbo.usp_GetRegionPerformance
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [Region],
        SUM([Sales]) AS total_sales,
        SUM([Profit]) AS total_profit,
        COUNT(DISTINCT [Order ID]) AS total_orders,
        AVG([Discount]) AS average_discount
    FROM dbo.retail_cleaned
    GROUP BY [Region]
    ORDER BY total_sales DESC;
END;
GO
