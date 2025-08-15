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
    $securePassword = ConvertTo-SecureString $Password -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential ($Username, $securePassword)

    $mailParams = @{
        From        = $From
        To          = $To
        Subject     = $Subject
        Body        = $BodyHtml
        BodyAsHtml  = $true
        SmtpServer  = $SmtpServer
        Port        = $SmtpPort
        UseSsl      = $true
        Credential  = $credential
    }

    # Add Cc and Bcc only if provided
    if ($Cc -and $Cc.Count -gt 0) {
        $mailParams['Cc'] = $Cc
    }
    if ($Bcc -and $Bcc.Count -gt 0) {
        $mailParams['Bcc'] = $Bcc
    }

    Send-MailMessage @mailParams

    Write-Host "✅ SMTP email sent successfully."
}
catch {
    Write-Error "❌ Failed to send SMTP alert: $($_.Exception.Message)"
    exit 1
}
