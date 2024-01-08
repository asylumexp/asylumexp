If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
  Start-Process powershell.exe "-Command",("Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://github.com/samh06/samh06/raw/master/charts/script.ps1'))") -Verb RunAs
  exit
}
Invoke-WebRequest -Uri https://github.com/samh06/samh06/raw/master/charts/schooljf.pfx -OutFile $HOME/jfschool.pfx
$pfxFilePath = "$HOME\jfschool.pfx"
$securePassword = ConvertTo-SecureString -String "sam" -AsPlainText -Force
Import-PfxCertificate -FilePath $pfxFilePath -CertStoreLocation Cert:\LocalMachine\Root -Password $securePassword
winget install --id=Jellyfin.JellyfinMediaPlayer -e 
Remove-Item -Path $HOME/jfschool.pfx
pause
