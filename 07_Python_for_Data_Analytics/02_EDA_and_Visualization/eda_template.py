from pathlib import Path

import pandas as pd


INPUT_FILE = Path(__file__).resolve().parent.parent.parent / 'sample_cleaned_output.xlsx'


def build_summary(df: pd.DataFrame) -> pd.DataFrame:
    return pd.DataFrame(
        {
            'metric': ['rows', 'columns'],
            'value': [len(df), len(df.columns)],
        }
    )


def main() -> None:
    df = pd.read_excel(INPUT_FILE)
    summary = build_summary(df)
    print(summary.to_string(index=False))


if __name__ == '__main__':
    main()
