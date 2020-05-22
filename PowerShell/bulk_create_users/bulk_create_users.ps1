###########################################################
# AUTHOR  : Kelly Bush
# DATE    : 1/16/2014  
# COMMENT : Creates Active Directory users and populates
#           different attributes based on import_users.csv
# Based on: PowerShell: Create Active Directory Users Based On Excel Input 
###########################################################
Import-Module ActiveDirectory
$path     = Split-Path -parent $MyInvocation.MyCommand.Definition
$newpath  = $path + "\import_users.csv"
# Define variables
$log      = $path + "\created_ActiveDirectory_users.log"
$date     = Get-Date
$i        = 0

Function createActiveDirectoryUsers
{

"Created the following Active Directory users (on " + $date + "): " | Out-File $log -append
"--------------------------------------------" | Out-File $log -append

  Import-CSV $newpath | ForEach-Object { 
    $samAccount = $_.SamAccountName
    Try   { $exists = Get-ADUser -LDAPFilter "(sAMAccountName=$samAccount)" }
    Catch { }
    If(!$exists)
    {
      $i++
      # Set all variables according to the table names in the Excel 
      # sheet / import CSV. The names can differ in every project, but 
      # if the names change, make sure to change it below as well.
      $setpass = ConvertTo-SecureString -AsPlainText $_.Password -force
      New-ADUser -Name $_.DisplayName -SamAccountName $_.SamAccountName -GivenName $_.GivenName -Initials $_.Initials `
      -Surname $_.SN -DisplayName $_.DisplayName -Office $_.OfficeName `
      -Description $_.Description -EmailAddress $_.eMail `
      -StreetAddress $_.StreetAddress -City $_.L `
      -PostalCode $_.PostalCode -Country $_.CO -UserPrincipalName $_.UPN `
      -Company $_.Company -Department $_.Department -EmployeeID $_.ID `
      -OfficePhone $_.Phone -AccountPassword $setpass -Enabled $true -Path $_.OU  
  
      $output  = $i.ToString() + ") Name: " + $_.CN + "  sAMAccountName: " 
      $output += $sam + "  Pass: " + $_.Password
      $output | Out-File $log -append
    }
    Else
    {
      "SKIPPED - USER ALREADY EXISTS OR ERROR: " + $_.CN | Out-File $log -append
    }
  }
  "----------------------------------------" + "`n" | Out-File $log -append
}
# Run function
createActiveDirectoryUsers
#End Script