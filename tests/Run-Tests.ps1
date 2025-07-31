#Requires -Modules @{ ModuleName="Pester"; ModuleVersion="5.3.3" }

BeforeDiscovery { 
    $sslCertificateDetails = Get-Content "$PSScriptRoot/../sslCertificateDetails.json" | ConvertFrom-Json
}

Describe "Alert Severity of SSL Certificate of <_.hostname>" -ForEach $sslCertificateDetails {
    It "has a valid Severity" {
        # Acceptable values for severity
        $validSeverities = @("Safe", "Low", "Medium", "High", "Error")
        $validSeverities | Should -Contain $_.Severity
    }
}
