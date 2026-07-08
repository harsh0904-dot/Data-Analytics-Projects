from pathlib import Path

import pandas as pd


RAW_FILE = Path(__file__).resolve().parent.parent / "01_Dataset" / "Raw_Data" / "financial_loan.xlsx"
OUTPUT_FILE = Path(__file__).resolve().parent.parent / "01_Dataset" / "Cleaned_Data" / "financial_loan_cleaned.csv"

DATE_COLUMNS = [
	"issue_date",
	"last_credit_pull_date",
	"last_payment_date",
	"next_payment_date",
]

NUMERIC_COLUMNS = [
	"annual_income",
	"dti",
	"installment",
	"int_rate",
	"loan_amount",
	"total_acc",
	"total_payment",
]

TEXT_COLUMNS = [
	"address_state",
	"application_type",
	"emp_length",
	"emp_title",
	"grade",
	"home_ownership",
	"loan_status",
	"purpose",
	"sub_grade",
	"term",
	"verification_status",
]


def load_dataset(file_path: Path) -> pd.DataFrame:
	return pd.read_excel(file_path)


def clean_financial_loan_data(df: pd.DataFrame) -> pd.DataFrame:
	cleaned = df.copy()
	cleaned.columns = [column.strip().lower() for column in cleaned.columns]
	cleaned = cleaned.drop_duplicates().reset_index(drop=True)

	for column in DATE_COLUMNS:
		if column in cleaned.columns:
			cleaned[column] = pd.to_datetime(cleaned[column], errors="coerce")

	for column in NUMERIC_COLUMNS:
		if column in cleaned.columns:
			cleaned[column] = pd.to_numeric(cleaned[column], errors="coerce")

	for column in TEXT_COLUMNS:
		if column in cleaned.columns:
			cleaned[column] = cleaned[column].astype("string").str.strip()

	if "address_state" in cleaned.columns:
		cleaned["address_state"] = cleaned["address_state"].str.upper()

	if "emp_title" in cleaned.columns:
		cleaned["emp_title"] = cleaned["emp_title"].fillna("Unknown")

	if "term" in cleaned.columns:
		cleaned["term_months"] = (
			cleaned["term"].astype("string").str.extract(r"(\d+)").astype("Int64")
		)

	if "issue_date" in cleaned.columns:
		cleaned["issue_year"] = cleaned["issue_date"].dt.year.astype("Int64")
		cleaned["issue_month"] = cleaned["issue_date"].dt.month.astype("Int64")

	if {"loan_amount", "total_payment"}.issubset(cleaned.columns):
		cleaned["payment_gap"] = cleaned["total_payment"] - cleaned["loan_amount"]

	return cleaned


def print_quality_summary(before_rows: int, cleaned: pd.DataFrame) -> None:
	print(f"Rows before cleaning: {before_rows}")
	print(f"Rows after cleaning: {len(cleaned)}")
	print("\nMissing values after cleaning:")
	print(cleaned.isna().sum().sort_values(ascending=False).to_string())


def save_dataset(df: pd.DataFrame, output_path: Path) -> None:
	output_path.parent.mkdir(parents=True, exist_ok=True)
	df.to_csv(output_path, index=False)


def main() -> None:
	dataset = load_dataset(RAW_FILE)
	cleaned_dataset = clean_financial_loan_data(dataset)

	print_quality_summary(len(dataset), cleaned_dataset)
	save_dataset(cleaned_dataset, OUTPUT_FILE)
	print(f"\nCleaned dataset saved to: {OUTPUT_FILE}")


if __name__ == "__main__":
	main()
