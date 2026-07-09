from pathlib import Path

import pandas as pd


BASE_DIR = Path(__file__).resolve().parent.parent
RAW_FILE = BASE_DIR / "01_Dataset" / "Raw_Data" / "tech_advertising_campaigns_dataset.csv"
OUTPUT_FILE = BASE_DIR / "01_Dataset" / "Cleaned_Data" / "AdNova_Digital_Marketing.xlsx"

DATE_COLUMNS = ["start_date"]

BOOLEAN_COLUMNS = ["has_call_to_action", "retargeting_flag"]

NUMERIC_COLUMNS = [
	"creative_age_days",
	"hour_of_day",
	"campaign_day",
	"quality_score",
	"actual_cpc",
	"impressions",
	"clicks",
	"conversions",
	"ad_spend",
	"revenue",
	"bounce_rate",
	"avg_session_duration_seconds",
	"pages_per_session",
	"ctr",
	"cpc",
	"conversion_rate",
	"cpa",
	"roas",
	"profit",
]


def safe_divide(numerator: pd.Series, denominator: pd.Series) -> pd.Series:
	denominator = denominator.replace(0, pd.NA)
	return (numerator / denominator).astype("Float64")


def load_dataset(file_path: Path) -> pd.DataFrame:
	return pd.read_csv(file_path)


def normalize_boolean(value: object) -> object:
	if pd.isna(value):
		return pd.NA
	value_str = str(value).strip().lower()
	if value_str in {"true", "1", "yes", "y"}:
		return True
	if value_str in {"false", "0", "no", "n"}:
		return False
	return pd.NA


def clean_dataset(df: pd.DataFrame) -> pd.DataFrame:
	cleaned = df.copy()
	cleaned.columns = [column.strip().lower() for column in cleaned.columns]
	cleaned = cleaned.drop_duplicates().reset_index(drop=True)

	if "campaign_id" in cleaned.columns:
		cleaned = cleaned.drop_duplicates(subset=["campaign_id"], keep="first").reset_index(drop=True)

	for column in DATE_COLUMNS:
		if column in cleaned.columns:
			cleaned[column] = pd.to_datetime(cleaned[column], errors="coerce")

	for column in NUMERIC_COLUMNS:
		if column in cleaned.columns:
			cleaned[column] = pd.to_numeric(cleaned[column], errors="coerce")

	for column in BOOLEAN_COLUMNS:
		if column in cleaned.columns:
			cleaned[column] = cleaned[column].map(normalize_boolean).astype("boolean")

	object_columns = cleaned.select_dtypes(include=["object", "string"]).columns
	for column in object_columns:
		cleaned[column] = cleaned[column].astype("string").str.strip()

	for column in ["platform", "campaign_objective", "ad_placement", "industry_vertical"]:
		if column in cleaned.columns:
			cleaned[column] = cleaned[column].str.title()

	if "campaign_id" in cleaned.columns:
		cleaned["campaign_id"] = cleaned["campaign_id"].str.upper()

	if "quarter" in cleaned.columns:
		cleaned["quarter"] = pd.to_numeric(cleaned["quarter"], errors="coerce").astype("Int64")

	if "hour_of_day" in cleaned.columns:
		cleaned["hour_of_day"] = cleaned["hour_of_day"].clip(lower=0, upper=23)

	if "bounce_rate" in cleaned.columns:
		cleaned["bounce_rate"] = cleaned["bounce_rate"].clip(lower=0, upper=100)

	for column in ["impressions", "clicks", "conversions", "ad_spend", "revenue", "quality_score"]:
		if column in cleaned.columns:
			cleaned[column] = cleaned[column].clip(lower=0)

	if {"clicks", "impressions"}.issubset(cleaned.columns):
		cleaned["ctr"] = safe_divide(cleaned["clicks"] * 100, cleaned["impressions"]).round(3)

	if {"ad_spend", "clicks"}.issubset(cleaned.columns):
		cleaned["cpc"] = safe_divide(cleaned["ad_spend"], cleaned["clicks"]).round(3)

	if {"conversions", "clicks"}.issubset(cleaned.columns):
		cleaned["conversion_rate"] = safe_divide(cleaned["conversions"] * 100, cleaned["clicks"]).round(3)

	if {"ad_spend", "conversions"}.issubset(cleaned.columns):
		cleaned["cpa"] = safe_divide(cleaned["ad_spend"], cleaned["conversions"]).round(3)

	if {"revenue", "ad_spend"}.issubset(cleaned.columns):
		cleaned["roas"] = safe_divide(cleaned["revenue"], cleaned["ad_spend"]).round(3)

	if {"revenue", "ad_spend"}.issubset(cleaned.columns):
		cleaned["profit"] = (cleaned["revenue"] - cleaned["ad_spend"]).round(2)

	numeric_columns = cleaned.select_dtypes(include=["number"]).columns
	for column in numeric_columns:
		if cleaned[column].isna().any():
			cleaned[column] = cleaned[column].fillna(cleaned[column].median())

	return cleaned


def print_quality_summary(before_rows: int, cleaned: pd.DataFrame) -> None:
	print(f"Rows before cleaning: {before_rows}")
	print(f"Rows after cleaning: {len(cleaned)}")
	print(f"Columns in cleaned data: {len(cleaned.columns)}")
	print("\nMissing values after cleaning:")
	print(cleaned.isna().sum().sort_values(ascending=False).to_string())


def save_dataset(df: pd.DataFrame, output_path: Path) -> None:
	output_path.parent.mkdir(parents=True, exist_ok=True)
	df.to_excel(output_path, index=False)


def main() -> None:
	if not RAW_FILE.exists():
		raise FileNotFoundError(f"Raw dataset not found: {RAW_FILE}")

	dataset = load_dataset(RAW_FILE)
	cleaned_dataset = clean_dataset(dataset)

	print_quality_summary(len(dataset), cleaned_dataset)
	save_dataset(cleaned_dataset, OUTPUT_FILE)
	print(f"\nCleaned dataset saved to: {OUTPUT_FILE}")


if __name__ == "__main__":
	main()
