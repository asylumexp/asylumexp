If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
  # Relaunch as an elevated process:
  Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
  exit
}
Invoke-WebRequest -Uri https://github.com/samh06/samh06/raw/master/charts/schooljf.pfx -OutFile $HOME/jfschool.pfx
$pfxFilePath = "$HOME\jfschool.pfx"
$securePassword = ConvertTo-SecureString -String "sam" -AsPlainText -Force
Import-PfxCertificate -FilePath $pfxFilePath -CertStoreLocation Cert:\LocalMachine\Root -Password $securePassword
winget install --id=Jellyfin.JellyfinMediaPlayer -e 
Remove-Item -Path $HOME/jfschool.pfx
