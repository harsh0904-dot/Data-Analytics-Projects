# SQL Analytics Layer

## Folder Purpose

This folder contains the full SQL analytics layer for the Executive Business Dashboard using the cleaned NovaMart Retail dataset.

## SQL Concepts Used

- Data definition and data quality checks
- Aggregation and KPI calculations
- Business-focused analytical queries
- Views for reusable semantic layers
- Stored procedures for repeatable reporting
- Window functions for ranking and trend analysis
- Common Table Expressions (CTEs) for multi-step logic

## Query Categories

- Data cleaning and validation: 01_Data_Cleaning.sql
- Business analysis: 02_Business_Queries.sql
- KPI calculations: 03_KPI_Queries.sql
- Reusable views: 04_Views.sql
- Parameterized procedures: 05_Stored_Procedures.sql
- Window function analytics: 06_Window_Functions.sql
- CTE-based analysis: 07_CTE_Analysis.sql

## Business Value

- Standardized metric definitions for dashboard consistency
- Faster analysis through reusable SQL artifacts
- Better decision support with trend, ranking, and profitability logic
- Cleaner separation between raw data checks and business reporting logic

## Best Practices

- Run data cleaning script first before analytical queries
- Use views and procedures for dashboard integration
- Keep business logic centralized in SQL files for traceability
- Validate nulls, duplicates, and numeric bounds regularly
- Index frequently queried columns to improve performance
