# Project Approach

## 1. Data Understanding

- Review available columns in raw campaign dataset.
- Identify dimensions (platform, audience, time) and measures (spend, revenue, conversions).
- Validate data types and completeness.

## 2. Data Preparation (Python)

- Standardize column naming and formatting.
- Convert date, numeric, and boolean fields to proper types.
- Recalculate core metrics (CTR, CPC, Conversion Rate, CPA, ROAS, Profit).
- Save final cleaned file for Power BI consumption.

## 3. SQL Analysis

- Build reusable SQL queries for platform, objective, audience, and time analysis.
- Define KPI snapshot queries for quick dashboard cards.
- Use SQL outputs to validate KPI logic.

## 4. Exploratory Analysis

- Generate statistical summaries and grouped performance views.
- Identify data distribution patterns and performance outliers.
- Validate business assumptions before dashboard build.

## 5. Feature Engineering

- Derive additional fields such as day part, campaign week, and engagement score.
- Keep engineered outputs in analysis folder for advanced modeling use cases.

## 6. Dashboard Development (Power BI)

- Build KPI overview section for leadership.
- Add drill-down visuals for platform, audience, and time analysis.
- Implement filters and interactions for self-service insights.

## 7. Insight Generation

- Translate findings into budget and optimization recommendations.
- Highlight actions with measurable expected business impact.
