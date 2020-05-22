##################
#--------Config
##################
$sourceOU = "OU=source_ou,OU=main,DC=test,DC=local"
$destinationOU = "OU=dest_ou,OU=main,DC=test,DC=local"
##################
#--------Main
##################
$adPath= "LDAP://" + $destinationOU
import-module activedirectory
#Create OUs
$objDomain=New-Object System.DirectoryServices.DirectoryEntry($adPath)
$ObjSearch=New-Object System.DirectoryServices.DirectorySearcher($ObjDomain)
[array] $OUs = @()
$OUs = dsquery * $sourceOU -Filter "(objectCategory=organizationalUnit)" -limit 0
$OUsorted = $OUs | sort-object { $_.Length}
for ($k=0; $k -le $OUsorted.Count -1; $k++)
{
    $OUtoCreate = ($OUsorted[$k] -replace $sourceOU,$destinationOU).ToString()
    $OUSearch = ($OUtoCreate -replace '"',"").ToString()
    $ObjSearch.Filter = "(&(objectCategory=organizationalUnit)(distinguishedName="+ $OUSearch + "))"
    $allSearchResult = $ObjSearch.FindAll()
    if ($allSearchResult.Count -eq 1)
    {
        "No changes were done on = " + $OUtoCreate
    }
    else
    {
        dsadd ou $OUtoCreate
        "OU Creation = " + $OUtoCreate
    }
}
