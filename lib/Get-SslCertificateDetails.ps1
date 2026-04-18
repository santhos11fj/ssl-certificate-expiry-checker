# Load the function to retrieve remote SSL certificates
. $PSScriptRoot/Get-RemoteCertificate.ps1

# Get the parent directory path
$upperPath = ($PSScriptRoot | Split-Path)

# Load endpoints and alert thresholds
$endpoints = Get-Content "$upperPath/endpoints.json" | ConvertFrom-Json
$alertThresholds = Get-Content "$upperPath/alertThresholds.json" | ConvertFrom-Json

# Retrieve SSL certificate details for each endpoint
$sslCertificateDetails = $endpoints | ForEach-Object {
    Write-Host "🔍 Checking SSL for $($_.hostname)..."

    try {
        # Attempt to retrieve SSL certificate
        $cert = Get-RemoteCertificate -ComputerName $_.hostname -Insecure
    } catch {
        Write-Host "❌ Failed to retrieve SSL certificate for $($_.hostname): $($_.Exception.Message)"
        throw  # ❌ In production, stop execution if SSL check fails
    }

    # Add issuer information
    Add-Member -InputObject $_ -NotePropertyName "Issuer" -NotePropertyValue $cert.Issuer -Force

    # Calculate days remaining until expiry
    $daysRemaining = ($cert.NotAfter - (Get-Date)).Days
    Add-Member -InputObject $_ -NotePropertyName "DaysToExpire" -NotePropertyValue $daysRemaining -Force

    # ✅ Determine severity
    if ($daysRemaining -gt 0) {
        if ($daysRemaining -le $alertThresholds.High) {
            $severity = 'High'
        }
        elseif ($daysRemaining -le $alertThresholds.Medium) {
            $severity = 'Medium'
        }
        elseif ($daysRemaining -le $alertThresholds.Low) {
            $severity = 'Low'
        }
        else {
            $severity = 'Safe'
        }
    }
    else {
        $severity = 'Error'   # Certificate is expired or invalid
    }

    # Add severity field
    Add-Member -InputObject $_ -NotePropertyName "Severity" -NotePropertyValue $severity -Force

    # Return updated object
    $_
}

# ✅ Save results to JSON
if (!(Test-Path "/app/reports")) {
    New-Item -ItemType Directory -Path "/app/reports" | Out-Null
}

$sslCertificateDetails | ConvertTo-Json | Out-File "/app/reports/sslCertificateDetails.json" -Force
Write-Host "SSL certificate scan completed. Results saved to /app/reports/sslCertificateDetails.json"
