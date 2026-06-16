param(
  [string]$OutputRoot = "assets-download"
)

$ErrorActionPreference = "Stop"

$sourcesPath = Join-Path (Split-Path $PSScriptRoot -Parent) "sources.json"
if (!(Test-Path $sourcesPath)) {
  throw "sources.json not found. Run this script from the cloned repository."
}

$sources = Get-Content -Raw -Path $sourcesPath | ConvertFrom-Json
New-Item -ItemType Directory -Force -Path $OutputRoot | Out-Null

Write-Host "This helper reads the catalog and creates local folders."
Write-Host "Google Drive folder downloads may require gdown, rclone, or authenticated browser access depending on Drive permissions."
Write-Host "Source folders:"

foreach ($folder in $sources.folders) {
  $target = Join-Path $OutputRoot $folder.slug
  New-Item -ItemType Directory -Force -Path $target | Out-Null
  Write-Host "- $($folder.title): $($folder.drive_url)"
}

Write-Host ""
Write-Host "Recommended next step: use rclone or gdown to mirror each public folder into its matching local folder."
