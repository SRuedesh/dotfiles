# Make sure to include the following in your $PROFILE
# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
# Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# Run this script in PowerShell
# add buckets
scoop bucket add extras

# install cli utils
scoop install git openssh curl wget grep fd ripgrep fzf neovim starship just nodejs python3 make

# install desktop utils
scoop install firefox vscode spotify
