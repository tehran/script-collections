Get-ADOrganizationalUnit -Identity 'OU=Avengers,DC=savilltech,DC=net' |
    Set-ADObject -ProtectedFromAccidentalDeletion:$false -PassThru |
    Remove-ADOrganizationalUnit -Confirm:$false