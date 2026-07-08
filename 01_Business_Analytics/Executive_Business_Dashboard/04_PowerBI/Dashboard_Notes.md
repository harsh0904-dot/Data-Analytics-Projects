# Dashboard Notes - NovaMart Executive Business Dashboard

## 1. Data Model

### Star Schema

- Fact Table: Fact_Sales
- Dimension Tables: Dim_Date, Dim_Customer, Dim_Product, Dim_Geography

### Relationship Design

- One-to-many relationships from dimensions to fact
- Single-direction filters from dimensions to fact
- Mark Dim_Date as the Date Table using Dim_Date[Date]

### Suggested Keys

- Fact_Sales[Order Date] -> Dim_Date[Date]
- Fact_Sales[Customer ID] -> Dim_Customer[Customer ID]
- Fact_Sales[Product ID] -> Dim_Product[Product ID]
- Fact_Sales[Postal Code] or Fact_Sales[State/City key] -> Dim_Geography key

## 2. Power Query Finalization

- Rename columns to business-friendly names
- Confirm data types (Date, Whole Number, Decimal Number, Text)
- Remove technical or unused columns
- Check and handle nulls in key fields
- Keep only required columns for model efficiency
- Disable load for intermediate queries

## 3. DAX Scope

Use measures listed in DAX_Measures.md for:

- Executive KPIs
- Comparison KPIs
- Rankings
- Time intelligence
- Dynamic titles and refresh labels

## 4. Dashboard Layout Blueprint

### Header

- NovaMart Retail logo placeholder (left)
- Executive Business Dashboard title (center)
- Last Refresh Date card (right)

### KPI Row (6 Cards)

- Total Sales
- Total Profit
- Total Orders
- Total Customers
- Profit Margin %
- Average Order Value

### Main Visuals

- Monthly Sales Trend (line chart)
- Sales by Region (filled map or bar chart fallback)
- Sales by Category (bar chart)
- Profit by Category (bar chart)
- Top 10 Products (bar chart)
- Top 10 Customers (bar chart)
- Profit vs Discount (scatter chart)
- Sales by Segment (donut or bar chart)

### Slicers

- Year
- Region
- Category
- Sub-Category
- Segment

## 5. Interactive Features

- Drill-through pages for Product and Customer analysis
- Report page tooltips for category and product visuals
- Dynamic titles and subtitles via DAX measures
- Sync slicers across pages
- Bookmarks for default view and focused views
- Reset Filters button (bookmark action)
- Navigation buttons between overview and detail pages

## 6. Design Standards

- Theme: modern executive look
- Font: Segoe UI
- Style: minimalist, clean spacing, consistent alignment
- Use professional icons and consistent color semantics
- Avoid clutter and 3D visuals

## 7. Performance Guidelines

- Limit visual count per page
- Prefer DAX measures over calculated columns where possible
- Disable unnecessary visual interactions
- Reduce model size by removing unused columns and tables
- Use star schema only (avoid snowflake when unnecessary)

## 8. Build Order

1. Load cleaned dataset and create dimension/fact tables
2. Build relationships and mark Date Table
3. Apply theme from Theme.json
4. Create all DAX measures
5. Place KPI cards, visuals, and slicers
6. Add interactions, bookmarks, and navigation
7. Validate performance and cross-filter behavior
8. Publish and test with business scenarios
