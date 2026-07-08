# Business Question Catalog

## 1. Purpose

This document defines the business questions that the Executive Business Dashboard must answer. Each question is mapped to a decision objective and KPI context so stakeholders can validate that the dashboard supports strategic and operational decisions.

## 2. How to Use This Document

- Use this catalog to validate dashboard scope during requirement sign-off.
- Use question IDs in design discussions, UAT scripts, and change requests.
- Prioritize implementation based on business impact and executive usage frequency.

Priority scale:

- P1: Critical for executive monitoring and monthly business reviews.
- P2: Important for functional performance management.
- P3: Useful for deeper investigation and optimization.

## 3. Question Inventory

| ID | Theme | Business Question | Decision Intent | Primary KPI(s) | Priority |
|---|---|---|---|---|---|
| BQ-01 | Overall Performance | What is the company’s total sales? | Verify top-line performance against plan and prior periods. | Sales Revenue | P1 |
| BQ-02 | Overall Performance | What is the total profit? | Assess absolute profitability at enterprise level. | Gross Profit | P1 |
| BQ-03 | Overall Performance | How many orders have been placed? | Monitor business volume and demand strength. | Order Volume | P1 |
| BQ-04 | Overall Performance | How many unique customers do we have? | Evaluate customer reach and commercial penetration. | Distinct Customers | P1 |
| BQ-05 | Overall Performance | What is the overall profit margin? | Evaluate efficiency of revenue-to-profit conversion. | Profit Margin % | P1 |
| BQ-06 | Sales Analysis | Which region generates the highest sales? | Identify regional revenue leaders for replication and benchmarking. | Sales Revenue by Region | P1 |
| BQ-07 | Sales Analysis | Which state contributes the highest revenue? | Prioritize state-level investment and sales planning. | Sales Revenue by State | P2 |
| BQ-08 | Sales Analysis | Which city has the highest sales? | Detect high-value micro-markets for growth focus. | Sales Revenue by City | P2 |
| BQ-09 | Sales Analysis | How has sales changed month over month? | Detect trend momentum and early signs of decline. | MoM Sales Growth % | P1 |
| BQ-10 | Sales Analysis | Which months perform the best? | Understand seasonality and improve demand planning. | Monthly Sales Trend | P2 |
| BQ-11 | Product Analysis | Which product categories generate the most sales? | Allocate portfolio focus to strongest revenue categories. | Sales Revenue by Category | P1 |
| BQ-12 | Product Analysis | Which sub-categories are the most profitable? | Improve product mix toward high-margin offerings. | Gross Profit by Sub-Category | P1 |
| BQ-13 | Product Analysis | Which products are top-performing? | Protect and scale high-performing SKUs. | Top Products by Sales/Profit | P2 |
| BQ-14 | Product Analysis | Which products generate losses? | Trigger corrective actions on pricing, discounting, or assortment. | Bottom Products by Profit | P1 |
| BQ-15 | Customer Analysis | Which customer segment contributes the highest revenue? | Align commercial strategy to strongest segment demand. | Sales Revenue by Segment | P1 |
| BQ-16 | Customer Analysis | Which customer segment is the most profitable? | Shift focus toward segments with best margin quality. | Profit Margin % by Segment | P1 |
| BQ-17 | Customer Analysis | Who are the top customers by sales? | Strengthen relationship strategy for key revenue accounts. | Sales Revenue by Customer | P2 |
| BQ-18 | Customer Analysis | Who are the top customers by profit? | Identify high-value customers beyond revenue volume. | Gross Profit by Customer | P2 |
| BQ-19 | Profitability | Does offering higher discounts reduce profit? | Validate discount policy and margin trade-offs. | Discount %, Gross Profit, Margin % | P1 |
| BQ-20 | Profitability | Which regions have high sales but low profit? | Detect structurally weak profitability despite strong volume. | Sales vs Profit by Region | P1 |
| BQ-21 | Executive Decision Making | Which business areas require immediate attention? | Prioritize management interventions on risk areas. | KPI variance and alert indicators | P1 |
| BQ-22 | Executive Decision Making | What opportunities exist to improve profitability? | Define actionable levers for margin improvement. | Margin drivers, discount impact, product mix | P1 |

## 4. Analytical Dimensions Required

To answer the questions above, the dashboard must support analysis by:

- Time: Day, Month, Quarter, Year.
- Geography: Region, State, City.
- Customer: Segment, Customer.
- Product: Category, Sub-Category, Product.

## 5. Key Design Implications for Dashboard

- KPI scorecards are required for BQ-01 to BQ-05.
- Trend visuals are required for BQ-09 and BQ-10.
- Ranking visuals are required for BQ-13, BQ-14, BQ-17, and BQ-18.
- Comparative visuals are required for BQ-19 and BQ-20.
- Conditional highlighting is required for BQ-21 and BQ-22.

## 6. Acceptance Criteria

This catalog is considered complete when:

- Each P1 question is mapped to at least one dashboard visual.
- KPI definitions align with the approved BRD KPI framework.
- Stakeholders confirm that decision-critical questions are fully covered.
- UAT test cases reference question IDs for traceability.