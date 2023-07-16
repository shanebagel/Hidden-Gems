# Run backup on a domain controller & creates scheduled backups

Install-WindowsFeature -Name Windows-Server-Backup –IncludeAllSubFeature
Import-Module WindowsServerBackup

$wbpolicy = New-WBPolicy
$volume = Get-WBVolume -VolumePath C:

Add-WBVolume -Policy $wbpolicy -Volume $volume
Add-WBSystemState $wbpolicy
Add-WBBareMetalRecovery $wbpolicy #3

$backupLocation = New-WBBackupTarget -VolumePath <Drive>

Add-WBBackupTarget -Policy $wbpolicy -Target $backupLocation
Set-WBVssBackupOptions -Policy $wbpolicy -VssCopyBackup
Start-WBBackup -Policy $wbpolicy

# Add this to the script to create a scheduled backup. 
# Example: Runs at 8:00 AM, 12:00 PM, 4:00 PM, 8:00 PM

Set-WBSchedule -Policy $wbpolicy -Schedule 08:00,12:00,16:00,20:00
Set-WBPolicy -Policy $wbpolicy
