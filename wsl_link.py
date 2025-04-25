import os
from pathlib import Path

path_home = Path.home()
path_config = Path(path_home, "dotfiles")

path_list = [
    {
        "src": Path(path_config, "kickstart.nvim"),
        "dst": Path(path_home, ".config/nvim")
    },
    {
        "src": Path(path_config, ".radian_profile"),
        "dst": Path(path_home, ".radian_profile")
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

