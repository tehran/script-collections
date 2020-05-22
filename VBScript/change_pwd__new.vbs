const domain="'LDAP://OU=All_Desktops,dc=test,dc=local'"  '##replace to name domain##
const USER_PROFILE = &H28&
Set WshNetwork = CreateObject("WScript.Network")
Const ADS_SCOPE_SUBTREE = 2
  Const ForReading = 1
  Const FOR_WRITING = 2
  Const ForAppending = 8
Set objConnection = CreateObject("ADODB.Connection")
Set objCommand =   CreateObject("ADODB.Command")
objConnection.Provider = "ADsDSOObject"
objConnection.Open "Active Directory Provider"
Set objCommand.ActiveConnection = objConnection
Set objShell = CreateObject("Shell.Application")
Set objFolder = objShell.Namespace(USER_PROFILE)
Set objFolderItem = objFolder.Self
Dim strFile
Dim objFSO, objTS, strComputer

objCommand.Properties("Page Size") = 1000
objCommand.Properties("Searchscope") = ADS_SCOPE_SUBTREE 
objCommand.CommandText = "SELECT   Name FROM "&domain&" WHERE objectCategory='computer'"  
Set objRecordSet = objCommand.Execute
 Set objFSO = CreateObject("Scripting.FileSystemObject")
objRecordSet.MoveFirst

Do Until objRecordSet.EOF
nam=objRecordSet.Fields("name").Value
if not isnull(nam) then
' 		if ReverseDNSLookup(nam)<>"Failed" then 
		strComputer = nam
		'strComputer = strComputer & ".test.local"
		'do something with strComputer
		WScript.Echo strComputer & " - AD record found " 
		If TestPing(strComputer) Then
			On Error Resume Next
			Dim objAdmin
			Set objAdmin = GetObject("WinNT://" & strComputer & "/Administrator,user")
			If Err = 0 Then
				objAdmin.SetPassword "new_pass"
				objAdmin.SetInfo
				WScript.Echo strComputer & " Done: " 
			Else
			   WScript.Echo strComputer & " No administrator account found or WMI error "
			End If
		    else
		    WScript.Echo strComputer & " no ping "
		end if
end if
 objRecordSet.MoveNext
Loop
Function TestPing(sName)
	Dim cPingResults, oPingResult
	Set cPingResults = GetObject("winmgmts:\\.\root\cimv2").ExecQuery("SELECT * FROM Win32_PingStatus WHERE Address = '" & sName & "'")
	For Each oPingResult In cPingResults
		If oPingResult.StatusCode = 0 Then
			TestPing = True
		Else
			TestPing = False
		End If
	Next
End Function
Function ReverseDNSLookup(sAlias)
  If len(sAlias) = 0 Then
    ReverseDNSLookup = "Failed."
  End If
  Const OpenAsDefault = -2
  Const FailIfNotExist = 0
  Const ForReading = 1
  Set oShell = CreateObject("WScript.Shell")
  Set oFSO = CreateObject("Scripting.FileSystemObject")
  sTemp = oShell.ExpandEnvironmentStrings("%TEMP%")
  sTempFile = sTemp & "\" & oFSO.GetTempName
  oShell.Run "%comspec% /c nslookup " & sAlias & ">" & sTempFile, 0, True
  Set fFile = oFSO.OpenTextFile(sTempFile, ForReading, FailIfNotExist, OpenAsDefault)
  sResults = fFile.ReadAll
  fFile.Close
  oFSO.DeleteFile (sTempFile)
  aIP = Split(sResults, "Address:")
  If UBound(aIP) < 2 Then
    ReverseDNSLookup = "Failed."
  Else
    aIPTemp = Split(aIP(2), Chr(13))
    ReverseDNSLookup = trim(aIPTemp(0))
  End If
  Set oShell = Nothing
  Set oFSO = Nothing
End Function
Function IsIP(sIPAddress)
  aOctets = Split(sIPAddress,".")
  If IsArray(aOctets) Then
    If UBound(aOctets) = 3 Then
      For Each sOctet In aOctets
        On Error Resume Next
        sOctet = Trim(sOctet)
        sOctet = sOctet + 0
        On Error Goto 0
        If IsNumeric(sOctet) Then
          If sOctet < 0 Or sOctet > 256 Then
            IsIP = False
            Exit Function
          End If
        Else
          IsIP = False
          Exit Function
        End If
      Next
      IsIP = True
    Else
      IsIP = False
    End If
  Else
    IsIP = False
  End If
End Function
