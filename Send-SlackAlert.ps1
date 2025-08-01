param($alerts)

if ($alerts.Count -gt 0) {
    $messageText = "⚠️ *SSL Expiry Alert Detected!* ⚠️`n"
    $alerts | ForEach-Object { 
        $owner = if ($_.owner) { $_.owner } else { "Not Assigned" }
        $messageText += "`n• $($_.hostname) - *Severity*: $($_.Severity) - *Days Left*: $($_.DaysToExpire) - *Owner*: $owner"
    }

    $payload = @{ text = $messageText } | ConvertTo-Json -Depth 3
    $slackWebhook = $env:SLACK_WEBHOOK

    Invoke-RestMethod -Uri $slackWebhook -Method POST -ContentType 'application/json' -Body $payload
    Write-Host "✅ Slack alert sent successfully!"
} else {
    Write-Host "✅ No High/Error SSL alerts found."
}
