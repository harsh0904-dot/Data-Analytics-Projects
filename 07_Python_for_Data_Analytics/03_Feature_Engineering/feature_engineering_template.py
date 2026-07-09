import pandas as pd


def add_features(df: pd.DataFrame) -> pd.DataFrame:
    engineered = df.copy()

    if {'sales', 'orders'}.issubset(engineered.columns):
        engineered['average_order_value'] = (
            engineered['sales'] / engineered['orders'].replace(0, pd.NA)
        ).round(2)

    return engineered
