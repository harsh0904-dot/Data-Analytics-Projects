from pathlib import Path

import pandas as pd


OUTPUT_DIR = Path(__file__).resolve().parent / 'outputs'


def export_report(df: pd.DataFrame, file_name: str) -> None:
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    output_path = OUTPUT_DIR / file_name
    df.to_excel(output_path, index=False)
    print(f'Report saved to: {output_path}')
