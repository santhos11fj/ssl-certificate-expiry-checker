param($alerts)

if ($alerts.Count -gt 0) {
    $messageText = "⚠️ *SSL Expiry Alert Detected!* ⚠️`n"
    $alerts | ForEach-Object { 
        $messageText += "`n• $($_.hostname) - *Severity*: $($_.Severity) - *Days Left*: $($_.DaysToExpire)"
    }

    $payload = @{ text = $messageText } | ConvertTo-Json -Depth 3
    $slackWebhook = $env:SLACK_WEBHOOK

    Invoke-RestMethod -Uri $slackWebhook -Method POST -ContentType 'application/json' -Body $payload
    Write-Host "✅ Slack alert sent successfully!"
} else {
    Write-Host "✅ No High/Error SSL alerts. No Slack message sent."
}
