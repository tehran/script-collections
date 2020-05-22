Import-Module Active Directory
$Resetpassword = Import-Csv "c:\UserList.csv"

foreach ($Account in $Resetpassword) {
    $Account.sAMAccountName
    $Account.Password
        Set-ADAccountPassword -Identity $Account.sAMAccountName -NewPassword (ConvertTo-SecureString $Account.Password -AsPlainText -force) -Reset
}