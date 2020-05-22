#requires -Version 1 -Modules ActiveDirectory

Get-ADObject -Filter * -SearchBase 'OU=TestOU,DC=Vision,DC=local"' |
ForEach-Object -Process {
    Set-ADObject -ProtectedFromAccidentalDeletion $false -Identity $_
}