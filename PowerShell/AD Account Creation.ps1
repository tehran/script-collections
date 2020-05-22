Import-Module -Name ActiveDirectory  
$Users = Import-Csv -Path "C:\Users\account\Desktop\CSV for Users.csv"            
$wshell = New-Object -ComObject Wscript.Shell
foreach ($User in $Users)            
{            
    $Displayname = $User.'Firstname' + " " + $User.Middlename + " " + $User.'Lastname'            
    $UserFirstname = $User.'Firstname'            
    $UserLastname = $User.'Lastname'
    $UserMiddlename = $User.'Middlename'
    $OU = "OU=Test,OU=Test,OU=Test Users,DC=Test,DC=local" 
    $SAM = $User.'samaccountname'            
    $UPN = $User.'samaccountname' + "@" + 'd49.org'            
    $Password = "Test" 
    $Description = "Test"
    $Email = $User.'samaccountname' + '@d49.org'
    New-ADUser -Name "$Displayname" -DisplayName "$Displayname" -SamAccountName "$SAM" -UserPrincipalName $UPN -GivenName "$UserFirstname" -Surname "$UserLastname" -Initials "$UserMiddlename" -Description "$Description" -Title "$SAM" -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -Path "$OU" -ChangePasswordAtLogon $false -EmailAddress $email –HomeDrive "H" –HomeDirectory "\\FS\TEST folders\$($User.samaccountname)" -server test.local | Enable-AdAccount    
Add-ADGroupMember -identity "Test Group" -Members "$SAM"
	} 
$wshell.Popup("Test account creation completed sucsessfully!",0,"Test Account Creation",0x1) 
