from pathlib import Path

import pandas as pd


BASE_DIR = Path(__file__).resolve().parent.parent.parent
RAW_FILE = BASE_DIR / 'sample_input.csv'
OUTPUT_FILE = BASE_DIR / 'sample_cleaned_output.xlsx'


def clean_columns(df: pd.DataFrame) -> pd.DataFrame:
    cleaned = df.copy()
    cleaned.columns = (
        cleaned.columns.str.strip()
        .str.lower()
        .str.replace(' ', '_', regex=False)
    )
    return cleaned


def clean_dataset(df: pd.DataFrame) -> pd.DataFrame:
    cleaned = clean_columns(df)
    cleaned = cleaned.drop_duplicates().reset_index(drop=True)

    text_columns = cleaned.select_dtypes(include=['object', 'string']).columns
    for column in text_columns:
        cleaned[column] = cleaned[column].astype('string').str.strip()

    return cleaned


def main() -> None:
    df = pd.read_csv(RAW_FILE)
    cleaned_df = clean_dataset(df)
    cleaned_df.to_excel(OUTPUT_FILE, index=False)
    print('Cleaning complete.')


if __name__ == '__main__':
    main()
