If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
  Start-Process powershell.exe "-Command",("Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://github.com/samh06/samh06/raw/master/charts/script.ps1'))") -Verb RunAs
  exit
}
Invoke-WebRequest -Uri https://github.com/samh06/samh06/raw/master/charts/schooljf.pfx -OutFile $HOME/jfschool.pfx
$pfxFilePath = "$HOME\jfschool.pfx"
$securePassword = ConvertTo-SecureString -String "sam" -AsPlainText -Force
Import-PfxCertificate -FilePath $pfxFilePath -CertStoreLocation Cert:\LocalMachine\Root -Password $securePassword
try {
    winget install --id=Jellyfin.JellyfinMediaPlayer -e
}
catch {
    $URL = "https://api.github.com/repos/microsoft/winget-cli/releases/latest"
    $URL = (Invoke-WebRequest -Uri $URL).Content | ConvertFrom-Json |
            Select-Object -ExpandProperty "assets" |
            Where-Object "browser_download_url" -Match '.msixbundle' |
            Select-Object -ExpandProperty "browser_download_url"
    Invoke-WebRequest -Uri $URL -OutFile $HOME/Setup.msix -UseBasicParsing
    Add-AppxPackage -Path $HOME/Setup.msix
    Remove-Item $HOME/Setup.msix
    winget install --id=Jellyfin.JellyfinMediaPlayer -e
}
Remove-Item -Path $HOME/jfschool.pfx
pause
