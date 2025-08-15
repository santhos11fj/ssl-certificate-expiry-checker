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

$mail = New-Object System.Net.Mail.MailMessage
$mail.From = $From
$To  | ForEach-Object { $mail.To.Add($_) }
$Cc  | Where-Object { $_ } | ForEach-Object { $mail.CC.Add($_) }
$Bcc | Where-Object { $_ } | ForEach-Object { $mail.Bcc.Add($_) }
$mail.Subject = $Subject
$mail.IsBodyHtml = $true
$mail.Body = $BodyHtml

$client = New-Object System.Net.Mail.SmtpClient($SmtpServer, $SmtpPort)
$client.EnableSsl = $true  # Always true for Outlook
$client.UseDefaultCredentials = $false
$client.DeliveryMethod = [System.Net.Mail.SmtpDeliveryMethod]::Network
$client.Credentials = New-Object System.Net.NetworkCredential($Username, $Password)

try {
  $client.Send($mail)
  Write-Host "✅ SMTP alert sent successfully."
} catch {
  Write-Error "❌ Failed to send SMTP alert: $($_.Exception.Message)"
  exit 1
}
