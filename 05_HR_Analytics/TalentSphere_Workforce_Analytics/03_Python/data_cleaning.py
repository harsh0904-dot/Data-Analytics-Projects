from pathlib import Path

import pandas as pd


BASE_DIR = Path(__file__).resolve().parent.parent
RAW_FILE = BASE_DIR / "01_Dataset" / "Raw_Data" / "WA_Fn-UseC_-HR-Employee-Attrition.csv"
OUTPUT_FILE = BASE_DIR / "01_Dataset" / "Cleaned_Data" / "IBM HR Analytics Employee Attrition.xlsx"

NUMERIC_COLUMNS = [
	"age",
	"dailyrate",
	"dailyrate",
	"distancefromhome",
	"employeecount",
	"employeenumber",
	"environmentsatisfaction",
	"hourlyrate",
	"jobinvolvement",
	"joblevel",
	"jobsatisfaction",
	"monthlyincome",
	"monthlyrate",
	"numcompaniesworked",
	"percentsalaryhike",
	"performancerating",
	"relationshipsatisfaction",
	"standardhours",
	"stockoptionlevel",
	"totalworkingyears",
	"trainingtimeslastyear",
	"worklifebalance",
	"yearsatcompany",
	"yearsincurrentrole",
	"yearssincelastpromotion",
	"yearswithcurrmanager",
]


def load_dataset(file_path: Path) -> pd.DataFrame:
	return pd.read_csv(file_path)


def clean_hr_dataset(df: pd.DataFrame) -> pd.DataFrame:
	cleaned = df.copy()
	cleaned.columns = [column.strip().lower() for column in cleaned.columns]

	cleaned = cleaned.drop_duplicates().reset_index(drop=True)

	for column in NUMERIC_COLUMNS:
		if column in cleaned.columns:
			cleaned[column] = pd.to_numeric(cleaned[column], errors="coerce")

	text_columns = cleaned.select_dtypes(include=["object", "string"]).columns
	for column in text_columns:
		cleaned[column] = cleaned[column].astype("string").str.strip()

	# Standardize common categorical values for consistency in reporting.
	for column in ["attrition", "gender", "over18", "overtime", "businesstravel"]:
		if column in cleaned.columns:
			cleaned[column] = cleaned[column].str.title()

	if "attrition" in cleaned.columns:
		cleaned["attrition_flag"] = cleaned["attrition"].map({"Yes": 1, "No": 0}).astype("Int64")

	if "overtime" in cleaned.columns:
		cleaned["overtime_flag"] = cleaned["overtime"].map({"Yes": 1, "No": 0}).astype("Int64")

	if {"monthlyincome", "totalworkingyears"}.issubset(cleaned.columns):
		cleaned["income_per_working_year"] = (
			cleaned["monthlyincome"] / cleaned["totalworkingyears"].replace(0, pd.NA)
		).astype("Float64").round(2)

	if {"yearsatcompany", "totalworkingyears"}.issubset(cleaned.columns):
		cleaned["tenure_ratio"] = (
			cleaned["yearsatcompany"] / cleaned["totalworkingyears"].replace(0, pd.NA)
		).astype("Float64").round(3)

	numeric_cols = cleaned.select_dtypes(include=["number"]).columns
	for column in numeric_cols:
		if cleaned[column].isna().any():
			cleaned[column] = cleaned[column].fillna(cleaned[column].median())

	return cleaned


def print_quality_summary(before_rows: int, cleaned: pd.DataFrame) -> None:
	print(f"Rows before cleaning: {before_rows}")
	print(f"Rows after cleaning: {len(cleaned)}")
	print(f"Columns after cleaning: {len(cleaned.columns)}")
	print("\nTop missing values after cleaning:")
	print(cleaned.isna().sum().sort_values(ascending=False).head(10).to_string())


def save_dataset(df: pd.DataFrame, output_file: Path) -> None:
	output_file.parent.mkdir(parents=True, exist_ok=True)
	df.to_excel(output_file, index=False)


def main() -> None:
	if not RAW_FILE.exists():
		raise FileNotFoundError(f"Dataset not found: {RAW_FILE}")

	dataset = load_dataset(RAW_FILE)
	cleaned_dataset = clean_hr_dataset(dataset)

	print_quality_summary(len(dataset), cleaned_dataset)
	save_dataset(cleaned_dataset, OUTPUT_FILE)
	print(f"\nCleaned file saved to: {OUTPUT_FILE}")


if __name__ == "__main__":
	main()
