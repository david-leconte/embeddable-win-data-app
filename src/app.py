"Example of a simple command-line application using cmd and pandas."

import cmd
from pathlib import Path
import pandas


class AppShell(cmd.Cmd):
    "Simple command-line application shell."
    intro = "Welcome to the App shell. Type help or ? to list commands.\n"
    prompt = "(app) "
    df = pandas.DataFrame({"A": [1, 2, 3], "B": [4, 5, 6]})

    def do_exit(self, _):
        "Exit the shell."
        print("Exiting...")
        return True

    def do_show_data(self, _):
        "Show the data in the DataFrame."
        print(self.df)

    def do_export_data(self, _):
        "Export the data in the DataFrame."
        export_path = Path(__file__).parent.parent / "data" / "data.csv"
        export_path.parent.mkdir(parents=True, exist_ok=True)
        self.df.to_csv(export_path, index=False)

    def do_help(self, arg):
        "List available commands."
        cmd.Cmd.do_help(self, arg)


if __name__ == "__main__":
    AppShell().cmdloop()
