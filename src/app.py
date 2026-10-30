"Example of a simple web app using pywebio and pandas."

from pathlib import Path

from pywebio import output
import pandas as pd


class WebApp:
    def __init__(self, root_path):
        self.root_path = root_path
        self.df = pd.DataFrame({"A": [1, 2, 3], "B": [4, 5, 6]})

    def show_data(self):
        with output.use_scope("output", clear=True):
            output.put_table([self.df.columns.tolist(), *self.df.values.tolist()])

    def export_data(self):
        export_path = self.root_path / "data" / "data.csv"
        export_path.parent.mkdir(parents=True, exist_ok=True)
        self.df.to_csv(export_path, index=False)
        with output.use_scope("output", clear=True):
            output.put_text(f"Exported to {export_path}")

    def help(self):
        with output.use_scope("output", clear=True):
            output.put_text("Show data: display the DataFrame.")
            output.put_text("Export data: save the DataFrame to CSV.")

    def run(self):
        output.put_markdown("# Embeddable Windows Data App")
        output.put_buttons(
            ["Show data", "Export data", "Help"],
            onclick=[self.show_data, self.export_data, self.help],
        )


if __name__ == "__main__":
    app = WebApp(Path(__file__).parent.parent.resolve())
    app.run()
