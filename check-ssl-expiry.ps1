& $PSScriptRoot/lib/Get-SslCertificateDetails.ps1

& $PSScriptRoot/lib/Generate-HTLMReport.ps1

& $PSScriptRoot/lib/Send-Notifications.ps1

# --- AI Data Logging for Prediction ---
Write-Host "📌 Updating history.json for AI-based prediction..."

# Load current SSL report
$currentRun = Get-Content "$PSScriptRoot/../sslCertificateDetails.json" | ConvertFrom-Json

# Load history if available
$historyFile = "$PSScriptRoot/../history.json"
if (Test-Path $historyFile) {
    $history = Get-Content $historyFile | ConvertFrom-Json
} else {
    $history = @()
}

# Append timestamp to each entry
$timestamp = Get-Date -Format "yyyy-MM-dd"
foreach ($entry in $currentRun) {
    $entry | Add-Member -NotePropertyName "timestamp" -NotePropertyValue $timestamp
    $history += $entry
}

# Save updated history
$history | ConvertTo-Json | Out-File $historyFile -Force
Write-Host "✅ history.json updated successfully."
