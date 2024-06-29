#!.venv/bin/python3

from os import listdir
import subprocess

from pyfzf.pyfzf import FzfPrompt

THEMES_DIR = "../themes/themes"
CONFIG_FILE = "../alacritty.toml"
MATCH_LINE = "### Colors ###"

fzf = FzfPrompt()


def choose_theme() -> str:
    return fzf.prompt(sorted(listdir(THEMES_DIR)))[0]


def update_config(theme: str) -> None:
    with open(CONFIG_FILE, "r") as config_file:
        config_file_content = config_file.read()

    # find the next line of the color section delimiter
    position = config_file_content.find(MATCH_LINE) + len(MATCH_LINE)

    # remove from the previous position
    config_file_content = f"{config_file_content[:position]}\n"

    with open(f"{THEMES_DIR}/{theme}", "r") as theme_file:
        theme_file_content = theme_file.read()

    config_file_content = f"{config_file_content}{theme_file_content}"

    with open(CONFIG_FILE, "w") as config_file:
        config_file.write(config_file_content)


if __name__ == "__main__":
    try:
        theme = choose_theme()
        update_config(theme)
        subprocess.call(["alacritty", "msg", "config", "--", "-1"])
    except:
        print("No theme picked")
