Import-Module ActiveDirectory
 
$users = Get-ADUser -LDAPfilter '(name=*)' -searchBase "OU=something,DC=contoso,DC=local" 
foreach($user in $users)
{
Enable-Mailbox -Identity $user.SamAccountName -database MBX00_x
}
