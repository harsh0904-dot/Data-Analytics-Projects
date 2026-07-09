/*
Customer Marketing Analytics - KPI Queries
Assumption: source table name is marketing_campaigns
*/

-- KPI 1: Total Spend
SELECT ROUND(SUM(ad_spend), 2) AS total_spend
FROM marketing_campaigns;

-- KPI 2: Total Revenue
SELECT ROUND(SUM(revenue), 2) AS total_revenue
FROM marketing_campaigns;

-- KPI 3: Total Profit
SELECT ROUND(SUM(revenue) - SUM(ad_spend), 2) AS total_profit
FROM marketing_campaigns;

-- KPI 4: Return On Ad Spend (ROAS)
SELECT ROUND(SUM(revenue) / NULLIF(SUM(ad_spend), 0), 3) AS overall_roas
FROM marketing_campaigns;

-- KPI 5: Click-Through Rate (CTR %)
SELECT ROUND(100.0 * SUM(clicks) / NULLIF(SUM(impressions), 0), 3) AS overall_ctr_pct
FROM marketing_campaigns;

-- KPI 6: Conversion Rate (%)
SELECT ROUND(100.0 * SUM(conversions) / NULLIF(SUM(clicks), 0), 3) AS overall_conversion_rate_pct
FROM marketing_campaigns;

-- KPI 7: Cost Per Click (CPC)
SELECT ROUND(SUM(ad_spend) / NULLIF(SUM(clicks), 0), 3) AS overall_cpc
FROM marketing_campaigns;

-- KPI 8: Cost Per Acquisition (CPA)
SELECT ROUND(SUM(ad_spend) / NULLIF(SUM(conversions), 0), 3) AS overall_cpa
FROM marketing_campaigns;

-- KPI 9: Average Quality Score
SELECT ROUND(AVG(quality_score), 2) AS avg_quality_score
FROM marketing_campaigns;

-- KPI 10: Average Bounce Rate
SELECT ROUND(AVG(bounce_rate), 2) AS avg_bounce_rate
FROM marketing_campaigns;

-- KPI 11: Campaign Count
SELECT COUNT(DISTINCT campaign_id) AS total_campaigns
FROM marketing_campaigns;

-- KPI 12: Profit Margin (%)
SELECT ROUND(100.0 * (SUM(revenue) - SUM(ad_spend)) / NULLIF(SUM(revenue), 0), 2) AS profit_margin_pct
FROM marketing_campaigns;

-- Dashboard Card Query (single-row KPI snapshot)
SELECT
	ROUND(SUM(ad_spend), 2) AS total_spend,
	ROUND(SUM(revenue), 2) AS total_revenue,
	ROUND(SUM(revenue) - SUM(ad_spend), 2) AS total_profit,
	ROUND(SUM(revenue) / NULLIF(SUM(ad_spend), 0), 3) AS roas,
	ROUND(100.0 * SUM(clicks) / NULLIF(SUM(impressions), 0), 3) AS ctr_pct,
	ROUND(100.0 * SUM(conversions) / NULLIF(SUM(clicks), 0), 3) AS conversion_rate_pct,
	ROUND(SUM(ad_spend) / NULLIF(SUM(conversions), 0), 3) AS cpa
FROM marketing_campaigns;
