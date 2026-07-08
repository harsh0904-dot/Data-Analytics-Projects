# Business Requirements Document (BRD)

## 1. Document Control

| Field | Details |
|---|---|
| Project Name | Executive Business Dashboard |
| Company | NovaMart Retail |
| Document Owner | Business Analytics Team |
| Prepared By | Data Analyst |
| Version | 1.0 |
| Date | 2026-07-04 |
| Status | Draft for Stakeholder Review |

## 2. Executive Summary

NovaMart Retail requires a unified executive reporting solution to monitor business performance across revenue, profitability, customer segments, product categories, and regions. Current reporting is fragmented and manually prepared, resulting in delays, inconsistent definitions, and limited ability to respond quickly to trends. This project will deliver an executive dashboard that provides near real-time visibility into performance and supports timely, data-driven decisions.

## 3. Business Context

NovaMart Retail operates across multiple regions and serves Consumer, Corporate, and Home Office segments with a broad product portfolio. Leadership requires a consistent view of business performance to:

- Evaluate whether strategic targets are being met.
- Detect underperforming regions, categories, and customer segments early.
- Understand margin pressure drivers and profitability opportunities.
- Prioritize commercial actions using fact-based insights.

## 4. Problem Statement

Senior management currently lacks a centralized and trusted reporting layer for core business KPIs. Existing manual reports are time-consuming, vulnerable to errors, and not standardized across functions. This creates decision latency and limits proactive performance management.

## 5. Project Objectives

The dashboard must enable executive users to:

- Monitor top-line and bottom-line KPIs in a single view.
- Analyze trends by time, region, segment, and product category.
- Identify growth opportunities and loss-making areas.
- Track progress against targets and prior period performance.
- Reduce report preparation dependency on manual analyst effort.

## 6. Scope

### 6.1 In Scope

- Executive-level KPI overview page.
- Drill-down by Region, Segment, Category, and Product.
- Time intelligence views (MTD, QTD, YTD, YoY where data permits).
- Profitability analysis including margin and discount impact.
- Customer and product performance ranking views.
- Standardized business definitions for approved KPIs.

### 6.2 Out of Scope

- Operational transaction-level workflows.
- Predictive forecasting models (phase 2 candidate).
- Writeback capability or planning workflows.
- Department-specific deep-dive dashboards beyond executive priority metrics.

## 7. Stakeholders and Roles

| Stakeholder | Role in Project | Key Decisions/Usage |
|---|---|---|
| CEO | Executive Sponsor | Strategic performance oversight and decision-making |
| COO | Business Sponsor | Operational performance direction |
| Sales Director | Functional Owner | Sales trend and regional action planning |
| Finance Manager | KPI Governance Owner | Metric definitions, margin and profitability validation |
| Regional Managers | Primary Consumers | Regional performance tracking and corrective actions |
| Data Analyst Team | Delivery Owner | Requirements, modeling, KPI validation, dashboard delivery |

## 8. KPI Framework

| KPI | Business Definition | Owner | Frequency |
|---|---|---|---|
| Sales Revenue | Net sales amount recognized for completed orders | Sales Director | Daily/Weekly |
| Gross Profit | Sales Revenue minus cost of goods sold | Finance Manager | Daily/Weekly |
| Profit Margin % | Gross Profit divided by Sales Revenue | Finance Manager | Daily/Weekly |
| Order Volume | Count of distinct orders | Sales Director | Daily/Weekly |
| Average Order Value | Sales Revenue divided by Order Volume | Sales Director | Weekly/Monthly |
| Discount % | Discount amount divided by gross sales | Finance Manager | Weekly/Monthly |
| YoY Growth % | Current period metric change versus same prior-year period | CEO/Finance | Monthly/Quarterly |

## 9. Functional Requirements

| ID | Requirement | Priority | Acceptance Measure |
|---|---|---|---|
| FR-01 | Dashboard shows executive KPI scorecards for Revenue, Gross Profit, Margin %, Orders, and YoY Growth. | High | All KPI cards display correct values with approved formulas. |
| FR-02 | Users can filter by Date Range, Region, Segment, and Category. | High | Filter selections update all visuals consistently. |
| FR-03 | Users can drill down from summary to regional and category performance. | High | Drill paths function correctly and preserve filter context. |
| FR-04 | Dashboard highlights top 10 and bottom 10 products by profit. | Medium | Ranking visuals correctly sort and update based on active filters. |
| FR-05 | Dashboard includes trend view for monthly Revenue and Margin %. | High | Trend charts display complete time-series with correct granularity. |
| FR-06 | Dashboard includes customer segment comparison for Revenue and Margin %. | Medium | Segment comparison view supports direct side-by-side analysis. |

## 10. Non-Functional Requirements

| ID | Requirement | Target |
|---|---|---|
| NFR-01 | Performance | Initial dashboard load less than 5 seconds for standard executive view. |
| NFR-02 | Data Freshness | Data refresh completed by 8:00 AM local time on business days. |
| NFR-03 | Usability | Executive users can interpret KPI status within 30 seconds of opening. |
| NFR-04 | Security | Role-based access enforced for leadership and management groups. |
| NFR-05 | Availability | Dashboard available during business hours with at least 99% uptime. |

## 11. Data Requirements and Assumptions

### 11.1 Required Data Domains

- Sales transactions (date, order, product, customer, region, segment, amount, discount).
- Product master (product, sub-category, category, standard cost).
- Customer master (customer ID, segment, geography).
- Calendar table (date, month, quarter, fiscal attributes if applicable).

### 11.2 Assumptions

- Source systems provide complete and historical data with stable keys.
- Finance-approved cost and discount definitions are available.
- Historical data quality issues are identified and remediated prior to UAT.

## 12. Risks and Mitigations

| Risk | Impact | Mitigation |
|---|---|---|
| Inconsistent KPI definitions across teams | Conflicting numbers and low trust | Finalize KPI dictionary and sign-off by Finance Manager and Sales Director. |
| Data quality gaps in source systems | Incorrect decisions based on flawed insights | Implement validation checks and exception reporting before release. |
| Scope creep from additional feature requests | Timeline delay | Enforce phase-wise scope and change control with sponsor approval. |
| Low adoption by business users | Reduced business value realization | Conduct user walkthroughs and provide quick reference guidance. |

## 13. Success Criteria

The project will be considered successful when:

- Leadership has a single trusted dashboard for core KPIs.
- Manual executive reporting effort is reduced by at least 50%.
- Monthly business review preparation time decreases measurably.
- Regional and category underperformance can be identified in one session.
- Stakeholder sign-off is completed after UAT with no critical defects.

## 14. UAT Acceptance Criteria

- All high-priority functional requirements (FR-01, FR-02, FR-03, FR-05) pass UAT.
- KPI values match validated benchmark reports for agreed test scenarios.
- Access control is tested and approved for each user role.
- Performance and refresh targets in NFRs are met.