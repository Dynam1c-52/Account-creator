#https://github.com/Dynam1c-52
#----------------------------------------------------------------------------------------------------------------------
Write-Host "Enter a username:" -ForegroundColor Yellow
$usr = Read-Host
Write-Host "Enter a password:" -ForegroundColor Yellow
$pswd = Read-Host                                          #All console input to create a new AD account this script took me a decent amount of time to write so give me a star if you found this helpful please :D

#Encrypt the password from plain text for better security
$storepswd = ConvertTo-SecureString $pswd -AsPlainText -Force

$Principal = "$usr@yourdomain.com"

do {
    Write-Host "Enter how long the account will be active for (in days):" -ForegroundColor Yellow
    $stay = Read-Host

    if ($stay -notmatch '^\d+$') {                                                                   #<----- Throws a error if the user doesn't enter a whole number
        Write-Host "Invalid format: Only whole numbers!" -ForegroundColor Red
        continue
    }
#----------------------------------------------------------------------------------------------------------------------
    # Assigns the amount of days given by the user to the variable tilldone
    $tilldone = (Get-Date).AddDays($stay)

    # Ties everything together and creates a new AD user account based off the given input and values added.                                                        
    New-ADUser -SamAccountName $usr -UserPrincipalName $Principal -Enabled $true -AccountExpirationDate $tilldone -ChangePasswordAtLogon $false -AccountPassword $storepswd -Path "OU=yourOU,DC=yourdomain,DC=com"

    # Nice little message
    Write-Host "Action successful!" -ForegroundColor Green

    break
} while ($true)
