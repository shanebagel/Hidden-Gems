# Creates archives from a specified directory

# You must pass in values for both the path you want to backup, and the destination path where you want the backup saved
Param(
  [string]$Path = '.<File-Path>,
  [string]$DestinationPath = <File-Path>'
)
If (-Not (Test-Path $Path)) 
{
  Throw "The directory $Path does not exist, please specify an existing directory"
}

$date = Get-Date -format "yyyy-MM-dd"
Compress-Archive -Path $Path -CompressionLevel 'Fastest' -DestinationPath "$($DestinationPath + 'backup-' + $date)"
Write-Host "Created backup at $($DestinationPath + 'backup-' + $date + '.zip')"