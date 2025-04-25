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
        nvim .
}
function get_window_names {
  Get-Process | Where-Object {$_.mainWindowTitle} | Format-Table Id, Name, mainWindowtitle -AutoSize
}
$prompt = ""
function Invoke-Starship-PreCommand {
    $current_location = $executionContext.SessionState.Path.CurrentLocation
    if ($current_location.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $current_location.ProviderPath -replace "\\", "/"
        $prompt = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"
    }
    $host.ui.Write($prompt)
}

Set-Alias gh cd_gh
Set-Alias oo obsid
Set-Alias conf config_win
Set-Alias vim nvim
Set-Alias lg lazygit
Set-Alias dod "Docker Desktop.exe"
Set-Alias wnames get_window_names
