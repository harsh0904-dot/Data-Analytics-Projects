# Data Model

## Modeling Strategy

The project uses a single campaign-level fact table with supporting derived date and category fields for slicing performance.

## Fact Table

### `FactCampaignPerformance`

Grain: One row per campaign record per date context.

Key columns:

- campaign_id
- start_date
- platform
- campaign_objective
- ad_placement
- device_type
- target_audience_age
- target_audience_gender
- audience_interest_category
- budget_tier

Measures:

- impressions
- clicks
- conversions
- ad_spend
- revenue
- ctr
- cpc
- conversion_rate
- cpa
- roas
- profit

## Recommended Dimensions

1. `DimDate`
	- Date, Year, Quarter, Month, Week, Day Name
2. `DimPlatform`
	- Platform, Placement, Device
3. `DimAudience`
	- Age Band, Gender, Interest Category, Income Bracket
4. `DimCampaign`
	- Campaign ID, Objective, Creative Format, Budget Tier, Retargeting Flag

## Relationship Guidance

- `FactCampaignPerformance[start_date]` -> `DimDate[Date]` (Many-to-One)
- Keep dimensions as one-side lookup tables.
- Use single-direction filtering from dimensions to fact.

## Data Quality Notes

- Ensure no duplicate `campaign_id` rows after cleaning logic.
- Validate ratio metrics against base measures in DAX.
- Keep a single final dataset in `Cleaned_Data` for dashboard consistency.
