/*
Customer Marketing Analytics - Core Analysis Queries
Assumption: source table name is marketing_campaigns
If your table name is different, replace it in all queries.
*/

-- 1) Basic dataset profile
SELECT
	COUNT(*) AS total_rows,
	COUNT(DISTINCT campaign_id) AS total_campaigns,
	MIN(start_date) AS min_start_date,
	MAX(start_date) AS max_start_date
FROM marketing_campaigns;

-- 2) Platform-level performance
SELECT
	platform,
	COUNT(DISTINCT campaign_id) AS campaigns,
	SUM(impressions) AS impressions,
	SUM(clicks) AS clicks,
	SUM(conversions) AS conversions,
	ROUND(SUM(ad_spend), 2) AS total_spend,
	ROUND(SUM(revenue), 2) AS total_revenue,
	ROUND(SUM(revenue) - SUM(ad_spend), 2) AS total_profit,
	ROUND(100.0 * SUM(clicks) / NULLIF(SUM(impressions), 0), 3) AS ctr_pct,
	ROUND(SUM(ad_spend) / NULLIF(SUM(clicks), 0), 3) AS cpc,
	ROUND(100.0 * SUM(conversions) / NULLIF(SUM(clicks), 0), 3) AS conversion_rate_pct,
	ROUND(SUM(revenue) / NULLIF(SUM(ad_spend), 0), 3) AS roas
FROM marketing_campaigns
GROUP BY platform
ORDER BY total_revenue DESC;

-- 3) Campaign objective performance
SELECT
	campaign_objective,
	COUNT(DISTINCT campaign_id) AS campaigns,
	ROUND(SUM(ad_spend), 2) AS total_spend,
	ROUND(SUM(revenue), 2) AS total_revenue,
	ROUND(SUM(revenue) - SUM(ad_spend), 2) AS total_profit,
	ROUND(SUM(revenue) / NULLIF(SUM(ad_spend), 0), 3) AS roas,
	ROUND(100.0 * SUM(conversions) / NULLIF(SUM(clicks), 0), 3) AS conversion_rate_pct
FROM marketing_campaigns
GROUP BY campaign_objective
ORDER BY roas DESC;

-- 4) Industry vertical performance
SELECT
	industry_vertical,
	ROUND(SUM(ad_spend), 2) AS total_spend,
	ROUND(SUM(revenue), 2) AS total_revenue,
	ROUND(SUM(revenue) - SUM(ad_spend), 2) AS total_profit,
	ROUND(SUM(revenue) / NULLIF(SUM(ad_spend), 0), 3) AS roas
FROM marketing_campaigns
GROUP BY industry_vertical
ORDER BY total_profit DESC;

-- 5) Audience segment by age and gender
SELECT
	target_audience_age,
	target_audience_gender,
	COUNT(DISTINCT campaign_id) AS campaigns,
	ROUND(SUM(ad_spend), 2) AS total_spend,
	ROUND(SUM(revenue), 2) AS total_revenue,
	ROUND(SUM(revenue) - SUM(ad_spend), 2) AS total_profit,
	ROUND(SUM(revenue) / NULLIF(SUM(ad_spend), 0), 3) AS roas
FROM marketing_campaigns
GROUP BY target_audience_age, target_audience_gender
ORDER BY roas DESC, total_revenue DESC;

-- 6) Day-of-week performance
SELECT
	day_of_week,
	ROUND(SUM(ad_spend), 2) AS total_spend,
	ROUND(SUM(revenue), 2) AS total_revenue,
	ROUND(SUM(revenue) - SUM(ad_spend), 2) AS total_profit,
	ROUND(SUM(revenue) / NULLIF(SUM(ad_spend), 0), 3) AS roas,
	ROUND(100.0 * SUM(conversions) / NULLIF(SUM(clicks), 0), 3) AS conversion_rate_pct
FROM marketing_campaigns
GROUP BY day_of_week
ORDER BY roas DESC;

-- 7) Hour-of-day performance
SELECT
	hour_of_day,
	ROUND(SUM(ad_spend), 2) AS total_spend,
	ROUND(SUM(revenue), 2) AS total_revenue,
	ROUND(SUM(revenue) - SUM(ad_spend), 2) AS total_profit,
	ROUND(SUM(revenue) / NULLIF(SUM(ad_spend), 0), 3) AS roas,
	ROUND(100.0 * SUM(clicks) / NULLIF(SUM(impressions), 0), 3) AS ctr_pct
FROM marketing_campaigns
GROUP BY hour_of_day
ORDER BY roas DESC;

-- 8) Budget tier vs performance
SELECT
	budget_tier,
	COUNT(DISTINCT campaign_id) AS campaigns,
	ROUND(AVG(quality_score), 2) AS avg_quality_score,
	ROUND(SUM(ad_spend), 2) AS total_spend,
	ROUND(SUM(revenue), 2) AS total_revenue,
	ROUND(SUM(revenue) / NULLIF(SUM(ad_spend), 0), 3) AS roas,
	ROUND(AVG(cpa), 3) AS avg_cpa
FROM marketing_campaigns
GROUP BY budget_tier
ORDER BY roas DESC;

-- 9) Retargeting impact
SELECT
	retargeting_flag,
	COUNT(DISTINCT campaign_id) AS campaigns,
	ROUND(SUM(ad_spend), 2) AS total_spend,
	ROUND(SUM(revenue), 2) AS total_revenue,
	ROUND(SUM(revenue) / NULLIF(SUM(ad_spend), 0), 3) AS roas,
	ROUND(100.0 * SUM(conversions) / NULLIF(SUM(clicks), 0), 3) AS conversion_rate_pct
FROM marketing_campaigns
GROUP BY retargeting_flag
ORDER BY roas DESC;

-- 10) Top 15 campaigns by profit
SELECT
	campaign_id,
	platform,
	campaign_objective,
	industry_vertical,
	ROUND(ad_spend, 2) AS ad_spend,
	ROUND(revenue, 2) AS revenue,
	ROUND(profit, 2) AS profit,
	ROUND(roas, 3) AS roas,
	ROUND(conversion_rate, 3) AS conversion_rate_pct
FROM marketing_campaigns
ORDER BY profit DESC
LIMIT 15;
