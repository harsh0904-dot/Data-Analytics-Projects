# Business Requirements Document (BRD)

## Project Title
Customer Marketing Analytics Dashboard

## Business Context
Marketing teams run campaigns across multiple platforms and audience segments. Leadership needs a single view to track budget usage, campaign effectiveness, and profitability.

## Problem Statement
Campaign performance metrics are distributed across raw data columns and are difficult to evaluate consistently without standardized KPI definitions.

## Business Objectives

- Improve marketing ROI by identifying high-performing channels and segments.
- Reduce inefficient spend by highlighting low-conversion campaigns.
- Enable weekly and monthly performance monitoring for decision-making.

## Stakeholders

- Marketing Manager
- Performance Marketing Analyst
- Finance/Revenue Team
- Executive Leadership

## In Scope

- Campaign performance analysis by platform, objective, audience, and time.
- KPI tracking (Spend, Revenue, Profit, ROAS, CTR, Conversion Rate, CPC, CPA).
- Executive dashboard for top-level and drill-down insights.

## Out of Scope

- Real-time streaming analytics.
- Attribution modeling across external channels.
- Automated campaign optimization logic.

## Success Criteria

- Dashboard provides full KPI coverage with consistent definitions.
- Users can identify top and bottom segments in less than 5 minutes.
- Final dataset supports analysis without manual recalculation of core metrics.

## Functional Requirements

1. Show high-level KPI cards for Spend, Revenue, Profit, and ROAS.
2. Compare performance by platform and campaign objective.
3. Analyze audience groups by age, gender, interest, and income bracket.
4. Provide time analysis by date, day of week, and hour of day.
5. Include filters for platform, objective, budget tier, and retargeting.

## Non-Functional Requirements

- Data refresh should complete within acceptable reporting window.
- Dashboard visuals must be readable for business users.
- Metrics must remain consistent between SQL, Python outputs, and Power BI.
