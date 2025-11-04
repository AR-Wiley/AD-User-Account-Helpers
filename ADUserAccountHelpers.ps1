function isEnabled {
    
    param (
        [string]$UID
    )

    $enabled = Get-ADUser -Identity $UID -Properties Enabled
    
    if (-not $enabled.Enabled) {
        return $enabled.Enabled
    } 
}

function isLocked {
    param (
        [string]$UID
    )

    $locked = Get-ADUser -Identity $UID -Properties LockedOut

    if ($locked.LockedOut) {
        Unlock-ADAccount -Identity $UID
        return "Unlocked $UID"
    } else {
        return "$UID is not locked"
    }
}

function passwordReset {

    param(
        [string]$UID,
        [SecureString]$Password
    )

    Set-ADAccountPassword -Identity $UID -NewPassword $Password -Reset

    Set-ADUser -Identity $UID -ChangePasswordAtLogon $true
}

 
 
