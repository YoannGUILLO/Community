# Demo 03
# Set variables
$RGName = "FRPSUG002"
$RGLocation = "West Europe"
$KeyVaultName = "demoygu001"
$VMName = "SimpleVM"
New-AzResourceGroup -Name $RGName -Location $RGLocation

Function New-RandomPassword {
    
    [CmdletBinding()]
    Param (
        [Parameter()]
        [ValidateRange(8, 35)]
        [int]$Length = 12,

        [Parameter()]
        [ValidateSet('Number', 'Uppercase', 'Lowercase', 'Symbol')]
        [string[]]$CharacterType = ('Number', 'Uppercase', 'Lowercase', 'Symbol'),

        [Parameter()]
        [string[]]$UnusedCharacter
    )

    #region Create character set.
    Write-Verbose -Message "Creating a random password with $Length characters."
    Write-Verbose -Message "Building the allowable character set."
    Foreach ($Character in $CharacterType) {
        Switch ($Character) {
            'Number' {
                # Numbers.
                For ($a = 48; $a -le 57; $a++) {
                    $CharacterSet += [array][char]$a
                }
            }
            'Uppercase' {
                # Uppercase.
                For ($b = 65; $b -le 89; $b++) {
                    $CharacterSet += [array][char]$b
                }
            }
            'Lowercase' {
                # Lowercase.
                For ($c = 97; $c -le 122; $c++) {
                    $CharacterSet += [array][char]$c
                }
            }
            'Symbol' {
                # Symbols.
                For ($d = 33; $d -le 47; $d++) {
                    $CharacterSet += [array][char]$d
                }
                For ($d = 58; $d -le 64; $d++) {
                    $CharacterSet += [array][char]$d
                }
                For ($d = 91; $d -le 96; $d++) {
                    $CharacterSet += [array][char]$d
                }
                For ($d = 123; $d -le 126; $d++) {
                    $CharacterSet += [array][char]$d
                }    
            }
        } # End Switch.
    } # End Foreach.
    Write-Verbose -Message "Displaying the allowable characters set as $($CharacterSet -join ',')."
    #endregion

    #region Remove unwanted characters.
    If ($UnusedCharacter) {
        Write-Verbose -Message "Removing unwanted character(s) $($UnusedCharacter -join ',') from the character set."

        $CharacterSet = {$CharacterSet}.Invoke()
        Foreach ($Character in $UnusedCharacter) {
            [System.Void]($CharacterSet.Remove($Character))
        }
        Write-Verbose -Message "Displaying the updated allowable characters set as $($CharacterSet -join ',')."
    } # End If.
    #endregion                                                                              s

    #region Create random password.
    Write-Verbose -Message "Creating the random password."
    For ($Loop = 1; $Loop –le $Length; $Loop++) {
        $RandomPassword += ($CharacterSet | Get-Random)
    } # End For.
    #endregion.

    #region Display random password.
    Write-Verbose -Message "Displaying the random password."
    $RandomPassword
    #endregion
}

# Generate complex password
$Secret = ConvertTo-SecureString (New-RandomPassword -Length 16 -UnusedCharacter "$") -AsPlainText –Force

# Register as secret in my Key Vault
Set-AzKeyVaultSecret -VaultName $KeyVaultName -Name $VMName -SecretValue $Secret -ContentType "password" | Out-Null

# Change reference in the parameters file
$Param = Get-Content "Code/03 - Vm Full.parameters.json" -raw | ConvertFrom-Json
$Param.parameters.adminPasswordOrKey.reference.secretName = $VMName
$Param | ConvertTo-Json -depth 32| set-content "Code/03 - Vm Full.parameters.json"


# Set the deployment name
$DeploymentName = ((Get-AzContext).Account.Id).Split("@")[0] + "_" + (Get-Date -Format s).Replace(":","-")
New-AzResourceGroupDeployment -Name $DeploymentName -ResourceGroupName $RGName -TemplateFile "Code/03 - Vm Full.json" -TemplateParameterFile "Code/03 - Vm Full.parameters.json"