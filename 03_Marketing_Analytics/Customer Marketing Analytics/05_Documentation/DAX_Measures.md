# DAX Measures

Use these measures in Power BI to keep KPI definitions consistent.

## Core Measures

```DAX
Total Spend = SUM('AdNova_Digital_Marketing'[ad_spend])

Total Revenue = SUM('AdNova_Digital_Marketing'[revenue])

Total Profit = [Total Revenue] - [Total Spend]

Total Clicks = SUM('AdNova_Digital_Marketing'[clicks])

Total Impressions = SUM('AdNova_Digital_Marketing'[impressions])

Total Conversions = SUM('AdNova_Digital_Marketing'[conversions])
```

## Ratio Measures

```DAX
ROAS = DIVIDE([Total Revenue], [Total Spend], 0)

CTR % = DIVIDE([Total Clicks], [Total Impressions], 0) * 100

Conversion Rate % = DIVIDE([Total Conversions], [Total Clicks], 0) * 100

CPC = DIVIDE([Total Spend], [Total Clicks], 0)

CPA = DIVIDE([Total Spend], [Total Conversions], 0)

Profit Margin % = DIVIDE([Total Profit], [Total Revenue], 0) * 100
```

## Quality and Engagement

```DAX
Average Quality Score = AVERAGE('AdNova_Digital_Marketing'[quality_score])

Average Bounce Rate = AVERAGE('AdNova_Digital_Marketing'[bounce_rate])

Average Session Duration (Sec) = AVERAGE('AdNova_Digital_Marketing'[avg_session_duration_seconds])
```

## Period Comparison (Optional)

```DAX
Revenue Previous Period =
CALCULATE(
	[Total Revenue],
	DATEADD('DimDate'[Date], -1, MONTH)
)

Revenue Growth % =
DIVIDE([Total Revenue] - [Revenue Previous Period], [Revenue Previous Period], 0) * 100
```
