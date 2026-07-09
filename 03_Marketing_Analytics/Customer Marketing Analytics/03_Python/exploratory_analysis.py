from pathlib import Path

import pandas as pd


BASE_DIR = Path(__file__).resolve().parent.parent
CLEANED_FILE = BASE_DIR / "01_Dataset" / "Cleaned_Data" / "AdNova_Digital_Marketing.xlsx"
RAW_FILE = BASE_DIR / "01_Dataset" / "Raw_Data" / "tech_advertising_campaigns_dataset.csv"
EDA_OUTPUT_FILE = BASE_DIR / "01_Dataset" / "Analysis_Outputs" / "AdNova_Digital_Marketing_EDA.xlsx"


def load_analysis_dataset() -> pd.DataFrame:
	if CLEANED_FILE.exists():
		return pd.read_excel(CLEANED_FILE)
	return pd.read_csv(RAW_FILE)


def safe_grouped_metrics(df: pd.DataFrame, group_col: str) -> pd.DataFrame:
	metrics = [
		"impressions",
		"clicks",
		"conversions",
		"ad_spend",
		"revenue",
		"profit",
		"roas",
		"ctr",
		"conversion_rate",
	]
	existing_metrics = [column for column in metrics if column in df.columns]
	grouped = (
		df.groupby(group_col, dropna=False)[existing_metrics]
		.mean(numeric_only=True)
		.sort_values(by=existing_metrics[0], ascending=False)
		.round(3)
	)
	return grouped.reset_index()


def build_eda_tables(df: pd.DataFrame) -> dict[str, pd.DataFrame]:
	working = df.copy()
	working.columns = [column.strip().lower() for column in working.columns]

	if "start_date" in working.columns:
		working["start_date"] = pd.to_datetime(working["start_date"], errors="coerce")

	numeric_summary = working.describe(include=["number"]).T.reset_index().rename(columns={"index": "metric"})

	missing_values = (
		working.isna()
		.sum()
		.reset_index()
		.rename(columns={"index": "column", 0: "missing_count"})
		.sort_values(by="missing_count", ascending=False)
	)

	platform_performance = safe_grouped_metrics(working, "platform") if "platform" in working.columns else pd.DataFrame()
	objective_performance = (
		safe_grouped_metrics(working, "campaign_objective") if "campaign_objective" in working.columns else pd.DataFrame()
	)

	daily_trend = pd.DataFrame()
	if "start_date" in working.columns:
		trend_metrics = [
			column
			for column in ["impressions", "clicks", "conversions", "ad_spend", "revenue", "profit"]
			if column in working.columns
		]
		if trend_metrics:
			daily_trend = (
				working.groupby(working["start_date"].dt.date)[trend_metrics]
				.sum(numeric_only=True)
				.reset_index()
				.rename(columns={"start_date": "date"})
			)

	return {
		"dataset_overview": pd.DataFrame(
			{
				"metric": ["rows", "columns"],
				"value": [len(working), len(working.columns)],
			}
		),
		"missing_values": missing_values,
		"numeric_summary": numeric_summary,
		"platform_performance": platform_performance,
		"objective_performance": objective_performance,
		"daily_trend": daily_trend,
	}


def save_eda_workbook(tables: dict[str, pd.DataFrame], output_path: Path) -> None:
	output_path.parent.mkdir(parents=True, exist_ok=True)
	with pd.ExcelWriter(output_path, engine="openpyxl") as writer:
		for sheet_name, table in tables.items():
			if table.empty:
				pd.DataFrame({"info": ["No data available"]}).to_excel(writer, sheet_name=sheet_name[:31], index=False)
			else:
				table.to_excel(writer, sheet_name=sheet_name[:31], index=False)


def main() -> None:
	dataset = load_analysis_dataset()
	eda_tables = build_eda_tables(dataset)
	save_eda_workbook(eda_tables, EDA_OUTPUT_FILE)
	print(f"EDA workbook saved to: {EDA_OUTPUT_FILE}")


if __name__ == "__main__":
	main()
