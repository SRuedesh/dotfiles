Invoke-Expression (&starship init powershell)
Invoke-Expression (& { ( zoxide init --cmd cd powershell | Out-String) })

Set-PSReadlineOption -PredictionViewStyle ListView
Set-PSReadlineOption -EditMode vi

# Custom Aliases
function cd_gh { cd ~/one_drive/github }
function obsid {
	cd ~/one_drive/github/obsidian 
	nvim main.md
}
function config_win {
	cd ~/one_drive/github/dotfiles
}
function visidata {
  wsl ~/.local/bin/visidata
}
function get_window_names {
  Get-Process | Where-Object {$_.mainWindowTitle} | Format-Table Id, Name, mainWindowtitle -AutoSize
}

Set-Alias gh cd_gh
Set-Alias oo obsid
Set-Alias conf config_win
Set-Alias vim nvim
Set-Alias vd visidata
Set-Alias lg lazygit
Set-Alias dod "Docker Desktop.exe"
Set-Alias wnames get_window_names
