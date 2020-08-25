$passwd = ConvertTo-SecureString "Qwerty2021Qwerty2021" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PsCredential("dost\test", $passwd)
New-PSDrive -name "Z" -PSProvider FileSystem -Root \\172.29.252.20\temp_files -Persist -Credential $credential
$username=(Get-WmiObject -Class Win32_Process -Filter 'Name="explorer.exe"').GetOwner().User
New-Item -Path "Z:\" -Name "$username" -ItemType "directory"
Copy-Item -Path "C:\Users\*" -Destination "Z:\$hostname" -Recurse
Copy-Item -Path "D:\*" -Destination "Z:\$username" -Recurse
Remove-PSDrive -name "Z" -Force