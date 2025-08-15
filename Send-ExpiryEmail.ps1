param(
  [string]$ResultsPath = ".\sslCertificateDetails.json",
  [string]$EnvName = "PROD",

  [Parameter(Mandatory=$true)][string]$SMTP_SERVER,
  [int]$SMTP_PORT = 587,
  [switch]$SMTP_SSL = $true,
  [Parameter(Mandatory=$true)][string]$SMTP_FROM,
  [Parameter(Mandatory=$true)][string]$SMTP_TO,   # comma-separated
  [string]$SMTP_CC,
  [string]$SMTP_BCC,
  [Parameter(Mandatory=$true)][string]$SMTP_USER,
  [Parameter(Mandatory=$true)][string]$SMTP_PASS
)

if (!(Test-Path $ResultsPath)) {
  Write-Error "Results file not found: $ResultsPath"
  exit 2
}

$data = Get-Content $ResultsPath | ConvertFrom-Json

$alerts = $data | Where-Object { $_.Severity -in @('High','Error') }
if (-not $alerts) {
  Write-Host "No High/Error findings. Skipping email."
  exit 0
}

$rows = $alerts | ForEach-Object {
  "<tr>
     <td>$($_.Host)</td>
     <td>$($_.Issuer)</td>
     <td>$($_.ExpiryDate)</td>
     <td>$($_.DaysRemaining)</td>
     <td><b>$($_.Severity)</b></td>
     <td>$($_.Owner)</td>
   </tr>"
} | Out-String

$body = @"
<h2>[$EnvName] SSL Certificates Requiring Attention</h2>
<p>The following certificates are near expiry or expired.</p>
<table border="1" cellpadding="6" cellspacing="0">
  <thead>
    <tr>
      <th>Host</th><th>Issuer</th><th>Expiry</th><th>Days Left</th><th>Severity</th><th>Owner</th>
    </tr>
  </thead>
  <tbody>
    $rows
  </tbody>
</table>
<p>Repository: ssl-certificate-expiry-checker</p>
"@

$to  = $SMTP_TO.Split(",")  | ForEach-Object { $_.Trim() } | Where-Object { $_ }
$cc  = $SMTP_CC.Split(",")  | ForEach-Object { $_.Trim() } | Where-Object { $_ }
$bcc = $SMTP_BCC.Split(",") | ForEach-Object { $_.Trim() } | Where-Object { $_ }

& "$PSScriptRoot\Send-SMTPAlert.ps1" `
  -SmtpServer $SMTP_SERVER -SmtpPort $SMTP_PORT -UseSsl:$SMTP_SSL `
  -From $SMTP_FROM -To $to -Cc $cc -Bcc $bcc `
  -Subject "[$EnvName] SSL Alerts: $($alerts.Count) certificate(s) need attention" `
  -BodyHtml $body -Username $SMTP_USER -Password $SMTP_PASS
