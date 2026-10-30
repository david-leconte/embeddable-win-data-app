import marimo

__generated_with = "0.25.2"
app = marimo.App(width="medium")


@app.cell
def _():
    import marimo as mo
    import pandas as pd
    from pathlib import Path

    return Path, pd


@app.cell
def _(pd):
    df = pd.DataFrame({"A": [1, 2, 3], "B": [4, 5, 6]})
    df
    return (df,)


@app.cell
def _(Path, df):
    export_path = Path.cwd().parent / "data" / "data.csv"
    df.to_csv(export_path, index=False)
    return


if __name__ == "__main__":
    app.run()
