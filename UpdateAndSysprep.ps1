Param(
  [switch]$InstallCloudbaseInit
)
$ErrorActionPreference = "Stop"

Get-WUInstall -AcceptAll -IgnoreReboot
if (Get-WURebootStatus -Silent)
{
    shutdown /r /t 0
}
else
{
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name Unattend*
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name AutoLogonCount
    if($InstallCloudbaseInit)
    {
        Start-Process -FilePath msiexec -ArgumentList "/i C:\Windows\Temp\CloudbaseInitSetup.msi /qn /l*v C:\Windows\Temp\CloudbaseInitSetup_Beta.log" -Wait
        C:\Windows\System32\Sysprep\Sysprep.exe /generalize /oobe /shutdown /unattend:C:\Program\ Files\ (x86)\Cloudbase\ Solutions\Cloudbase-Init\conf\Unattend.xml
    }
    else
    {
        C:\Windows\System32\Sysprep\Sysprep.exe /generalize /oobe /shutdown /unattend:C:\Windows\Temp\Unattend.xml
    }
}
