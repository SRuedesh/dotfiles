# make sure to run this script with python3 from an elevated shell!!
import os
from pathlib import Path

path_home = Path.home()
path_config = Path(path_home, "one_drive/github/dotfiles")

path_list = [
    {
        "src": Path(path_config, "starship/starship.toml"),
        "dst": Path(path_home, ".config/starship.toml")
    },
    {
        "src": Path(path_config, "kickstart.nvim"),
        "dst": Path(path_home, ".config/nvim")
    },
    {
        "src": Path(path_config, "wezterm/.wezterm.lua"),
        "dst": Path(path_home, ".wezterm.lua")
    },
    {
        "src": Path(path_config, "wezterm"),
        "dst": Path(path_home, ".config/wezterm")
    },
    {
        "src": Path(path_config, "glaze-wm"),
        "dst": Path(path_home, ".glzr")
    },
    {
        "src": Path(path_config, "linter"),
        "dst": Path(path_home, "linter")
    },
    {
        "src": Path(path_config, "powershell/Microsoft.PowerShell_profile.ps1"),
        "dst": Path(path_home, "one_drive/Documents/PowerShell/Microsoft.PowerShell_profile.ps1")
    }
]

for item in path_list:
    src = item["src"]
    dst = item["dst"]

    # check file exists
    if not src.exists():
        print(f"Source file {src} does not exist.")
        continue
    if dst.exists():
        print(f"Destination {dst} already exists.")
        continue

    try:
        os.symlink(src, dst)
        print(f"Established symlink from {src} to {dst}")
    except OSError as e:
        print(f"Failed to create symlink from {src} to {dst}: {e}")

