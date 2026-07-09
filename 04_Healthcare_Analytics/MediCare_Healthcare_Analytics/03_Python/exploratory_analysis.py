from pathlib import Path

import pandas as pd


BASE_DIR = Path(__file__).resolve().parent.parent
CLEANED_FILE = BASE_DIR / "01_Dataset" / "Cleaned_Data" / "Hospital_Patient_Cleaned.xlsx"
EDA_OUTPUT_FILE = BASE_DIR / "01_Dataset" / "Cleaned_Data" / "Hospital_Patient_EDA_Summary.csv"


def load_cleaned_data() -> pd.DataFrame:
	if not CLEANED_FILE.exists():
		raise FileNotFoundError(
			f"Cleaned dataset not found: {CLEANED_FILE}. Run data_cleaning.py first."
		)
	return pd.read_excel(CLEANED_FILE)


def build_eda_summary(df: pd.DataFrame) -> pd.DataFrame:
	working = df.copy()
	working.columns = (
		working.columns.str.strip()
		.str.lower()
		.str.replace(" ", "_", regex=False)
		.str.replace("__", "_", regex=False)
	)

	summary_rows: list[dict[str, object]] = []

	summary_rows.extend(
		[
			{"section": "overview", "metric": "total_rows", "value": int(len(working))},
			{"section": "overview", "metric": "total_columns", "value": int(len(working.columns))},
		]
	)

	if "readmission" in working.columns:
		readmission_rate = 100 * working["readmission"].astype("string").str.title().eq("Yes").mean()
		summary_rows.append(
			{
				"section": "kpi",
				"metric": "readmission_rate_pct",
				"value": round(float(readmission_rate), 2),
			}
		)

	if "total_cost" in working.columns:
		summary_rows.extend(
			[
				{
					"section": "kpi",
					"metric": "avg_total_cost",
					"value": round(float(working["total_cost"].mean()), 2),
				},
				{
					"section": "kpi",
					"metric": "median_total_cost",
					"value": round(float(working["total_cost"].median()), 2),
				},
			]
		)

	if "length_of_stay" in working.columns:
		summary_rows.extend(
			[
				{
					"section": "kpi",
					"metric": "avg_length_of_stay",
					"value": round(float(working["length_of_stay"].mean()), 2),
				},
				{
					"section": "kpi",
					"metric": "max_length_of_stay",
					"value": int(working["length_of_stay"].max()),
				},
			]
		)

	if "condition" in working.columns:
		condition_counts = working["condition"].value_counts(dropna=False).head(5)
		for condition, count in condition_counts.items():
			summary_rows.append(
				{
					"section": "top_condition",
					"metric": str(condition),
					"value": int(count),
				}
			)

	if "patient_state" in working.columns:
		state_counts = working["patient_state"].value_counts(dropna=False).head(5)
		for state, count in state_counts.items():
			summary_rows.append(
				{
					"section": "top_state",
					"metric": str(state),
					"value": int(count),
				}
			)

	if "satisfaction" in working.columns:
		sat_dist = working["satisfaction"].value_counts(dropna=False).sort_index()
		for score, count in sat_dist.items():
			summary_rows.append(
				{
					"section": "satisfaction_distribution",
					"metric": str(score),
					"value": int(count),
				}
			)

	return pd.DataFrame(summary_rows)


def main() -> None:
	df = load_cleaned_data()
	summary = build_eda_summary(df)

	EDA_OUTPUT_FILE.parent.mkdir(parents=True, exist_ok=True)
	summary.to_csv(EDA_OUTPUT_FILE, index=False)

	print("EDA completed.")
	print(f"Input rows analyzed: {len(df)}")
	print(f"EDA summary rows: {len(summary)}")
	print(f"Saved EDA file: {EDA_OUTPUT_FILE}")


if __name__ == "__main__":
	main()
