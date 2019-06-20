Function Select-Subs {
    $ErrorActionPreference = 'SilentlyContinue'
    $Menu = 0
    Try {
        Get-AzSubscription
    } 
    Catch {
        If ($_ -like "*Connect-AzAccount to login*") {
            Write-host -ForegroundColor Yellow "No Azure connection detected, please connect..."
            Connect-AzAccount
        } 
        Else {
            Throw
        }
    }
    $Subs = @(Get-AzSubscription | Select-Object Name, ID, TenantId)
    $Content = Get-AzContext

    Write-Host "Please select the subscription you want to use:" -ForegroundColor Green;
    ForEach-Object { Write-Host "" }
    $Subs | ForEach-Object { Write-Host "[$($Menu)]" -ForegroundColor Cyan -NoNewline ; Write-host ". $($_.Name)"; $Menu++; }
    ForEach-Object { Write-Host "" }
    ForEach-Object { Write-Host "[S]" -ForegroundColor Yellow -NoNewline ; Write-host ". To switch Azure Account (Actually connected with $($Content.Account.Id) on $($Content.Subscription.Name))." }
    ForEach-Object { Write-Host "" }
    ForEach-Object { Write-Host "[Q]" -ForegroundColor Red -NoNewline ; Write-host ". To quit." }
    ForEach-Object { Write-Host "" }
    $Selection = Read-Host "Please select the Subscription Number - Valid numbers are 0 - $($Subs.count -1), S to switch Azure Account or Q to quit"
    If ($Selection -eq 'S') { 
        Connect-AzAccount
        Select-Subs
    }
    If ($Selection -eq 'Q') { 
        Clear-Host
        Exit
    }
    If ($Subs.item($Selection) -ne $null) {
        Set-AzContext -Subscription $Subs[$Selection].ID -ErrorAction Stop
    }
}