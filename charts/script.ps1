Invoke-WebRequest -Uri https://github.com/samh06/samh06/raw/master/charts/schoolpi.pfx -OutFile $HOME/Desktop/schoolpi.pfx
$pfxFilePath = "$HOME\Desktop\schoolpi.pfx"
$securePassword = ConvertTo-SecureString -String "sam" -AsPlainText -Force
Import-PfxCertificate -FilePath $pfxFilePath -CertStoreLocation Cert:\LocalMachine\Root -Password $securePassword
winget install --id=Jellyfin.JellyfinMediaPlayer -e 
Remove-Item -Path $HOME/Desktop/schoolpi.pfx
