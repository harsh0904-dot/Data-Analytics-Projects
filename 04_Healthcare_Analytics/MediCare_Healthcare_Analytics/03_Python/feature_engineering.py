from pathlib import Path

import pandas as pd


BASE_DIR = Path(__file__).resolve().parent.parent
CLEANED_FILE = BASE_DIR / "01_Dataset" / "Cleaned_Data" / "Hospital_Patient_Cleaned.xlsx"


def load_cleaned_data() -> pd.DataFrame:
	if not CLEANED_FILE.exists():
		raise FileNotFoundError(
			f"Cleaned dataset not found: {CLEANED_FILE}. Run data_cleaning.py first."
		)
	return pd.read_excel(CLEANED_FILE)


def engineer_features(df: pd.DataFrame) -> pd.DataFrame:
	engineered = df.copy()
	engineered.columns = (
		engineered.columns.str.strip()
		.str.lower()
		.str.replace(" ", "_", regex=False)
		.str.replace("__", "_", regex=False)
	)

	if "age" in engineered.columns:
		engineered["age_group"] = pd.cut(
			engineered["age"],
			bins=[0, 18, 35, 50, 65, 120],
			labels=["0-18", "19-35", "36-50", "51-65", "66+"],
			include_lowest=True,
		)

	if {"total_cost", "length_of_stay"}.issubset(engineered.columns):
		engineered["cost_per_day"] = (
			engineered["total_cost"] / engineered["length_of_stay"].replace(0, pd.NA)
		).round(2)

	if "length_of_stay" in engineered.columns:
		median_stay = engineered["length_of_stay"].median()
		engineered["long_stay_flag"] = (engineered["length_of_stay"] > median_stay).astype(int)

	if "readmission" in engineered.columns:
		engineered["readmission_flag"] = (
			engineered["readmission"].astype("string").str.title().eq("Yes").astype(int)
		)

	if "insurance_claimed" in engineered.columns:
		engineered["insurance_claimed_flag"] = (
			engineered["insurance_claimed"].astype("string").str.title().eq("Yes").astype(int)
		)

	if "satisfaction" in engineered.columns:
		engineered["satisfaction_segment"] = pd.cut(
			engineered["satisfaction"],
			bins=[0, 2, 3, 5],
			labels=["Low", "Medium", "High"],
			include_lowest=True,
		)

	if {"outcome", "satisfaction"}.issubset(engineered.columns):
		outcome_score_map = {
			"Recovered": 3,
			"Stable": 2,
			"Critical": 1,
			"Deceased": 0,
		}
		engineered["outcome_score"] = (
			engineered["outcome"].astype("string").str.title().map(outcome_score_map).fillna(0)
		)
		engineered["recovery_index"] = (
			0.6 * engineered["outcome_score"] + 0.4 * engineered["satisfaction"].fillna(0)
		).round(2)

	return engineered


def main() -> None:
	df = load_cleaned_data()
	engineered_df = engineer_features(df)

	print("Feature engineering completed.")
	print(f"Original columns: {len(df.columns)}")
	print(f"Engineered columns: {len(engineered_df.columns)}")
	print("\nEngineered preview (first 10 rows):")
	print(engineered_df.head(10).to_string(index=False))


if __name__ == "__main__":
	main()
