# Load the function to retrieve remote SSL certificates
. $PSScriptRoot/Get-RemoteCertificate.ps1

# Get the parent directory path
$upperPath = ($PSScriptRoot | Split-Path)

# Load endpoints and alert thresholds
$endpoints = Get-Content "$upperPath/endpoints.json" | ConvertFrom-Json
$alertThresholds = Get-Content "$upperPath/alertThresholds.json" | ConvertFrom-Json

# Retrieve SSL certificate details for each endpoint
$sslCertificateDetails = $endpoints | ForEach-Object {
    # Get the SSL certificate for the current endpoint
    $cert = Get-RemoteCertificate -ComputerName $_.hostname -Insecure

    # Add issuer information
    Add-Member -InputObject $_ -NotePropertyName "Issuer" -NotePropertyValue $cert.Issuer

    # Calculate days remaining until expiry
    $daysRemaining = ($cert.NotAfter - (Get-Date)).Days
    Add-Member -InputObject $_ -NotePropertyName "DaysToExpire" -NotePropertyValue $daysRemaining

    # ✅ Correct Severity Calculation
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
        $severity = 'Error'   # Certificate is already expired or invalid
    }

    # Add severity field to the object
    Add-Member -InputObject $_ -NotePropertyName "Severity" -NotePropertyValue $severity

    # Return the updated object
    $_
}

# Save results as JSON for downstream usage (HTML report, notifications, etc.)
$sslCertificateDetails | ConvertTo-Json | Out-File "$upperPath/sslCertificateDetails.json" -Force
