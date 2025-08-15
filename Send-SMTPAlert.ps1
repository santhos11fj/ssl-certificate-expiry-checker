param(
  [Parameter(Mandatory=$true)][string]$SmtpServer,
  [int]$SmtpPort = 587,
  [switch]$UseSsl,
  [Parameter(Mandatory=$true)][string]$From,
  [Parameter(Mandatory=$true)][string[]]$To,
  [string[]]$Cc,
  [string[]]$Bcc,
  [Parameter(Mandatory=$true)][string]$Subject,
  [Parameter(Mandatory=$true)][string]$BodyHtml,
  [Parameter(Mandatory=$true)][string]$Username,
  [Parameter(Mandatory=$true)][string]$Password
)

try {
    # Create credential object with App Password
    $securePassword = ConvertTo-SecureString $Password -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential ($Username, $securePassword)

    # Send the email
    Send-MailMessage `
        -From $From `
        -To $To `
        -Cc $Cc `
        -Bcc $Bcc `
        -Subject $Subject `
        -BodyAsHtml $BodyHtml `
        -SmtpServer $SmtpServer `
        -Port $SmtpPort `
        -UseSsl `
        -Credential $credential

    Write-Host "✅ SMTP email sent successfully."
}
catch {
    Write-Error "❌ Failed to send SMTP alert: $($_.Exception.Message)"
    exit 1
}
