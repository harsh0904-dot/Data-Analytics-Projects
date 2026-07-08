# Dashboard Build Steps (Power BI Desktop)

## Current Status

- Documentation is ready.
- The actual .pbix report page is not created yet.

## 1. Load Data

1. Open Power BI Desktop.
2. Get Data -> Text/CSV.
3. Select ../01_Dataset/Clean_Data/NovaMart_Retail_Cleaned.csv.
4. Click Transform Data.

## 2. Build Star Schema in Power Query

1. Keep one query as Fact_Sales.
2. Reference Fact_Sales to create dimensions:
- Dim_Date from Order Date (remove duplicates)
- Dim_Customer from Customer fields (remove duplicates)
- Dim_Product from Product fields (remove duplicates)
- Dim_Geography from Region/State/City/Postal Code (remove duplicates)
3. Ensure correct data types for each table.
4. Close & Apply.

## 3. Create Relationships

1. Open Model view.
2. Create one-to-many, single-direction relationships:
- Dim_Date[Date] -> Fact_Sales[Order Date]
- Dim_Customer[Customer ID] -> Fact_Sales[Customer ID]
- Dim_Product[Product ID] -> Fact_Sales[Product ID]
- Dim_Geography[Region/State/City key] -> Fact_Sales matching key
3. Mark Dim_Date as Date table using Dim_Date[Date].

## 4. Apply Theme

1. View -> Themes -> Browse for themes.
2. Import Theme.json from this folder.

## 5. Add DAX Measures

1. Create a measure table (optional) named Measures.
2. Copy measures from DAX_Measures.md.
3. Format:
- Currency for Sales/Profit/AOV
- Percentage for Margin/Growth/Discount
- Whole number for Orders/Customers/Quantity

## 6. Build Executive Overview Page

### Header

- Left: logo placeholder image
- Center: dashboard title
- Right: Last Refresh Date measure card

### KPI Row (6 cards)

- Total Sales
- Total Profit
- Total Orders
- Total Customers
- Profit Margin %
- Average Order Value

### Main visuals

- Line: Monthly Sales Trend
- Map/Bar: Sales by Region
- Bar: Sales by Category
- Bar: Profit by Category
- Bar: Top 10 Products
- Bar: Top 10 Customers
- Scatter: Profit vs Discount
- Donut/Bar: Sales by Segment

### Slicers

- Year
- Region
- Category
- Sub-Category
- Segment

## 7. Interactivity

1. Drill-through pages for Product and Customer.
2. Create tooltip page and assign to key visuals.
3. Use dynamic title measures for trend and category visuals.
4. Sync slicers if multiple pages exist.
5. Add bookmarks:
- Default View
- Focus View
6. Add Reset Filters button linked to Default View bookmark.
7. Add navigation buttons between overview/detail pages.

## 8. Performance Pass

1. Keep only required visuals on page.
2. Disable unnecessary visual interactions.
3. Avoid calculated columns when equivalent measures exist.
4. Remove unused columns from model.

## 9. Publish-Ready Check

- Cross-filtering works correctly.
- KPI totals match SQL outputs.
- Tooltips and drill-through pass test scenarios.
- Layout is aligned and readable on laptop screen.
