from pathlib import Path

import pandas as pd


BASE_DIR = Path(__file__).resolve().parent.parent
CLEANED_FILE = BASE_DIR / "01_Dataset" / "Cleaned_Data" / "AdNova_Digital_Marketing.xlsx"
RAW_FILE = BASE_DIR / "01_Dataset" / "Raw_Data" / "tech_advertising_campaigns_dataset.csv"
FEATURE_OUTPUT_FILE = BASE_DIR / "01_Dataset" / "Analysis_Outputs" / "AdNova_Digital_Marketing_Features.xlsx"


def safe_divide(numerator: pd.Series, denominator: pd.Series) -> pd.Series:
	denominator = denominator.replace(0, pd.NA)
	return (numerator / denominator).astype("Float64")


def load_feature_dataset() -> pd.DataFrame:
	if CLEANED_FILE.exists():
		return pd.read_excel(CLEANED_FILE)
	return pd.read_csv(RAW_FILE)


def build_features(df: pd.DataFrame) -> pd.DataFrame:
	features = df.copy()
	features.columns = [column.strip().lower() for column in features.columns]

	if "start_date" in features.columns:
		features["start_date"] = pd.to_datetime(features["start_date"], errors="coerce")
		features["start_year"] = features["start_date"].dt.year.astype("Int64")
		features["start_month"] = features["start_date"].dt.month.astype("Int64")
		features["start_day"] = features["start_date"].dt.day.astype("Int64")
		features["is_weekend"] = features["start_date"].dt.dayofweek.isin([5, 6]).astype("Int64")

	if "purchase_intent_score" in features.columns:
		intent_map = {"low": 1, "medium": 2, "high": 3}
		features["purchase_intent_encoded"] = (
			features["purchase_intent_score"].astype("string").str.lower().map(intent_map).astype("Int64")
		)

	if {"clicks", "impressions"}.issubset(features.columns):
		features["ctr_calc"] = safe_divide(features["clicks"] * 100, features["impressions"]).round(3)

	if {"conversions", "clicks"}.issubset(features.columns):
		features["conversion_rate_calc"] = safe_divide(features["conversions"] * 100, features["clicks"]).round(3)

	if {"ad_spend", "conversions"}.issubset(features.columns):
		features["cpa_calc"] = safe_divide(features["ad_spend"], features["conversions"]).round(3)

	if {"revenue", "ad_spend"}.issubset(features.columns):
		features["roas_calc"] = safe_divide(features["revenue"], features["ad_spend"]).round(3)

	if {"ad_spend", "impressions"}.issubset(features.columns):
		features["cost_per_thousand_impressions"] = safe_divide(features["ad_spend"] * 1000, features["impressions"]).round(3)

	if {"quality_score", "roas", "conversion_rate"}.issubset(features.columns):
		features["efficiency_score"] = (
			(features["quality_score"] * 0.4)
			+ (features["roas"] * 0.35)
			+ (features["conversion_rate"] * 0.25)
		).round(3)

	if {"pages_per_session", "avg_session_duration_seconds", "bounce_rate"}.issubset(features.columns):
		features["engagement_score"] = (
			(features["pages_per_session"] * 0.35)
			+ (features["avg_session_duration_seconds"] * 0.01)
			- (features["bounce_rate"] * 0.02)
		).round(3)

	if "hour_of_day" in features.columns:
		features["day_part"] = pd.cut(
			features["hour_of_day"],
			bins=[-1, 5, 11, 17, 23],
			labels=["Night", "Morning", "Afternoon", "Evening"],
		).astype("string")

	if "campaign_day" in features.columns:
		features["campaign_week"] = ((features["campaign_day"] - 1) // 7 + 1).astype("Int64")

	return features


def save_dataset(df: pd.DataFrame, output_path: Path) -> None:
	output_path.parent.mkdir(parents=True, exist_ok=True)
	df.to_excel(output_path, index=False)


def main() -> None:
	dataset = load_feature_dataset()
	features_dataset = build_features(dataset)
	save_dataset(features_dataset, FEATURE_OUTPUT_FILE)
	print(f"Feature-engineered dataset saved to: {FEATURE_OUTPUT_FILE}")
	print(f"Total columns after feature engineering: {len(features_dataset.columns)}")


if __name__ == "__main__":
	main()
