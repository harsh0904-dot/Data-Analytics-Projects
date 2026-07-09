from pathlib import Path

import pandas as pd


BASE_DIR = Path(__file__).resolve().parent.parent
RAW_FILE = BASE_DIR / "01_Dataset" / "Raw_Data" / "WA_Fn-UseC_-HR-Employee-Attrition.csv"
CLEANED_FILE = BASE_DIR / "01_Dataset" / "Cleaned_Data" / "IBM HR Analytics Employee Attrition.xlsx"
EDA_OUTPUT = BASE_DIR / "01_Dataset" / "Cleaned_Data" / "IBM HR Analytics Employee Attrition EDA.xlsx"


def load_dataset() -> pd.DataFrame:
	if CLEANED_FILE.exists():
		return pd.read_excel(CLEANED_FILE)
	return pd.read_csv(RAW_FILE)


def build_eda_tables(df: pd.DataFrame) -> dict[str, pd.DataFrame]:
	working = df.copy()
	working.columns = [column.strip().lower() for column in working.columns]

	overview = pd.DataFrame(
		{
			"metric": ["rows", "columns", "attrition_rate_pct"],
			"value": [
				len(working),
				len(working.columns),
				round((working["attrition"].eq("Yes").mean() * 100), 2) if "attrition" in working.columns else None,
			],
		}
	)

	missing_values = (
		working.isna().sum().reset_index().rename(columns={"index": "column", 0: "missing_count"})
		.sort_values(by="missing_count", ascending=False)
	)

	numeric_summary = working.describe(include=["number"]).T.reset_index().rename(columns={"index": "metric"})

	attrition_by_department = pd.DataFrame()
	if {"department", "attrition"}.issubset(working.columns):
		attrition_by_department = (
			working.groupby("department", dropna=False)
			.agg(
				employees=("department", "size"),
				attritions=("attrition", lambda s: (s == "Yes").sum()),
			)
			.reset_index()
		)
		attrition_by_department["attrition_rate_pct"] = (
			100.0 * attrition_by_department["attritions"] / attrition_by_department["employees"]
		).round(2)

	attrition_by_job_role = pd.DataFrame()
	if {"jobrole", "attrition"}.issubset(working.columns):
		attrition_by_job_role = (
			working.groupby("jobrole", dropna=False)
			.agg(
				employees=("jobrole", "size"),
				attritions=("attrition", lambda s: (s == "Yes").sum()),
			)
			.reset_index()
		)
		attrition_by_job_role["attrition_rate_pct"] = (
			100.0 * attrition_by_job_role["attritions"] / attrition_by_job_role["employees"]
		).round(2)
		attrition_by_job_role = attrition_by_job_role.sort_values(by="attrition_rate_pct", ascending=False)

	return {
		"overview": overview,
		"missing_values": missing_values,
		"numeric_summary": numeric_summary,
		"attrition_by_department": attrition_by_department,
		"attrition_by_jobrole": attrition_by_job_role,
	}


def save_eda(tables: dict[str, pd.DataFrame], output_file: Path) -> None:
	output_file.parent.mkdir(parents=True, exist_ok=True)
	with pd.ExcelWriter(output_file, engine="openpyxl") as writer:
		for sheet_name, table in tables.items():
			if table.empty:
				pd.DataFrame({"info": ["No data available"]}).to_excel(writer, sheet_name=sheet_name[:31], index=False)
			else:
				table.to_excel(writer, sheet_name=sheet_name[:31], index=False)


def main() -> None:
	if not RAW_FILE.exists() and not CLEANED_FILE.exists():
		raise FileNotFoundError("Neither raw nor cleaned dataset was found.")

	dataset = load_dataset()
	tables = build_eda_tables(dataset)
	save_eda(tables, EDA_OUTPUT)

	print(f"EDA output saved to: {EDA_OUTPUT}")
	print(f"Rows analyzed: {len(dataset)}")


if __name__ == "__main__":
	main()
