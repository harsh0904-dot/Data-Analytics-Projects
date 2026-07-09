from pathlib import Path

import pandas as pd


BASE_DIR = Path(__file__).resolve().parent.parent
RAW_FILE = BASE_DIR / "01_Dataset" / "Raw_Data" / "Hospital Patient .csv"
OUTPUT_FILE = BASE_DIR / "01_Dataset" / "Cleaned_Data" / "Hospital_Patient_Cleaned.xlsx"


def normalize_columns(df: pd.DataFrame) -> pd.DataFrame:
	cleaned = df.copy()
	cleaned.columns = (
		cleaned.columns.str.strip()
		.str.lower()
		.str.replace(" ", "_", regex=False)
		.str.replace("__", "_", regex=False)
	)
	return cleaned


def clean_dataset(df: pd.DataFrame) -> pd.DataFrame:
	cleaned = normalize_columns(df)

	cleaned = cleaned.drop_duplicates().reset_index(drop=True)

	for col in ["admission_date", "discharge_date"]:
		if col in cleaned.columns:
			cleaned[col] = pd.to_datetime(cleaned[col], errors="coerce", dayfirst=True)

	numeric_columns = [
		"patient_id",
		"age",
		"year_of_admission",
		"length_of_stay",
		"satisfaction",
		"total_cost",
	]
	for col in numeric_columns:
		if col in cleaned.columns:
			cleaned[col] = pd.to_numeric(cleaned[col], errors="coerce")

	text_columns = cleaned.select_dtypes(include=["object", "string"]).columns
	for col in text_columns:
		cleaned[col] = cleaned[col].astype("string").str.strip()

	yes_no_columns = ["readmission", "insurance_claimed"]
	for col in yes_no_columns:
		if col in cleaned.columns:
			cleaned[col] = cleaned[col].str.title()

	title_case_columns = ["gender", "condition", "medication", "patient_state", "outcome"]
	for col in title_case_columns:
		if col in cleaned.columns:
			cleaned[col] = cleaned[col].str.title()

	if "patient_state" in cleaned.columns:
		cleaned["patient_state"] = cleaned["patient_state"].replace({"Maharastra": "Maharashtra"})

	if {"admission_date", "discharge_date"}.issubset(cleaned.columns):
		date_diff = (cleaned["discharge_date"] - cleaned["admission_date"]).dt.days
		cleaned["length_of_stay"] = date_diff.fillna(cleaned["length_of_stay"]).astype("Int64")

	for col in cleaned.select_dtypes(include=["number"]).columns:
		if cleaned[col].isna().any():
			cleaned[col] = cleaned[col].fillna(cleaned[col].median())

	if "admission_date" in cleaned.columns:
		cleaned["admission_date"] = cleaned["admission_date"].dt.strftime("%Y-%m-%d")
	if "discharge_date" in cleaned.columns:
		cleaned["discharge_date"] = cleaned["discharge_date"].dt.strftime("%Y-%m-%d")

	return cleaned


def main() -> None:
	if not RAW_FILE.exists():
		raise FileNotFoundError(f"Raw dataset not found: {RAW_FILE}")

	df = pd.read_csv(RAW_FILE)
	cleaned_df = clean_dataset(df)

	OUTPUT_FILE.parent.mkdir(parents=True, exist_ok=True)
	cleaned_df.to_excel(OUTPUT_FILE, index=False)

	print("Data cleaning completed.")
	print(f"Rows before cleaning: {len(df)}")
	print(f"Rows after cleaning: {len(cleaned_df)}")
	print(f"Columns after cleaning: {len(cleaned_df.columns)}")
	print(f"Saved cleaned file: {OUTPUT_FILE}")


if __name__ == "__main__":
	main()
